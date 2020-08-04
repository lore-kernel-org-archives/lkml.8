Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455C5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 05:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D43206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 05:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgHDFsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 01:48:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:26165 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgHDFsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 01:48:01 -0400
IronPort-SDR: 3Eks73BsGwP+08fr7mCQGCQmpDoLyimcSEmrsZj3rKgou5p9HZTCsEnD+GJ9TKy22wlAIm8VRb
 EWDUgyQK9lFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="152219657"
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="152219657"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 22:48:01 -0700
IronPort-SDR: 4TsweWsk8h72Y0jQG0lf9nwLPAmJlGM/RilKmozq3qZJfR3tJ2+BgGmi2V7H+/r7mb1nmTEJYs
 ype/nE39DKsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="366771280"
Received: from ekonks-mobl.ccr.corp.intel.com (HELO ubuntu) ([10.252.37.210])
  by orsmga001.jf.intel.com with ESMTP; 03 Aug 2020 22:48:00 -0700
Date:   Tue, 4 Aug 2020 07:47:59 +0200
From:   Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vhost tree
Message-ID: <20200804054758.GA17220@ubuntu>
References: <20200804151117.232dfef4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804151117.232dfef4@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Aug 04, 2020 at 03:11:17PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the vhost tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> drivers/rpmsg/virtio_rpmsg_bus.c:28:10: fatal error: linux/virtio_rpmsg.h: No such file or directory
>    28 | #include <linux/virtio_rpmsg.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   bba6f4f52c31 ("rpmsg: move common structures and defines to headers")
> 
> I have used the vhost tree from next-20200803 for today.

Yes, I've seen that, that's a clang build for MIPS... I'll have a look.

Thanks
Guennadi

> -- 
> Cheers,
> Stephen Rothwell


