Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9E8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6843920836
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="I65y0rS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390241AbgFXN0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:26:20 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58778 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbgFXN0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:26:19 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200624132617euoutp0163db1ee44592c06ccb348160876271ac~bfcTeV0ru1570315703euoutp01M
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:26:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200624132617euoutp0163db1ee44592c06ccb348160876271ac~bfcTeV0ru1570315703euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593005177;
        bh=0gqxpn18q0iv1xmjJZRrD/hRcqgguNv5UewCRUP14cc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=I65y0rS29qiRwmeZBLIUNxU65pHP2TFz4lMuJQkKnASe4yEKNrsUHUjf+nmCLtCRJ
         +5nh8m5aDzS396okzqEsSdejNZWM+4Lo4UKKp6vFDZzMOiZaJXWD1bA89DvddYNiKE
         Dwh9JC3GlWIsMtpMXbZcqj3nBu5U4FqXzBH2PySI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200624132617eucas1p177e4764ae168a90cce619a5790491c75~bfcTL1Taw1737917379eucas1p1W;
        Wed, 24 Jun 2020 13:26:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D0.EF.05997.97453FE5; Wed, 24
        Jun 2020 14:26:17 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200624132617eucas1p2a5588ef1821b826ff1aba8465f276b71~bfcS0sSNQ2249322493eucas1p2B;
        Wed, 24 Jun 2020 13:26:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200624132616eusmtrp1a7b178dcb4c5c2ecdd3230ac5e04b0d3~bfcSzOkKe1250812508eusmtrp11;
        Wed, 24 Jun 2020 13:26:16 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-1c-5ef354791ddc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D4.84.06314.87453FE5; Wed, 24
        Jun 2020 14:26:16 +0100 (BST)
