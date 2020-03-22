Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B81C4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 15:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E8420722
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 15:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="euo5bqfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgCVPo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 11:44:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41591 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgCVPo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 11:44:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id z65so6172676pfz.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 08:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YL+MR4SeE7ZMKyLj3pq91f9YbQ3vSzoJuwAbHw1Bf+c=;
        b=euo5bqfjl82QDaTCxgYHrwbwx1CZxogNrh71EorKsEz+of9psHTsKBi9jD+BVMF9/i
         la6IlwZiIeBLqJdotzhOopEAsYNyxuiIiKC2dHtrnbApYpn1uIZynco9BNDWDp53KcYi
         mm0N4OoucSO7VRIAfKI4scY1S3I6oOMPCgbzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YL+MR4SeE7ZMKyLj3pq91f9YbQ3vSzoJuwAbHw1Bf+c=;
        b=Ml0zA4yaeW6x7qKg/FlpgLOQ8sPy3EjpPP2X6sG0ZGRF9RV44+cixwai8flVLzx7S5
         e9KJU87J/hdYy5g6xL1IdU5slTqDbs8UeDCY1VNQPKYYP89fzCT1ZpWPaluJuBI6LDfd
         zE5L5ttqEKx1fYfMWHGVkcAt8Z/2QQchlMm8KyGCiFpSLBRRKNuC4+0AqPof1RpwfJxj
         XMGwK1tVc7u4kaXElrEJWwaa7ojwk7BA1SQ0us7hCjb3AxhuT6we1NICZZGShga/uij5
         x0HGLDXu2vpxhAptmRz6o/qB6jyneFDJGuaFrNtoaGbEQLN4repLDaEpEq/O37Y8q238
         rriw==
X-Gm-Message-State: ANhLgQ2N1Q/GPyS20aeArLKgoFfbtLr6oHTW5jKa0knzENQIzAwut99b
        rGJJWlxFgjHIWq41MkYv9vaDJQ==
X-Google-Smtp-Source: ADFU+vsOuZnbrkJ1+OlzMtqbAiGhhpTVn5FLmXciOuBCi3EqN698sLpsBrXbCZstEAjm/8Z8ZeWbNA==
X-Received: by 2002:a62:144c:: with SMTP id 73mr20002041pfu.265.1584891866727;
        Sun, 22 Mar 2020 08:44:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 71sm11249418pfv.8.2020.03.22.08.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 08:44:25 -0700 (PDT)
Date:   Sun, 22 Mar 2020 08:44:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 02/11] blkoops: add blkoops, a warpper for pstore/blk
Message-ID: <202003220816.C877AB41A4@keescook>
References: <1581078355-19647-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1581078355-19647-3-git-send-email-liaoweixiong@allwinnertech.com>
 <202003181025.20B6978@keescook>
 <11f3dcbf-dba5-8fdc-6b2c-43dbe4e478c8@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11f3dcbf-dba5-8fdc-6b2c-43dbe4e478c8@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 06:00:34PM +0800, WeiXiong Liao wrote:
> On 2020/3/19 AM2:06, Kees Cook wrote:
> > On Fri, Feb 07, 2020 at 08:25:46PM +0800, WeiXiong Liao wrote:
> >> blkoops is a better wrapper for pstore/blk, which provides efficient
> >> configuration mothod. It divides all configurations of pstore/blk into
> > 
> > typo: method
> > 
> 
> I will fix it.
> 
> >> 2 parts, configurations for user and configurations for driver.
> >>
> >> Configurations for user detemine how pstore/blk work, such as
> >> dump_oops and dmesg_size. They can be set by Kconfig and module
> >> parameters.
> > 
> > I'd like to keep blkoops as close to ramoops as possible on the user
> > configuration side. Notes below...
> > 
> 
> Is your question why not use device-tree on the user configuration
> side? Here are my answer about it.
> 
> There is an important difference between blkoops and ramoops.
> The ramoops can be initialized at any time since ram already be
> ready. However, blkoops must waits for block_dev registering.

Right, that's true and looks fine as you have it. I meant I wondered if
there was a way to teach blkoops about mtd device naming (in the same
way that it already supports many ways to find matching block devices by
path, by UUID, etc). That way when blkoops see a matching MTD device,
it'll load the mtd module, etc. For now, let's leave this as-is, and
revisit this idea after v3.

> No, non-block here means devices such as MTD device which is not a block
> device and do not use generic block layer.

How are filesystems implemented on top of MTD devices? Are they
MTD-specific, or is there a block layer driver that goes on top of MTD?

> So, why not extract a common layer from ramoops and blkoops to allocate
> and manager storage sapce? That is what psotre/blk (blkzone.c) do. The
> ramoops and the blkoops do not care about the use of storage.
> 
> I don't know whether the common layer is good enough to ramoops and
> whether is good time to rename the common layer from pstore/blk to
> psotre/zone?

