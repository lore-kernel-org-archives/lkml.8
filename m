Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A88C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C5020776
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592579633;
	bh=Ioc4TzxfqbTd4S5EBzQSWT0oJidXxLmnm7TD9CDAcAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Trh1Fy874I5j0UErrdAJY/xNRO2XW2zgHyAoF8Ug9fkwIKV2R2+lhRbrOXJBoaWX
	 sz1dMHE2TIn3le48qeGVjZyt3rxAhiCOVS73y688wPs+bCeyJZhkN8KcIbioG+wFqg
	 QAOYV+Xdx+QgPafz6CXHKQ414KkWuB33pqwzSz34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391801AbgFSPNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:13:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392260AbgFSPNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:13:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 794DB20776;
        Fri, 19 Jun 2020 15:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579620;
        bh=Ioc4TzxfqbTd4S5EBzQSWT0oJidXxLmnm7TD9CDAcAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MhkVNwIseG8cDtRcjPevBwL0lGG0hrYqWtW8yhQIyre700heFrEEUKmdke+3mu90d
         EpFhIB953YwtSe6RhjXTpUwZrW8mj3piVB/NQ5afnhGtn0MZwhBgBy8rttxY/bSNmY
         psD+f/WYt9091QlNEqS42zIFktGOb6/SGT6oy1iA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [PATCH 5.4 204/261] b43: Fix connection problem with WPA3
Date:   Fri, 19 Jun 2020 16:33:35 +0200
Message-Id: <20200619141659.667759577@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141649.878808811@linuxfoundation.org>
References: <20200619141649.878808811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Larry Finger <Larry.Finger@lwfinger.net>

commit 75d057bda1fbca6ade21378aa45db712e5f7d962 upstream.

Since the driver was first introduced into the kernel, it has only
handled the ciphers associated with WEP, WPA, and WPA2. It fails with
WPA3 even though mac80211 can handle those additional ciphers in software,
b43 did not report that it could handle them. By setting MFP_CAPABLE using
ieee80211_set_hw(), the problem is fixed.

With this change, b43 will handle the ciphers it knows in hardware,
and let mac80211 handle the others in software. It is not necessary to
use the module parameter NOHWCRYPT to turn hardware encryption off.
Although this change essentially eliminates that module parameter,
I am choosing to keep it for cases where the hardware is broken,
and software encryption is required for all ciphers.

Reported-and-tested-by: Rui Salvaterra <rsalvaterra@gmail.com>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Stable <stable@vger.kernel.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200526155909.5807-2-Larry.Finger@lwfinger.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/broadcom/b43/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -5569,7 +5569,7 @@ static struct b43_wl *b43_wireless_init(
 	/* fill hw info */
 	ieee80211_hw_set(hw, RX_INCLUDES_FCS);
 	ieee80211_hw_set(hw, SIGNAL_DBM);
-
+	ieee80211_hw_set(hw, MFP_CAPABLE);
 	hw->wiphy->interface_modes =
 		BIT(NL80211_IFTYPE_AP) |
 		BIT(NL80211_IFTYPE_MESH_POINT) |


