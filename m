Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2403AC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59F12467E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996309;
	bh=6x5H/qSfeoUdvmRrLY1/QJTMbneI6c4ICGyYoLfZWVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pOFJg8uMAeuSBFUnMjUo9Fqrecx8V8VxbYU4z2au2j65DxakMSaepfMoOqHTQ5IyO
	 k5jNMdwmGyNRUEsCbPLRJIpbvKoa8kIaBbeOzWMkgYhHvkk5UYHMD9m6mUKes1PKq1
	 GUR0fAKAT3rrFarfs7jhtpqI/IPfa02JPMgegNLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgANKFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:32916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730025AbgANKFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:05:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D567D2467E;
        Tue, 14 Jan 2020 10:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996303;
        bh=6x5H/qSfeoUdvmRrLY1/QJTMbneI6c4ICGyYoLfZWVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mIph/3NXmVvsx2oRPconjLXu7BXg/74S/4ShLMlS2fDNebEcvZpysqVVdQ75u7Rvr
         uly4Pv3Ib6lhHRfE0l8NrFS4ly/4PbIkyoCI/4lTKoT/l0DedckP3pc7/vdC16swCX
         xJZ2kZ4SX/7quAzSW4zGXM+9oJaHbyQqUjijqv1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 5.4 50/78] staging: vt6656: correct return of vnt_init_registers.
Date:   Tue, 14 Jan 2020 11:01:24 +0100
Message-Id: <20200114094400.201384767@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094352.428808181@linuxfoundation.org>
References: <20200114094352.428808181@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Malcolm Priestley <tvboxspy@gmail.com>

commit 7de6155c8968a3342d1bef3f7a2084d31ae6e4be upstream.

The driver standard error returns remove bool false conditions.

Cc: stable <stable@vger.kernel.org> # v5.3+
Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
Link: https://lore.kernel.org/r/072ec0b3-425f-277e-130c-1e3a116c90d6@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/vt6656/main_usb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -950,7 +950,7 @@ static const struct ieee80211_ops vnt_ma
 
 int vnt_init(struct vnt_private *priv)
 {
-	if (!(vnt_init_registers(priv)))
+	if (vnt_init_registers(priv))
 		return -EAGAIN;
 
 	SET_IEEE80211_PERM_ADDR(priv->hw, priv->permanent_net_addr);


