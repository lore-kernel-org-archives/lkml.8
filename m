Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3648BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A342467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686718;
	bh=h9wDXmwEsFdoPohpB5Y3eEkycsp8x/x34bOnIPfQ6gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Erx78tnfjt7WlHJrf+AgxcCSfQ0abFjsP9ygPArxccY3Kza/awUNNJ+O63EkPM5do
	 B3hn7yrSeoT18FvFTOHIE3EEWzFjy6P4ppOb1TElH3+vthw2upeMpx1GHJhGEHnfiF
	 tQeESHnDm4LwLpw7Pe4jE6ZSAB6lSgiU5ZG2Ydos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732677AbgAVJv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:51:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:52516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729473AbgAVJgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:36:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 138BB24680;
        Wed, 22 Jan 2020 09:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685811;
        bh=h9wDXmwEsFdoPohpB5Y3eEkycsp8x/x34bOnIPfQ6gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z9lpHi14XKZaLWwpXKs6BW0WepnX1RhoE9qK4ECFE+MnRDi79KTTlUVh2eLx8mbY4
         P+ojzAWHM8h7+S82fsWpViPzRGjmx+9ScQaCPdXqu1NIxnX/al6LLtFRoktCSRFbES
         0CFeWNRnYBiIFfD2+szTLMOTEReLsKLhcQhayUAg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.9 88/97] cw1200: Fix a signedness bug in cw1200_load_firmware()
Date:   Wed, 22 Jan 2020 10:29:32 +0100
Message-Id: <20200122092810.381077481@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 4a50d454502f1401171ff061a5424583f91266db upstream.

The "priv->hw_type" is an enum and in this context GCC will treat it
as an unsigned int so the error handling will never trigger.

Fixes: a910e4a94f69 ("cw1200: add driver for the ST-E CW1100 & CW1200 WLAN chipsets")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/st/cw1200/fwio.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/st/cw1200/fwio.c
+++ b/drivers/net/wireless/st/cw1200/fwio.c
@@ -323,12 +323,12 @@ int cw1200_load_firmware(struct cw1200_c
 		goto out;
 	}
 
-	priv->hw_type = cw1200_get_hw_type(val32, &major_revision);
-	if (priv->hw_type < 0) {
+	ret = cw1200_get_hw_type(val32, &major_revision);
+	if (ret < 0) {
 		pr_err("Can't deduce hardware type.\n");
-		ret = -ENOTSUPP;
 		goto out;
 	}
+	priv->hw_type = ret;
 
 	/* Set DPLL Reg value, and read back to confirm writes work */
 	ret = cw1200_reg_write_32(priv, ST90TDS_TSET_GEN_R_W_REG_ID,


