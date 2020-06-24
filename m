Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01035C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 04:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C89392070E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 04:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKiltaF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388795AbgFXD7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 23:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388393AbgFXD7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 23:59:37 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CBCC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 20:59:36 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x202so651868oix.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 20:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnEdc0adKymab+qTSEaLkwtzD9ZgZSbPfaKonk964fY=;
        b=OKiltaF1uMCaw3/rXHHtnDBJq6LDvUOveCzJD8ZGFs3252odcaMZM+EWC1P5hQVuj+
         +dCZcBqeK9VpAr4JzKe7Ipid7gGEWu0QpazZSY7IDTV3pdEpyVdeL4ZgYW4w78TcaTbb
         QVeTm5wzTZXwn8jqVd6Hu5K/wnUooTFiOc3f6c1rO/EeNK2H5kCJG4eCLC/Iak1kTBI0
         D+afQNI7Xn4vkw2TVyp+n8Jr9awtSpGiDbcfmWatJgOiXgiYejsdQWr34mGkRkBtp9OE
         wB469Ra0RALYhJkazPozIBZE7pkqgaRCUkTw1bAxLI7Olzdz7UtT4MCpddyqyB9kl+fR
         mi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnEdc0adKymab+qTSEaLkwtzD9ZgZSbPfaKonk964fY=;
        b=B/ySDIyfnuk0/IUK/XYuG4sLQaGoBLpFKZuclAPSkS5rf4JRgYpC8rO7gW5pxr94qF
         Dhg/knI6OthSS3YwwLKfDQv6eoqqKM7lxKNA12l031bHqKlhrY067wdj/G53EnZD8ePK
         NxZeSGaENkDbOFB566uJHytZ3DX0Gdwpw7SeDCAKeYFDoV0QLXHuXWIZkdaXZahm3tKa
         YwCRn2Zk091tCoEDigIoO8Owut4AaS5LYU/6DeyJjvEmWNFWKAHcmdy0/lkp92oX51E0
         3Xi6m+VDZXqdZWCCLcv6YvBbcc05Zag25S1H85OziBOqqZv52wHDNh+79yAz74MnxFhB
         7JBw==
X-Gm-Message-State: AOAM530l0HXyCu+Uc+LGQQfAabskqRI8+fvu0fJh2sDGC5/3RBxp5E5O
        2AHwehYrq5+K/GGpEVxgmHw=
X-Google-Smtp-Source: ABdhPJw2T7FOEBgquf/Z1s88BHwaqOlkic9kTzx/Dy1aJI7YmtncjwU5hZZUgPhTjGDmapGzZaM5bQ==
X-Received: by 2002:aca:1e0b:: with SMTP id m11mr19113749oic.147.1592971176070;
        Tue, 23 Jun 2020 20:59:36 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id m20sm4538380ots.13.2020.06.23.20.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 20:59:35 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Geoff Levand <geoff@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Joel Stanley <joel@jms.id.au>
Subject: [PATCH] powerpc/boot: Use address-of operator on section symbols
Date:   Tue, 23 Jun 2020 20:59:20 -0700
Message-Id: <20200624035920.835571-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

arch/powerpc/boot/main.c:107:18: warning: array comparison always
evaluates to a constant [-Wtautological-compare]
        if (_initrd_end > _initrd_start) {
                        ^
arch/powerpc/boot/main.c:155:20: warning: array comparison always
evaluates to a constant [-Wtautological-compare]
        if (_esm_blob_end <= _esm_blob_start)
                          ^
2 warnings generated.

These are not true arrays, they are linker defined symbols, which are
just addresses.  Using the address of operator silences the warning
and does not change the resulting assembly with either clang/ld.lld
or gcc/ld (tested with diff + objdump -Dr).

Link: https://github.com/ClangBuiltLinux/linux/issues/212
Reported-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/powerpc/boot/main.c | 4 ++--
 arch/powerpc/boot/ps3.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index a9d209135975..cae31a6e8f02 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -104,7 +104,7 @@ static struct addr_range prep_initrd(struct addr_range vmlinux, void *chosen,
 {
 	/* If we have an image attached to us, it overrides anything
 	 * supplied by the loader. */
-	if (_initrd_end > _initrd_start) {
+	if (&_initrd_end > &_initrd_start) {
 		printf("Attached initrd image at 0x%p-0x%p\n\r",
 		       _initrd_start, _initrd_end);
 		initrd_addr = (unsigned long)_initrd_start;
@@ -152,7 +152,7 @@ static void prep_esm_blob(struct addr_range vmlinux, void *chosen)
 	unsigned long esm_blob_addr, esm_blob_size;
 
 	/* Do we have an ESM (Enter Secure Mode) blob? */
-	if (_esm_blob_end <= _esm_blob_start)
+	if (&_esm_blob_end <= &_esm_blob_start)
 		return;
 
 	printf("Attached ESM blob at 0x%p-0x%p\n\r",
diff --git a/arch/powerpc/boot/ps3.c b/arch/powerpc/boot/ps3.c
index c52552a681c5..6e4efbdb6b7c 100644
--- a/arch/powerpc/boot/ps3.c
+++ b/arch/powerpc/boot/ps3.c
@@ -127,7 +127,7 @@ void platform_init(void)
 	ps3_repository_read_rm_size(&rm_size);
 	dt_fixup_memory(0, rm_size);
 
-	if (_initrd_end > _initrd_start) {
+	if (&_initrd_end > &_initrd_start) {
 		setprop_val(chosen, "linux,initrd-start", (u32)(_initrd_start));
 		setprop_val(chosen, "linux,initrd-end", (u32)(_initrd_end));
 	}

base-commit: 3e08a95294a4fb3702bb3d35ed08028433c37fe6
-- 
2.27.0

