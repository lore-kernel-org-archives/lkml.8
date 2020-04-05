Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853DBC2BA19
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 19:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A01720672
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 19:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmssw7Q4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgDETVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 15:21:19 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43049 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgDETVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 15:21:19 -0400
Received: by mail-lj1-f195.google.com with SMTP id g27so12296794ljn.10
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 12:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=K/gE1z0Eaezf8CdrotTqmm4GlBR/apNE6goPF1H868E=;
        b=jmssw7Q4C+dMb4APFNV1JCtZ50K44ipedz3O1LoSw7dkZ/AYx2iaQ3PE5R0a34M8on
         4Y8ESBetYuHssrR5QDRKF006VRXj3xvYM+pK9RCUL16B1/n3/7srIiBJ3aPF21zPhyZc
         sKskY+Mjjopx1GOb0Yk4PGosduC7m08UgOCBYDoqcAk/+lg5ziKQ41dcnkMddZdo0hLi
         uVjs+xnIAvfpcPGwdUf1CdIFVgYcNjbNNWUUfvwzOsrlcT+mgxMqeUZjPkAWKgzAgcae
         cIF+nWm+NgjUjfg2sko8BBD0XZ8wZ3/gKvpTtQbN8EnX2UglUJq6gU1IPN8ffgxnCfd5
         tADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=K/gE1z0Eaezf8CdrotTqmm4GlBR/apNE6goPF1H868E=;
        b=gFVK8nWKn9wO+AzaGb4n33YVlulhpLgGZv2SHztlugMF+L5cZDaXQ74rDKcRvI56kB
         3QEotAfgAre5sUfTXhZi8Sbq/qdoctJ4dT1e5FCvsSTfTceF1HRKbK0O7KkSbyumfOtq
         BT+Amz6tWyfgevSYacy4XcTDInoE81JIhloCTK2G0wkszSqfbYq+kbcT7r2lExQQ13lv
         ca4n9G0DzbcT8t6SYjtX3co1DkaZnPfbdoEdjZta1Z4cT428eltcOGYr7y4O2WgHuDtj
         TLJlmCobs1J9a6TUcWJAqWDubSanqGQ/KafrPzfqY3nswCVayB6FS3pr8GpSYV8qrCC7
         6MVA==
X-Gm-Message-State: AGi0PuZumv8vQ1rbADQKQyHK/GEaEzQwcCTeHUMmXACscp6zCjBTC8hP
        6Cvu6vw4gsgkRsWJDf8u9qQ=
X-Google-Smtp-Source: APiQypIOCgLvNUUwJVdz2ZAl6mcMp7GYpClx3bpUAGMEoGpx0nrA7xNGUNZiZxBdXzqQMU5Wq6U0hQ==
X-Received: by 2002:a2e:a412:: with SMTP id p18mr10529382ljn.39.1586114476048;
        Sun, 05 Apr 2020 12:21:16 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id d9sm8914864ljg.39.2020.04.05.12.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 12:21:15 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sun, 5 Apr 2020 21:21:08 +0200
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     William Kucharski <william.kucharski@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, jroedel@suse.de,
        vbabka@suse.cz, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm/vmalloc: Sanitize __get_vm_area() arguments
Message-ID: <20200405192108.GA9429@pc636>
References: <D25C4027-6EF9-44C2-AD4D-DDC785288B9A@oracle.com>
 <20200404185229.GA424@pc636>
 <EEB53CBF-0B3F-43E0-94F6-B001918BAC3E@oracle.com>
 <20200405172315.GA8404@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200405172315.GA8404@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 05, 2020 at 07:23:15PM +0200, Uladzislau Rezki wrote:
> On Sat, Apr 04, 2020 at 11:25:45PM -0600, William Kucharski wrote:
> > 
> > 
> > > On Apr 4, 2020, at 12:52 PM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > > 
> > >> 
> > >> ﻿Is there any need to similarly sanitize “size” to assure start + size doesn’t go past “end?”
> > >> 
> > > Why is that double check needed if all such tests are done deeper on stack?
> > 
> > If such tests ARE performed, then it doesn't matter to me whether it is checked before or after,
> > it just seems that nothing checks whether start + size makes some sort of sense with respect
> > to end.
> > 
> > I admit I didn't walk through all the routines to see if such a check would be superfluous.
> > 
> Yes, we check it:
> 
> <snip>
> static __always_inline bool
> is_within_this_va(struct vmap_area *va, unsigned long size,
>  unsigned long align, unsigned long vstart)
> {
>  ...
>  return (nva_start_addr + size <= va->va_end);
> }
> <snip>
> 
Sorry, was thinking about one place showed different one. Here we go:

<snip>
 /* Check the "vend" restriction. */
  if (nva_start_addr + size > vend)
    return vend;
<snip>

--
Vlad Rezki
