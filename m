Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52599C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2171D206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oo4LHiWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgGJHnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:43:18 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56925 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgGJHm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:42:57 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200710074254euoutp01e47f1216c504d4ec38620c33b46c527a~gVFDQPsxY2017420174euoutp01I
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:42:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200710074254euoutp01e47f1216c504d4ec38620c33b46c527a~gVFDQPsxY2017420174euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594366974;
        bh=71gtjQdayz9Sfx+7JNM9XZnqbiN5Eovh/TyYw4n3WSY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=oo4LHiWpjv4wIEUAFZ651FDCz2YHBPDPYPGSo2H4deZO3G9W/L52vtJTuw23nGb4e
         +CgjU6YNWSMtSFfZ7qkuq0LDHSNR4JPKMIShh9+9kqNOoxjEVSX8+IZdF/9tRm0rUi
         c2Q5N5sYvTDSQM0dB5bVlblJOjQRhGD3lF9jwz9o=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200710074253eucas1p2775486b98930110528986a9f115b7f6e~gVFCv7IEx0975109751eucas1p2_;
        Fri, 10 Jul 2020 07:42:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 94.96.06318.DFB180F5; Fri, 10
        Jul 2020 08:42:53 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200710074253eucas1p2bc069723595d44f960e1acc68033ff36~gVFCXtqgq3199831998eucas1p2q;
        Fri, 10 Jul 2020 07:42:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200710074253eusmtrp1342b48667d23b45e504193ae209b6191~gVFCW7DM20503905039eusmtrp1C;
        Fri, 10 Jul 2020 07:42:53 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-24-5f081bfd17c5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 40.3A.06314.DFB180F5; Fri, 10
        Jul 2020 08:42:53 +0100 (BST)
