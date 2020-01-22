Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5B5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B99B24680
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685640;
	bh=0wWvWshp+tvgSFI8pOHOJrx1Z8wnPY0sv8HdFJhYBDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bn5x4LaFE5vAs1F/2BWKdZ2gtAM1/AOeK+pMUSH9ppKM8rbblDlSYWzIXZV4N4Bu9
	 ORFKn1h5VioudVEOYH+dm90jQJ3uEdUYZNXo1JiRiPMPBk1DJlgMK9EVBVbfv9Vqtb
	 LIOqwatysdSjHEQ0j64RfLebOSIR2FjP5+g0TPnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgAVJd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:33:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:48048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730063AbgAVJdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:33:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BA802071E;
        Wed, 22 Jan 2020 09:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685633;
        bh=0wWvWshp+tvgSFI8pOHOJrx1Z8wnPY0sv8HdFJhYBDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rme50aIieASfpVAOLsMFtn73Uzc8i1vqbYvZ0E72s2IF3URu+Dn4QdPHule5Gz4r2
         9fw5cXh3EQIjLRabauMVTQXgVIDwSB4EOdOCPcqwVfopbbieUUBto5oQmUWqf17SZu
         K1u6giEPx3PRZY8mUa0L1AIiBIFqMO11EOM9sDUM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sanjay Konduri <sanjay.konduri@redpinesignals.com>,
        Sushant Kumar Mishra <sushant.mishra@redpinesignals.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 06/97] rsi: add fix for crash during assertions
Date:   Wed, 22 Jan 2020 10:28:10 +0100
Message-Id: <20200122092756.754932862@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092755.678349497@linuxfoundation.org>
References: <20200122092755.678349497@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanjay Konduri <sanjay.konduri@redpinesignals.com>

commit abd39c6ded9db53aa44c2540092bdd5fb6590fa8 upstream.

Observed crash in some scenarios when assertion has occurred,
this is because hw structure is freed and is tried to get
accessed in some functions where null check is already
present. So, avoided the crash by making the hw to NULL after
freeing.

Signed-off-by: Sanjay Konduri <sanjay.konduri@redpinesignals.com>
Signed-off-by: Sushant Kumar Mishra <sushant.mishra@redpinesignals.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/rsi/rsi_91x_mac80211.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -199,6 +199,7 @@ void rsi_mac80211_detach(struct rsi_hw *
 		ieee80211_stop_queues(hw);
 		ieee80211_unregister_hw(hw);
 		ieee80211_free_hw(hw);
+		adapter->hw = NULL;
 	}
 
 	rsi_remove_dbgfs(adapter);


