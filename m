Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862A1C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 679712070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595268378;
	bh=b60/FdC2t6HYruEEaVXkmCbb3k2s7nALgggU+wqVnII=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sORPc1aSH/x0oq/4xnmm300llqVO/IJO7aL8NShigOt+GeRT5VwO3IsTfPa4XDgMP
	 I9PHCqIU3d1lbssb7Ar1AjlDq7laYQAtL8teh+Ju96OojbFtOObZgNS7dS4QraG1GC
	 uCT4zXN6rcWLRkHLz4CopBLYGe05CIyOPEEDVr7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbgGTSGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbgGTSGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 14:06:12 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E546C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 11:06:11 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u25so10227780lfm.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 11:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uI8ot/2J0X8mcn9Zfp2J49mB1lp08I2jN3wbAeSC/Pw=;
        b=Cz61HqTwOZ6IEwVnpU+vIjJ2UVZP/Mu4fKA2ydp8JL2VDpMC+nUU4axsRhH+TxIuMT
         7h9Jetot2Q2oMe1da303RP61HjMA+kS64YBC7m4CKaPJ6ZkKqgFan1xJh394/xLoayCV
         YJQKJ0gYeeODtQeM9+onNI6euuT5xsMXV1y1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uI8ot/2J0X8mcn9Zfp2J49mB1lp08I2jN3wbAeSC/Pw=;
        b=Vs8UnD4DHumd62b9Aug0sKLNmHoRjsk0nAi3qBaWiJgDodJUzWJGvXvkUTa1y5OnTz
         Lo3CC16CqBy18Beg6dhNmUoH+dzHoc3jJyBROgOyWb6OIh5q1eWEX2Y5J1xIQjZYBqHE
         0I2kF/mKm57J+BjuYKqxwv2Fjc5Lwf34rdv8r4eY2sVMcQ/7L3NhHQVvhz4VupBTXLng
         3awKw0VbqFw+gBMhmyfP5RIWBznhbahb5CHeuPg6KL5UXpHscxutRk7l1UnGyPGIVkdW
         nXazvm4mwIctfFwf0pN9QYql8xmMax0TEMuCGOvT9yuunNoQX0YcZ3YgqSmX74f/yV4A
         cB8w==
X-Gm-Message-State: AOAM530nqTDOwHuR2eUhe7TVZTAHmXDGeNE98VqNVg6R4OhhmuU3Syct
        TF7VLWwk7midU+FFvIdzGuuTOnENrZk=
X-Google-Smtp-Source: ABdhPJwmaVEjt2UWYaWUWfZiu3j56dRVxgOJfjwy3CcCry9X8+xAPNlWA3/FYLune2jXaZVEwKAnWQ==
X-Received: by 2002:a05:6512:752:: with SMTP id c18mr3436125lfs.53.1595268368608;
        Mon, 20 Jul 2020 11:06:08 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id i10sm3337079ljg.80.2020.07.20.11.06.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 11:06:07 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id y18so10206197lfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 11:06:07 -0700 (PDT)
X-Received: by 2002:a05:6512:2082:: with SMTP id t2mr2412004lfr.142.1595268366796;
 Mon, 20 Jul 2020 11:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200720155902.181712-1-hch@lst.de> <20200720155902.181712-5-hch@lst.de>
In-Reply-To: <20200720155902.181712-5-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Jul 2020 11:05:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimKMPiGP6n_HQUJ1rQ_6cT6hZH5rjQa_nfAgjB1mug+A@mail.gmail.com>
Message-ID: <CAHk-=wimKMPiGP6n_HQUJ1rQ_6cT6hZH5rjQa_nfAgjB1mug+A@mail.gmail.com>
Subject: Re: [PATCH 04/24] fs: move the putname from filename_create to the callers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 8:59 AM Christoph Hellwig <hch@lst.de> wrote:
>
> This allows reusing the struct filename for retries, and will also allow
> pushing the getname up the stack for a few places to allower for better
> handling of kernel space filenames.

I find this _very_ confusing.

Now the rule is that filename_create() does the putname() if it fails,
but not if it succeeds.

That's just all kinds of messed up.

It was already slightly confusing how "getname()" was paired with
"putname()", and how you didn't need to check for errors, but at least
it was easy to explain: "filename_create() will  check errors and use
the name we got".

That slightly confusing calling convention made the code much more
compact, and nobody involved needed to do error checks on the name
etc.

Now that "slightly confusing" convention has gone from "slightly" to
"outright", and the whole advantage of the interface has completely
gone away, because now you not only need to do the putname() in the
caller, you need to do it _conditionally_.

So please don't do this.

The other patches also all make it *really* hard to follow when
putname() is done - because depending on the context, you have to do
it when returning an error, or when an error was not returned.

I really think this is a huge mistake. Don't do it this way. NAK NAK NAK.

Please instead of making this all completely messy and completely
impossible to follow the rule about exactly who does "putname()" and
under what conditions, just leave the slight duplication in place.

Duplicating simple helper routines is *good*. Complex and
hard-to-understand and non-intuitive rules are *bad*.

You're adding badness.

                 Linus
