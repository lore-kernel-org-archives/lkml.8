Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35A6C7619D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 23:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9314521D56
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 23:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgO2PZ3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgBSXhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 18:37:24 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42141 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgBSXhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 18:37:24 -0500
Received: by mail-yw1-f68.google.com with SMTP id b81so1007918ywe.9;
        Wed, 19 Feb 2020 15:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Orzy6eDvO44Ke7Q13dM0od3EjiBktCuUDbuSH/RXkbw=;
        b=jgO2PZ3m52LdxQ7HUKo54WSwJAmkRB+fZTqgKFrKnkDDWMt2nfQPbpUxUPDWjTWpCL
         ivKGgxXtFGtOpmFeBd6rHui9FEu0sYEG/KCcpqv6T84nFpEiJQimgzyzgBolnTPyKGZt
         H2BNwX+iQamnXIfIGCgo8ZQ6wlm5QxF2faZW5nTfHaxSS9Oney3EC2pHN8cKBRbKrdZm
         dVXC60aXsPSIhZgRRa4i/GudysFhIzOgdN+nW22U47A9M88JEWloIh+F6tuX8P3eFoqo
         OSjeV1SCnojjACSK9EZf+lHI5nfT8InSR4T1D3nCqOoExgqYGOhCBJEj2wX1iKo+RmVU
         DNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Orzy6eDvO44Ke7Q13dM0od3EjiBktCuUDbuSH/RXkbw=;
        b=oei7/6Y3iAQi1etPW2RJaIopW5W+E6qYeJe50JZADWnITu0EP/vo2aVjUwO/YF15M7
         eC59+ONIdIU30f9zrSwJo0VWG22jQfqT5UEWBhCoqg9CBPda/MWggggdn0kxcYN488VX
         /bl2YQ4wR0DbfSkc59ew83a40ONRa1d1bDWTcONHQdufftNg/dntP+IkDYWpZnuXAImz
         H73xzi2C0XyplZGbjtprVh9E3k5urXrcDx6GF9zzLSVIU/vBbnWkUqJx1WA/T6+Akslu
         0By9IIeUvaru9e+eMvMZtxgNHP8mvOo/yuf24iYbFh1xR7V1OEnL6EBeJke5b03qoBvD
         lZ2Q==
X-Gm-Message-State: APjAAAVp5e2NXC6Zs+dDZFH5zEip6dkTNsxh4sFfVRfpzFhPQPl09GlU
        qnu9y+k+rFxEFFioXp2A4/s=
X-Google-Smtp-Source: APXvYqzRXKQDTQ67CFUX8qautSExnmyWkTBqKK3Sejrsw0csxe/+Jd704xYLQR8q5t9xfi8k3WE4nw==
X-Received: by 2002:a0d:e652:: with SMTP id p79mr22301622ywe.491.1582155442692;
        Wed, 19 Feb 2020 15:37:22 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id b195sm745065ywh.80.2020.02.19.15.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2020 15:37:22 -0800 (PST)
Subject: Re: [PATCH 1/2] of: unittest: add overlay gpio test to catch gpio hog
 problem
To:     Rob Herring <robh@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        pantelis.antoniou@konsulko.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alan Tull <atull@kernel.org>
References: <1580276765-29458-1-git-send-email-frowand.list@gmail.com>
 <1580276765-29458-2-git-send-email-frowand.list@gmail.com>
 <20200219215656.GA15842@bogus>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <ff65f982-f71e-5bef-1811-fdb94fd7da2f@gmail.com>
Date:   Wed, 19 Feb 2020 17:37:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200219215656.GA15842@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/20 3:56 PM, Rob Herring wrote:
> On Tue, Jan 28, 2020 at 11:46:04PM -0600, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Geert reports that gpio hog nodes are not properly processed when
>> the gpio hog node is added via an overlay reply and provides an
>> RFC patch to fix the problem [1].
>>
>> Add a unittest that shows the problem.  Unittest will report "1 failed"
>> test before applying Geert's RFC patch and "0 failed" after applying
>> Geert's RFC patch.
> 
> What's the status of that? I don't want to leave the tests failing at 
> least outside of a kernel release.

I agree.  I would like to see my patches applied, showing the test fail,
immediately followed by Geert's fix.  So my series should not go in
until Geert's patch is ready.

