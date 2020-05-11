Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CDFC54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28A7B20714
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V3GLzgPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgEKXJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 19:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725828AbgEKXJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 19:09:03 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29EAC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 16:09:01 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n11so5240580pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 16:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+Ld81GyY/GHLnL4y1DpxaPz5U+KNc36SlFebF+aJ9bg=;
        b=V3GLzgPgnS/URkeRJcrQrTcvOYmDOHLXraWJf1nxLVqAqnHxasAId/BmEgQEI9Hx9I
         MBhw2GQG1/lnTUMBGus2B5TzIXDQHtuReS5mGEneRNNo7kipGt5/CkvqBMo5AoC3R0rG
         GHySsHVKnh58nzBKvOXXK5756QqjmJi2op628=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Ld81GyY/GHLnL4y1DpxaPz5U+KNc36SlFebF+aJ9bg=;
        b=bnMrQr8+LUbIolFkonPNVMFajy8Q3nmjeEpBHQy6nGXTPrP281CfDfvW/HeN5cQ8+e
         QIwukcjhcOm8j4e2OsrEQKc3nrD6h4iyhUuq11snbk5O2CTNmhmAqao+5dmErq+rN9Rg
         zOg0ZKEcWBx5UqctoZEogm9iOR9T240Yax5E/K0g2sLR3fAgFDPulESBlBJFA1CPoUu8
         sDEa4I7af9OAXoSv0yHT8wBcitfIpjAKSOOg7pgqbyRNAQ3ZvpxjUDqW3e6bFNCF2aZb
         XDXacEvVASZtoeFT2X61zZfdhlRZGkekbzghzjuOgSWa9759oOed2R4kJPwgqjQiNVVP
         DEEA==
X-Gm-Message-State: AGi0PuYvF8FWPt4dOC2fOh+VDqtPfhM8JdQ7wZPFlYs5on+uTcGryhxl
        QX10kVcvT2pOVZ/eZXIGXJIBeA==
X-Google-Smtp-Source: APiQypLjkjOEG7DqtyjXy6A8mXwOvLNAEpQazWDSgv2ZKRndHckNBjiLrl/A1bI0ogGyWqBLzU0GNQ==
X-Received: by 2002:aa7:9a43:: with SMTP id x3mr18731830pfj.266.1589238541285;
        Mon, 11 May 2020 16:09:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fv12sm168799pjb.42.2020.05.11.16.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 16:09:00 -0700 (PDT)
Date:   Mon, 11 May 2020 16:08:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
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
Message-ID: <202005111607.1543AD86A@keescook>
References: <20200510202436.63222-1-keescook@chromium.org>
 <20200510202436.63222-10-keescook@chromium.org>
 <1f63c624-98aa-52de-a1ef-0a449decf4e9@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f63c624-98aa-52de-a1ef-0a449decf4e9@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 04:36:51PM +0800, WeiXiong Liao wrote:
> On 2020/5/11 AM 4:24, Kees Cook wrote:
> > [...]
> > +static struct block_device *psblk_get_bdev(void *holder,
> > +					   struct bdev_info *info)
> 
> Well. That's pretty a good idea to get information about block device
> after registering. And after your codes, the global variable g_bdev_info is
> useless. It's time to drop it.

Ah yes! I meant to clean that up and forgot. Fixed now.

> > [...]
> > +	bdev = blkdev_get_by_path(blkdev, mode, holder);
> > +	if (IS_ERR(bdev)) {
> > +		dev_t devt;
> > +
> > +		devt = name_to_dev_t(blkdev);
> > +		if (devt == 0)
> > +			return ERR_PTR(-ENODEV);
> > +		bdev = blkdev_get_by_dev(devt, mode, holder);
> > +	}
> 
> We should check bdev here. Otherwise, part_nr_sects_read()
> may catch segment error.
> 
> 	if (IS_ERR(bdev))
> 		return bdev;

Whoops, yes. Fixed.

> > +	bdev = psblk_get_bdev(holder, &binfo);
> > +	if (IS_ERR(bdev)) {
> > +		pr_err("failed to open '%s'!\n", blkdev);
> > +		ret = PTR_ERR(bdev);
> > +		goto err_put_bdev;
> 
> It should not goto err_put_bdev since bdev already be put if get_bdev()
> fail.

Ah yes, good point. Fixed.

-- 
Kees Cook
