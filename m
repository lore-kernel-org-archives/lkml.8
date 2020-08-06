Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0A9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 21:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F1B2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 21:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyMVZ1mf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgHFVrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 17:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgHFVrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 17:47:03 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F9DC061574;
        Thu,  6 Aug 2020 14:47:03 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id c16so31530941ejx.12;
        Thu, 06 Aug 2020 14:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=EKBk8NjHQ8J7NnALNiPvVq0O4gNAFuSjWQHfJh6hX3Q=;
        b=fyMVZ1mfs7ZNX8WrgRQAtDq/CVbg6yXJS7spNFiJcM93nszqRdxL2ZMchvZY6QCrR3
         3+cOEG+Y1xd9YnJJWM+wuZK3xWCYzZOhhiYj6q+AeDkeffUbYDZ6NLIBd8NAmSID7Bxq
         7MWy9ewu7VDOlROulsvOX06/q0VfB0EWNYhvtFjviolKpMBrD9Pov0hiPtD+DG7EFTUw
         ohrlvq78eyZ5tCtF5Ykju4O2WfenMaCb+Y9So1NFk5Caq1vNOgeHmartDSqJ0huwC929
         PDXUu57h8dU+hs2aD3gazbZfU7AddyOEDWfRHs9I41U8OH23gHwTUTo/CVRRIL9AuzEI
         F8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EKBk8NjHQ8J7NnALNiPvVq0O4gNAFuSjWQHfJh6hX3Q=;
        b=LwmSZ9zREP62w61JzoN5vN59NAQ8pm8WjHwhwxNnMYAUIlBysSYJOQm+ZIuab13RXn
         r7VI7Y6QwIbVvLVk6PfoTsMTq7WcIT6bp0Xc3ZKUu9w1/3Rn/oRVV25/MIG+EP+4xNot
         9dngOgyT0nyFIbTiHnylYK+/oZ0qAJHYSzoSN6PKNkhmx9SNzyJ+LsM7SujH2YO8CEmo
         HW0XzLp8m7VscTztEivXyXLCwRoaPCm40X4ifUdMvq9/eMG2PEPmFHsQJnt2Qagi8jl5
         EzaNEmRD2yzw8DLMvQZ4ZyxEd4xh9Fq4GX1Vq6SYf0BWrxxQu+NOo6nnaTW24mZKcfNa
         MrCA==
X-Gm-Message-State: AOAM531ZjWys1UIaKqf8N3HhMbSw5jPOgPnPX98yTToUYP62xU52wsh2
        FVBNcZQgBF0IJy63LW4Xt6ctWq1UZ5EGya9/dBZtU/FPl5zh4Q==
X-Google-Smtp-Source: ABdhPJwwKcFOQnDy3MFNnAzspeHWWrM9iSOw1kCgSpPXNGBRFgvLY8WrybmvuwIViEpqFrhMWwDVGwx5qDFY0wjkYYA=
X-Received: by 2002:a17:906:57cc:: with SMTP id u12mr6755423ejr.422.1596750421772;
 Thu, 06 Aug 2020 14:47:01 -0700 (PDT)
MIME-Version: 1.0
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 6 Aug 2020 17:46:50 -0400
Message-ID: <CAMdYzYoqKcG+LtFZy+TeYWB=GJo8Ya60r3Los4T5j7j3Okdbtw@mail.gmail.com>
Subject: [PATCH] arm: Add support for ZSTD compressed kernel
To:     nolange79@gmail.com
Cc:     linux-kernel@vger.kernel.org, Petr Malat <oss@malat.biz>,
        Kees Cook <keescook@chromium.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Terrell <terrelln@fb.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Evening,

I had attempted to get this working as well, but have run into
difficulties with both my implementation and yours as well.
My implementation was almost the same as yours, with the exception of
also changing:
@@ -303,7 +305,7 @@ restart: adr r0, LC1

 #ifndef CONFIG_ZBOOT_ROM
  /* malloc space is above the relocated stack (64k max) */
- add r10, sp, #0x10000
+ add r10, sp, #0x30000
 #else
  /*
  * With ZBOOT_ROM the bss/stack is non relocatable,

On QEMU this implementation works fine.
However on bare metal tegra30, I get the following error:

Jumping to kernel at:4861 ms

C:0x80A000C0-0x8112BA40->0x8152C700-0x81C58080
Uncompressing Linux...

ZSTD-compressed dstSize is too small

 -- System halted

The only difference between the bare metal test and the qemu test is
the zImage with appended dtb is packaged in the android boot format
for the bare metal test.
Otherwise it's exactly the same file.

I had to modify the original zstd error message because it grouped
several errors together.
Here is my patch for that:

diff --git a/lib/decompress_unzstd.c b/lib/decompress_unzstd.c
index 062617bb0afe..89ac73e900ce 100644
--- a/lib/decompress_unzstd.c
+++ b/lib/decompress_unzstd.c
@@ -103,10 +103,14 @@ static int INIT handle_zstd_error(size_t ret,
void (*error)(char *x))
  error("Input is not in the ZSTD format (wrong magic bytes)");
  break;
  case ZSTD_error_dstSize_tooSmall:
+ error("ZSTD-compressed dstSize is too small");
+ break;
  case ZSTD_error_corruption_detected:
- case ZSTD_error_checksum_wrong:
  error("ZSTD-compressed data is corrupt");
  break;
+ case ZSTD_error_checksum_wrong:
+ error("ZSTD-compressed data checksum is wrong");
+ break;
  default:
  error("ZSTD-compressed data is probably corrupt");
  break;

Very Respectfully,
Peter Geis
