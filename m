Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D95C5ACC4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F88520656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582149421;
	bh=n6F+2L4Y5nWCghmMCkFQUgCIoUKvGSVAh0C6ftmLS8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kjd40sjomtoXM98/VPgCObZYQ0i7V+L0uMSP5xKz5jqrYugtR6FYLYh2LODoKfsO1
	 UCZvYelk/g8x0V78mVJxOOBkUWs4sCTfGXsgvUgLitT/0r7ChbtcgJJKoqijHJNt8N
	 ibv808e6RHa94taPHChAcYBtSf+8Tsi69CnC0JO8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgBSV5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:57:00 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33216 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbgBSV47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:56:59 -0500
Received: by mail-ot1-f65.google.com with SMTP id w6so1733091otk.0;
        Wed, 19 Feb 2020 13:56:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+FbRrEInmMUI8SjCl1cYF7hQdWw/r8Og0X41rC3ZI/I=;
        b=oCx191V5nD2v/S6aYcT1paVuDYCdUKPBKirHQKCe9hLQC/YLnIfcanvK348A9Px25z
         cGjaSd+98/o7w9maMrwgn0JX0o0pP74tgGJzhBu47m0W+Unc0utEt6PqmMWCzSL9ggrF
         Y/fOcU1xQou2niHWAfI+CsYUUDOIYabson75/GOiVvvI6PWktK5q998uk71p4XI2TCE3
         N72hRk3CJjZ/a0FNZ5nOlKij/AIcUcVit0QkdHCLgmwkz8I4NaPk2UYRZCZ7hUyVGs8M
         /sAqynCO8VxaphSef1wba6KT7QF5hYIHHca0mxviwoEwzzBukLLWl3oPaxZeNqJFy/CF
         suSw==
X-Gm-Message-State: APjAAAWumcFqT7e+ozbk38XBhKvpmYidoh/PEJd5tZ7atUPpryrMJtSv
        ox34fFbNcjfK8HdlwyiY9ndkO/Y=
X-Google-Smtp-Source: APXvYqzcPExR6VZZTHAjjC+dZINjSQBuia2Vfa+u9DctdfuGG7lUWU8CTR2bwPkA+F+rvWqMcEPpKA==
X-Received: by 2002:a05:6830:2111:: with SMTP id i17mr19988646otc.24.1582149418026;
        Wed, 19 Feb 2020 13:56:58 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j13sm386051oij.56.2020.02.19.13.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 13:56:57 -0800 (PST)
Received: (nullmailer pid 8154 invoked by uid 1000);
        Wed, 19 Feb 2020 21:56:56 -0000
Date:   Wed, 19 Feb 2020 15:56:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        pantelis.antoniou@konsulko.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alan Tull <atull@kernel.org>
Subject: Re: [PATCH 1/2] of: unittest: add overlay gpio test to catch gpio
 hog problem
Message-ID: <20200219215656.GA15842@bogus>
References: <1580276765-29458-1-git-send-email-frowand.list@gmail.com>
 <1580276765-29458-2-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580276765-29458-2-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 11:46:04PM -0600, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Geert reports that gpio hog nodes are not properly processed when
> the gpio hog node is added via an overlay reply and provides an
> RFC patch to fix the problem [1].
> 
> Add a unittest that shows the problem.  Unittest will report "1 failed"
> test before applying Geert's RFC patch and "0 failed" after applying
> Geert's RFC patch.

What's the status of that? I don't want to leave the tests failing at 
least outside of a kernel release.

> 
> [1] https://lore.kernel.org/linux-devicetree/20191230133852.5890-1-geert+renesas@glider.be/
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
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
> changes since RFC:
>   - fixed node names in overlays
>   - removed unused fields from struct unittest_gpio_dev
>   - of_unittest_overlay_gpio() cleaned up comments
>   - of_unittest_overlay_gpio() moved saving global values into
>     probe_pass_count and chip_request_count more tightly around
>     test code expected to trigger changes in the global values
> 
>  drivers/of/unittest-data/Makefile             |   8 +-
>  drivers/of/unittest-data/overlay_gpio_01.dts  |  23 +++
>  drivers/of/unittest-data/overlay_gpio_02a.dts |  16 ++
>  drivers/of/unittest-data/overlay_gpio_02b.dts |  16 ++
>  drivers/of/unittest-data/overlay_gpio_03.dts  |  23 +++
>  drivers/of/unittest-data/overlay_gpio_04a.dts |  16 ++
>  drivers/of/unittest-data/overlay_gpio_04b.dts |  16 ++
>  drivers/of/unittest.c                         | 255 ++++++++++++++++++++++++++
>  8 files changed, 372 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/of/unittest-data/overlay_gpio_01.dts
>  create mode 100644 drivers/of/unittest-data/overlay_gpio_02a.dts
>  create mode 100644 drivers/of/unittest-data/overlay_gpio_02b.dts
>  create mode 100644 drivers/of/unittest-data/overlay_gpio_03.dts
>  create mode 100644 drivers/of/unittest-data/overlay_gpio_04a.dts
>  create mode 100644 drivers/of/unittest-data/overlay_gpio_04b.dts
> 
> diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
> index 9b6807065827..009f4045c8e4 100644
> --- a/drivers/of/unittest-data/Makefile
> +++ b/drivers/of/unittest-data/Makefile
> @@ -21,7 +21,13 @@ obj-$(CONFIG_OF_OVERLAY) += overlay.dtb.o \
>  			    overlay_bad_add_dup_prop.dtb.o \
>  			    overlay_bad_phandle.dtb.o \
>  			    overlay_bad_symbol.dtb.o \
> -			    overlay_base.dtb.o
> +			    overlay_base.dtb.o \
> +			    overlay_gpio_01.dtb.o \
> +			    overlay_gpio_02a.dtb.o \
> +			    overlay_gpio_02b.dtb.o \
> +			    overlay_gpio_03.dtb.o \
> +			    overlay_gpio_04a.dtb.o \
> +			    overlay_gpio_04b.dtb.o
>  
>  # enable creation of __symbols__ node
>  DTC_FLAGS_overlay += -@
> diff --git a/drivers/of/unittest-data/overlay_gpio_01.dts b/drivers/of/unittest-data/overlay_gpio_01.dts
> new file mode 100644
> index 000000000000..f039e8bce3b6
> --- /dev/null
> +++ b/drivers/of/unittest-data/overlay_gpio_01.dts
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +/plugin/;
> +
> +&unittest_test_bus {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	gpio_01 {

Missing unit address:

gpio@0


> +		compatible = "unittest-gpio";
> +		reg = <0>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		ngpios = <2>;
> +		gpio-line-names = "line-A", "line-B";
> +
> +		line_b {

Don't use '_'.

line-b

> +			gpio-hog;
> +			gpios = <2 0>;
> +			input;
> +			line-name = "line-B-input";
> +		};
> +	};
> +};
> diff --git a/drivers/of/unittest-data/overlay_gpio_02a.dts b/drivers/of/unittest-data/overlay_gpio_02a.dts
> new file mode 100644
> index 000000000000..cdafab604793
> --- /dev/null
> +++ b/drivers/of/unittest-data/overlay_gpio_02a.dts
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +/plugin/;
> +
> +&unittest_test_bus {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	gpio_02 {

gpio@1

...and a few more.

> +		compatible = "unittest-gpio";
> +		reg = <1>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		ngpios = <2>;
> +		gpio-line-names = "line-A", "line-B";
> +	};
> +};
