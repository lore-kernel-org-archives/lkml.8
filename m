Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054FFC433E5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA0EA20715
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 18:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nG3iBDXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgGZShF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 14:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgGZShC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 14:37:02 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AD2C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 11:37:01 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i92so660146pje.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 11:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=JnUU93WKUKWrXbn9kgNlLm9JHar+29seJwT67nss/Ow=;
        b=nG3iBDXv6+813nvKzqFi/7D1yujtCUMoArCy+DcXTmZ4I+ju4cUuNU7FW7uA5qY49Z
         ahZqNfeUh/0ve0ztq5LULa1EdAVrpXYDBPr6fNriCImZTYtzcyey4UvcFxtlbUZhf6K+
         dBMM/A/8iLFwllKgkA9vjtMBbEawjuQICs3wmlYinNGG/5h0dW1M5DxVk99vKXZn0XVy
         ANwa+nPHlWm3+6Hw/FXfkx2MdNSxPUaAHqWd8lwl6ZvyE3dpmGdtRQ3AODmaQRqLyPtY
         6lPlKthvNWbkEmlUgXvS6Y34a9+GTfX+QnlxmES6i6gOxi4ETMgasw0oEqkeVJZv4+jy
         7hgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=JnUU93WKUKWrXbn9kgNlLm9JHar+29seJwT67nss/Ow=;
        b=uf3Smh9z+JS+2M63icAHhbMAQx0GtJFlU6sbKE970v9PNujJ5wu79KzptsEkvAwcYl
         ocYdePNh3bkrJc5yB2xlaFEk60+BrqOGRSH/DDBA5bmSBfXBYY784z18zrCiRJxuFLGT
         iaQTNdW1AR3hXPYe2U+KRoLn9YlYoJhhH3FEiYbx6QHK2hRSWyDVRpX5Mmdfxx68sRD8
         wX4o68TEKbLgJ6GDB2yPpBoc1rf4MfSZbbKzMaOhOLFzjeWQm9ZpUzw2QNAZN6w/mczO
         KBqAXdxaWIlgMUEjG2wOONiF/N3MbUJOYvx6H5gMqWaNJmQg6tqNCjiq9XjA/j7cQINC
         42Qg==
X-Gm-Message-State: AOAM5304GUdwVmN7w/uZX5v8X63NZLnZjQK1NgaRiOJNCBeRhv/hNgIG
        DUjLOO/ZZncuxEa/1Z3/Y43XfvJYkeA=
X-Google-Smtp-Source: ABdhPJx6qjIBH11BxaatM2ew4upUkR6JBUEegthI6NcPTsjsf+zkeU/A6V44/q74Th3YbWdN+FdGdQ==
X-Received: by 2002:a17:90a:bf04:: with SMTP id c4mr2738242pjs.149.1595788619210;
        Sun, 26 Jul 2020 11:36:59 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id c125sm11977747pfa.119.2020.07.26.11.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 11:36:58 -0700 (PDT)
Date:   Sun, 26 Jul 2020 11:36:58 -0700 (PDT)
X-Google-Original-Date: Sun, 26 Jul 2020 10:59:11 PDT (-0700)
Subject:     Re: [PATCH AUTOSEL 4.19 18/19] RISC-V: Upgrade smp_mb__after_spinlock() to iorw,iorw
In-Reply-To: <20200720213851.407715-18-sashal@kernel.org>
CC:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        sashal@kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     sashal@kernel.org
Message-ID: <mhng-5bf9e67f-f6f9-4c9b-9d56-afd0a6e21cd6@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 14:38:49 PDT (-0700), sashal@kernel.org wrote:
> From: Palmer Dabbelt <palmerdabbelt@google.com>
>
> [ Upstream commit 38b7c2a3ffb1fce8358ddc6006cfe5c038ff9963 ]
>
> While digging through the recent mmiowb preemption issue it came up that
> we aren't actually preventing IO from crossing a scheduling boundary.
> While it's a bit ugly to overload smp_mb__after_spinlock() with this
> behavior, it's what PowerPC is doing so there's some precedent.
>
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/riscv/include/asm/barrier.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
> index d4628e4b3a5ea..f4c92c91aa047 100644
> --- a/arch/riscv/include/asm/barrier.h
> +++ b/arch/riscv/include/asm/barrier.h
> @@ -69,8 +69,16 @@ do {									\
>   * The AQ/RL pair provides a RCpc critical section, but there's not really any
>   * way we can take advantage of that here because the ordering is only enforced
>   * on that one lock.  Thus, we're just doing a full fence.
> + *
> + * Since we allow writeX to be called from preemptive regions we need at least
> + * an "o" in the predecessor set to ensure device writes are visible before the
> + * task is marked as available for scheduling on a new hart.  While I don't see
> + * any concrete reason we need a full IO fence, it seems safer to just upgrade
> + * this in order to avoid any IO crossing a scheduling boundary.  In both
> + * instances the scheduler pairs this with an mb(), so nothing is necessary on
> + * the new hart.
>   */
> -#define smp_mb__after_spinlock()	RISCV_FENCE(rw,rw)
> +#define smp_mb__after_spinlock()	RISCV_FENCE(iorw,iorw)
>
>  #include <asm-generic/barrier.h>

While I don't think it hurts to have this, IIRC we didn't have the generic
mmiowb spinlock stuff back then so it doesn't really fix the problem.  That
said, I'm pretty sure 4.19 doesn't make it to userspace so backports are really
an academic discussion at this point.  Whatever's less work for everyone is
fine on my end for 4.19.
