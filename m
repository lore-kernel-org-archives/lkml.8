Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5425CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A6E920884
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mOkJnVML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgGBG6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:58:04 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42698 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgGBG6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 02:58:03 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200702065800euoutp01cd58759b0fc3f3ea95730bfe87e14e40~d3TkwHNO31444914449euoutp01p
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 06:58:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200702065800euoutp01cd58759b0fc3f3ea95730bfe87e14e40~d3TkwHNO31444914449euoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593673080;
        bh=HY3QJuzFQ+SJkNZhYjq1mgAxfvlBDyzp0zvay/HzfxI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mOkJnVMLeqNqVSWDaZwMrAqWqbgKv6p2u1Mt9mkM4dDzyvp/VMsAHUuUnsPAlT+fa
         3SUAmcU/PIv/JIGGanZQl6MYqIARrBh4rwi5W/UlfYmE8iyCp3/eAtPy40g1Tyu1/M
         QGVSRH0Oy3ma6VrE01S53coIhqHpopC+/19uGKc8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200702065800eucas1p2501315ca027794f9e159de569803fd71~d3TkVL7OU2154521545eucas1p23;
        Thu,  2 Jul 2020 06:58:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 77.CF.06456.8758DFE5; Thu,  2
        Jul 2020 07:58:00 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200702065759eucas1p27aed78f9bea21366d390de015624cacf~d3Tj5db_I2866328663eucas1p2F;
        Thu,  2 Jul 2020 06:57:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200702065759eusmtrp1a46bc4aa0194674fbbd56e521b0911a4~d3Tj4mgDk1817218172eusmtrp1D;
        Thu,  2 Jul 2020 06:57:59 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-d4-5efd8578b72c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 09.F2.06017.7758DFE5; Thu,  2
        Jul 2020 07:57:59 +0100 (BST)
