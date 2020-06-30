Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7808C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90E2020724
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Wiw+xl2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389621AbgF3Pld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:41:33 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43546 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbgF3Plc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:41:32 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200630154130euoutp0119b76a99a4cc62d0f3b749732fac0d8f~dXKEpbmH33091230912euoutp011
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 15:41:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200630154130euoutp0119b76a99a4cc62d0f3b749732fac0d8f~dXKEpbmH33091230912euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593531690;
        bh=9+ZLNHccDw6coz73gcRe7hN+aPPjOugZXhzt0Urpb10=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Wiw+xl2QnqJRK70fj0aslQhPtb6MNS8iJKs7ADL6AMmR67lZJ4DEUnU6eo93oeVA2
         hEarkjDbsK5LT6MAD1yOFUwDU5QtY8iJKZsSR4nVOunctkJG6aMakPbgxY2T8stuPq
         2N/7XY36JADRaEAFA7izWH8ga04sPdsvA4MHTxuI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200630154129eucas1p17cd71ea4c71e6b908bd03beb386f8352~dXKD949CJ1267712677eucas1p1B;
        Tue, 30 Jun 2020 15:41:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A2.6C.06456.92D5BFE5; Tue, 30
        Jun 2020 16:41:29 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200630154129eucas1p1b9fe4f782eaacfc3997bbb3742816326~dXKDjZNdh0182201822eucas1p1F;
        Tue, 30 Jun 2020 15:41:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200630154129eusmtrp1704148f4f0ae4aab4cfadc825f5a57d6~dXKDigtoR0929409294eusmtrp1N;
        Tue, 30 Jun 2020 15:41:29 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-27-5efb5d291577
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B0.27.06314.92D5BFE5; Tue, 30
        Jun 2020 16:41:29 +0100 (BST)
