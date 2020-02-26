Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1678DC4BA18
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8792468B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582735332;
	bh=jc1k6Lh9DHpyhVe+NcXxVMj2yFOca1PCTD1rjqLKTm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Rve6VM49n3R11PNX0U++s3kv7vkNSFtO3+63ybGC2PmILGs369uitfUyRYgsl8Pi5
	 DU5pBZGVyrqpDVva9nnqKGvB5Rj4HlPCl1e3VgkWsd9B8cqIYn9pdJm7M3wumbTuO6
	 QV2209zSe/lX3ajud8mR/gZhymkgDacsX4MGDdow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgBZQmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:42:11 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38948 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgBZQmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:42:11 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so13334oty.6;
        Wed, 26 Feb 2020 08:42:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3FWdu8yiFNXhep3Pm+PE/WEngzA4h1YnchL3v9C5QE0=;
        b=PZpOaVbOKmfNUS1IQSKMatfNDgdRbWe7fLGJAeL3l6ayQQsHBdIaqyF8jz4bvPKKxp
         ADIwNOLJm5AVtlxGS2HtO1K9w3HtEUEVYY68YuRbvxZByaIFeDlhd2I10FDV9pw888Al
         LzXyLz62w5fHAfK+v9KDGIj6i0DAHwRabNEC2YYEBkUr5XkZEQmsCQ+/IGYhj9ksjFCP
         7ybbce58scmATK4akqHO39RB9KWbN8NZ6iodv/xmW9NCXMTpMS2oncNA+0UmcdBTLOZh
         0fhXiqUVs4f88e1lIVS8cAlbleKnxlYRW8+ZiSlRZp+ZvCO8WUWEfcjc8P0EiavyfX/+
         mmBA==
X-Gm-Message-State: APjAAAUif5nUoBf0jAFSDz9k8yBiNE9KGfv3NQJEHweTVOYVU16wzLUN
        TNXIzxZOWifYglythKAhig==
X-Google-Smtp-Source: APXvYqzRtuKvH4sv+x9a7HaS+KroxFh0h50n5jhX/nks32lhClZFnJ0nxWqVQusIHxFZ/SJLKI7JJg==
X-Received: by 2002:a9d:7613:: with SMTP id k19mr2222391otl.144.1582735328617;
        Wed, 26 Feb 2020 08:42:08 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b4sm946300oie.55.2020.02.26.08.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 08:42:07 -0800 (PST)
Received: (nullmailer pid 10219 invoked by uid 1000);
        Wed, 26 Feb 2020 16:42:06 -0000
Date:   Wed, 26 Feb 2020 10:42:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        pantelis.antoniou@konsulko.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alan Tull <atull@kernel.org>
Subject: Re: [PATCH v2 1/2] of: unittest: add overlay gpio test to catch gpio
 hog problem
Message-ID: <20200226164206.GA10128@bogus>
References: <1582224021-12827-1-git-send-email-frowand.list@gmail.com>
 <1582224021-12827-2-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582224021-12827-2-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020 12:40:20 -0600, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Geert reports that gpio hog nodes are not properly processed when
> the gpio hog node is added via an overlay reply and provides an
> RFC patch to fix the problem [1].
> 
> Add a unittest that shows the problem.  Unittest will report "1 failed"
> test before applying Geert's RFC patch and "0 failed" after applying
> Geert's RFC patch.
> 
> [1] https://lore.kernel.org/linux-devicetree/20191230133852.5890-1-geert+renesas@glider.be/
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> changes since v1:
>   - base on 5.6-rc1
>   - fixed node names in overlays
>   - removed unused fields from struct unittest_gpio_dev
>   - of_unittest_overlay_gpio() cleaned up comments
>   - of_unittest_overlay_gpio() moved saving global values into
>     probe_pass_count and chip_request_count more tightly around
>     test code expected to trigger changes in the global values
> 
> v1 of this patch incorrectly reported that it had made changes
> since the RFC version, but it was mistakenly created from the
> wrong branch.
> 
> There are checkpatch warnings.
>   - New files are in a directory already covered by MAINTAINERS
>   - The undocumented compatibles are restricted to use by unittest
>     and should not be documented under Documentation
>   - The printk() KERN_<LEVEL> warnings are false positives.  The level
>     is supplied by a define parameter instead of a hard coded constant
>   - The lines over 80 characters are consistent with unittest.c style
> 
> This unittest was also valuable in that it allowed me to explore
> possible issues related to the proposed solution to the gpio hog
> problem.
> 
> 
>  drivers/of/unittest-data/Makefile             |   8 +-
>  drivers/of/unittest-data/overlay_gpio_01.dts  |  23 +++
>  drivers/of/unittest-data/overlay_gpio_02a.dts |  16 ++
>  drivers/of/unittest-data/overlay_gpio_02b.dts |  16 ++
>  drivers/of/unittest-data/overlay_gpio_03.dts  |  23 +++
>  drivers/of/unittest-data/overlay_gpio_04a.dts |  16 ++
>  drivers/of/unittest-data/overlay_gpio_04b.dts |  16 ++
>  drivers/of/unittest.c                         | 253 ++++++++++++++++++++++++++
>  8 files changed, 370 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/of/unittest-data/overlay_gpio_01.dts
>  create mode 100644 drivers/of/unittest-data/overlay_gpio_02a.dts
>  create mode 100644 drivers/of/unittest-data/overlay_gpio_02b.dts
>  create mode 100644 drivers/of/unittest-data/overlay_gpio_03.dts
>  create mode 100644 drivers/of/unittest-data/overlay_gpio_04a.dts
>  create mode 100644 drivers/of/unittest-data/overlay_gpio_04b.dts
> 

Applied, thanks.

Rob
