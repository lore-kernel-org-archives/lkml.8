Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B57C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FD1222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609913;
	bh=m5h+TfoZBMq8+QQTbTonTmHL2eCkmjNWI9LgLwgQetQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sbh8L+NVAidJJBpRcJ+V41KobF6icc3kSck4aEdIpoVFr9BTPRxZlvjP+L1OF/fye
	 Ma6ZJlLjSL0G4NpX5ZkPCFUoikWDASbEGLfSynhH2RA8yZggzoFCmJUK1NYsDlnIof
	 Zk4GFg61p9gEmpQvmQjn3teUW5smrKR1Y9hfGL6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgBMQFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:05:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728526AbgBMPXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:23:53 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3971324689;
        Thu, 13 Feb 2020 15:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607432;
        bh=m5h+TfoZBMq8+QQTbTonTmHL2eCkmjNWI9LgLwgQetQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xz7FKxMbnuMB/jIVyQMG9AOmWVtaWV8zhKHDa6BnvKyX3zVZnUg9o2mzvy56uiGWM
         DLjce2LoP9ZeTOqKE0/8ZlJbYJj6A7FN4iyl6+UFdvXjI8lrlaUhBckTZ9pxpMP3c+
         JH9Xubexu80q2JPtjLjnIN5XZ5wT1ZjDwdTwELHI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 066/116] net: tulip: Adjust indentation in {dmfe, uli526x}_init_module
Date:   Thu, 13 Feb 2020 07:20:10 -0800
Message-Id: <20200213151908.551367898@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151842.259660170@linuxfoundation.org>
References: <20200213151842.259660170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

commit fe06bf3d83ef0d92f35a24e03297172e92ce9ce3 upstream.

Clang warns:

../drivers/net/ethernet/dec/tulip/uli526x.c:1812:3: warning: misleading
indentation; statement is not part of the previous 'if'
[-Wmisleading-indentation]
        switch (mode) {
        ^
../drivers/net/ethernet/dec/tulip/uli526x.c:1809:2: note: previous
statement is here
        if (cr6set)
        ^
1 warning generated.

../drivers/net/ethernet/dec/tulip/dmfe.c:2217:3: warning: misleading
indentation; statement is not part of the previous 'if'
[-Wmisleading-indentation]
        switch(mode) {
        ^
../drivers/net/ethernet/dec/tulip/dmfe.c:2214:2: note: previous
statement is here
        if (cr6set)
        ^
1 warning generated.

This warning occurs because there is a space before the tab on these
lines. Remove them so that the indentation is consistent with the Linux
kernel coding style and clang no longer warns.

While we are here, adjust the default block in dmfe_init_module to have
a proper break between the label and assignment and add a space between
the switch and opening parentheses to avoid a checkpatch warning.

Fixes: e1c3e5014040 ("[PATCH] initialisation cleanup for ULI526x-net-driver")
Link: https://github.com/ClangBuiltLinux/linux/issues/795
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/dec/tulip/dmfe.c    |    7 ++++---
 drivers/net/ethernet/dec/tulip/uli526x.c |    4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/dec/tulip/dmfe.c
+++ b/drivers/net/ethernet/dec/tulip/dmfe.c
@@ -2225,15 +2225,16 @@ static int __init dmfe_init_module(void)
 	if (cr6set)
 		dmfe_cr6_user_set = cr6set;
 
- 	switch(mode) {
-   	case DMFE_10MHF:
+	switch (mode) {
+	case DMFE_10MHF:
 	case DMFE_100MHF:
 	case DMFE_10MFD:
 	case DMFE_100MFD:
 	case DMFE_1M_HPNA:
 		dmfe_media_mode = mode;
 		break;
-	default:dmfe_media_mode = DMFE_AUTO;
+	default:
+		dmfe_media_mode = DMFE_AUTO;
 		break;
 	}
 
--- a/drivers/net/ethernet/dec/tulip/uli526x.c
+++ b/drivers/net/ethernet/dec/tulip/uli526x.c
@@ -1813,8 +1813,8 @@ static int __init uli526x_init_module(vo
 	if (cr6set)
 		uli526x_cr6_user_set = cr6set;
 
- 	switch (mode) {
-   	case ULI526X_10MHF:
+	switch (mode) {
+	case ULI526X_10MHF:
 	case ULI526X_100MHF:
 	case ULI526X_10MFD:
 	case ULI526X_100MFD:


