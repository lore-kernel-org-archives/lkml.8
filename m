Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766C2C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5271D20714
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kds3MjSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgEKXL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 19:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726079AbgEKXLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 19:11:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716D8C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 16:11:25 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 18so5435477pfv.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 16:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kd/QhpImkX36HF8SlWn26Vq1MT1a121rRIqfkQ3OXgM=;
        b=kds3MjSmr+27Km3d5Oqby9a5V7U3EwsuhhfZylClXw9zwc4b+sEYlhi4/M9bgYp5oB
         ang2aRYRWcMFQYbgk5YRBlzv3/fVADiSFz2nwkFRGmc5lPYWVxEHJYfF7rYTeO/sjxc6
         vdDOl1TTJxTZOoez95WzbMM3Hee11EoiliYSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kd/QhpImkX36HF8SlWn26Vq1MT1a121rRIqfkQ3OXgM=;
        b=oTUMLkUf6aFYCBo38d/tqjgztbnR8UDloZuDSDiQiaZnFu9TJBBWGXSnoYWJ+7bH3Q
         ckiDBuzwPEfCLOrmzQ6296kjHLc7gmRdnIlSGOHdOJJAK00l1lfayjVRICf4EAMmx5Q3
         Zst0IeFT55IlsNFxnRHlVoY2ecch473DvC7UzprDyd73Gw4cPKnnhD/aSRftxzpkIlPB
         X2TKk4E0WEEbv9f3UcvrkvbNBXgyiEMGjvLYurmu5PiSF3rhHh54WQ3odq7APDWQ6/my
         ixlT71JiyVVK1ZsZuHtcg+3xWgBc2dBGwy3dhWGC/rOnUJOOkiH17oj1RW/0LnkVtgJw
         xiCw==
X-Gm-Message-State: AOAM531tCe8NoWD1zGN/fq2lCogMt29FYa/ubZGg6oc94CteuJkdCg5r
        usw6snbpYq9tiTgEOVqQK8Rq3w==
X-Google-Smtp-Source: ABdhPJwPSUZYIDM8rwAeY/r+K/5u3nE0s9lk3VUhI8mXzXA0IuzsVQak6fdByiO5BrTqPRTkUdRfcg==
X-Received: by 2002:a63:387:: with SMTP id 129mr7901119pgd.117.1589238684936;
        Mon, 11 May 2020 16:11:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 138sm10064164pfz.31.2020.05.11.16.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 16:11:23 -0700 (PDT)
Date:   Mon, 11 May 2020 16:11:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     WeiXiong Liao <liaoweixiong@allwinnertech.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v7 09/18] pstore/blk: Introduce backend for block devices
Message-ID: <202005111609.2CA37E4A3@keescook>
References: <20200510202436.63222-1-keescook@chromium.org>
 <20200510202436.63222-10-keescook@chromium.org>
 <2b4fec3e-53f7-b8d9-49f8-d24401f83363@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b4fec3e-53f7-b8d9-49f8-d24401f83363@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 08:36:49AM -0700, Randy Dunlap wrote:
> On 5/10/20 1:24 PM, Kees Cook wrote:
> > diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> > index 98d2457bdd9f..92ba73bd0b62 100644
> > --- a/fs/pstore/Kconfig
> > +++ b/fs/pstore/Kconfig
> > @@ -160,3 +160,67 @@ config PSTORE_ZONE
> >  	help
> >  	  The common layer for pstore/blk (and pstore/ram in the future)
> >  	  to manage storage in zones.
> > +
> > +config PSTORE_BLK
> > +	tristate "Log panic/oops to a block device"
> > +	depends on PSTORE
> > +	depends on BLOCK
> > +	select PSTORE_ZONE
> > +	default n
> > +	help
> > +	  This enables panic and oops message to be logged to a block dev
> > +	  where it can be read back at some later point.
> > +
> > +	  If unsure, say N.
> > +
> > +config PSTORE_BLK_BLKDEV
> > +	string "block device identifier"
> > +	depends on PSTORE_BLK
> > +	default ""
> > +	help
> > +	  Which block device should be used for pstore/blk.
> > +
> > +	  It accept the following variants:
> > +	  1) <hex_major><hex_minor> device number in hexadecimal represents
> > +	     itself no leading 0x, for example b302.
> 
> 	     itself with no leading 0x,

Yes, I've reworked the language here. Thanks!

-- 
Kees Cook
