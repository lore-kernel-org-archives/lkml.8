Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8618DC33CAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A7C24655
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579647735;
	bh=hVutNbUk17sUC4Jfu13c5zPr79RRQeEdRhc9OWgYfjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qqJOHxSsnVmgKe3Tf4tCWcHQ4EZQnPHOw1V9Xr0jYDSh89HQgeqtW5wI/KmD1hg9f
	 R/VXdr9jhst/9EHQiYUec6iHq6SQZRfiYN+E8wkWDKzFByciznwsW5Qm+cbY23wQC+
	 EkRqAu3q+aVEnaLH4DnaUHTyqvrS5vg/8ZzMfBLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgAUXCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 18:02:14 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45306 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgAUXCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 18:02:14 -0500
Received: by mail-oi1-f195.google.com with SMTP id n16so4276674oie.12;
        Tue, 21 Jan 2020 15:02:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7EU1KhQCMAMjPfPLlC82NMZr4WxJXzDaL5xW09NysoE=;
        b=WryKGDrNn5CVSk2TJcOUYHDMZqPDPOUdDwscpZCr1QL346GF6+lZwipmLshB011KZa
         L8oOFaTzjA+QV5oNNdJ63MZP9ydN+LqYpI/DURkCbE9O0Ci6CiMN3dWQjx6Ef3+jX3ws
         zVjGLQPmdRjo8jUMqaZNd0q8xr3LY2prvmPkA401wq6LpToRrJ/RtVYnY+kWWNUzLuoi
         qjVf3mIMIXJviY/4YQQo96ZCTi7HoO+SvdvW0VFTbAfWDLYmrby//RQhfIDIf0hVpA+8
         BWs0OwkSCyrahuPKvlC+MqebeqMfAhJm5N9xYEfB9pQnQTCtzRHhV2UUryIFQ5kUGxiT
         u3tA==
X-Gm-Message-State: APjAAAWrulhACx3GcTAo9/oZOY3AUeeCvGeeybv2IOv+t1okfPNvQ7tj
        152WREcg4zLdRkeBLb4uPA==
X-Google-Smtp-Source: APXvYqwvRTj58MSi6KQGbcrHXdZg80appeeaYzqMwECATuDMrdbSmi/xVX0YYdJBYsan+QLmUL/c3Q==
X-Received: by 2002:aca:f507:: with SMTP id t7mr4781181oih.156.1579647732506;
        Tue, 21 Jan 2020 15:02:12 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j20sm14019914otp.24.2020.01.21.15.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 15:02:11 -0800 (PST)
Received: (nullmailer pid 2344 invoked by uid 1000);
        Tue, 21 Jan 2020 23:02:10 -0000
Date:   Tue, 21 Jan 2020 17:02:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Tull <atull@kernel.org>
Subject: Re: [RFC PATCH 1/2] of: unittest: add overlay gpio test to catch
 gpio hog problem
Message-ID: <20200121230210.GA3193@bogus>
References: <1579070828-18221-1-git-send-email-frowand.list@gmail.com>
 <1579070828-18221-2-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579070828-18221-2-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 12:47:07AM -0600, frowand.list@gmail.com wrote:
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
> There are checkpatch warnings.
>   - The lines over 80 characters are consistent with unittest.c style
>   - The undocumented compatibles are restricted to use by unittest
>     and should not be documented under Documentation
> 
> This unittest was also valuable in that it allowed me to explore
> possible issues related to the proposed solution to the gpio hog
> problem.
> 
>  drivers/of/unittest-data/Makefile             |   8 +-
>  drivers/of/unittest-data/overlay_gpio_01.dts  |  23 +++
>  drivers/of/unittest-data/overlay_gpio_02a.dts |  16 ++
>  drivers/of/unittest-data/overlay_gpio_02b.dts |  16 ++
>  drivers/of/unittest-data/overlay_gpio_03.dts  |  23 +++
>  drivers/of/unittest-data/overlay_gpio_04a.dts |  16 ++
>  drivers/of/unittest-data/overlay_gpio_04b.dts |  16 ++
>  drivers/of/unittest.c                         | 257 ++++++++++++++++++++++++++
>  8 files changed, 374 insertions(+), 1 deletion(-)
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