Received: from [106.210.85.205] (unknown [106.210.85.205]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200624132615eusmtip160f5fa79a788116bbd3770cdf1ada0ce~bfcR2qC0z2266522665eusmtip1V;
        Wed, 24 Jun 2020 13:26:15 +0000 (GMT)
Subject: Re: [RESEND PATCH v5 2/5] driver core: add deferring probe reason
 to devices_deferred property
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>, andy.shevchenko@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <94ed179a-bcc7-1e52-985f-57e9c124a5f0@samsung.com>
Date:   Wed, 24 Jun 2020 15:26:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200624123438.GC1773782@kroah.com>
Content-Transfer-Encoding: 7bit
Content-Language: pl
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTYRTGe3fv7q7i7DoXnjSsViEKambQhULMIi4RFGQKmR8rrx/kpu2q
        ZUgNW2lZaalUK9NSUWaxmh+VYdmUponrU1uUrWwUC6fFJn1nbrfI/37vc57znvPAITHJhDCQ
        zFbmsyqlPEdGeOOd97+Zw4vinSnLXQ+ktL2yF9HXz+qFdM1bG0E/m5ok6EMNeoIe/mLH6IHx
        YZw+eqpRRBvejQjpp10XCNpY043oq32jItp4MomuddVgsb7M05HHGDNpOSxibmlHRcz5snNC
        xqA7SjD9lU8EzN3aKyLGWm4SMG2NB5mT7TrE9JyowhmnIXiLz3bvNelsTnYhq4qMSfPOOtOX
        mlcZsq+6VkOo0fTCY8iLBGoljDVVo2PIm5RQLQic7+qE/MOFoNvWiNwuCeVE8Olr0r+OH5oG
        jDc1I7AaLv7tmERgsPzG3S5/KhvOT/djbpZS0VAxpBW5TRjViYN+XOMpEFQo/Gp7QbhZTMWA
        3TEicDNOLYOS4W6PPo9KhuPWjxjv8YOBczbPAC8qChxvnB7GqIVww3EB41kKljGNJxBQNSQM
        q58gfu/1oNMfFvDsDx9N7SKeF8Bg1XGc54NgbdFgfHMZgo5rtzC+sBpemb/PbETOTAgFfVck
        L6+F1133PDJQvmBx+PE7+MLpzjMYL4uh7IiEdy8G61DH3w8DoOnRFFGJZNpZybSz0mhnpdH+
        n1uPcB0KYAs4RSbLrVCyeyM4uYIrUGZG7MpVGNDMFQ7+Nrluoq6fO42IIpHMR3ztzecUiVBe
        yBUpjAhITCYVxw0NpkjE6fKi/awqN1VVkMNyRhRE4rIAcfRle7KEypTns7tZNo9V/asKSK9A
        NerICK7vuZPxsjioNNZfljRhql5Xri4JL36/1d9gO7FxLC8yfMmlkNI47kPF5t49m0KiQ88m
        NwQkVCWmOaxRi5YqKmI1a8vpiP73bHvM80Nzm+rjd0w+XDw/q1khD7qZICKWFQYXzuHiEm+H
        GeM39LYKq8x124yvWts6m1+sMh/Qf5bhXJY8KgxTcfI/TYjOqIEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42I5/e/4Xd2KkM9xBlt/mFq8nHCY0WLjjPWs
        FlMfPmGzuPL1PZtF8+L1bBZXv79ktjj55iqLRefEJewWmx5fY7W4vGsOm8WhqXsZLdYeuctu
        cagv2mLul6nMDnwel69dZPZ4f6OV3WPnrLvsHrM7ZrJ6bFrVyeZxYsIlJo/9c9ewe9zvPs7k
        sXlJvUffllWMHgd6J7N4fN4kF8ATpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtl
        ZKqkb2eTkpqTWZZapG+XoJcx/Uh8wQT1iilzW9gaGP/LdzFyckgImEj8blnM3MXIxSEksJRR
        4uvU14wQCXGJ3fPfMkPYwhJ/rnWxQRS9ZZQ4/fgUC0hCWCBT4szW42wgtoiAsUT/2VnsIEXM
        ArtYJNb9+8cO0fGAUeLT+0tgVWwCmhJ/N98Es3kF7CRevr3GBGKzCKhKNF3dCxYXFYiV6F78
        gx2iRlDi5MwnYNs4BQwl3j74DGYzC5hJzNv8kBnClpfY/nYOlC0iceNRC+MERqFZSNpnIWmZ
        haRlFpKWBYwsqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQLjf9uxn5t3MF7aGHyIUYCDUYmH
        d8ODj3FCrIllxZW5hxglOJiVRHidzp6OE+JNSaysSi3Kjy8qzUktPsRoCvTcRGYp0eR8YGrK
        K4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAqLWM87H021QjSRar
        vu2mKQKyUW3q20SXXky8s7pznVPYvjfaPxV87e4dn3/30Mmtdk9vPl5W9Ua9+4zefxEl3pNr
        ZXLzmacsOPr919kHfQp53uKH/pR6Pwh6fGw+iyvbdJYDV/cvVl23q2r/83TDji7diqnu0T6H
        G0xex3zy/zXpweSZO/uy+pVYijMSDbWYi4oTAQahVccVAwAA
X-CMS-MailID: 20200624132617eucas1p2a5588ef1821b826ff1aba8465f276b71
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200624114136eucas1p1a3a31d95d86754201c7965f26ccd5de0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200624114136eucas1p1a3a31d95d86754201c7965f26ccd5de0
References: <20200624114127.3016-1-a.hajda@samsung.com>
        <CGME20200624114136eucas1p1a3a31d95d86754201c7965f26ccd5de0@eucas1p1.samsung.com>
        <20200624114127.3016-3-a.hajda@samsung.com>
        <20200624123438.GC1773782@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24.06.2020 14:34, Greg Kroah-Hartman wrote:
> On Wed, Jun 24, 2020 at 01:41:24PM +0200, Andrzej Hajda wrote:
>> /sys/kernel/debug/devices_deferred property contains list of deferred devices.
>> This list does not contain reason why the driver deferred probe, the patch
>> improves it.
>> The natural place to set the reason is probe_err function introduced recently,
>> ie. if probe_err will be called with -EPROBE_DEFER instead of printk the message
>> will be attached to deferred device and printed when user read devices_deferred
>> property.
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> Reviewed-by: Mark Brown <broonie@kernel.org>
>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> ---
>>   drivers/base/base.h |  3 +++
>>   drivers/base/core.c | 10 ++++++----
>>   drivers/base/dd.c   | 21 ++++++++++++++++++++-
>>   3 files changed, 29 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/base/base.h b/drivers/base/base.h
>> index 95c22c0f9036..93ef1c2f4c1f 100644
>> --- a/drivers/base/base.h
>> +++ b/drivers/base/base.h
>> @@ -93,6 +93,7 @@ struct device_private {
>>   	struct klist_node knode_class;
>>   	struct list_head deferred_probe;
>>   	struct device_driver *async_driver;
>> +	char *deferred_probe_msg;
>>   	struct device *device;
>>   	u8 dead:1;
>>   };
>> @@ -134,6 +135,8 @@ extern void device_release_driver_internal(struct device *dev,
>>   extern void driver_detach(struct device_driver *drv);
>>   extern int driver_probe_device(struct device_driver *drv, struct device *dev);
>>   extern void driver_deferred_probe_del(struct device *dev);
>> +extern void __deferred_probe_set_msg(const struct device *dev,
>> +				     struct va_format *vaf);
>>   static inline int driver_match_device(struct device_driver *drv,
>>   				      struct device *dev)
>>   {
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index ee9da66bff1b..2a96954d5460 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -3962,6 +3962,8 @@ define_dev_printk_level(_dev_info, KERN_INFO);
>>    *
>>    * This helper implements common pattern present in probe functions for error
>>    * checking: print message if the error is not -EPROBE_DEFER and propagate it.
>> + * In case of -EPROBE_DEFER it sets defer probe reason, which can be checked
>> + * later by reading devices_deferred debugfs attribute.
>>    * It replaces code sequence:
>>    * 	if (err != -EPROBE_DEFER)
>>    * 		dev_err(dev, ...);
>> @@ -3977,14 +3979,14 @@ int probe_err(const struct device *dev, int err, const char *fmt, ...)
>>   	struct va_format vaf;
>>   	va_list args;
>>   
>> -	if (err == -EPROBE_DEFER)
>> -		return err;
>> -
>>   	va_start(args, fmt);
>>   	vaf.fmt = fmt;
>>   	vaf.va = &args;
>>   
>> -	dev_err(dev, "error %d: %pV", err, &vaf);
>> +	if (err == -EPROBE_DEFER)
>> +		__deferred_probe_set_msg(dev, &vaf);
>> +	else
>> +		dev_err(dev, "error %d: %pV", err, &vaf);
>>   
>>   	va_end(args);
>>   
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index 9a1d940342ac..f44d26454b6a 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -27,6 +27,7 @@
>>   #include <linux/async.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/pinctrl/devinfo.h>
>> +#include <linux/slab.h>
>>   
>>   #include "base.h"
>>   #include "power/power.h"
>> @@ -136,6 +137,8 @@ void driver_deferred_probe_del(struct device *dev)
>>   	if (!list_empty(&dev->p->deferred_probe)) {
>>   		dev_dbg(dev, "Removed from deferred list\n");
>>   		list_del_init(&dev->p->deferred_probe);
>> +		kfree(dev->p->deferred_probe_msg);
>> +		dev->p->deferred_probe_msg = NULL;
>>   	}
>>   	mutex_unlock(&deferred_probe_mutex);
>>   }
>> @@ -211,6 +214,21 @@ void device_unblock_probing(void)
>>   	driver_deferred_probe_trigger();
>>   }
>>   
>> +/*
>> + * __deferred_probe_set_msg() - Set defer probe reason message for device
>> + */
>> +void __deferred_probe_set_msg(const struct device *dev, struct va_format *vaf)
>> +{
>> +	const char *drv = dev_driver_string(dev);
>> +
>> +	mutex_lock(&deferred_probe_mutex);
>> +
>> +	kfree(dev->p->deferred_probe_msg);
>> +	dev->p->deferred_probe_msg = kasprintf(GFP_KERNEL, "%s: %pV", drv, vaf);
> What about the device name?  Don't you also want that?


deferred_devs_show prints it already, deferred_probe_msg is appended if 
not null.


Regards

Andrzej


>
> You want the same format that __dev_printk() outputs, please use that
> to be consistant with all other messages that drivers are spitting out.
>
> thanks,
>
> greg k-h
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://protect2.fireeye.com/url?k=28daee95-7508f5cd-28db65da-0cc47a31c8b4-b3e8d1affcda9c08&q=1&u=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel
>
