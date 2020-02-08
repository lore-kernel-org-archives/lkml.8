Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6930AC35242
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 02:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E34E22314
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 02:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mSKNR7w2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbgBHCC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 21:02:56 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45296 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbgBHCCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 21:02:54 -0500
Received: by mail-ot1-f66.google.com with SMTP id 59so1161055otp.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 18:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ZL1vw2AXxwnJQ2itrk5zfzZQ8p6ax5CM4oF2dWGGnQc=;
        b=mSKNR7w2E2yDs943NNg37EL3/vyyqIeWtfn+pvbMxm6Ppu9/jMXRV5puYVNqkZWAbJ
         IA++lHgYp8J4Ttq/NxqrwtOg4pJ+0VoUwyelqs6zdwL/XbMeKk2J/+JQwpve+qA+2B6l
         c6hvByKoNep9vf8QExch1b2nYfgHciDzQmhRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZL1vw2AXxwnJQ2itrk5zfzZQ8p6ax5CM4oF2dWGGnQc=;
        b=oFmBAOWKVZRcPDCLrAdzJXUMMIhF4Gv2Po2yRIjfd6pxXFNU3MxHfxNVj4QqW61SGp
         QbD0C8FGf49zAvJR8pdO4LLfsFhEoxBxKy/19QMOK45XDAIKLve8GQXKbvORLhtDS59L
         p/mRRmIcUdjWhsN3+nHQTElztI+iIYSqcwqtiOuj3VLE0/tX/SxfhDFXlToe7ifhgKrr
         zDnwnDamCA6rTRZ96kZwINEkCr836sDJIzsqhWx/9y3G0QP9imfHW8aETMIUeTghtSVV
         Uc8+NZTSh2YIski1PrCaBmPJ2r4dJ6UsWhp9kT1VS4+Uz2xNSvqv8ExPD4QvmqD0Q4SK
         TiYA==
X-Gm-Message-State: APjAAAVYXJYTqkICanc86WY+wxbWEamwQZIPlsO1GPUYbP2TqdP4unEw
        fO2/2Ioe0LSN0qt4DbA0tBUsig==
X-Google-Smtp-Source: APXvYqy16hNfOnp4HG5nW1dbIIaqb7qga2IbA8K9tC05B9Y8mof43qotvfzTXHFB7Pos82dfVCYL1w==
X-Received: by 2002:a9d:5e9:: with SMTP id 96mr1788864otd.307.1581127373870;
        Fri, 07 Feb 2020 18:02:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i12sm1803428otk.11.2020.02.07.18.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 18:02:53 -0800 (PST)
Date:   Fri, 7 Feb 2020 18:02:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: rename missed uaccess .fixup section
Message-ID: <202002071754.F5F073F1D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the uaccess .fixup section was renamed to .text.fixup, one case was
missed. Under ld.bfd, the orphaned section was moved close to .text
(since they share the "ax" bits), so things would work normally on
uaccess faults. Under ld.lld, the orphaned section was placed outside
the .text section, making it unreachable. Rename the missed section.

Link: https://github.com/ClangBuiltLinux/linux/issues/282
Link: https://bugs.chromium.org/p/chromium/issues/detail?id=1020633#c44
Link: https://lore.kernel.org/r/nycvar.YSQ.7.76.1912032147340.17114@knanqh.ubzr
Fixes: c4a84ae39b4a5 ("ARM: 8322/1: keep .text and .fixup regions closer together")
Cc: stable@vger.kernel.org
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Reported-by: Manoj Gupta <manojgupta@google.com>
Debugged-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
I completely missed this the first several times I looked at this
problem. Thank you Nicolas for pushing back on the earlier patch!
Manoj or Nathan, can you test this?
---
 arch/arm/lib/copy_from_user.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
index 95b2e1ce559c..f8016e3db65d 100644
--- a/arch/arm/lib/copy_from_user.S
+++ b/arch/arm/lib/copy_from_user.S
@@ -118,7 +118,7 @@ ENTRY(arm_copy_from_user)
 
 ENDPROC(arm_copy_from_user)
 
-	.pushsection .fixup,"ax"
+	.pushsection .text.fixup,"ax"
 	.align 0
 	copy_abort_preamble
 	ldmfd	sp!, {r1, r2, r3}
-- 
2.20.1


-- 
Kees Cook
