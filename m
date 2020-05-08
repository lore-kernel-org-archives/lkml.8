Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C795DC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A856520720
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GXE6bm+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgEHGHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 02:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgEHGHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 02:07:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61736C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 23:07:19 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id a4so402685pgc.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 23:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YVeRZZUHFH3YFPDWCfBx69wZVfQpp/EEA0nPL773ZGE=;
        b=GXE6bm+/eihbO9FZYZXzo33Q8p58K1PLmCmbx2lnDEo9heJ/5wAFgtMibiLz6h1vpu
         4T+jy2i+uzoxFA9Cl8FgGS9eLkFU7xccdPORN9aqQVlcqtrQbvmlBdw0C/H4GtGx1xp5
         ljPagTm2rOZoZONqjaS14h5GGGYY/M0XUp5lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YVeRZZUHFH3YFPDWCfBx69wZVfQpp/EEA0nPL773ZGE=;
        b=gFC8JwnN41osjac5slGUAD4ckYuKxRurXE8SfKGpg1xTYSNqRh+q7Shnj3a6tlU2Yt
         nldUE7YGgTGjCqnPHwhVCM0BCY9Ydc/GtExAJ53+Kdvx8U4LXm9iwbdWwaeJE7m2GMNp
         zC+30fGwgqB/evvRI1WVZByDHNcoKLx0tCc/+Dbf1YAM50E3F7r+wtFYCVGUaNZZ28fr
         DOyAIoPiTAZ0y+8XPLBu2xidjDO5Nhq9EYHN2UXslPf7gteP1JqYBbm4nYBGhKEoflLi
         cYdJg2O0LrSofz1p6pELxz1DwCOBAjQ0LFHa8vTE19KqCcY483lcwfmqZQqbR+Ah+2Q1
         ex6g==
X-Gm-Message-State: AGi0Pubj9b1f9vkPALxsHyWvo4E5vaD81ekwkHaD0tbn7N0xiOi5B51D
        9PGBS4pVbg3JA72SBV+MlngjyQ==
X-Google-Smtp-Source: APiQypL6/ve1p+CULUBjLX95ozq6LKlzyLNOdsl6iqGHnULRpNmN3haFOkySOgtz84GqfZP6rf89qg==
X-Received: by 2002:a62:a106:: with SMTP id b6mr1119513pff.23.1588918038521;
        Thu, 07 May 2020 23:07:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k6sm1456658pju.44.2020.05.07.23.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 23:07:17 -0700 (PDT)
Date:   Thu, 7 May 2020 23:07:16 -0700
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
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3 02/11] pstore/blk: new support logger for block devices
Message-ID: <202005072301.57F73B61CC@keescook>
References: <1585126506-18635-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1585126506-18635-3-git-send-email-liaoweixiong@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585126506-18635-3-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 04:54:57PM +0800, WeiXiong Liao wrote:
> pstore/blk is similar to pstore/ram, but dump log to block device
> rather than persistent ram.
> [...]
> +int psblk_register_blkdev(unsigned int major, psblk_panic_write_op panic_write)
> +{
> +	struct block_device *bdev;
> +	struct psblk_device dev = {0};
> +	struct bdev_info *binfo;
> +	int ret = -ENODEV;
> +	void *holder = blkdev;
> +
> +	binfo = psblk_get_bdev_info();
> +	if (IS_ERR(binfo))
> +		return PTR_ERR(binfo);
> +
> +	/* only allow driver matching the @blkdev */
> +	if (!binfo->devt || MAJOR(binfo->devt) != major) {
> +		pr_debug("invalid major %u (expect %u)\n",
> +				major, MAJOR(binfo->devt));
> +		return -ENODEV;
> +	}
> +
> +	/* hold bdev exclusively */
> +	bdev = psblk_get_bdev(holder);
> +	if (IS_ERR(bdev)) {
> +		pr_err("failed to open '%s'!\n", blkdev);
> +		return PTR_ERR(bdev);
> +	}
> +
> +	/* psblk_bdev must be assigned before register to pstore/blk */
> +	psblk_bdev = bdev;
> +	blkdev_panic_write = panic_write;
> +
> +	dev.total_size = psblk_bdev_size(bdev);
> +	dev.panic_write = panic_write ? psblk_blk_panic_write : NULL;
> +	dev.read = psblk_generic_blk_read;
> +	dev.write = psblk_generic_blk_write;
> +
> +	ret = psblk_register_do(&dev);
> +	if (ret)
> +		goto err_put_bdev;
> +
> +	pr_info("using '%s'\n", blkdev);
> +	return 0;
> +
> +err_put_bdev:
> +	psblk_bdev = NULL;
> +	blkdev_panic_write = NULL;
> +	psblk_put_bdev(bdev, holder);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(psblk_register_blkdev);

I've gotten this series refactored on top of current pstore, and I've
been making various bikeshed changes to names, etc, and as I went to go
start testing, I realized that nothing actually uses
psblk_register_blkdev().

It seems like it should be possible to just start using this on any
block device of the user's choosing. I assume the idea is to allow for
drivers to register panic_write handlers, but even without that, it'd be
nice to just be able to test this with something like /dev/loop0.

What's your thinking on how this would happen? It seems like if
pstore/blk uses pstore/zone, and mtdpstore uses pstore/blk, there should
be a blkoops that uses pstore/blk too? I guess I need to learn a bit
more about how block device probing works so pstore/blk can notice
devices as they're brought online, etc.

-- 
Kees Cook
