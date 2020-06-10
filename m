Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F52C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF1EF20734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MP3qU7v9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgFJF0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 01:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgFJF0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 01:26:48 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D618EC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 22:26:47 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so505806plv.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 22:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=C73zglBEMDME+CuVXUOa9MjlW4GPGi1nqlramfoTPEc=;
        b=MP3qU7v9ubA5PsvIyBe22857HQx1uPmTikkmoVl/+DWB2/6bH8no5xBs8enWPSEGPs
         5VcdODk+KczV28hHqzEfvUZ9628Dm+p8XahYiutGXrES6XFxDJynneRvSg0F3rvb1+2M
         gpI/0BLnny7aU41jjv7OEEX9p58UtD4D83Vf1l1XrCzmlDCtj75XfbALQvo/gCWgww9P
         CfGxx2FBKrdVlzmTwj/IUl3nBYswJ8Ej/TXeB0vJVCOAq6r3UfmnCvB+jBoHg767wI1m
         V9taJ7Fq3JajMl2YoPwgyQ8Et5Nm8i/eKBEnmbU/mOyeTY/+lEnzknBEOecFVgDjCPlp
         VLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=C73zglBEMDME+CuVXUOa9MjlW4GPGi1nqlramfoTPEc=;
        b=RcVIAIezc+W0SIoPjC+TeWyqvSi4QXTZ0d8T7I+07PZLEaZ/ZHr5sICv8azoEQzmv4
         iEBSyoDAUbtAEZm0iAT2n9vlrQ2tB0eps/JHgw+ydet5N9cqcljZrMxlWe332wK6V8Ao
         Tny8LrxvCmVsuEB+A3FIWFRzN/oluU4LYT7m7o6fPvpdcNQVR8jx1Dv5mfieustibH6o
         t8XSfH4kug/HZqSn6CSIwQFFYkfen0ReE9uk3eFerf810vI1akJ8KkotSzG1FgeIgmCV
         6FMPeLsNF9S8HoJvhyaoH6YCPaaoko0pClgTR7DZIXLp299qIX/YmC2RWI817R4uulvy
         O9MA==
X-Gm-Message-State: AOAM531kge33wDjs3ucDDE7fS6gqznUguMzL3SWJ55dxn6OtrAkhM3te
        JT2Nao9rJH2eF1Dc+/VXIax0vA==
X-Google-Smtp-Source: ABdhPJzu5FJVYb5R0O5mf0gZObl8Y1JRKbIsp1Gc70W/r+j0vRWjar/v+mzNeEGFzkzPksaIYHxV6g==
X-Received: by 2002:a17:902:aa92:: with SMTP id d18mr1602231plr.127.1591766807153;
        Tue, 09 Jun 2020 22:26:47 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id x2sm11477140pfj.142.2020.06.09.22.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 22:26:46 -0700 (PDT)
Date:   Tue, 9 Jun 2020 22:26:45 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>
cc:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        alsa-devel@alsa-project.org, bp@alien8.de, hch@infradead.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        Pavel Machek <pavel@ucw.cz>, perex@perex.cz,
        tglx@linutronix.de, tiwai@suse.com, x86@kernel.org
Subject: Re: next-0519 on thinkpad x60: sound related? window manager crash
In-Reply-To: <20200609054306.GA9606@lst.de>
Message-ID: <alpine.DEB.2.22.394.2006092213110.154443@chino.kir.corp.google.com>
References: <20200520111136.GA3802@amd> <1591545088.74ii116nf2.none@localhost> <20200608061950.GA17476@lst.de> <1591624340.z01ejtod28.none@localhost> <alpine.DEB.2.22.394.2006081928070.148886@chino.kir.corp.google.com> <20200609054306.GA9606@lst.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jun 2020, Christoph Hellwig wrote:

> > Working theory is that CONFIG_DMA_NONCOHERENT_MMAP getting set is causing 
> > the error_code in the page fault path.  Debugging with Alex off-thread we 
> > found that dma_{alloc,free}_from_pool() are not getting called from the 
> > new code in dma_direct_{alloc,free}_pages() and he has not enabled 
> > mem_encrypt.
> 
> While DMA_COHERENT_POOL absolutely should not select DMA_NONCOHERENT_MMAP
> (and you should send your patch either way), I don't think it is going
> to make a difference here, as DMA_NONCOHERENT_MMAP just means we
> allows mmaps even for non-coherent devices, and we do not support
> non-coherent devices on x86.
> 

We haven't heard yet whether the disabling of DMA_NONCOHERENT_MMAP fixes 
Aaron's BUG(), and the patch included some other debugging hints that will 
be printed out in case it didn't, but I'll share what we figured out:

In 5.7, his config didn't have DMA_DIRECT_REMAP or DMA_REMAP (it did have 
GENERIC_ALLOCATOR already).  AMD_MEM_ENCRYPT is set.  

In Linus HEAD, AMD_MEM_ENCRYPT now selects DMA_COHERENT_POOL so it sets 
the two aforementioned options.

We also figured out that dma_should_alloc_from_pool() is always false up 
until the BUG().  So what else changed?  Only the selection of DMA_REMAP 
and DMA_NONCOHERENT_MMAP.

The comment in the Kconfig about setting "an uncached bit in the 
pagetables" led me to believe it may be related to the splat he's seeing 
(reserved bit violation).  So I suggested dropping DMA_NONCOHERENT_MMAP 
from his Kconfig for testing purposes.



If this option should not implicitly be set for DMA_COHERENT_POOL, then I 
assume we need yet another Kconfig option since DMA_REMAP selected it 
before and DMA_COHERENT_POOL selects DMA_REMAP :)

So do we want a DMA_REMAP_BUT_NO_DMA_NONCOHERENT_MMAP?  Decouple DMA_REMAP 
from DMA_NONCOHERENT_MMAP and select the latter wherever the former was 
set (but not DMA_COHERENT_POOL)?  Something else?