Received: from [106.210.85.205] (unknown [106.210.85.205]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200710074250eusmtip2ceb74bdc3624e7716492e0d55442b0be~gVE-5rvJ61823918239eusmtip2I;
        Fri, 10 Jul 2020 07:42:50 +0000 (GMT)
Subject: Re: [PATCH v6 2/4] driver core: add deferring probe reason to
 devices_deferred property
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonas Karlman <jonas@kwiboo.se>,
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
Message-ID: <8b228571-d124-e5e2-2f53-57ea4b46b904@samsung.com>
Date:   Fri, 10 Jul 2020 09:42:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200707041442.GE3273837@dtor-ws>
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTURjHO3sve13NXlfhg0mXQdG6uEKTl26UFr6fwo9plK18U2lbtaWm
        X5RZpstkpmLOC2Kaly7mdJqSKbOcshSzMoNkRUUtvICXypGV2zHy2+85z3N+5/nDYQjZHBXA
        JGgvCTqtSi2nJWRLz9zAjvm1TMzO5+4NnMvUjbjGWw0UV/jhE811V35F3KvZSZrLuN1Ac3UF
        JPf6h4vg+sZek1x2XpWYs3wcpriX7aU0ZyvsQNz9p6NizpZ7nCubKSQOsvzL4RcEPzlyVcy3
        mUfFfElWMcVb6rNpvtc0JOI7y+6Jeed1u4hvqkrjc5vrEd91I5/k7SOtIn7asi5SGi3ZFyuo
        E5IEnfLAKUl84Z8c6sL3kMu1xhZxOvqpMCKGATYEOitXGpGEkbG1CIqG+mlczCCYahojcDGN
        4O7zLyIj8vHeeDbxjcSNGgQZneUIF5MI3ozPkZ6pVexpGG3uoDy8mlVCa4kbeZhg7RS8KyA8
        TLMKmG96S3tYyh6AmjvFXibZTVDcWOHlNexJaHC1ivCMH/QVf/L6fRacPaZpAjvXQ4a1ZJH9
        wTBTR+FN6xjoypHjnIfB/UCNj1fBN3uzGHMgOPJzSMxp4Ky94k0MbBYC68M2Ajf2wrsBN+3x
        EAs7N7QrsfIQVH8MxegLI+N+eAFfuNlSROBjKWRlyrBjIzj7rYs+f6genKVNSG5eEsu8JIp5
        SRTz/2crEFmP/IVEvSZO0AdrheQgvUqjT9TGBZ05r7GghQ/p+G2ffYSe/DptQyyD5Cukp+bp
        GBmlStKnaGwIGEK+WhrW7zgpk8aqUlIF3fkYXaJa0NvQWoaU+0uDK10nZGyc6pJwThAuCLp/
        XRHjE5COljuc1127211n14wpLS8Coj9n3puoNeblPUk9bojJTQsP0vRKorZNbpaJXRX7Hwvh
        mdl7IgzO+eCQa7EpVcdC0xRbtkO1IXy6XG1936fSPe7XdtzV9ES6S+PmInqSL5YfDWubqnO8
        Hff52hZl8gtUGAaHlNXyxvbN2qxlR34NP5KT+njVrq2ETq/6C5wjHESMAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsVy+t/xe7p/pTniDRYt5bB4OeEwo8XGGetZ
        LaY+fMJmcXjRC0aLK1/fs1k0L17PZrFyCovF1e8vmS1OvrnKYtE5cQm7xabH11gtLu+aw2Zx
        aOpeRou1R+6yWxzqi7aY+2Uqs4OAx+VrF5k93t9oZffYOesuu8fsjpmsHptWdbJ5nJhwiclj
        /9w17B73u48zeWxeUu/Rt2UVo8eB3sksHsdvbGfy+LxJLoA3Ss+mKL+0JFUhI7+4xFYp2tDC
        SM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j6v8e1oJvJhUruraxNzD+0Oxi5OSQ
        EDCROPruFUsXIxeHkMBSRon5E5axQSTEJXbPf8sMYQtL/LnWxQZR9JZRYlnrHVaQhLBAksTd
        LXvBbBEBfYnts38xghQxC5xmlfi8ehYrRMcyFom+z4fBqtgENCX+br4JtoJXwE5i+bKZYDaL
        gKrEzI0LwGxRgTiJ5Vvms0PUCEqcnPmEBcTmBNpwbMJnsJOYBcwk5m1+CGXLSzRvnQ1li0s0
        fVnJOoFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwOSw7djP
        zTsYL20MPsQowMGoxMO74z9bvBBrYllxZe4hRgkOZiURXqezp+OEeFMSK6tSi/Lji0pzUosP
        MZoCPTeRWUo0OR+YuPJK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBK
        NTCq7w96+rDQNSsoU1WqZfWUrzqRvhdSzrxe/3Ga2Nk/bkzZfp1nX2yfr7HxPsuNEAsxw+Wu
        lroTXv//4br3+YXOAnebqm+8szPv1tkVebzPSZguWCTV8Horl339u/8Lzjx3vv/1fOKqvzmK
        inrhf73DRBv+JDBLm9h2vt6yYn2H68W3l74EnFmoxFKckWioxVxUnAgAiL0YZCQDAAA=
X-CMS-MailID: 20200710074253eucas1p2bc069723595d44f960e1acc68033ff36
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
        <e6057292-39de-831c-0b8d-b3f0b66937dc@samsung.com>
        <20200707041442.GE3273837@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.07.2020 06:14, Dmitry Torokhov wrote:
> On Thu, Jul 02, 2020 at 08:57:55AM +0200, Andrzej Hajda wrote:
>> On 30.06.2020 20:00, Dmitry Torokhov wrote:
>>> On Tue, Jun 30, 2020 at 8:42 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>>>> On 30.06.2020 10:59, Grygorii Strashko wrote:
>>>>> Hi
>>>>>
>>>>> On 29/06/2020 14:28, Andrzej Hajda wrote:
>>>>>> Hi Grygorii,
>>>>>>
>>>>>> (...)
>>>>>>
>>>>>>>>      /*
>>>>>>>>       * deferred_devs_show() - Show the devices in the deferred probe
>>>>>>>> pending list.
>>>>>>>>       */
>>>>>>>> @@ -221,7 +241,8 @@ static int deferred_devs_show(struct seq_file *s,
>>>>>>>> void *data)
>>>>>>>>          mutex_lock(&deferred_probe_mutex);
>>>>>>>>            list_for_each_entry(curr, &deferred_probe_pending_list,
>>>>>>>> deferred_probe)
>>>>>>>> -        seq_printf(s, "%s\n", dev_name(curr->device));
>>>>>>>> +        seq_printf(s, "%s\t%s", dev_name(curr->device),
>>>>>>>> + curr->device->p->deferred_probe_reason ?: "\n");
>>>>>>>>            mutex_unlock(&deferred_probe_mutex);
>>>>>>>>
>>>>>>> Sry, may be i missing smth, but shouldn't it be optional
>>>>>>> (CONFIG_DEBUG_FS is probably too generic).
>>>>>>>
>>>>>> I am not sure what exactly are you referring to, but this patch does not
>>>>>> add new property, it just extends functionality of existing one.
>>>>> Sry, needed to be more specific.
>>>>>
>>>>> You've added  device_set_deferred_probe_reson(dev, &vaf);
>>>>> which expected to be used on every EPROBE_DEFER in dev_err_probe() in
>>>>> combination with
>>>>>
>>>>> +       } else {
>>>>> +               device_set_deferred_probe_reson(dev, &vaf);
>>>>>                   dev_dbg(dev, "error %d: %pV", err, &vaf);
>>>>>
>>>>> ^^ dev_dbg() does not add any runtime overhead during boot unless enabled
>>>>> +       }
>>>>>
>>>>> But:
>>>>>
>>>>> +void device_set_deferred_probe_reson(const struct device *dev, struct
>>>>> va_format *vaf)
>>>>> +{
>>>>> +       const char *drv = dev_driver_string(dev);
>>>>> +
>>>>> +       mutex_lock(&deferred_probe_mutex);
>>>>> +
>>>>> +       kfree(dev->p->deferred_probe_reason);
>>>>> +       dev->p->deferred_probe_reason = kasprintf(GFP_KERNEL, "%s:
>>>>> %pV", drv, vaf);
>>>>> +
>>>>> +       mutex_unlock(&deferred_probe_mutex);
>>>>> +}
>>>>>
>>>>> ^^ Adds locking, kfree() and kasprintf() for every deferred probe
>>>>> during boot and can't be disabled.
>>>>>
>>>>> Right?
>>>> Right, but usually the burden should be insignificant in comparison to
>>>> probe time, so I do not think it is worth optimizing.
>>> I do not think this is going to take. You are suggesting that we
>>> modify pretty much every driver to supply this deferral reason, and I
>>> doubt it will happen. Can we put this burden on providers that raise
>>> the deferral?
>>
>> I wouldn't say they raise the deferral, they just inform resource is not
>> yet available. Only device driver, and only in its probe function can
>> "raise the deferral".
> Well, this is a matter of perspective. If devm_gpiod_get() returns
> -EBUSY and this is returned to driver core, is it GPIO line signals that
> line is busy, or is it the driver applies its knowledge. I say that in
> majority of cases driver does not really get a say in this and simply
> has to pass whatever error condition that is signalled by providers up
> the stack.
>
> I would consider whenever a driver does not propagate -EPROBE_DEFER to
> the driver code a bug that needs fixing, because it should not degrade
> functionality and/or performance just because we have not figured out
> how to order probing properly and have to rely on deferrals.
>
>>
>>>    I.e. majority of code are using devm API now, so we most
>>> likely know the device for which deferral is being raised. We can have
>>> a list of deferral reasons and their devices and when in device code
>>> once probe is done we could try reconciling it with the deferred
>>> devicelist, and this would mean you only need to implement this in
>>> gpiolib, regulator core, clocks core, etc.
>>
>> This patchset tries to solve simple issue - replace multiple lines of
>> code present in multiple probe functions (additionally fixing lot of
>> them) with single call and then enhance it little bit, nothing more.
>>
>> What you are proposing is blurry at the moment for me, provider does not
>> know if consumer want to defer,
> This is my point - the consumer does not get to decide. If deferral is
> raised, it must be honored.
>
>> or will continue working without missing resource,
> Deferral does not mean resource does not exist and the driver has to get
> by if it can. It means the resource is not ready, and even if the system
> can work without it, it will not be working optimally.
>
>> moreover some consumers can acquire resources after probe - again no
>> probe deferral.
> In this case we should not signal deferral either.


But the provider does not know if *get is called in probe context or 
not, so it is not able to differentiate it.

So the whole idea is for me suspicious/wrong. Kind of proof:

1. If you insist that provider's EPROBE_ERROR must be always propagated 
to driver core then.

2. You must enforce that resources can be gathered only from probe.

3. But this is against current practice, even if majority of drivers 
does it from probe, there are many which doesn't.

QED :)


So if you really want to go this way it would be good to look at these 
drivers, check why they do it this way, and try to convert them.

But I do not think it is a good way.


Regards

Andrzej

>
>> Even if it will be done (it can be, for
>> example by creating probe version of all resource get functions), it
>> will require much more changes but finally it will look like:
>>
>> res = devm_get_resource_from_probe(....)
>>
>> if (IS_ERR(res))
>>
>>       return PTR_ERR(res);
>>
>> vs:
>>
>> res = devm_get_resource(...)
>>
>> if (IS_ERR(res))
>>
>>       return dev_err_probe(dev, PTR_ERR(res), ...);
> And we will need to adjust how many hundreds of drivers?
>
> Consider that most drivers use devm_clk_get(), devm_gpiod_get() and
> devm_regulator_get() and their friends. All these APIs already have
> device for which resource is being allocated, and moreover their use
> outside of probe() path is highly suspicious (because devm outside of
> probe() typically result in unwinding in really surprising order). So if
> you could stash device and deferral reason in a list and then scan this
> list in driver core when handling the raised deferral you would not need
> to change anything in individual drivers.

> Hope this clears what I had in mind.
>
> Thanks.
>
