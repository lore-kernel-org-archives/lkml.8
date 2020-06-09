Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABE6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 02:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 502A32078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 02:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nbplERD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgFICbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 22:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgFICbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 22:31:49 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CFDC03E969
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 19:31:49 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ga6so711730pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 19:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Uf7YxA2IP95xtQMwprvHZh/+brkgKT+D9GOzcVjR1js=;
        b=nbplERD3lm2DyeLKL2MPAt3tYmAKmi4rs6mqX1hQnIbHOCvx4okJf/YogwePZaBS5O
         mv1ZZ1XwUzjhnCNuRrgohfhCEu516KvH0pOC0shDmW6urtRwZjrAq6tBgbqWEBK2Hdte
         IY0BXEJIPS+/Iabps7k/cmr5qsZ12eLTtv9F2kMRWYRqyuZIvrzi639LlUq26G1r28f0
         7HiiGDy98/bv2znYier20wDPrURl6WqO8J3i2AEIshYdH9eCkGcMqfHVXgK908ddr2qE
         5pkVdDEnzKmOUqKL+J4XERZ9Da4oX4rRtDudgf2iwsCPy0zrnKmpyW5460FhXk8V/dZS
         QEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Uf7YxA2IP95xtQMwprvHZh/+brkgKT+D9GOzcVjR1js=;
        b=TY9HM0llYxaGn/DwhstGALwPrj+sJ89ii9oTFH27qB00Mc+eMsG0fl+w2UqLS+ixI3
         DoS1/ofULa05FagZccG4VlljsKLxKgKrP/IxM+d53fqCYz6blxwuWOCevOb8UAdVk0b+
         ywWT7z/CTS0TyOmQEGu6R5QBpls6RlA1mm2B7yt+rIlo+XLjV0WkwPhoW/UzTeHdajvX
         Z6Sz+Nr1UJUrbL5p5I2lT3qwWQeOlw8GHpRdC8YBSuu1KXN9NAKSqS/gp0OmaRzaNjH6
         JEDwsEYDqTCr1QTE8qNK5dvJqi099Sr/sV/d0Z8ujU0z1QQYJ9lsLPtVO/2coo2V860g
         MTmg==
X-Gm-Message-State: AOAM530BduTX+TOCsMDITf2+J1aw2NzKeyMIbORkIm9V6v3i74Q1VqG9
        GTJzVm6wlMfbjytKk/KS4MOOgQ==
X-Google-Smtp-Source: ABdhPJyPmc6nD146PWpr/frnGgN6NECuEUJLdwlEejutFdIY225WMaQ8w6UrY80doaVyy1+g6urU+w==
X-Received: by 2002:a17:90a:9484:: with SMTP id s4mr2312969pjo.30.1591669908883;
        Mon, 08 Jun 2020 19:31:48 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id x2sm8301376pfj.142.2020.06.08.19.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 19:31:47 -0700 (PDT)
Date:   Mon, 8 Jun 2020 19:31:47 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
cc:     Christoph Hellwig <hch@lst.de>, alsa-devel@alsa-project.org,
        bp@alien8.de, hch@infradead.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        Pavel Machek <pavel@ucw.cz>, perex@perex.cz,
        tglx@linutronix.de, tiwai@suse.com, x86@kernel.org
Subject: Re: next-0519 on thinkpad x60: sound related? window manager crash
In-Reply-To: <1591624340.z01ejtod28.none@localhost>
Message-ID: <alpine.DEB.2.22.394.2006081928070.148886@chino.kir.corp.google.com>
References: <20200520111136.GA3802@amd> <1591545088.74ii116nf2.none@localhost> <20200608061950.GA17476@lst.de> <1591624340.z01ejtod28.none@localhost>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jun 2020, Alex Xu (Hello71) wrote:

> Excerpts from Christoph Hellwig's message of June 8, 2020 2:19 am:
> > Can you do a listing using gdb where this happens?
> > 
> > gdb vmlinux
> > 
> > l *(snd_pcm_hw_params+0x3f3)
> > 
> > ?
> > 
> 
> (gdb) l *(snd_pcm_hw_params+0x3f3)
> 0xffffffff817efc85 is in snd_pcm_hw_params (.../linux/sound/core/pcm_native.c:749).
> 744             while (runtime->boundary * 2 <= LONG_MAX - runtime->buffer_size)
> 745                     runtime->boundary *= 2;
> 746
> 747             /* clear the buffer for avoiding possible kernel info leaks */
> 748             if (runtime->dma_area && !substream->ops->copy_user)
> 749                     memset(runtime->dma_area, 0, runtime->dma_bytes);
> 750
> 751             snd_pcm_timer_resolution_change(substream);
> 752             snd_pcm_set_state(substream, SNDRV_PCM_STATE_SETUP);
> 753
> 

Working theory is that CONFIG_DMA_NONCOHERENT_MMAP getting set is causing 
the error_code in the page fault path.  Debugging with Alex off-thread we 
found that dma_{alloc,free}_from_pool() are not getting called from the 
new code in dma_direct_{alloc,free}_pages() and he has not enabled 
mem_encrypt.

So the issue is related to setting CONFIG_DMA_COHERENT_POOL, and not 
anything else related to AMD SME.  He has a patch to try out, but I wanted 
to update the thread in case there are other ideas to try other than 
selecting CONFIG_DMA_NONCOHERENT_MMAP only when CONFIG_DMA_REMAP is set 
(and not CONFIG_DMA_COHERENT_POOL).
