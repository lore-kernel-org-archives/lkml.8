Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DEBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A13206DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RivW6jUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgHDJPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:15:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33089 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726351AbgHDJPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 05:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596532530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H8QXz7fnC1FbuJmyzQuqpkIxFUX+YqGk4KEmRvjwdmI=;
        b=RivW6jUk+weSOtUKcvDeTiV5sEqU0u57cSzyVCymme0mLVJBZnh1spWkH599mWxgERQIin
        Oxd1eB+Eeu/St9hdCrnCihnL6vyxxH591e92ymxiPcpfAdtObPfVFrVbv3wMgT/PnK4PC6
        74bRDgwhRSKpMDj5HjMeI35CQDPa+xg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-rCGCFTu2NSC1c-X8Hf5_fw-1; Tue, 04 Aug 2020 05:15:28 -0400
X-MC-Unique: rCGCFTu2NSC1c-X8Hf5_fw-1
Received: by mail-qk1-f200.google.com with SMTP id h185so28089579qke.21
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 02:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H8QXz7fnC1FbuJmyzQuqpkIxFUX+YqGk4KEmRvjwdmI=;
        b=hzkYlUeWackxNAnNdMJH+27KJL5YmB3Ozk3yxvcZHSFGjd06wViQtyGkodcQIyX01m
         pMcB98ydf+BtOPy2uoBeU4KuR+ADkvST/xQHrA578W2YE1Euch611kycF09ZQhAID/LE
         bX3CzaEUKFZCamvRsP4IH0/MYKXORi+QWBE/PlGMjPyvTUAwJd+NBDUKOqcJ+e6tm3UX
         TmgjRB5uP/YPuPKIETLNvk0ygV2601zTHXt1WlSW3TZl1/SA3BtkjrF4w1fHKOh9G/Wp
         5PEDK2JIQWHge5Rw7sV/T4GrX9kfU+Qmj/HRxfVUyYjle0/lX0PDJy3StuPp+yJVWMZk
         e9jA==
X-Gm-Message-State: AOAM530RaGzW6LGFRoaUt2VzcYaE/1YZ919tThbdS4Qus+IE6q7aka7b
        xNVH5zOnjI+vkfuWFxGfaFCB7k87hLMw30+PiDLBqf5aGUF+0UujfHDOdad2Is4jBPw7FwRy+Qj
        LzAf461+0HPOaw/2wEq4/yY4Y
X-Received: by 2002:ac8:387b:: with SMTP id r56mr20997836qtb.353.1596532528379;
        Tue, 04 Aug 2020 02:15:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSsFMJ3ogES9JB6qeeEOcrOVPHbbmxVdfVmbi9Q/EzOEODdga5bCKDv5Yb/1HR6/0FQgXS+A==
X-Received: by 2002:ac8:387b:: with SMTP id r56mr20997825qtb.353.1596532528169;
        Tue, 04 Aug 2020 02:15:28 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id 141sm17034212qke.41.2020.08.04.02.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 02:15:27 -0700 (PDT)
Date:   Tue, 4 Aug 2020 05:15:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: build failure after merge of the vhost tree
Message-ID: <20200804051448-mutt-send-email-mst@kernel.org>
References: <20200804151117.232dfef4@canb.auug.org.au>
 <20200804054758.GA17220@ubuntu>
 <20200804070439.GB17220@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804070439.GB17220@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 09:04:40AM +0200, Guennadi Liakhovetski wrote:
> Michael, looks like something went wrong with your merge? My patch 
> https://lore.kernel.org/r/20200722150927.15587-3-guennadi.liakhovetski@linux.intel.com 
> has the header, your merged commit 
> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?h=vhost&id=bba6f4f52c31af1ce4ebcc063afa08eb063b3d2c
> doesn't have it?
> 
> Thanks
> Guennadi

My bad: patch was based on a hash I did not have in my tree
so git am failed, I use patch and forgot git add.

> On Tue, Aug 04, 2020 at 07:47:58AM +0200, Guennadi Liakhovetski wrote:
> > Hi Stephen,
> > 
> > On Tue, Aug 04, 2020 at 03:11:17PM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > After merging the vhost tree, today's linux-next build (arm
> > > multi_v7_defconfig) failed like this:
> > > 
> > > drivers/rpmsg/virtio_rpmsg_bus.c:28:10: fatal error: linux/virtio_rpmsg.h: No such file or directory
> > >    28 | #include <linux/virtio_rpmsg.h>
> > >       |          ^~~~~~~~~~~~~~~~~~~~~~
> > > 
> > > Caused by commit
> > > 
> > >   bba6f4f52c31 ("rpmsg: move common structures and defines to headers")
> > > 
> > > I have used the vhost tree from next-20200803 for today.
> > 
> > Yes, I've seen that, that's a clang build for MIPS... I'll have a look.
> > 
> > Thanks
> > Guennadi
> > 
> > > -- 
> > > Cheers,
> > > Stephen Rothwell