> 
>>
>> [1] https://lore.kernel.org/linux-devicetree/20191230133852.5890-1-geert+renesas@glider.be/
>>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>
>> There are checkpatch warnings.
>>   - New files are in a directory already covered by MAINTAINERS
>>   - The undocumented compatibles are restricted to use by unittest
>>     and should not be documented under Documentation
>>   - The printk() KERN_<LEVEL> warnings are false positives.  The level
>>     is supplied by a define parameter instead of a hard coded constant
>>   - The lines over 80 characters are consistent with unittest.c style
>>
>> This unittest was also valuable in that it allowed me to explore
>> possible issues related to the proposed solution to the gpio hog
>> problem.
>>
>> changes since RFC:
>>   - fixed node names in overlays
>>   - removed unused fields from struct unittest_gpio_dev
>>   - of_unittest_overlay_gpio() cleaned up comments
>>   - of_unittest_overlay_gpio() moved saving global values into
>>     probe_pass_count and chip_request_count more tightly around
>>     test code expected to trigger changes in the global values
>>
>>  drivers/of/unittest-data/Makefile             |   8 +-
>>  drivers/of/unittest-data/overlay_gpio_01.dts  |  23 +++
>>  drivers/of/unittest-data/overlay_gpio_02a.dts |  16 ++
>>  drivers/of/unittest-data/overlay_gpio_02b.dts |  16 ++
>>  drivers/of/unittest-data/overlay_gpio_03.dts  |  23 +++
>>  drivers/of/unittest-data/overlay_gpio_04a.dts |  16 ++
>>  drivers/of/unittest-data/overlay_gpio_04b.dts |  16 ++
>>  drivers/of/unittest.c                         | 255 ++++++++++++++++++++++++++
>>  8 files changed, 372 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/of/unittest-data/overlay_gpio_01.dts
>>  create mode 100644 drivers/of/unittest-data/overlay_gpio_02a.dts
>>  create mode 100644 drivers/of/unittest-data/overlay_gpio_02b.dts
>>  create mode 100644 drivers/of/unittest-data/overlay_gpio_03.dts
>>  create mode 100644 drivers/of/unittest-data/overlay_gpio_04a.dts
>>  create mode 100644 drivers/of/unittest-data/overlay_gpio_04b.dts
>>
>> diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
>> index 9b6807065827..009f4045c8e4 100644
>> --- a/drivers/of/unittest-data/Makefile
>> +++ b/drivers/of/unittest-data/Makefile
>> @@ -21,7 +21,13 @@ obj-$(CONFIG_OF_OVERLAY) += overlay.dtb.o \
>>  			    overlay_bad_add_dup_prop.dtb.o \
>>  			    overlay_bad_phandle.dtb.o \
>>  			    overlay_bad_symbol.dtb.o \
>> -			    overlay_base.dtb.o
>> +			    overlay_base.dtb.o \
>> +			    overlay_gpio_01.dtb.o \
>> +			    overlay_gpio_02a.dtb.o \
>> +			    overlay_gpio_02b.dtb.o \
>> +			    overlay_gpio_03.dtb.o \
>> +			    overlay_gpio_04a.dtb.o \
>> +			    overlay_gpio_04b.dtb.o
>>  
>>  # enable creation of __symbols__ node
>>  DTC_FLAGS_overlay += -@
>> diff --git a/drivers/of/unittest-data/overlay_gpio_01.dts b/drivers/of/unittest-data/overlay_gpio_01.dts
>> new file mode 100644
>> index 000000000000..f039e8bce3b6
>> --- /dev/null
>> +++ b/drivers/of/unittest-data/overlay_gpio_01.dts
>> @@ -0,0 +1,23 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +&unittest_test_bus {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	gpio_01 {
> 
> Missing unit address:
> 
> gpio@0

But my changelog claimed that I fixed that, isn't that
good enough?  :-)

/me pulls big brown paper bag over head.

And the same for all the issues you point out below, for the
second patch version in a row.

I'll re-spin on 5.6-rc1 and truly include the fixes.

-Frank


> 
> 
>> +		compatible = "unittest-gpio";
>> +		reg = <0>;
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +		ngpios = <2>;
>> +		gpio-line-names = "line-A", "line-B";
>> +
>> +		line_b {
> 
> Don't use '_'.
> 
> line-b
> 
>> +			gpio-hog;
>> +			gpios = <2 0>;
>> +			input;
>> +			line-name = "line-B-input";
>> +		};
>> +	};
>> +};
>> diff --git a/drivers/of/unittest-data/overlay_gpio_02a.dts b/drivers/of/unittest-data/overlay_gpio_02a.dts
>> new file mode 100644
>> index 000000000000..cdafab604793
>> --- /dev/null
>> +++ b/drivers/of/unittest-data/overlay_gpio_02a.dts
>> @@ -0,0 +1,16 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +&unittest_test_bus {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	gpio_02 {
> 
> gpio@1
> 
> ...and a few more.
> 
>> +		compatible = "unittest-gpio";
>> +		reg = <1>;
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +		ngpios = <2>;
>> +		gpio-line-names = "line-A", "line-B";
>> +	};
>> +};
> 

