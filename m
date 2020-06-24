Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6412C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEC4B20578
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fQsqKB2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391256AbgFXOoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:44:32 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42185 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389583AbgFXOob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:44:31 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200624144429euoutp02c247749efd224d90441e42af2e1e268e~bggkvZY4i0676406764euoutp02r
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 14:44:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200624144429euoutp02c247749efd224d90441e42af2e1e268e~bggkvZY4i0676406764euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593009869;
        bh=74EXcU6NRTGKVQiLkCTApb9pHuDA6DI1dcukDnNb+T8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fQsqKB2vfGepXa57hANXvKqyu0Os5rhfzWeKzCcjeBsTQb31uLO6+hqZINOBXPgbw
         hHDfEt0fTWKCBQe/ABxVbJy3vtiplS6ORlNqcmeqrrOX+aNcjfOvkjN3cWhd68i9rf
         6Wjp/lGNp8SdeJg11T25vOlZK8A6rOneAokUL2U0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200624144428eucas1p2b99915a9edc8b7d9067a80b5299cc0f4~bggkXneqj3223732237eucas1p21;
        Wed, 24 Jun 2020 14:44:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2B.C7.06456.CC663FE5; Wed, 24
        Jun 2020 15:44:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200624144428eucas1p21261d3700fcf3134d6ffdc9e61039d91~bggkIZ8Bc0160201602eucas1p2-;
        Wed, 24 Jun 2020 14:44:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200624144428eusmtrp204558c37895a41ec3bc8806e004f54e4~bggkHsmfS1589415894eusmtrp2a;
        Wed, 24 Jun 2020 14:44:28 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-a9-5ef366ccd204
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E3.FE.06017.CC663FE5; Wed, 24
        Jun 2020 15:44:28 +0100 (BST)
