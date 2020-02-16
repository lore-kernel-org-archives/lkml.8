Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDD4C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 11:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970F1206D6
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 11:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV54L2NJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgBPL2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 06:28:37 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36142 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBPL2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 06:28:37 -0500
Received: by mail-pl1-f195.google.com with SMTP id a6so5602501plm.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 03:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ldWzck2c3LD7o1k5UxrvQt5EP0uHeWJ6qrwVSuPjz8g=;
        b=eV54L2NJyt+0NF3drKExSE/tx4A9tnD0dAqd1eqHAFsqWTmUtoffDKEWl76y7/zNXm
         SC39jU4/Ky4laA6B5D9NBAWJSvL4JLYVBes84KZNRmXFRn2Z/KIe8IkBgUBM9+c5SWok
         qhTwuvMSOtlwB9BbSpOmdkmQJ+322u2dcBifFWQRIdqakn6uOF4wIbchS8z9JnOtzPO/
         4wQNrB9YxIrgST6GWx3rmX7DIST0gi6ABpiguqwH+q/w/gUUeWshFTNjbOcFcZPN8Dyp
         w0QR2uTavcyxsnxptdj2NLXO+ovpaGETfDRACrcPwRS4spzKjhJcQ8JAs/ZCA7j5nWXE
         2Ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ldWzck2c3LD7o1k5UxrvQt5EP0uHeWJ6qrwVSuPjz8g=;
        b=hT8lJ3rOAF5WRyTexLPMXyPYGKkV0A5igQOkYQptvCY48rs30liXWIGN5UZS5nSusk
         r1Hrh2GZHEqMIzYIlvrxqD9SdeNMRGQorkCu9DLiBs4AUlEHT9lSdnlMMiQDXPo8eo8w
         05d3wklxPBxztLNBYXE7RFABny4gGKuZUSgMAKfRIdwiPwA8b3IAknY5HRDD+xXbS71B
         vRP5ZHh5XVkGdXW+Zt8Vg6FSRHiJJzIs6FETQtdfNOfIiAnuctIz3ggYbAIk8uOLwt2m
         qaGPBdNEXKnXegbLC6JVVqz5IGTTGh4hTZVf6zgzfpDZqtmXMr7EUKZ1jMbpyzXkMqA5
         IaUA==
X-Gm-Message-State: APjAAAXxW1b4CvSN/eMdZDcb3Dv8IOpSGuRUFe3kT5JiqlvYrRgdgnSW
        dshmC2bleTSs5MMJLVuZrJQ=
X-Google-Smtp-Source: APXvYqxRU3PSFd3cBvBKc6gAZq7NCs/W+Dhx9qbKb95ivTWo83lgzS2GBGEnChnMxQ82fqnsxr45Bw==
X-Received: by 2002:a17:902:7009:: with SMTP id y9mr11659769plk.254.1581852516699;
        Sun, 16 Feb 2020 03:28:36 -0800 (PST)
Received: from VM_0_35_centos.localdomain ([150.109.62.251])
        by smtp.gmail.com with ESMTPSA id a19sm12658783pju.11.2020.02.16.03.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Feb 2020 03:28:36 -0800 (PST)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     akpm@linux-foundation.org
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, keescook@chromium.org,
        rppt@linux.ibm.com, linux@dominikbrodowski.net,
        nivedita@alum.mit.edu, nadav.amit@gmail.com, glider@google.com,
        linux-kernel@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] init/main.c: mark boot_config_checksum static
Date:   Sun, 16 Feb 2020 19:28:31 +0800
Message-Id: <1581852511-14163-1-git-send-email-hqjagain@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fact, this function is only used in this file, so mark it with 'static'.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 init/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index f95b014..534589f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -335,7 +335,7 @@ static char * __init xbc_make_cmdline(const char *key)
 	return new_cmdline;
 }
 
-u32 boot_config_checksum(unsigned char *p, u32 size)
+static u32 boot_config_checksum(unsigned char *p, u32 size)
 {
 	u32 ret = 0;
 
-- 
1.8.3.1

