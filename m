Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F640C35240
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 03:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8A1206D5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 03:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACojz0Ii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgAZDQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 22:16:10 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45205 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbgAZDQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 22:16:09 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so6282017qkl.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 19:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version;
        bh=3xZp8vrOAuOOQ1xHL+BM+C43h6UE60eT1akLRCXtuAs=;
        b=ACojz0IiVuJBtkpcQqLGT/IsaS+GinlPsoTuAym83lDEvID2SKRiX+QgChFrf+J567
         ALH30bb2TrUKZpst9eFSCu5YvcFQp62qGTWdb0eub7gXJA8wteeX7nkZOdEyaiV8E7lA
         CepyKHqdGAl87QXdbyGtsjeNhADXpgkuuEEu47aWKWxuYWVEjqhXNfUDW2wx/SUPKipb
         iVvRXtse0uInCYSykVXUs987MeHTT6OJINu5ei9IWOs/tt3iL0Yvnxexo0JUANzk3QIq
         n2IFqSsMfoBEpthqnrx3+EGe2tdmec9uwZ/UOCUBr/6knSK2fS7hM6C6BO/9W52nCOBE
         5h5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version;
        bh=3xZp8vrOAuOOQ1xHL+BM+C43h6UE60eT1akLRCXtuAs=;
        b=sccvaHkAaIRKyGE415eN1qgKEwNBRZPH/g2Lm9VKZHpGSN5HlKX5RmAtsLZEYdjM7A
         6cif6vJrode5satT6WVio7sY5MtVFYSL0/K/mxkXAqQW5nYtEpUR2/xMhWdQu5qnedl3
         WOpT9+DvovfizvdG2vuNxoxoNgPAyB7+RF9rqDOr9uGMA3xvgl3NYKPGVFtuZfB8uq1T
         TRyEwnNWuT7/DTDH5b3Oj0pX3q61apvLqWH9eYRtCvY/DnLRvZGtMysRU6sJzef/q10y
         cq++t4I9lNjqoWmI+xD4XilrgnGLtlGUwsROfBQXVTECMPnY12l8ny7QGbRty5673gPE
         Vtlw==
X-Gm-Message-State: APjAAAVoC9tKbmQ3q0Akz9aOPbeaiE9WcAsZsxzKMp/GsKQmP1HMQZQt
        PM/+XZOXNw+AISiSJmDdv9Fw3Kv75w==
X-Google-Smtp-Source: APXvYqyZ/uqvTvy864X99ZunW1Rl7DCCElFl71XtPlIOLunlNvdzOOiCw41+k7LsRA1kP2aD4OS2UQ==
X-Received: by 2002:a37:9ed3:: with SMTP id h202mr11049971qke.456.1580008568432;
        Sat, 25 Jan 2020 19:16:08 -0800 (PST)
Received: from [120.7.1.38] ([184.175.21.212])
        by smtp.gmail.com with ESMTPSA id f97sm6921319qtb.18.2020.01.25.19.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Jan 2020 19:16:07 -0800 (PST)
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     ben@decadent.org.uk
From:   Woody Suwalski <terraluna977@gmail.com>
Subject: [PATCH] fix 3.16 unknown rela relocation 4 error
Message-ID: <48d562fd-f80a-69ae-56e5-d0bada0feeed@gmail.com>
Date:   Sat, 25 Jan 2020 22:16:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:52.0) Gecko/20100101 Firefox/52.0
 SeaMonkey/2.49.5
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------556E9E7D66A6EAFDDCA5DC60"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------556E9E7D66A6EAFDDCA5DC60
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Trying to use an AMD64 3.16 kernel built on a new Debian system fails 
because
most of the kernel modules can not be loaded.

This patch handles the PLT32 relocation errors for kernels modules built 
with binutils
newer then 2.31, similar to:
[    5.742485] module: autofs4: Unknown rela relocation: 4
[    5.742536] systemd[1]: Failed to insert module 'autofs4': Exec 
format error

This patch is based on a mainline kernel patch 
b21ebf2fb4cde1618915a97cc773e287ff49173e
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Wed, 7 Feb 2018 14:20:09 -0800
Subject: x86: Treat R_X86_64_PLT32 as R_X86_64_PC32

Signed-off-by: Woody Suwalski <terraluna977@gmail.com>

--- a/arch/x86/tools/relocs.c    2020-01-24 18:48:09.477919152 -0500
+++ b/arch/x86/tools/relocs.c    2020-01-24 18:48:53.645612045 -0500
@@ -763,6 +763,7 @@ static int do_reloc64(struct section *se
      switch (r_type) {
      case R_X86_64_NONE:
      case R_X86_64_PC32:
+    case R_X86_64_PLT32:
          /*
           * NONE can be ignored and PC relative relocations don't
           * need to be adjusted.
--- a/arch/x86/kernel/module.c    2020-01-24 18:46:54.922670590 -0500
+++ b/arch/x86/kernel/module.c    2020-01-24 18:47:46.714112016 -0500
@@ -180,6 +180,7 @@ int apply_relocate_add(Elf64_Shdr *sechd
                  goto overflow;
              break;
          case R_X86_64_PC32:
+        case R_X86_64_PLT32:
              val -= (u64)loc;
              *(u32 *)loc = val;
  #if 0


--------------556E9E7D66A6EAFDDCA5DC60
Content-Type: text/x-patch;
 name="reloc_PLT32_3.16.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reloc_PLT32_3.16.diff"

Handle the PLT32 reloacation errors for kernels binaries built with binutils
newer then 2.31, similar to:
[    5.742485] module: autofs4: Unknown rela relocation: 4
[    5.742536] systemd[1]: Failed to insert module 'autofs4': Exec format error

This patch is based on a mainline kernel patch b21ebf2fb4cde1618915a97cc773e287ff49173e
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Wed, 7 Feb 2018 14:20:09 -0800
Subject: x86: Treat R_X86_64_PLT32 as R_X86_64_PC32

Signed-off-by: Woody Suwalski <terraluna977@gmail.com>

--- a/arch/x86/tools/relocs.c	2020-01-24 18:48:09.477919152 -0500
+++ b/arch/x86/tools/relocs.c	2020-01-24 18:48:53.645612045 -0500
@@ -763,6 +763,7 @@ static int do_reloc64(struct section *se
 	switch (r_type) {
 	case R_X86_64_NONE:
 	case R_X86_64_PC32:
+	case R_X86_64_PLT32:
 		/*
 		 * NONE can be ignored and PC relative relocations don't
 		 * need to be adjusted.
--- a/arch/x86/kernel/module.c	2020-01-24 18:46:54.922670590 -0500
+++ b/arch/x86/kernel/module.c	2020-01-24 18:47:46.714112016 -0500
@@ -180,6 +180,7 @@ int apply_relocate_add(Elf64_Shdr *sechd
 				goto overflow;
 			break;
 		case R_X86_64_PC32:
+		case R_X86_64_PLT32:
 			val -= (u64)loc;
 			*(u32 *)loc = val;
 #if 0

--------------556E9E7D66A6EAFDDCA5DC60--
