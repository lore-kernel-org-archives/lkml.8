Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7488C3F361
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48582469B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812117;
	bh=fIQ9dRT5falEOKAiEhOmoWhkW76BUdeoKlh3hMghr8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YMKS8+0YezAiu/R1lFZHUyioJMyfCy1gR/BQQgVDEW/LJxxnXtqpYILUMfPpF/xUN
	 OHncwvaW0feXugBImkZM/3N7sQzo9F4ixhbMnO+TXj7OJAIaTAH5H4T/WKCtqzjEPh
	 OXej3Bfak2c8TQZsNiBrhi/ngSca0aJXAh75PXUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733028AbgB0OB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:01:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733011AbgB0OBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:01:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABF2D20801;
        Thu, 27 Feb 2020 14:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812113;
        bh=fIQ9dRT5falEOKAiEhOmoWhkW76BUdeoKlh3hMghr8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YCc59oIcl+5Nd5zfQCfSH32ksUdIGJr3XB5UqvLe5j5CLGK8VpKKWDm9XIljADc16
         AYrRsAnjApw6s9gUcJ9o3Uai1jvEsSYqec4Zv7cA201rp3NTLEz+M+zFjID6tZOEGq
         NQiPRtaHakCG3NpTR4btRQbtYfAwzPPg5NuWL5eI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4.14 226/237] staging: rtl8723bs: fix copy of overlapping memory
Date:   Thu, 27 Feb 2020 14:37:20 +0100
Message-Id: <20200227132312.756569432@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit 8ae9a588ca35eb9c32dc03299c5e1f4a1e9a9617 upstream.

Currently the rtw_sprintf prints the contents of thread_name
onto thread_name and this can lead to a potential copy of a
string over itself. Avoid this by printing the literal string RTWHALXT
instread of the contents of thread_name.

Addresses-Coverity: ("copy of overlapping memory")
Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20200126220549.9849-1-colin.king@canonical.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
@@ -486,14 +486,13 @@ int rtl8723bs_xmit_thread(void *context)
 	s32 ret;
 	struct adapter *padapter;
 	struct xmit_priv *pxmitpriv;
-	u8 thread_name[20] = "RTWHALXT";
-
+	u8 thread_name[20];
 
 	ret = _SUCCESS;
 	padapter = context;
 	pxmitpriv = &padapter->xmitpriv;
 
-	rtw_sprintf(thread_name, 20, "%s-"ADPT_FMT, thread_name, ADPT_ARG(padapter));
+	rtw_sprintf(thread_name, 20, "RTWHALXT-" ADPT_FMT, ADPT_ARG(padapter));
 	thread_enter(thread_name);
 
 	DBG_871X("start "FUNC_ADPT_FMT"\n", FUNC_ADPT_ARG(padapter));


