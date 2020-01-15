Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6DDC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA19F2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="fpojuKnu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgAOURx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:17:53 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44442 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbgAOURv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:17:51 -0500
Received: by mail-ot1-f65.google.com with SMTP id h9so17208115otj.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 12:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dPd0oj72IQTr7Ho1Km4ZWXqORK+AR/nQgrcplLwpJyE=;
        b=fpojuKnu+Wi5p9+eOGcUnK1tXz/ym+tDyQJR7fiN07JPdlNydPbQ1RuKfL9nYOO/vp
         ktdoj1LGNeeH0tLetzt6le5Wb0WjNM3TI4p2CjOGGX+EuSOWw0DzUACfhhv8vVjFUZDe
         W6M8jugyiYMYQ6KmvTTdLB9sA/e2SPnlatCfzz0H0tbTOuYqDFrMchmtCY6PyFUez9hR
         OJoFqGd7eJNY1E5+nY46wPN/+WfX65rZrOFaITHNzfaWg74cclGgIH9l50y+jzJWSEL7
         OLoPXxM4Hj1zKIsYyFEQOBs4ip5mmicI0GLmGXVjvoFJoRTGMOaPmOsh7mhiRTDNLsCU
         UcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dPd0oj72IQTr7Ho1Km4ZWXqORK+AR/nQgrcplLwpJyE=;
        b=rq9/kX1EdloaxKlBA9hIed12QG8BxpN6JLlIfd8CPIHQJuiV5vJeX8QSTypEcrOuIJ
         3XXpuBiX50q1UGHCft7pMYiHteDjlAq7xbrER2fJJ4f+UCTRgC/XVIr0z0Y7Fp4VLe8C
         TEyBFPcp8+Fyd6BIA6kBDj39Djc+ZiapNu/i7rvsjLtOEw1ZwH7d2BBn32VwF+64STsF
         ZYNnNXM2XRWBl2smgyKuUQO1kCFBDEz9e8rPPly95wlyNIImyR91B+XoW1Tddqj93hL2
         woPLlrrbGvUZvg4wwXju+Lo14z4QFQvJgd45zBf7wskyniXTjCMatKdIJMAS4vR83IHE
         SDHA==
X-Gm-Message-State: APjAAAXCYsHq4TjLPT7wA/D8vaQHPlPvXuo3t7u/4tpK/jgnMMTI/3PO
        3WVG+PBZZ5FE+bO+yaeA2fADln8FdvEQPGv+L1KVFA==
X-Google-Smtp-Source: APXvYqxa2PtNKtiTJcIUathhM+5vp8w9k5zscIWT4wSuOwLkVVcCWydFq1TB1qX0u3WdgAKuekec5Tb3+clHuOZsZ0c=
X-Received: by 2002:a9d:68d3:: with SMTP id i19mr3785693oto.71.1579119471207;
 Wed, 15 Jan 2020 12:17:51 -0800 (PST)
MIME-Version: 1.0
References: <20200107180101.GC15920@redhat.com> <CAPcyv4gmdoqpwwwy4dS3D2eZFjmJ_Zi39k=1a4wn-_ksm-UV4A@mail.gmail.com>
 <20200107183307.GD15920@redhat.com> <CAPcyv4ggoS4dWjq-1KbcuaDtroHKEi5Vu19ggJ-qgycs6w1eCA@mail.gmail.com>
 <20200109112447.GG27035@quack2.suse.cz> <CAPcyv4j5Mra8qeLO3=+BYZMeXNAxFXv7Ex7tL9gra1TbhOgiqg@mail.gmail.com>
 <20200114203138.GA3145@redhat.com> <CAPcyv4iXKFt207Pen+E1CnqCFtC1G85fxw5EXFVx+jtykGWMXA@mail.gmail.com>
 <20200114212805.GB3145@redhat.com> <CAPcyv4igrs40uWuCB163PPBLqyGVaVbaNfE=kCfHRPRuvZdxQA@mail.gmail.com>
 <20200115195617.GA4133@redhat.com>
In-Reply-To: <20200115195617.GA4133@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 15 Jan 2020 12:17:40 -0800
Message-ID: <CAPcyv4iEoN9SnBveG7-Mhvd+wQApi1XKVnuYpyYxDybrFv_YYw@mail.gmail.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Moyer <jmoyer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 11:56 AM Vivek Goyal <vgoyal@redhat.com> wrote:
[..]
> > Even the Red Hat
> > installation guide example shows mounting on pmem0 directly. [1]
>
> Below that example it also says.
>
> "When creating partitions on a pmem device to be used for direct access,
> partitions must be aligned on page boundaries. On the Intel 64 and AMD64
> architecture, at least 4KiB alignment for the start and end of the
> partition, but 2MiB is the preferred alignment. By default, the parted
> tool aligns partitions on 1MiB boundaries. For the first partition,
> specify 2MiB as the start of the partition. If the size of the partition
> is a multiple of 2MiB, all other partitions are also aligned."
>
> So documentation is clearly saying dax will work with partitions as well.
> And some user might decide to just do that.

Yes, of course but my point is that it was ambiguous.

I'm going to take a look at how hard it would be to develop a kpartx
fallback in udev. If that can live across the driver transition then
maybe this can be a non-event for end users that already have that
udev update deployed.