Yeah, I'm still looking through that. I'd love to be able to merge the
pstore/zone with much of ram.c. That way we could even get ECC support
on non-RAM storage devices. :)

But let's not worry about that for v3. I'd like to get our
configurations matched up, though. To that end, yes, let's keep your
"dmesg_size" (or should we maybe call this "oops_size" to distinguish
oops dmesg from console dmesg) and I will add an alias to ramoops to
support "oops_size". Then we can have a single place to configure
settings for the pstore/zone layer. I'll keep thinking about how to best
to that.

> How about Makefile and Kconfig as follow?
> 
> 	<Kconfig>
> 	config PSOTRE_ZONE
> 		# NOTE.
> 		# the configuration is hidden from users and selected by
> 		# pstore/blk.
> 		help
> 		  The common layer for pstore/blk (and pstore/ram in the future)
> 		  to manager storage as zones.
> 	config PSTORE_BLK
> 		tristate "Log panic/oops to a block device"
> 		select PSOTRE_ZONE
> 		help
> 		  ......
> 	config PSTORE_BLK_DMESG_SIZE
> 		......
> 
> 	<Makefile>
> 	#  Note: rename blkzone.c to pstore_zone.c
> 	obj-$(CONFIG_PSTORE_ZONE) += pstore_zone.c
> 
> 	# Note: rename blkoops.c to pstore_blk.c
> 	obj-$(CONFIG_PSTORE_BLK) += pstore_blk.c

Yeah, this works, though with the "psotre" typos fixed. ;) The comments
in the Makefile aren't needed, since there's no renaming actually
happening. They're just named that from the first time they appear
upstream.

> 
> >> +
> >> +	  NOTE that, both kconfig and module parameters can configure blkoops,
> >> +	  but module parameters have priority over kconfig.
> >> +
> >> +	  If unsure, say N.
> >> +
> >> +config PSTORE_BLKOOPS_DMESG_SIZE
> >> +	int "dmesg size in kbytes for blkoops"
> > 
> > How about "Size in Kbytes of dmesg to store"? (It will already show up
> > under the parent config, so no need to repeat "blkoops" here.
> 
> That's good idea.

Or, based on above, "Size if Kbytes of oops log to store"?

> >> +#ifdef CONFIG_PSTORE_BLKOOPS_DMESG_SIZE
> > 
> > This (and all the others below) will always be defined, so no need to
> > test it -- just use it as needed below.
> > 
> 
> It's fine to dmesg_size and dump_oops but not pmsg_size, ftrace_size
> and console_size, because they will be not available sometimes.

Yeah, this has bothered me for a while but mostly only ramoops cared
(almost all the other backends only support the oops frontend :P).
I have some ideas about this, but I'm not quite ready to implement it
(basically, the backend would tell the core what it could support,
and the core would examine available frontends and then report back to
the backend what it needed). But that's not something we need for v3.
I'll keep thinking about it.

> >> +	bzinfo->total_size = bo_dev->total_size;
> >> +	bzinfo->dump_oops = dump_oops;
> >> +	bzinfo->read = bo_dev->read;
> >> +	bzinfo->write = bo_dev->write;
> > 
> > Why copy these separate functions? Shouldn't bzinfo just keep a pointer
> > to bo_dev?
> > 
> 
> bo_dev is a structure defined in blkoops and not available to bzinfo.
> 
> At the very beginning of my design, the pstore/blk is a common layer
> for  blkoops and ramoops. So, it's not suitable for bzinfo to keep a
> pointer to structure of blkoops.

We may need to revisit this in the future in order to keep the module
loading sane: we can't have the function body get unloaded while
something holding a pointer to it is active. But this would be a small
change at a later time. Let's leave this as-is for v3.

> I will keep generic_file_read_iter() rather than vfs_iter_read().

Absolutely. :)

> >> +
> >> +	blkoops_bdev = bdev;
> >> +	blkdev_panic_write = panic_write;
> >> +
> >> +	/* only allow driver matching the @blkdev */
> >> +	if (!bdev->bd_dev || MAJOR(bdev->bd_dev) != major)
> > 
> > And add similar error reports here.
> > 
> 
> I'd  use pr_debug rather than pr_err. Because we allow mulitiple
> devices to attempt to register to blkoops. It's not an error.
> 
> pr_debug("invalid major %u (expect %u)\n", major, MAJOR(bdev->bd_dev));

Ah! Right. Then it should separate "non matching" with pr_debug() and
"the matching one failed" with pr_err() (i.e. it's the right device, but
something about it is bad: bad size, can't register, etc).

> > I don't see this function getting used anywhere. Can it be removed? I
> > see the notes in the Documentation. Could these values just be cached at
> > open time instead of reopening the device?
> > 
> 
> This function is reserved for block driver to get information about the
> using block device. So it can't be removed.
> 
> Sure, a new structrue is created to cached these values.

Okay.

-- 
Kees Cook
