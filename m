Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02638C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE44820771
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Af0DT3tX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgGBPvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:51:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28353 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726187AbgGBPvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593705103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3VZY2zDbwBbzLtxgPU26SXjP7JkefPkdEkB2jqODvmQ=;
        b=Af0DT3tXG3+oqpR3j1ZsBx/Rtcv/mzOG5z7bJQQAew+6sMt7IqblPlKmiZmFDEqBzYgUMu
        N8R174HmmM3Lslmtgv4nX0fwv1T5SeTADarmWOLuHEgWjhiFpVql4I2GkZzYbqCiS0a6kS
        dWCdw75wP+/+6B5lt7t/iZI31tfcgTs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-P9_Ur8O7MH2efJ2D0UyRcw-1; Thu, 02 Jul 2020 11:51:37 -0400
X-MC-Unique: P9_Ur8O7MH2efJ2D0UyRcw-1
Received: by mail-qt1-f198.google.com with SMTP id d45so11770490qte.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 08:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3VZY2zDbwBbzLtxgPU26SXjP7JkefPkdEkB2jqODvmQ=;
        b=VruEBGA9FTGJSaX7BHXBgskmcFE50D13iYp2DHNBgWyZA5OAFvqShyJljbkGO2roUi
         NjWaiuYyDYiTaoOOFLFtgNFXP8XFFymj5Fs06xm4WyBe3i+ynjWvqHjTYhU4L3+148KV
         vlOqf392rRfA7ETqOECSBD5Q5BOc/fT+n1qyveLfhXBwI1zo/8xFHoJPFWTn7us6wYKx
         eyzf62hXkyRuFKvhcwznr7+eGfCJwnvnpoNs/+n8daxhNodKUs36CKPolk075+0KTXw8
         AV9SlrQnrZEZSv5fOTbLOu6fvidoN2e4ijiz9Z5W9ToYT3Br4MgBacvIMEJU13Rc3t/p
         adkQ==
X-Gm-Message-State: AOAM53211SdqQyNtVC29NE16AMh7AKqzpZJLLEvHuvf6ZBVlWFR1vJEe
        D3JRYst4YCmlsZ92iAb8U+hkyYZwLI8mc8G6UKAmlrrwl9ZbAfS1vUZR8MkkpE/jeHuFJKzJoLM
        4mv41dElaE0Mtuia1PTRzoXYC
X-Received: by 2002:a37:5bc4:: with SMTP id p187mr31620570qkb.166.1593705095717;
        Thu, 02 Jul 2020 08:51:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKAr0yUH8hYYhDsr4DruYkVLRU9FgSh469c3MauYeix84ykqUuFOOZU7bgix90YvCz9q//0g==
X-Received: by 2002:a37:5bc4:: with SMTP id p187mr31620555qkb.166.1593705095513;
        Thu, 02 Jul 2020 08:51:35 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id x13sm8044078qts.57.2020.07.02.08.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 08:51:33 -0700 (PDT)
Date:   Thu, 2 Jul 2020 11:51:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Pekka Enberg <penberg@gmail.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 17/26] mm/riscv: Use general page fault accounting
Message-ID: <20200702155132.GJ40675@xz-x1>
References: <20200626223130.199227-1-peterx@redhat.com>
 <20200626223625.199813-1-peterx@redhat.com>
 <CAOJsxLEYHzjgMtXgbkoWYvU+Lf_08GPkMAFqibnEwARNzxJZxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOJsxLEYHzjgMtXgbkoWYvU+Lf_08GPkMAFqibnEwARNzxJZxQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 02:46:24PM +0300, Pekka Enberg wrote:
> Hi Peter,

Hi, Pekka,

> 
> On Sat, Jun 27, 2020 at 1:36 AM Peter Xu <peterx@redhat.com> wrote:
> > Use the general page fault accounting by passing regs into handle_mm_fault().
> > It naturally solve the issue of multiple page fault accounting when page fault
> > retry happened.
> 
> I sent a patch to fix up riscv page fault accounting some days ago:
> 
> http://lists.infradead.org/pipermail/linux-riscv/2020-June/000775.html

Yes, this is a valid fix too.

> 
> However, your fix is obviously even better. For the generic and riscv parts:
> 
> Reviewed-by: Pekka Enberg <penberg@kernel.org>

Thanks!

-- 
Peter Xu