Received: from [106.210.85.205] (unknown [106.210.85.205]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200624144427eusmtip1f97ba39572c6c38ce86c18ff1da16811~bggi_r4cn0372403724eusmtip1_;
        Wed, 24 Jun 2020 14:44:27 +0000 (GMT)
Subject: Re: [RESEND PATCH v5 3/5] drivers core: allow probe_err accept
 integer and pointer types
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <345c10ba-b047-3ef4-0129-0ef494c8f812@samsung.com>
Date:   Wed, 24 Jun 2020 16:44:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0i7mU3dGGZv3sUwG2_2OCRP3=bPB7a8sstj0qLwmiwhog@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: pl
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfSzUcRzH973fw/2Y09el+YQe3LRJDyh//JZGtbZ+9UcPS2vVqJNfx3LY
        ncf+wErtaESxusOSECJ1IWdZdSpJeaiYJg/JmjMPCze0VO5+Wv57fb+f9/vz+by/+zKEdIxy
        ZsIjY3hVpDxCRtuSda/n27a8Ozcd7L3wfTNrympC7KNb1RSb+3WYZj+ZJ2n20t1qmu2aNRFs
        y1gXyaZlF4tZ/bduiv3YkE+zxtxGxFa97BOzxsxTbMFMLrHLnvvY3Ulwkz2XxZxB1yfm8jRa
        itNXpNHcm6wPIu5ZQaWYG7jaLOIeFydzmTUViHuecYPkpvVrD9udtN0ZykeEx/EqL/8ztmH9
        KQYqWu+eUFXaTqSgUdd0ZMMA9oXR6kGUjmwZKS5DkFHyhBQOMwgmXveKLCopnkaQV+6Wjhir
        Q9uuEDT3EGjnKwnhMInA1NdLW0Qr8VkwZGyzeB3xJigu6rJqCPyLhHfP5ihLgcYbYeHxZ9rC
        EuwPJZoZwsIk3gAps6PWwatwEGSWFC5pHKBFO0xa2AYfgcbZKauewOvgyXj+EjtCz1CqNQ5g
        LQM5v4WmgPdC0dMmSuCVMNpcIxbYFf4YbosEToaBslRCMGsQ1D40LJn94EvbT2syYnHr6gYv
        4SV2g+HFAQHtoWfcQVjBHq7X3SSEawlorkiFHm4w8L52qZ8TlHSY6Swk0y0LplsWRrcsjO7/
        2EJEViAnPlatVPBqn0g+fqtarlTHRiq2no1S6tHiH2z93TxVj8wfQowIM0hmJ3k4+CNYSsnj
        1IlKIwKGkDlK9rxvDZZKQuWJF3hV1GlVbASvNiIXhpQ5SbYXmYKkWCGP4c/zfDSv+lcVMTbO
        KSjLqSDQwyug/n5OrbYzsO1g/upDmpGAHXGl+/Teaddykjw+e1LZeWvWrIi/88psg2ObHea6
        fCe02Xfs3kSnUt31/f4Dk9ndryr2mxK3n0haf7djiJPqj9aVu7sEmje6jo8VhrWwIbO9Ee5B
        x5UTp4tGKi82eh57cORwT02CX3nS23QZqQ6T+3gSKrX8LyBbaL9/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42I5/e/4Xd0zaZ/jDH4vkbR4OeEwo8XGGetZ
        LaY+fMJmceXrezaL5sXr2Syufn/JbHHyzVUWi86JS9gtNj2+xmpxedccNotDU/cyWqw9cpfd
        4lBftMXcL1OZHfg8Ll+7yOzx/kYru8fOWXfZPWZ3zGT12LSqk83jxIRLTB77565h97jffZzJ
        Y/OSeo++LasYPQ70Tmbx+LxJLoAnSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbK
        yFRJ384mJTUnsyy1SN8uQS/jXsNO1oJNKhVrl51nbmB8JdPFyMEhIWAiMfN8ehcjF4eQwFJG
        idMbGti6GDmB4uISu+e/ZYawhSX+XOtigyh6yygxefclZpBmYYFkiZ29RiA1IgLaEksWXWUG
        qWEW+MMi8evACkaIhgYmiWUNh8CmsgloSvzdfBPM5hWwk1ja8QVsA4uAqkTD91dMILaoQKzE
        t3tboGoEJU7OfMICYnMKBErs/f4JrJ5ZwExi3uaHULa8xPa3c6BsEYkbj1oYJzAKzULSPgtJ
        yywkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRGP3bjv3csoOx613wIUYBDkYl
        Ht4NDz7GCbEmlhVX5h5ilOBgVhLhdTp7Ok6INyWxsiq1KD++qDQntfgQoynQcxOZpUST84GJ
        Ka8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA+OqJ5PCmsxrpt+e
        wf5i9pcaif+HDyVKGLaHPP5k8vfGs5qyC4v1Jm9h/X3ROc9gml7r46kWxo9ibnz0bYndYHvo
        eMWcbRx9TNdvztDYq/g0Iuvynwr+lRfevaztCH8itKBX3eS+9vqkteUudww/s8ze8nuip5cq
        97/9zv9V56bt+r5fzP9JF+MeJZbijERDLeai4kQA6/Jc0hQDAAA=
X-CMS-MailID: 20200624144428eucas1p21261d3700fcf3134d6ffdc9e61039d91
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200624114136eucas1p1c84f81b1d78e2dbad7ac1b762f0a4b4f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200624114136eucas1p1c84f81b1d78e2dbad7ac1b762f0a4b4f
References: <CGME20200624114136eucas1p1c84f81b1d78e2dbad7ac1b762f0a4b4f@eucas1p1.samsung.com>
        <20200624114127.3016-1-a.hajda@samsung.com>
        <20200624114127.3016-4-a.hajda@samsung.com>
        <CAJZ5v0i7mU3dGGZv3sUwG2_2OCRP3=bPB7a8sstj0qLwmiwhog@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24.06.2020 14:14, Rafael J. Wysocki wrote:
> On Wed, Jun 24, 2020 at 1:41 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>> Many resource acquisition functions return error value encapsulated in
>> pointer instead of integer value. To simplify coding we can use macro
>> which will accept both types of error.
>> With this patch user can use:
>>          probe_err(dev, ptr, ...)
>> instead of:
>>          probe_err(dev, PTR_ERR(ptr), ...)
>> Without loosing old functionality:
>>          probe_err(dev, err, ...)
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> The separation of this change from patch [1/5] looks kind of artificial to me.
>
> You are introducing a new function anyway, so why not to make it what
> you want right away?


Two reasons:

1.This patch is my recent idea, I didn't want to mix it with already 
reviewed code.

2. This patch could be treated hacky by some devs due to macro 
definition and type-casting.


If both patches are OK I can merge them of course into one.


Regards

Andrzej


>
>> ---
>>   drivers/base/core.c    | 25 ++-----------------------
>>   include/linux/device.h | 25 ++++++++++++++++++++++++-
>>   2 files changed, 26 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 2a96954d5460..df283c62d9c0 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -3953,28 +3953,7 @@ define_dev_printk_level(_dev_info, KERN_INFO);
>>
>>   #endif
>>
>> -/**
>> - * probe_err - probe error check and log helper
>> - * @dev: the pointer to the struct device
>> - * @err: error value to test
>> - * @fmt: printf-style format string
>> - * @...: arguments as specified in the format string
>> - *
>> - * This helper implements common pattern present in probe functions for error
>> - * checking: print message if the error is not -EPROBE_DEFER and propagate it.
>> - * In case of -EPROBE_DEFER it sets defer probe reason, which can be checked
>> - * later by reading devices_deferred debugfs attribute.
>> - * It replaces code sequence:
>> - *     if (err != -EPROBE_DEFER)
>> - *             dev_err(dev, ...);
>> - *     return err;
>> - * with
>> - *     return probe_err(dev, err, ...);
>> - *
>> - * Returns @err.
>> - *
>> - */
>> -int probe_err(const struct device *dev, int err, const char *fmt, ...)
>> +int __probe_err(const struct device *dev, int err, const char *fmt, ...)
>>   {
>>          struct va_format vaf;
>>          va_list args;
>> @@ -3992,7 +3971,7 @@ int probe_err(const struct device *dev, int err, const char *fmt, ...)
>>
>>          return err;
>>   }
>> -EXPORT_SYMBOL_GPL(probe_err);
>> +EXPORT_SYMBOL_GPL(__probe_err);
>>
>>   static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
>>   {
>> diff --git a/include/linux/device.h b/include/linux/device.h
>> index 40a90d9bf799..22d3c3d4f461 100644
>> --- a/include/linux/device.h
>> +++ b/include/linux/device.h
>> @@ -965,7 +965,30 @@ void device_links_supplier_sync_state_pause(void);
>>   void device_links_supplier_sync_state_resume(void);
>>
>>   extern __printf(3, 4)
>> -int probe_err(const struct device *dev, int err, const char *fmt, ...);
>> +int __probe_err(const struct device *dev, int err, const char *fmt, ...);
>> +
>> +/**
>> + * probe_err - probe error check and log helper
>> + * @dev: the pointer to the struct device
>> + * @err: error value to test, can be integer or pointer type
>> + * @fmt: printf-style format string
>> + * @...: arguments as specified in the format string
>> + *
>> + * This helper implements common pattern present in probe functions for error
>> + * checking: print message if the error is not -EPROBE_DEFER and propagate it.
>> + * In case of -EPROBE_DEFER it sets defer probe reason, which can be checked
>> + * later by reading devices_deferred debugfs attribute.
>> + * It replaces code sequence:
>> + *     if (err != -EPROBE_DEFER)
>> + *             dev_err(dev, ...);
>> + *     return err;
>> + * with
>> + *     return probe_err(dev, err, ...);
>> + *
>> + * Returns @err.
>> + *
>> + */
>> +#define probe_err(dev, err, args...) __probe_err(dev, (long)(err), args)
>>
>>   /* Create alias, so I can be autoloaded. */
>>   #define MODULE_ALIAS_CHARDEV(major,minor) \
>> --
>> 2.17.1
>>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://protect2.fireeye.com/url?k=fe383567-a3a29cc4-fe39be28-002590f5b904-1faeb9cf68e31587&q=1&u=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel
>