Received: from [106.210.85.205] (unknown [106.210.85.205]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200630154127eusmtip12655edbc046a96b358ecc5ebb417ec9c~dXKB8M9py1474314743eusmtip10;
        Tue, 30 Jun 2020 15:41:27 +0000 (GMT)
Subject: Re: [PATCH v6 2/4] driver core: add deferring probe reason to
 devices_deferred property
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <21f5ec9c-2d1d-5f28-5aeb-ac0db144a55e@samsung.com>
Date:   Tue, 30 Jun 2020 17:41:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <66faa188-5ef6-d449-07fe-28c8be5e559c@ti.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGczvT6VAtDAXTE3CJdQloRIloxiXELTrERH10CWjBkUUopLUK
        vkBEtKAsFRu1gCFgAevSUhYFQyDFWAyyCLJIgGoUY1VopCwRlUiZEnn7zv3P/59zkkti4mm+
        Hxkrv8Aq5LJ4KSHEa1/96tgUGP47YsuH3jW0Pa8Z0ZV3jXxa+/EzQb+bdBB0eqmRoB/exume
        aTtGv/7Rg9OZmgcC2vypl0931xcStEXbgOgnL4cEtCXnFF00ocX2eDHdvW8xxtGfIWDqdEMC
        pkB9j8+YDZkE05LXxWMaix4LGNsNK4+pepDK5FQbENOUnY8z1v5nPMZpXnlMdFK4+ywbH3uR
        VWwOPSOMMbTY8KQ+7+SRzvg01OuZhTxIoELAlDvKy0JCUkxVILg/PYZxxQSCokazu3AiKC3/
        QyxYXpi+E5xQjqBPM+PuciCYKWoVuLp8qEgYqm7gu9iXioJfg7PzDoyqxWHw/ot5gaAC4W/V
        +/lYERUKA+0d82acWgcd12Z5Ll5GhUOOvtjd4w2v733GXexB7YRHpmHkYoxaBek1BRjHErgy
        8ZDvGgaUnoQ3+ib33gdgaqqMz7EPfLNWCzheDq35N3GOU8FWcRXjzGoENaY6jBN2wWD7zFwQ
        OTchEIz1m10I1F7Qf9rOoSf0j3pzK3jCrdo7GPcsAvU1MZexGmxtNe48Ceg7J4k8JNUtOky3
        6BjdomN0/8cWI9yAJKxKmRDNKoPl7KUgpSxBqZJHB0UlJpjR3HdsnbWOP0eTXZEWRJFIulSk
        XvE7QsyXXVSmJFgQkJjUV7SvrTVCLDorS7nMKhJPK1TxrNKC/ElcKhFtLbGHi6lo2QX2PMsm
        sYoFlUd6+KUhg8Qr76uhRHpubb2fzdf/8Hp/Q9DTy3/tYXXGJcXjtqa3GvPHjHYobs9QOa/v
        SLT7WMdV2oDC422OXcOnTgTklnhGaiZyj4SPOUvNEFvSqIkRhJQfisq6nX2wauOWnOSu0TJ1
        pQPEP68O5Du/bGMKmo/GKc6Eee9/lhEXYxppkOLKGFnwBkyhlP0DUG3b4ooDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42I5/e/4XV3N2N9xBv/7OSxeTjjMaLFxxnpW
        i6kPn7BZXPn6ns2iefF6NouVU1gsrn5/yWxx8s1VFovOiUvYLTY9vsZqcXnXHDaLQ1P3Mlqs
        PXKX3eJQX7TF3C9TmR34PS5fu8js8f5GK7vHzll32T1md8xk9di0qpPN48SES0we++euYfe4
        332cyWPzknqPvi2rGD0O9E5m8Th+YzuTx+dNcgG8UXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6
        RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZq07cZym4Lljx9EJOA+M1vi5GTg4JAROJ3Rte
        s4HYQgJLGSVW/dCDiItL7J7/lhnCFpb4c60LqIYLqOYto8Sh32vAEsICSRJ3t+xlBbFFBJIl
        vnS8YAEpYhbYxSJx4m8DO0THBSaJKTO2g61gE9CU+Lv5JpjNK2AncevceXYQm0VAVeJ82z8m
        EFtUIFbi270tUDWCEidnPmEBsTkFrCRWb7jHCGIzC5hJzNv8kBnClpdo3jobyhaXaPqyknUC
        o9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIHpYNuxn5t3MF7a
        GHyIUYCDUYmHt0P2d5wQa2JZcWXuIUYJDmYlEV6ns6fjhHhTEiurUovy44tKc1KLDzGaAj03
        kVlKNDkfmKrySuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUwtm3o
        eOq+40Vz+ByOubarKzQWad/x/P5jw8ZZn4yuX+kXvhP4c078/sc7t0/zd+4odY09OHWRLo/H
        M+XiqiDxO7/CZr6+OPHijqk/FHvs5u7fsjpv31KFl6xiO5+0/399/mzt3urP/Qf9fb4lrety
        6N5w/u/XDZKRlmqhbw9tWci6pd8y6afmjm1KLMUZiYZazEXFiQAhCqvUHQMAAA==
X-CMS-MailID: 20200630154129eucas1p1b9fe4f782eaacfc3997bbb3742816326
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30.06.2020 10:59, Grygorii Strashko wrote:
> Hi
>
> On 29/06/2020 14:28, Andrzej Hajda wrote:
>> Hi Grygorii,
>>
>> (...)
>>
>>>>    /*
>>>>     * deferred_devs_show() - Show the devices in the deferred probe
>>>> pending list.
>>>>     */
>>>> @@ -221,7 +241,8 @@ static int deferred_devs_show(struct seq_file *s,
>>>> void *data)
>>>>        mutex_lock(&deferred_probe_mutex);
>>>>          list_for_each_entry(curr, &deferred_probe_pending_list,
>>>> deferred_probe)
>>>> -        seq_printf(s, "%s\n", dev_name(curr->device));
>>>> +        seq_printf(s, "%s\t%s", dev_name(curr->device),
>>>> + curr->device->p->deferred_probe_reason ?: "\n");
>>>>          mutex_unlock(&deferred_probe_mutex);
>>>>
>>>
>>> Sry, may be i missing smth, but shouldn't it be optional
>>> (CONFIG_DEBUG_FS is probably too generic).
>>>
>>
>> I am not sure what exactly are you referring to, but this patch does not
>> add new property, it just extends functionality of existing one.
>
> Sry, needed to be more specific.
>
> You've added  device_set_deferred_probe_reson(dev, &vaf);
> which expected to be used on every EPROBE_DEFER in dev_err_probe() in 
> combination with
>
> +       } else {
> +               device_set_deferred_probe_reson(dev, &vaf);
>                 dev_dbg(dev, "error %d: %pV", err, &vaf);
>
> ^^ dev_dbg() does not add any runtime overhead during boot unless enabled
> +       }
>
> But:
>
> +void device_set_deferred_probe_reson(const struct device *dev, struct 
> va_format *vaf)
> +{
> +       const char *drv = dev_driver_string(dev);
> +
> +       mutex_lock(&deferred_probe_mutex);
> +
> +       kfree(dev->p->deferred_probe_reason);
> +       dev->p->deferred_probe_reason = kasprintf(GFP_KERNEL, "%s: 
> %pV", drv, vaf);
> +
> +       mutex_unlock(&deferred_probe_mutex);
> +}
>
> ^^ Adds locking, kfree() and kasprintf() for every deferred probe 
> during boot and can't be disabled.
>
> Right?


Right, but usually the burden should be insignificant in comparison to 
probe time, so I do not think it is worth optimizing.


Regards

Andrzej


>
>
