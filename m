Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5107C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC98620663
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="jqxMBWky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgDURyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgDURym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:54:42 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEB0C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 10:54:42 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id z6so5523070plk.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 10:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=fXONOcXjfzmg4/8NqYoxCOrRJXZM2a+CQjG3mmDwPyM=;
        b=jqxMBWkyITGTkyArVg5A7B3Nb+yKDX/D3KPdvqKLY0Ri6kPC86+wcydWlXG1SOVg8V
         gPL7/JGN2Gjbkmysk5ZwRZTMggUW5PqbZ+c7WvDT6PyqIIlUu1RDYF0h1KXTs+vuWCQk
         frqrtY0HOzU7OAVa8rif0uRUE7E7QiohdxG/8OKCqhRI+8F2cdqwds/1IsvZAXMW4bV1
         HjT/tbGON/oL1iBaowvcmqF/hCP70nrduT+Bls+0EwQuyGh+cSSXKk71DlHjnF6YwYny
         mA4U8duugWqlDDY/sg9LgR5jNq7QrHSStIgiyVNIQit7Jw2MWOvaiqYFHL3B6qNEO4iE
         /23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=fXONOcXjfzmg4/8NqYoxCOrRJXZM2a+CQjG3mmDwPyM=;
        b=IdRHRJ4F1/5qTqrXnYxhWwHOWVIZgaKc4dDJMBPIKewjb4hgZRqtZyKM6YiLOj4BjA
         Pm3dDeuFor1ixqayXhtmf/sk+UJslIfuUXXzof53rWagjBPwKdKj/I0YkacHDUYHL71H
         nGvZkAFGNV4ye9egsz93EOhBgHkJe+3czcUSiFdJnEtqIyXna1SkGoCYCEhWCgtxzlTv
         wqGMgWfFP9YPO3trrlwz8hO4IeIL3AmjVeTck/rdEXeHBgs3j0mNNSiTRMqqLHBhi0iX
         D0we1EaGPdbKyvLCOFhiGzOl1MIuPwLO2YdRrc0u3QBoC7c7CsolI/mHgPG0h6E/uY4n
         1Hwg==
X-Gm-Message-State: AGi0Pubh1xJXg0wxZkEexISy+bPVttvsthcMBxYkoXeOAAHUdEVAEJ4O
        Dd39k7G3DS9w5yXS4HqeGSUt1w==
X-Google-Smtp-Source: APiQypKUKHy9LqmcEHWtneAGE00iw2r9YefvUnXi4aNqVMqA5eInRhD74ETL3HPTg5l7RO2P2U2zBg==
X-Received: by 2002:a17:902:7d98:: with SMTP id a24mr5927002plm.75.1587491681259;
        Tue, 21 Apr 2020 10:54:41 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id c3sm2953665pfa.160.2020.04.21.10.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 10:54:40 -0700 (PDT)
Date:   Tue, 21 Apr 2020 10:54:40 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Apr 2020 10:50:41 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: stacktrace: Declare sp_in_global outside ifdef
In-Reply-To: <20200413161234.78346-1-linux@roeck-us.net>
CC:     aou@eecs.berkeley.edu, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     linux@roeck-us.net
Message-ID: <mhng-05436660-e53b-4e68-bb35-3e47141bdcf7@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Apr 2020 09:12:34 PDT (-0700), linux@roeck-us.net wrote:
> riscv:allnoconfig and riscv:tinyconfig fail to compile.
>
> arch/riscv/kernel/stacktrace.c: In function 'walk_stackframe':
> arch/riscv/kernel/stacktrace.c:78:8: error: 'sp_in_global' undeclared
>
> sp_in_global is declared inside CONFIG_FRAME_POINTER but used outside
> of it.
>
> Fixes: 52e7c52d2ded ("RISC-V: Stop relying on GCC's register allocator's hueristics")
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Apologies for the noise if this has already been fixed somewhere.
>
>  arch/riscv/kernel/stacktrace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> index 02087fe539c6..6c854875ac74 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -12,6 +12,8 @@
>  #include <linux/stacktrace.h>
>  #include <linux/ftrace.h>
>
> +register unsigned long sp_in_global __asm__("sp");
> +
>  #ifdef CONFIG_FRAME_POINTER
>
>  struct stackframe {
> @@ -19,8 +21,6 @@ struct stackframe {
>  	unsigned long ra;
>  };
>
> -register unsigned long sp_in_global __asm__("sp");
> -
>  void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>  			     bool (*fn)(unsigned long, void *), void *arg)
>  {

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks.  This is on fixes.
