Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0498EC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 18:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC36120786
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 18:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUUoqlHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgGKSoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 14:44:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60605 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728390AbgGKSop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 14:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594493083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bS19/wWScaoigC28WtauFL/l6Ha+uxblMLUn/Mypy1E=;
        b=LUUoqlHWdEdqWIFPbe6aezWDRE8tg56W/l3P9CiayVL6L0HJxUcKQ12Er481lgZaYNu03s
        BJYOew+hMi9QTit/vP/isJfKujfRCGsCKanRYN3R9tOnd0fscWWT+f0oBl6oekpBOsBOhG
        Th7HJp5SLN2N2rhIXtbTzInotMXTvFk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-eol0BVGvPb-gDxFH5urOGw-1; Sat, 11 Jul 2020 14:44:42 -0400
X-MC-Unique: eol0BVGvPb-gDxFH5urOGw-1
Received: by mail-wm1-f69.google.com with SMTP id g124so11748818wmg.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 11:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bS19/wWScaoigC28WtauFL/l6Ha+uxblMLUn/Mypy1E=;
        b=KhHyMTfRc//pyvO6HqIURW1GeJH5wlzbb5WPHlR3AQaIOR04I819j9P1QtY2CbyLIZ
         As1sd6TaHSkmC87yk2rVsA75vbcHRB8Dy1rgtuckjoc2RatdwOnAAp7/xGwXQZgYLeNq
         0GCd0mkJrVXujjQoTQj+rl1l1Gu9qQ5JlMLq0Y9L9r4mRpPPU3AH8s5rly+036nM4hPw
         2mL0+xcnzl+zRaNEy7WKeM7H/A9eM0Pu9VWHm+3phPaSv5lk53EkzNiGjwBrhdqBnjN4
         f2xD8Sh0fcHQN8RTCNGPxqoZ2TObdoNyIYiKOaa7Fb47i6ZghGsxkC133ZhOdMXHXU7u
         dZ9A==
X-Gm-Message-State: AOAM53061Vw6llkBnLiDRtfbMovJyEU9RYY4b85FnZv5wLOQqh83DMPx
        qfQyy4BcOwUyS2zkWj7IxOoAh9k57F572nxLgy1I2c0OBhV8c8ZNJXpSCXz2mQN54F7Z1eIIpLR
        +435mOizlSz2Dzq1Vl56N47h1
X-Received: by 2002:a1c:b686:: with SMTP id g128mr11471076wmf.145.1594493080465;
        Sat, 11 Jul 2020 11:44:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygwQmxPTGDCpKObOVAAUSmALBrwy00qKV5C2K74YeE+tRXIP/JRrrSaIMIkdPE6mekfNCtDg==
X-Received: by 2002:a1c:4d11:: with SMTP id o17mr10838336wmh.134.1594493079525;
        Sat, 11 Jul 2020 11:44:39 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
        by smtp.gmail.com with ESMTPSA id a84sm4541096wmh.47.2020.07.11.11.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 11:44:38 -0700 (PDT)
Date:   Sat, 11 Jul 2020 14:44:34 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     jgross@suse.com, Peng Fan <peng.fan@nxp.com>,
        konrad.wilk@oracle.com, jasowang@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org, linux-imx@nxp.com,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
Message-ID: <20200711144334-mutt-send-email-mst@kernel.org>
References: <20200624163940-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s>
 <20200624181026-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006251014230.8121@sstabellini-ThinkPad-T480s>
 <20200626110629-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006291621300.8121@sstabellini-ThinkPad-T480s>
 <20200701133456.GA23888@infradead.org>
 <alpine.DEB.2.21.2007011020320.8121@sstabellini-ThinkPad-T480s>
 <20200701172219-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2007101019340.4124@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2007101019340.4124@sstabellini-ThinkPad-T480s>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 10:23:22AM -0700, Stefano Stabellini wrote:
> Sorry for the late reply -- a couple of conferences kept me busy.
> 
> 
> On Wed, 1 Jul 2020, Michael S. Tsirkin wrote:
> > On Wed, Jul 01, 2020 at 10:34:53AM -0700, Stefano Stabellini wrote:
> > > Would you be in favor of a more flexible check along the lines of the
> > > one proposed in the patch that started this thread:
> > > 
> > >     if (xen_vring_use_dma())
> > >             return true;
> > > 
> > > 
> > > xen_vring_use_dma would be implemented so that it returns true when
> > > xen_swiotlb is required and false otherwise.
> > 
> > Just to stress - with a patch like this virtio can *still* use DMA API
> > if PLATFORM_ACCESS is set. So if DMA API is broken on some platforms
> > as you seem to be saying, you guys should fix it before doing something
> > like this..
> 
> Yes, DMA API is broken with some interfaces (specifically: rpmesg and
> trusty), but for them PLATFORM_ACCESS is never set. That is why the
> errors weren't reported before. Xen special case aside, there is no
> problem under normal circumstances.

So why not fix DMA API? Then this patch is not needed.


> 
> If you are OK with this patch (after a little bit of clean-up), Peng,
> are you OK with sending an update or do you want me to?