gpio@0

> +		compatible = "unittest-gpio";

There's a mock GPIO driver and I think there was a binding proposed at 
some point for some sort of GPIO testing device binding. Maybe that can 
save another test driver.

> +		reg = <0>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		ngpios = <2>;
> +		gpio-line-names = "line-A", "line-B";
> +
> +		line_b {

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
> +		compatible = "unittest-gpio";
> +		reg = <1>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		ngpios = <2>;
> +		gpio-line-names = "line-A", "line-B";
> +	};
> +};
> diff --git a/drivers/of/unittest-data/overlay_gpio_02b.dts b/drivers/of/unittest-data/overlay_gpio_02b.dts
> new file mode 100644
> index 000000000000..0cea0dccafba
> --- /dev/null
> +++ b/drivers/of/unittest-data/overlay_gpio_02b.dts
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +/plugin/;
> +
> +&unittest_test_bus {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	gpio_02 {
> +		line_a {
> +			gpio-hog;
> +			gpios = <1 0>;
> +			input;
> +			line-name = "line-A-input";
> +		};
> +	};
> +};
> diff --git a/drivers/of/unittest-data/overlay_gpio_03.dts b/drivers/of/unittest-data/overlay_gpio_03.dts
> new file mode 100644
> index 000000000000..1d5c680fa254
> --- /dev/null
> +++ b/drivers/of/unittest-data/overlay_gpio_03.dts
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +/plugin/;
> +
> +&unittest_test_bus {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	gpio_03 {
> +		compatible = "unittest-gpio";
> +		reg = <0>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		ngpios = <2>;
> +		gpio-line-names = "line-A", "line-B", "line-C", "line-D";
> +
> +		line_d {
> +			gpio-hog;
> +			gpios = <4 0>;
> +			input;
> +			line-name = "line-D-input";
> +		};
> +	};
> +};
> diff --git a/drivers/of/unittest-data/overlay_gpio_04a.dts b/drivers/of/unittest-data/overlay_gpio_04a.dts
> new file mode 100644
> index 000000000000..d2482cde310e
> --- /dev/null
> +++ b/drivers/of/unittest-data/overlay_gpio_04a.dts
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +/plugin/;
> +
> +&unittest_test_bus {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	gpio_04 {
> +		compatible = "unittest-gpio";
> +		reg = <1>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		ngpios = <2>;
> +		gpio-line-names = "line-A", "line-B", "line-C", "line-D";
> +	};
> +};
> diff --git a/drivers/of/unittest-data/overlay_gpio_04b.dts b/drivers/of/unittest-data/overlay_gpio_04b.dts
> new file mode 100644
> index 000000000000..70ad05d759f9
> --- /dev/null
> +++ b/drivers/of/unittest-data/overlay_gpio_04b.dts
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +/plugin/;
> +
> +&unittest_test_bus {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	gpio_04 {
> +		line_c {
> +			gpio-hog;
> +			gpios = <3 0>;
> +			input;
> +			line-name = "line-C-input";
> +		};
> +	};
> +};
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 68b87587b2ef..db0a6f4103a4 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -24,6 +24,7 @@
>  
>  #include <linux/i2c.h>
>  #include <linux/i2c-mux.h>
> +#include <linux/gpio/driver.h>
>  
>  #include <linux/bitops.h>
>  
> @@ -46,6 +47,101 @@
>  	failed; \
>  })
>  
> +/*
> + * Expected message may have a message level other than KERN_INFO.
> + * Print the expected message only if the current loglevel will allow
> + * the actual message to print.
> + */
> +#define EXPECT_BEGIN(level, fmt, ...) \
> +	printk(level pr_fmt("EXPECT \\ : ") fmt, ##__VA_ARGS__)
> +
> +#define EXPECT_END(level, fmt, ...) \
> +	printk(level pr_fmt("EXPECT / : ") fmt, ##__VA_ARGS__)

When I first saw this, I thought of kunit...

Just wondering if this is a standard way to express this, and if not, is 
there?

> +
> +struct unittest_gpio_dev {
> +	void __iomem *base;
> +	struct gpio_chip chip;
> +	spinlock_t gpio_lock;

base and gpio_lock aren't used.

> +};
> +
> +static int unittest_gpio_chip_request_count;
> +static int unittest_gpio_probe_count;
> +static int unittest_gpio_probe_pass_count;
> +
> +static int unittest_gpio_chip_request(struct gpio_chip *chip, unsigned int offset)
> +{
> +	unittest_gpio_chip_request_count++;
> +
> +	pr_debug("%s(): %s %d %d\n", __func__, chip->label, offset,
> +		 unittest_gpio_chip_request_count);
> +	return 0;
> +}
> +
> +static int unittest_gpio_probe(struct platform_device *pdev)
> +{
> +	struct unittest_gpio_dev *devptr;
> +	int ret;
> +
> +	unittest_gpio_probe_count++;
> +
> +	devptr = kzalloc(sizeof(*devptr), GFP_KERNEL);
> +	if (!devptr)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&devptr->gpio_lock);
> +
> +	platform_set_drvdata(pdev, devptr);
> +
> +	devptr->chip.of_node = pdev->dev.of_node;
> +	devptr->chip.label = "of-unittest-gpio";
> +	devptr->chip.base = -1; /* dynamic allocation */
> +	devptr->chip.ngpio = 5;
> +	devptr->chip.request = unittest_gpio_chip_request;
> +
> +	ret = gpiochip_add_data(&devptr->chip, NULL);
> +
> +	unittest(!ret,
> +		 "gpiochip_add_data() for node @%pOF failed, ret = %d\n", devptr->chip.of_node, ret);
> +
> +	if (!ret)
> +		unittest_gpio_probe_pass_count++;
> +	return ret;
> +}
> +
> +static int unittest_gpio_remove(struct platform_device *pdev)
> +{
> +	struct unittest_gpio_dev *gdev = platform_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	dev_dbg(dev, "%s for node @%pOF\n", __func__, np);
> +
> +	if (!gdev)
> +		return -EINVAL;
> +
> +	if (gdev->chip.base != -1)
> +		gpiochip_remove(&gdev->chip);
> +
> +	platform_set_drvdata(pdev, NULL);
> +	kfree(pdev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id unittest_gpio_id[] = {
> +	{ .compatible = "unittest-gpio", },
> +	{}
> +};
> +
> +static struct platform_driver unittest_gpio_driver = {
> +	.probe	= unittest_gpio_probe,
> +	.remove	= unittest_gpio_remove,
> +	.driver	= {
> +		.name		= "unittest-gpio",
> +		.of_match_table	= of_match_ptr(unittest_gpio_id),
> +	},
> +};
> +
>  static void __init of_unittest_find_node_by_name(void)
>  {
>  	struct device_node *np;
> @@ -2183,6 +2279,153 @@ static inline void of_unittest_overlay_i2c_15(void) { }
>  
>  #endif
>  
> +static void __init of_unittest_overlay_gpio(void)
> +{
> +	int chip_request_count;
> +	int probe_pass_count;
> +	int ret;
> +
> +	/*
> +	 * tests: apply overlays before registering driver
> +	 * Similar to installing a driver as a module, the
> +	 * driver is registered after applying the overlays.
> +	 *
> +	 * - apply overlay_gpio_01
> +	 * - apply overlay_gpio_02a
> +	 * - apply overlay_gpio_02b
> +	 * - register driver
> +	 *
> +	 * register driver will result in
> +	 *   - probe and processing gpio hog for overlay_gpio_01
> +	 *   - probe for overlay_gpio_02a
> +	 *   - processing gpio for overlay_gpio_02b
> +	 */
> +
> +	probe_pass_count = unittest_gpio_probe_pass_count;
> +	chip_request_count = unittest_gpio_chip_request_count;
> +
> +	/*
> +	 * overlay_gpio_01 contains gpio node and child gpio hog node
> +	 * overlay_gpio_02a contains gpio node
> +	 * overlay_gpio_02b contains child gpio hog node
> +	 */
> +
> +	unittest(overlay_data_apply("overlay_gpio_01", NULL),
> +		 "Adding overlay 'overlay_gpio_01' failed\n");
> +
> +	unittest(overlay_data_apply("overlay_gpio_02a", NULL),
> +		 "Adding overlay 'overlay_gpio_02a' failed\n");
> +
> +	unittest(overlay_data_apply("overlay_gpio_02b", NULL),
> +		 "Adding overlay 'overlay_gpio_02b' failed\n");
> +
> +	/*
> +	 * messages are the result of the probes, after the
> +	 * driver is registered
> +	 */
> +
> +	EXPECT_BEGIN(KERN_INFO,
> +		     "GPIO line <<int>> (line-B-input) hogged as input\n");
> +
> +	EXPECT_BEGIN(KERN_INFO,
> +		     "GPIO line <<int>> (line-A-input) hogged as input\n");
> +
> +	ret = platform_driver_register(&unittest_gpio_driver);
> +	if (unittest(ret == 0, "could not register unittest gpio driver\n"))
> +		return;
> +
> +	EXPECT_END(KERN_INFO,
> +		   "GPIO line <<int>> (line-A-input) hogged as input\n");
> +	EXPECT_END(KERN_INFO,
> +		   "GPIO line <<int>> (line-B-input) hogged as input\n");
> +
> +	unittest(probe_pass_count + 2 == unittest_gpio_probe_pass_count,
> +		 "unittest_gpio_probe() failed or not called\n");
> +
> +	unittest(chip_request_count + 2 == unittest_gpio_chip_request_count,
> +		 "unittest_gpio_chip_request() called %d times (expected 1 time)\n",
> +		 unittest_gpio_chip_request_count - chip_request_count);
> +
> +	/*
> +	 * tests: apply overlays after registering driver
> +	 *
> +	 * Similar to a driver built-in to the kernel, the
> +	 * driver is registered before applying the overlays.
> +	 *
> +	 * overlay_gpio_03 contains gpio node and child gpio hog node
> +	 *
> +	 * - apply overlay_gpio_03
> +	 *
> +	 * apply overlay will result in
> +	 *   - probe and processing gpio hog.
> +	 */
> +
> +	probe_pass_count = unittest_gpio_probe_pass_count;
> +	chip_request_count = unittest_gpio_chip_request_count;
> +
> +	EXPECT_BEGIN(KERN_INFO,
> +		     "GPIO line <<int>> (line-D-input) hogged as input\n");
> +
> +	/* overlay_gpio_03 contains gpio node and child gpio hog node */
> +
> +	unittest(overlay_data_apply("overlay_gpio_03", NULL),
> +		 "Adding overlay 'overlay_gpio_03' failed\n");
> +
> +	EXPECT_END(KERN_INFO,
> +		   "GPIO line <<int>> (line-D-input) hogged as input\n");
> +
> +	unittest(probe_pass_count + 1 == unittest_gpio_probe_pass_count,
> +		 "unittest_gpio_probe() failed or not called\n");
> +
> +	unittest(chip_request_count + 1 == unittest_gpio_chip_request_count,
> +		 "unittest_gpio_chip_request() called %d times (expected 1 time)\n",
> +		 unittest_gpio_chip_request_count - chip_request_count);
> +
> +	/*
> +	 * overlay_gpio_04a contains gpio node
> +	 *
> +	 * - apply overlay_gpio_04a
> +	 *
> +	 * apply the overlay will result in
> +	 *   - probe for overlay_gpio_04a
> +	 */
> +
> +	probe_pass_count = unittest_gpio_probe_pass_count;
> +	chip_request_count = unittest_gpio_chip_request_count;
> +
> +	/* overlay_gpio_04a contains gpio node */
> +
> +	unittest(overlay_data_apply("overlay_gpio_04a", NULL),
> +		 "Adding overlay 'overlay_gpio_04a' failed\n");
> +
> +	unittest(probe_pass_count + 1 == unittest_gpio_probe_pass_count,
> +		 "unittest_gpio_probe() failed or not called\n");
> +
> +	/*
> +	 * overlay_gpio_04b contains child gpio hog node
> +	 *
> +	 * - apply overlay_gpio_04b
> +	 *
> +	 * apply the overlay will result in
> +	 *   - processing gpio for overlay_gpio_04b
> +	 */
> +
> +	EXPECT_BEGIN(KERN_INFO,
> +		     "GPIO line <<int>> (line-C-input) hogged as input\n");
> +
> +	/* overlay_gpio_04b contains child gpio hog node */
> +
> +	unittest(overlay_data_apply("overlay_gpio_04b", NULL),
> +		 "Adding overlay 'overlay_gpio_04b' failed\n");
> +
> +	EXPECT_END(KERN_INFO,
> +		   "GPIO line <<int>> (line-C-input) hogged as input\n");
> +
> +	unittest(chip_request_count + 1 == unittest_gpio_chip_request_count,
> +		 "unittest_gpio_chip_request() called %d times (expected 1 time)\n",
> +		 unittest_gpio_chip_request_count - chip_request_count);
> +}
> +
>  static void __init of_unittest_overlay(void)
>  {
>  	struct device_node *bus_np = NULL;
> @@ -2242,6 +2485,8 @@ static void __init of_unittest_overlay(void)
>  	of_unittest_overlay_i2c_cleanup();
>  #endif
>  
> +	of_unittest_overlay_gpio();
> +
>  	of_unittest_destroy_tracked_overlays();
>  
>  out:
> @@ -2295,6 +2540,12 @@ struct overlay_info {
>  OVERLAY_INFO_EXTERN(overlay_12);
>  OVERLAY_INFO_EXTERN(overlay_13);
>  OVERLAY_INFO_EXTERN(overlay_15);
> +OVERLAY_INFO_EXTERN(overlay_gpio_01);
> +OVERLAY_INFO_EXTERN(overlay_gpio_02a);
> +OVERLAY_INFO_EXTERN(overlay_gpio_02b);
> +OVERLAY_INFO_EXTERN(overlay_gpio_03);
> +OVERLAY_INFO_EXTERN(overlay_gpio_04a);
> +OVERLAY_INFO_EXTERN(overlay_gpio_04b);
>  OVERLAY_INFO_EXTERN(overlay_bad_add_dup_node);
>  OVERLAY_INFO_EXTERN(overlay_bad_add_dup_prop);
>  OVERLAY_INFO_EXTERN(overlay_bad_phandle);
> @@ -2319,6 +2570,12 @@ struct overlay_info {
>  	OVERLAY_INFO(overlay_12, 0),
>  	OVERLAY_INFO(overlay_13, 0),
>  	OVERLAY_INFO(overlay_15, 0),
> +	OVERLAY_INFO(overlay_gpio_01, 0),
> +	OVERLAY_INFO(overlay_gpio_02a, 0),
> +	OVERLAY_INFO(overlay_gpio_02b, 0),
> +	OVERLAY_INFO(overlay_gpio_03, 0),
> +	OVERLAY_INFO(overlay_gpio_04a, 0),
> +	OVERLAY_INFO(overlay_gpio_04b, 0),
>  	OVERLAY_INFO(overlay_bad_add_dup_node, -EINVAL),
>  	OVERLAY_INFO(overlay_bad_add_dup_prop, -EINVAL),
>  	OVERLAY_INFO(overlay_bad_phandle, -EINVAL),
> -- 
> Frank Rowand <frank.rowand@sony.com>
> 
