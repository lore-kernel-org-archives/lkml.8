Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D33C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 01:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDAAA2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 01:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIHVyT3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgGNB5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 21:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgGNB5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 21:57:48 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7B9C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 18:57:48 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w2so6875493pgg.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 18:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nXOSB0ZRPuQ9A1WyrVeJbOY3UGyrJ9rRxSkxDn9MEyE=;
        b=eIHVyT3adtlj2h9JYse58LLJWVui34c0wGDIWHBfaBpq/wDq697wU/8Enw+qHGz7Ca
         VDXtNoGCbVzYdceUil0j3FdtRrj6ITD4AZKUm9SLSUHP9bJHKMabvueXMXR4UABfpMZB
         kZLinypET8hCIJrfsiqtY2tl3PH+ZxMCqw7nHUylXg7hioiR75tK5KhNypydhA/zjE8l
         Mi/0ToxeE7M1iOsLdo/FmPoxzhvbphWc74tyb6CdCH4diH3RlQrSoNUS+ZweZu8k7DUL
         LbE2X7aFhPtjVLUgYjCOF88zbiZIve1wq4Rntr6IV4ape8zrprLI0auxDrMbgJc1Red8
         IGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nXOSB0ZRPuQ9A1WyrVeJbOY3UGyrJ9rRxSkxDn9MEyE=;
        b=IcIDSKPrR6uG4f8rPetGYx4jbkkm8qSZMPCcKCaTAeGcfygvS3ZHYXWLh2d1wrIA+l
         Jm9KgIThiAxi7XyaNFn3lwELWxEmESZKdSUt+tHHc0+InJXVvmMrTbZlkiXcnr9NwVSj
         minLdN0gu2QjDvtiqmNBFudU6wAfNKoqkOYt90cbafp9mzRimJlHAzMUhEpcWaZbKw+A
         S65BaFPAFeRVq+NQe1Ojci4PaiEk5+8A2LtpV+svrB7ngEoqVuVRRrCf8mdp87wCT/l8
         s4jHNy3NWOXN8/yVWfIrf9ivt6ZRDIujsU7sOH5nGI5zThoqdSa1ow67yDfL8O1QlH3i
         rOdA==
X-Gm-Message-State: AOAM530E17Qp9gj7nhJ7rdQLcRbn1unqaasOR2dcQO2+cho2bHyHcoZ9
        jHcnAvJMD0YH/jhAmxlojwA=
X-Google-Smtp-Source: ABdhPJxSqYOpqSYqWpNHoiL1CUeek2IzHty8XoVDrr9WqzlnX+GW7bpH58jk1kffpPFnhJpo4Cvn2g==
X-Received: by 2002:aa7:9906:: with SMTP id z6mr2407642pff.60.1594691867136;
        Mon, 13 Jul 2020 18:57:47 -0700 (PDT)
Received: from gmail.com ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id y19sm16772203pfc.135.2020.07.13.18.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 18:57:46 -0700 (PDT)
Date:   Mon, 13 Jul 2020 18:57:43 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v5 0/6] arm64: add the time namespace support
Message-ID: <20200714015743.GA843937@gmail.com>
References: <20200624083321.144975-1-avagin@gmail.com>
 <20200705064055.GA28894@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200705064055.GA28894@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 04, 2020 at 11:40:55PM -0700, Andrei Vagin wrote:
> On Wed, Jun 24, 2020 at 01:33:15AM -0700, Andrei Vagin wrote:
> > Allocate the time namespace page among VVAR pages and add the logic
> > to handle faults on VVAR properly.
> > 
> > If a task belongs to a time namespace then the VVAR page which contains
> > the system wide VDSO data is replaced with a namespace specific page
> > which has the same layout as the VVAR page. That page has vdso_data->seq
> > set to 1 to enforce the slow path and vdso_data->clock_mode set to
> > VCLOCK_TIMENS to enforce the time namespace handling path.
> > 
> > The extra check in the case that vdso_data->seq is odd, e.g. a concurrent
> > update of the VDSO data is in progress, is not really affecting regular
> > tasks which are not part of a time namespace as the task is spin waiting
> > for the update to finish and vdso_data->seq to become even again.
> > 
> > If a time namespace task hits that code path, it invokes the corresponding
> > time getter function which retrieves the real VVAR page, reads host time
> > and then adds the offset for the requested clock which is stored in the
> > special VVAR page.
> > 
> 
> > v2: Code cleanups suggested by Vincenzo.
> > v3: add a comment in __arch_get_timens_vdso_data.
> > v4: - fix an issue reported by the lkp robot.
> >     - vvar has the same size with/without CONFIG_TIME_NAMESPACE, but the
> >       timens page isn't allocated on !CONFIG_TIME_NAMESPACE. This
> >       simplifies criu/vdso migration between different kernel configs.
> > v5: - Code cleanups suggested by Mark Rutland.
> >     - In vdso_join_timens, mmap_write_lock is downgraded to
> >       mmap_read_lock. The VMA list isn't changed there, zap_page_range
> >       doesn't require mmap_write_lock.
> > 
> > Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Reviewed-by: Dmitry Safonov <dima@arista.com>
> 
> Hello Will and Catalin,
> 
> Have you had a chance to look at this patch set? I think it is ready to be
> merged. Let me know if you have any questions.

*friendly ping*

If I am doing something wrong, let me know.

> 
> Thanks,
> Andrei
> 
