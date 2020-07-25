Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2ADC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 18:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B61D5206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 18:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="0AVLkDg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgGYSYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 14:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgGYSYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 14:24:48 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E2FC08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 11:24:46 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s189so7144664pgc.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 11:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=g5KV4oQr9blE2xaUSgxxVlTAVbR4qnTHAPsngn5VHhU=;
        b=0AVLkDg4gvYXOyCyuaQ/UyC2NTl8sa7rUS972GkzEEkWYey9OY2uwFrAoxMvrbUKk6
         x6uShijEDCqjc3W/VfyzX2UUHz4g3J7vJoapE7AN0jar+CW7JDQOm4KxbJ6uMPSkdx/j
         /sfQhtEJQkzDwZCKtZ3dUovhjSMG3beQI9c+4ND3zgsPal5T3b9h+wTjClcJZ8OZbgla
         qooCMTDklefjTGQtl7HKpdN21EPGnLV2HpQRFsQux3YcaBcXNIXPpewlNW/QoFke8JiM
         FJ7zNZK7IkOtQIjbkhs9mvA2AaGpuCYX69o7w6BMoCz8rTLhCAaLD4gMBY+r/o+6LtFT
         gWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=g5KV4oQr9blE2xaUSgxxVlTAVbR4qnTHAPsngn5VHhU=;
        b=leSV+FG3BAcEk2SlM96kQiyxMZPPY/F4LyA6T4cPFzKpR+SJNmiSVr1miX02xFLyJE
         LfxGL/fXsEKkgFtavBoPTLdan38QhPp8HkTcLhuyZuJ+dTSt/Mlbq777rKCAVEUNo2ru
         EtmCh7K1GmZTA8Z7xrD22gvm8LEZl4V/oNfiVtDOpfyHiKqR4r1pcITIG/HO0JoYSiNU
         pzsXXSW8q3CtmStOPO8iEMYtRFBx1GL+CTOf0cC0JVu/OA9wqmphJlHr1RJAcWv+5yU0
         3wbP/kJJOZzG45XZmAhJA6jaWq7A5dh/zo73EBMMbvbsjGzAu8GUFIAufr2GY0CCjMlk
         ZbxQ==
X-Gm-Message-State: AOAM533lYNb8MyMZ+3GvB5FjQZvwsFbwpcJ7Fy+Jn77goBeGdW3EjGx1
        zVWY9fo9pPeYH3As0AvnRUxF3LDJ4bg=
X-Google-Smtp-Source: ABdhPJws9Ncp+xuPpJvv/8k128LHXFkxmXtpwAUE3C5X74SuXudwiFvjH0EoAMdDaY+TX1yoajakZw==
X-Received: by 2002:a63:9342:: with SMTP id w2mr13144548pgm.20.1595701486207;
        Sat, 25 Jul 2020 11:24:46 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id m9sm9046242pjs.18.2020.07.25.11.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 11:24:45 -0700 (PDT)
Date:   Sat, 25 Jul 2020 11:24:45 -0700 (PDT)
X-Google-Original-Date: Fri, 24 Jul 2020 22:21:16 PDT (-0700)
Subject:     Re: [PATCH 0/2] Fix some build warnings when W=1
In-Reply-To: <cover.1594880014.git.zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-7bb6277d-bca5-4cd0-a791-3fa2b9891f69@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 23:15:25 PDT (-0700), zong.li@sifive.com wrote:
> These patches fix some build warnings when W=1, the most of warnings are
> missing prototype as follows:
>
> arch/riscv/mm/init.c:520:13: warning: no previous prototype for 'resource_init' [-Wmissing-prototypes]
> arch/riscv/mm/pageattr.c:130:5: warning: no previous prototype for 'set_memory_ro' [-Wmissing-prototypes]
> arch/riscv/mm/pageattr.c:136:5: warning: no previous prototype for 'set_memory_rw' [-Wmissing-prototypes]
> arch/riscv/mm/pageattr.c:142:5: warning: no previous prototype for 'set_memory_x' [-Wmissing-prototypes]
> arch/riscv/mm/pageattr.c:147:5: warning: no previous prototype for 'set_memory_nx' [-Wmissing-prototypes]
> arch/riscv/mm/pageattr.c:152:5: warning: no previous prototype for 'set_direct_map_invalid_noflush' [-Wmissing-prototypes]
> arch/riscv/mm/pageattr.c:169:5: warning: no previous prototype for 'set_direct_map_default_noflush' [-Wmissing-prototypes]
> arch/riscv/mm/pageattr.c:97:1: warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
>
> Zong Li (2):
>   riscv: Fix build warning for mm/init
>   riscv: fix build warning of mm/pageattr
>
>  arch/riscv/mm/init.c     | 2 +-
>  arch/riscv/mm/pageattr.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Thanks, these are on for-next.