Received: from [106.210.85.205] (unknown [106.210.85.205]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200702065756eusmtip2c7bd6fd2a24410f6728b9731c3cb082c~d3Tgl8o7Z2648926489eusmtip2w;
        Thu,  2 Jul 2020 06:57:56 +0000 (GMT)
Subject: Re: [PATCH v6 2/4] driver core: add deferring probe reason to
 devices_deferred property
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <e6057292-39de-831c-0b8d-b3f0b66937dc@samsung.com>
Date:   Thu, 2 Jul 2020 08:57:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAKdAkRRLBLCLGH2qhEjaVnt8wNjoyGAfQimNWHZUvzx2m6Mwng@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHefZe9jqavE7FQ4bW6ktRmhXxlGb3eqEi+1JUOJv5eiGntqmt
        PpRohpey5aVyJtpKmiPxrmmascxpopmmaHhJNFAxDNMyu7q9Sn77nfP/n/P8DzwMIftJrWTC
        IqJ5dYQyXE5LyKqmH283aRN/KzZPdznhcd0rhEvvF1M4a3iUxq8MYwi/n52iccKjYhoXZpK4
        +/s4gVsmu0mcfOexGJeN9FC4q/YBjc1Z9QgXNQ6IsTntLM6dySL2sFxXzzuCm+pNFHM1+gEx
        l5OUTXFlpmSaa9Z1iriG3KdibijVIuLKH1/j0ipMiHt5K4PkLL3VIu5rmZuf9IzEJ4gPD4vl
        1Z6+5yShxtS/oqh+d+3PukNx6BekIDsG2G3wrbJBnIIkjIw1IuipM1NCMYPgTWMCIRRfEZQ8
        jUNLI687hhddTxBM6lqQUEwhqO7LJawuRzYQBirqKSs7sZ5QnTNvMxGshYJbz9NsAs2uh9/l
        fbSVpawvVFV/WmCGIdl1kJnuam07s/6QVpC/aHGAluxR0sp27AkonMyxJSJYd0iozCEEdoH4
        mUJbOmCLGDB80dNC7AMwljglFtgRJiwVi7wKWjNukgJfgyHjdUIYTkJQWVJDCII39LfP28IR
        C6GLaz2tCOxeKBjZLqA99H52ECLYQ3rVPUJoSyHphkzYsQaG2ioX97lAQccsrUNy/bLD9MuO
        0S87Rv//2XxEmpALH6NRhfAarwj+kodGqdLERIR4nI9UlaGFL9n6xzL9DM12BpoRyyD5Cmmo
        9pdCRiljNZdVZgQMIXeS7mtrVcikQcrLV3h1ZIA6JpzXmJErQ8pdpFsN4/4yNkQZzV/g+She
        vaSKGLuVceiUZaTbdKfJ25le67uj0+fji+C5i37xio03V9Gj7VfnPgTUjhyZWN2dF6x9+dBE
        7z3YJDns8WGLU56KwPP3cyeOBTLG5LD9Xu++uFVkGg2Kxl3qrMHbmd/m6o4avE76nNZ/dk0q
        Dzn+Pnj39E7xXcfo252DzaUTusgZynxkY9cp90tyUhOq9NpAqDXKf3A1nuSOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42I5/e/4Pd3y1r9xBlcnmlm8nHCY0WLjjPWs
        FlMfPmGzOLzoBaPFla/v2SyaF69ns1g5hcXi6veXzBYn31xlseicuITdYtPja6wWl3fNYbM4
        NHUvo8XaI3fZLQ71RVvM/TKV2UHA4/K1i8we72+0snvsnHWX3WN2x0xWj02rOtk8Tky4xOSx
        f+4ado/73ceZPDYvqffo27KK0eNA72QWj+M3tjN5fN4kF8AbpWdTlF9akqqQkV9cYqsUbWhh
        pGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJexovs/U8Ed+Yrfe9waGP9IdDFyckgI
        mEgcvfCQtYuRi0NIYCmjxN1jrawQCXGJ3fPfMkPYwhJ/rnWxQRS9ZZS4seARE0hCWCBJ4u6W
        vWANIgL6Ettn/2IEKWIWOMkqcXb6TyaIjjPMErfnXwerYhPQlPi7+SYbiM0rYCexbftTIJuD
        g0VARWLKJGmQsKhArMS3e1ugSgQlTs58wgJicwoESqx8M5sRxGYWMJOYt/khM4QtL9G8dTaU
        LS7R9GUl6wRGoVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAhPD
        tmM/t+xg7HoXfIhRgINRiYc3o+JPnBBrYllxZe4hRgkOZiURXqezp+OEeFMSK6tSi/Lji0pz
        UosPMZoC/TaRWUo0OR+YtPJK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQx
        cXBKNTDOmDx/4Q+RSw/3r9JYvahQtWP7xnupvFbrHkyMW+afz3t6+vK6Equ70wo+B37J8PHY
        N+X0mkOemx9dqCrKlLNada6Z+bpeZHZAulLyY7fW8LeiK71O5k758idQ8AiH3jVHHqtOpbT1
        dYbVBzb9qwj89VH75Msnwo2LlzpJnX/ooXpuSXNJrddnJZbijERDLeai4kQA9ILhMCIDAAA=
X-CMS-MailID: 20200702065759eucas1p27aed78f9bea21366d390de015624cacf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200626100110eucas1p2c5b91f2c98a5c6e5739f5af3207d192e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200626100110eucas1p2c5b91f2c98a5c6e5739f5af3207d192e
References: <20200626100103.18879-1-a.hajda@samsung.com>
        <CGME20200626100110eucas1p2c5b91f2c98a5c6e5739f5af3207d192e@eucas1p2.samsung.com>
        <20200626100103.18879-3-a.hajda@samsung.com>
        <5f159e00-44fd-515b-dd8c-4db9845dc9e6@ti.com>
        <7e3c924b-c025-a829-6868-78e2935c70eb@samsung.com>
        <66faa188-5ef6-d449-07fe-28c8be5e559c@ti.com>
        <21f5ec9c-2d1d-5f28-5aeb-ac0db144a55e@samsung.com>
        <CAKdAkRRLBLCLGH2qhEjaVnt8wNjoyGAfQimNWHZUvzx2m6Mwng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30.06.2020 20:00, Dmitry Torokhov wrote:
> On Tue, Jun 30, 2020 at 8:42 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>>
>> On 30.06.2020 10:59, Grygorii Strashko wrote:
>>> Hi
>>>
>>> On 29/06/2020 14:28, Andrzej Hajda wrote:
>>>> Hi Grygorii,
>>>>
>>>> (...)
>>>>
>>>>>>     /*
>>>>>>      * deferred_devs_show() - Show the devices in the deferred probe
>>>>>> pending list.
>>>>>>      */
>>>>>> @@ -221,7 +241,8 @@ static int deferred_devs_show(struct seq_file *s,
>>>>>> void *data)
>>>>>>         mutex_lock(&deferred_probe_mutex);
>>>>>>           list_for_each_entry(curr, &deferred_probe_pending_list,
>>>>>> deferred_probe)
>>>>>> -        seq_printf(s, "%s\n", dev_name(curr->device));
>>>>>> +        seq_printf(s, "%s\t%s", dev_name(curr->device),
>>>>>> + curr->device->p->deferred_probe_reason ?: "\n");
>>>>>>           mutex_unlock(&deferred_probe_mutex);
>>>>>>
>>>>> Sry, may be i missing smth, but shouldn't it be optional
>>>>> (CONFIG_DEBUG_FS is probably too generic).
>>>>>
>>>> I am not sure what exactly are you referring to, but this patch does not
>>>> add new property, it just extends functionality of existing one.
>>> Sry, needed to be more specific.
>>>
>>> You've added  device_set_deferred_probe_reson(dev, &vaf);
>>> which expected to be used on every EPROBE_DEFER in dev_err_probe() in
>>> combination with
>>>
>>> +       } else {
>>> +               device_set_deferred_probe_reson(dev, &vaf);
>>>                  dev_dbg(dev, "error %d: %pV", err, &vaf);
>>>
>>> ^^ dev_dbg() does not add any runtime overhead during boot unless enabled
>>> +       }
>>>
>>> But:
>>>
>>> +void device_set_deferred_probe_reson(const struct device *dev, struct
>>> va_format *vaf)
>>> +{
>>> +       const char *drv = dev_driver_string(dev);
>>> +
>>> +       mutex_lock(&deferred_probe_mutex);
>>> +
>>> +       kfree(dev->p->deferred_probe_reason);
>>> +       dev->p->deferred_probe_reason = kasprintf(GFP_KERNEL, "%s:
>>> %pV", drv, vaf);
>>> +
>>> +       mutex_unlock(&deferred_probe_mutex);
>>> +}
>>>
>>> ^^ Adds locking, kfree() and kasprintf() for every deferred probe
>>> during boot and can't be disabled.
>>>
>>> Right?
>>
>> Right, but usually the burden should be insignificant in comparison to
>> probe time, so I do not think it is worth optimizing.
> I do not think this is going to take. You are suggesting that we
> modify pretty much every driver to supply this deferral reason, and I
> doubt it will happen. Can we put this burden on providers that raise
> the deferral?


I wouldn't say they raise the deferral, they just inform resource is not 
yet available. Only device driver, and only in its probe function can 
"raise the deferral".


>   I.e. majority of code are using devm API now, so we most
> likely know the device for which deferral is being raised. We can have
> a list of deferral reasons and their devices and when in device code
> once probe is done we could try reconciling it with the deferred
> devicelist, and this would mean you only need to implement this in
> gpiolib, regulator core, clocks core, etc.


This patchset tries to solve simple issue - replace multiple lines of 
code present in multiple probe functions (additionally fixing lot of 
them) with single call and then enhance it little bit, nothing more.

What you are proposing is blurry at the moment for me, provider does not 
know if consumer want to defer,  or will continue working without 
missing resource, moreover some consumers can acquire resources after 
probe - again no probe deferral. Even if it will be done (it can be, for 
example by creating probe version of all resource get functions), it 
will require much more changes but finally it will look like:

res = devm_get_resource_from_probe(....)

if (IS_ERR(res))

     return PTR_ERR(res);

vs:

res = devm_get_resource(...)

if (IS_ERR(res))

     return dev_err_probe(dev, PTR_ERR(res), ...);


Regards

Andrzej


>
> Thanks.
>
