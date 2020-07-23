Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D87C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B4B02086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8CE5vqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgGWRlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgGWRlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:41:44 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2263EC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 10:41:44 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o22so3401130pjw.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 10:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+RJZw0EUjRyZGrBL+JOJ2S5jetRR1oKhR6Zvd1RgJh8=;
        b=g8CE5vqbzx8+q8gvwPCQVVlTu/4DoCklRjtBzfdi3iZDNiYEAw5sE9gpie8nmZ3+cP
         NCxicK2Ve2qHMNwrV7A3g5V8ZuBwUT1zGg6+a4OzxescH3EfZreFvywl4Nl2hLIFyiB7
         tTbEk/HhGativgJefsiLNJXQW/tcS6QBJgFsKyAG22KPmh/GswkNrIZPHLVsBDOkocLq
         9WkIlAdXcjlzDROyl+n+H+gmKyXruyfu4joQJ+GiprjYCXZ4t50jY/4qyvMkaj1z4gxl
         9AviwBse/t1C7/1KG54XxoijhcC1AwFlI0QhTxITwqg7eFTO2hUY0EOpKtMFU8NvLvei
         aYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+RJZw0EUjRyZGrBL+JOJ2S5jetRR1oKhR6Zvd1RgJh8=;
        b=D00CNuDoIrICFedMFEkQFMZTtr3wrKGc5kyYnkmTs1Hzh+tfhXHr9giXH+NL3BzZz5
         WYgK7+3B61wGHkzmn5iZLFxdwUD1yqfb7hjvc786cda9iM08K82+oeBxDvsDuNXUFcVb
         bqYDcqlkodvI7FJi+Dnvf9xczYVzNV5gddvLbFE3IhqB4YWznA888wdEAhRd05YoBCEs
         rpZP6aJAmu1qlM4qfS6d0TR215awXt9r5ykwJ4X0/zdGV6woNcAiNNNZfE1Yc2L/xYgL
         HS/uj7E/lGLgOLLIcWvR1eJEUJ1C7LMurr/24t/lzMbLIpJMS0GMHKbMd+ixpemTIlfh
         D5lA==
X-Gm-Message-State: AOAM531adXP8P0ZodWwNT6KjShLcGCyqa/KO6lrBrgV75OV1Ca35WNpf
        PYV9RnjG+JHPvBu/EFanXSN78PTxuh0=
X-Google-Smtp-Source: ABdhPJxoBkIy9VJSu6/9RLSZ5Nl/QUfE4CzVFNPVZsaPQiEv1+cvwyDb5XSdajla+/0XQPb2x8jfUg==
X-Received: by 2002:a17:902:654e:: with SMTP id d14mr4913612pln.60.1595526103417;
        Thu, 23 Jul 2020 10:41:43 -0700 (PDT)
Received: from gmail.com ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id n25sm3757021pff.51.2020.07.23.10.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:41:42 -0700 (PDT)
Date:   Thu, 23 Jul 2020 10:41:40 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v5 0/6] arm64: add the time namespace support
Message-ID: <20200723174140.GA3991167@gmail.com>
References: <20200624083321.144975-1-avagin@gmail.com>
 <20200705064055.GA28894@gmail.com>
 <20200714015743.GA843937@gmail.com>
 <20200722181506.GA4517@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200722181506.GA4517@gaia>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 07:15:06PM +0100, Catalin Marinas wrote:
> On Mon, Jul 13, 2020 at 06:57:43PM -0700, Andrei Vagin wrote:
> > On Sat, Jul 04, 2020 at 11:40:55PM -0700, Andrei Vagin wrote:
> > > On Wed, Jun 24, 2020 at 01:33:15AM -0700, Andrei Vagin wrote:
> > > > Allocate the time namespace page among VVAR pages and add the logic
> > > > to handle faults on VVAR properly.
> > > > 
> > > > If a task belongs to a time namespace then the VVAR page which contains
> > > > the system wide VDSO data is replaced with a namespace specific page
> > > > which has the same layout as the VVAR page. That page has vdso_data->seq
> > > > set to 1 to enforce the slow path and vdso_data->clock_mode set to
> > > > VCLOCK_TIMENS to enforce the time namespace handling path.
> > > > 
> > > > The extra check in the case that vdso_data->seq is odd, e.g. a concurrent
> > > > update of the VDSO data is in progress, is not really affecting regular
> > > > tasks which are not part of a time namespace as the task is spin waiting
> > > > for the update to finish and vdso_data->seq to become even again.
> > > > 
> > > > If a time namespace task hits that code path, it invokes the corresponding
> > > > time getter function which retrieves the real VVAR page, reads host time
> > > > and then adds the offset for the requested clock which is stored in the
> > > > special VVAR page.
> > > > 
> > > 
> > > > v2: Code cleanups suggested by Vincenzo.
> > > > v3: add a comment in __arch_get_timens_vdso_data.
> > > > v4: - fix an issue reported by the lkp robot.
> > > >     - vvar has the same size with/without CONFIG_TIME_NAMESPACE, but the
> > > >       timens page isn't allocated on !CONFIG_TIME_NAMESPACE. This
> > > >       simplifies criu/vdso migration between different kernel configs.
> > > > v5: - Code cleanups suggested by Mark Rutland.
> > > >     - In vdso_join_timens, mmap_write_lock is downgraded to
> > > >       mmap_read_lock. The VMA list isn't changed there, zap_page_range
> > > >       doesn't require mmap_write_lock.
> > > > 
> > > > Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > > > Reviewed-by: Dmitry Safonov <dima@arista.com>
> > > 
> > > Hello Will and Catalin,
> > > 
> > > Have you had a chance to look at this patch set? I think it is ready to be
> > > merged. Let me know if you have any questions.
> > 
> > *friendly ping*
> > 
> > If I am doing something wrong, let me know.
> 
> Not really, just haven't got around to looking into it. Mark Rutland
> raised a concern (in private) about the safety of multithreaded apps
> but I think you already replied that timens_install() checks for this
> already [1].
> 
> Maybe a similar atomicity issue to the one raised by Mark but for
> single-threaded processes: the thread is executing vdso code, gets
> interrupted and a signal handler invokes setns(). Would resuming the
> execution in the vdso code on sigreturn cause any issues?

It will not cause any issues in the kernel. In the userspace,
clock_gettime() can return a clock value with an inconsistent offset, if
a process switches between two non-root namespaces. And it can triggers
SIGSEGV if it switches from a non-root to the root time namespace,
because a time namespace isn't mapped in the root time namespace.

I don't think that we need to handle this case in the kernel. Users
must understand what they are doing and have to write code so that avoid
these sort of situations. In general, I would say that in most cases it
is a bad idea to call setns from a signal handler.

Thanks,
Andrei

> 
> [1] https://lore.kernel.org/linux-arm-kernel/d16b5cd1-bdb1-5667-fbda-c622cc795389@arista.com/
> 
> -- 
> Catalin
