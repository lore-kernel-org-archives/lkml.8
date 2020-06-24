Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A88BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7BEB2077D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="t5TKyt04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391339AbgFXTkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:40:03 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36158 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391239AbgFXTkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 15:40:03 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200624194001euoutp021f50915a7be015d606ca6b4f24eb2602~bkinNb5VF0412504125euoutp02j
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 19:40:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200624194001euoutp021f50915a7be015d606ca6b4f24eb2602~bkinNb5VF0412504125euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593027601;
        bh=/PKPR21D3yzmO8zgUQVUMWEJLHNB4e4J1RxOI6CYodQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=t5TKyt04mrUUTWkoslfsWlnTaikKJCOqh4ouA6AHkmpi3ueSW6cvv9Lovz/U1PSI8
         h4dpMpjDyUmcK1qNjxMdJVvyH9G9UNLGJ91yEPo2N1PvLY19CBNU8f9TCrM/GQ1P76
         vXunOYdyByzvWbKnkP2Jcv4qGjDEbEAId96nYhic=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200624193959eucas1p2f75833f9cd8a06228784ed4d5ebd8026~bkil1R8ZS1377313773eucas1p2A;
        Wed, 24 Jun 2020 19:39:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7F.AE.05997.F0CA3FE5; Wed, 24
        Jun 2020 20:39:59 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200624193958eucas1p2f640d2c5ae0f1ec6ada4376a76e8bc04~bkikqwIB62368623686eucas1p22;
        Wed, 24 Jun 2020 19:39:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200624193958eusmtrp16be7ca4ff5fc9317e6fc39e7f98f4866~bkikpCiOB3265032650eusmtrp10;
        Wed, 24 Jun 2020 19:39:58 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-70-5ef3ac0fb559
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B4.71.06314.E0CA3FE5; Wed, 24
        Jun 2020 20:39:58 +0100 (BST)
Received: from [106.210.85.205] (unknown [106.210.85.205]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200624193957eusmtip2f7eb568029a754d272079ac78319c72d~bkijvKvFk3269732697eusmtip25;
        Wed, 24 Jun 2020 19:39:57 +0000 (GMT)
Subject: Re: [RESEND PATCH v5 3/5] drivers core: allow probe_err accept
 integer and pointer types
To:     Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <70b61b75-c68b-ad89-5f6a-f1d681b9f5d0@samsung.com>
Date:   Wed, 24 Jun 2020 21:39:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <381de683-df5e-4112-5690-13dd9272ae22@arm.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+XYuO4rTs2n4Ylk06E5aKXlCuxccgiCCCgytqQedqcmmZnez
        lLlyqWHl1BKbpqIsrzlLymmZSKM0RWUqmv4xu0zbKgovtR0j//t93/s87/s+8FKY5CfhQ8kT
        kjhFgixOSrriTa9/mTZ7VNvCtwzOBzKWnHbE1N7XE0z+2ATJfPhuJZnrj/Qk0/fTgjFdn/tw
        JitXJ2TqPvYTTG9LEckY81sRU9MxLGSMmpNMsT0fY9qmJ4g9Hmz1g2rE9va/x1jrQIaQNWiH
        hWyhqoBg66qySPZNTo+AfVFcLWRHb3YK2HrdVVbTUIXYl9l3cNZWt/KIKNQ1JIqLk6dwCv9d
        p11jFqwPicRp91TTqxoyDd11UyMXCuhAMBd/wtTIlZLQFQh05SqCf9gRmL+9JxwqCW1DYCsN
        /Of40a4medFjBLczni46rAielNgFakRRnnQkGLK3OQxeNAu1RV+dGozOJeC5VoM7CiS9Aebq
        B0kHi+hd0PKh1jkNp9dAZuszzMHL6DDQlJUsasTQVTDh9LrQwXBtrMfJGL0KrjcWYjx7Q7q9
        0jkM6DIK+gtHcH7tA9A1NSzg2ROmOhuEPK+A7ju3FjVXYbTiBsabVQganxgwvhAMZtNv0pEM
        +7u1vsXfgUDvBUPbIR7dYeCLmF/BHfKa7mH8twhUmRK+x2oYfdu42M8byt59J3OQVLskmHZJ
        GO2SMNr/Y0sQXoW8uWRlfDSn3JbAnfNTyuKVyQnRfpFn4+vQ33Psnu+0N6OW2QgjoikkdROt
        T7GFSwhZivJ8vBEBhUm9RPvedodLRFGy8xc4xdlTiuQ4TmlEyylc6i0KKLWESehoWRJ3huMS
        OcW/qoBy8UlDvtMQm6jpH5/drfIYEo4H+OVFBImP7R+LOnPodLk8NGLtFLo0eP/Cwuz2Jkml
        eWVs5I0ZgXhkUmxhog3h64Iu/pjZkaLYog6dLvG5HOJyENJ9rbqCzKa5GJP8aPNl0I3ofM0C
        tyvGncWb9GlD0oFJYWFG6uFSk/6E3DY+drxDiitjZFs3Ygql7A8gj4V4igMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42I5/e/4PV2+NZ/jDJofqVm8nHCY0WLjjPWs
        FlMfPmGzuPL1PZtF8+L1bBZXv79ktjj55iqLRefEJewWmx5fY7W4vGsOm8WhqXsZLdYeuctu
        cagv2mLul6nMFgc/PGF14PdYM28No8flaxeZPd7faGX32DnrLrvH7I6ZrB6bVnWyeZyYcInJ
        Y//cNewe97uPM3lsXlLv0bdlFaPHgd7JLB6fN8kF8Ebp2RTll5akKmTkF5fYKkUbWhjpGVpa
        6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZfx/P5+14ANfxbmja9kaGKfxdDFyckgImEh8
        O9zFBmILCSxllPjzzBMiLi6xe/5bZghbWOLPNZAaLqCat4wSs5sOMnUxcnAICyRL7Ow1AqkR
        EfCQ2DjnHStIDbPAVFaJq8smsUI07GaW+PX+JdgGNgFNib+bb4LZvAJ2EruubGQFsVkEVCXa
        9u4G2yYqECvx7d4WqBpBiZMzn7CA2JwC1hKNDy+B2cwCZhLzNj9khrDlJZq3zoayxSWavqxk
        ncAoNAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYELYduzn5h2M
        lzYGH2IU4GBU4uHVKPscJ8SaWFZcmXuIUYKDWUmE1+ns6Tgh3pTEyqrUovz4otKc1OJDjKZA
        z01klhJNzgcmq7ySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYx1
        s7akXd3iwTzNp9TAvj2GI2G3O8O0tN4ni1TV/YNqth7WmSnPzrmy+LDYuphp0Wu/sx5XVJpb
        oTzpyP3T2Yc7Vux8fmODi1vgiYjnvu7qt23eHX28KVrvkqXxa21J8w+LuJl6Jv99tYxRymfJ
        T83fTx9xv925lEF11qOfz19bcIuqTjRt8slSYinOSDTUYi4qTgQAQALfcR4DAAA=
X-CMS-MailID: 20200624193958eucas1p2f640d2c5ae0f1ec6ada4376a76e8bc04
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200624114136eucas1p1c84f81b1d78e2dbad7ac1b762f0a4b4f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200624114136eucas1p1c84f81b1d78e2dbad7ac1b762f0a4b4f
References: <20200624114127.3016-1-a.hajda@samsung.com>
        <CGME20200624114136eucas1p1c84f81b1d78e2dbad7ac1b762f0a4b4f@eucas1p1.samsung.com>
        <20200624114127.3016-4-a.hajda@samsung.com>
        <2203e0c2-016b-4dbe-452d-63c857f06dd1@arm.com>
        <CAHp75VfpP1cGK3FvTL0hBudRY2N_7GpXYRuUHUCipz7X2sMLmQ@mail.gmail.com>
        <be755825-b413-e5c1-7ea4-06506b20d1f0@arm.com>
        <20200624150434.GH5472@sirena.org.uk>
        <381de683-df5e-4112-5690-13dd9272ae22@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24.06.2020 17:16, Robin Murphy wrote:
> On 2020-06-24 16:04, Mark Brown wrote:
>> On Wed, Jun 24, 2020 at 03:25:33PM +0100, Robin Murphy wrote:
>>
>>> And yeah, anyone who pipes up suggesting that places where an 
>>> ERR_PTR value
>>> could be passed to probe_err() could simply refactor IS_ERR() checks 
>>> with
>>> more uses of the god-awful PTR_ERR_OR_ZERO() obfuscator gets a long 
>>> stare of
>>> disapproval...
>>
>> We could also have a probe_err_ptr() or something that took an ERR_PTR()
>> instead if there really were an issue with explicitly doing this.
>
> Yeah, for all my lyrical objection, a static inline <blah>_ptr_err() 
> helper to wrap <blah>_err() with sensible type checking might actually 
> be an OK compromise if people really feel strongly for having that 
> utility.


I have proposed such thing in my previous iteration[1], except it was 
macro because of variadic arguments.

With current version we save 8 chars and hacky macro, with the old 
version we save only 4 chars and more clear construct - less tempting 
solution for me.

Personally I prefer the current version - it does not seems to me more 
dangerous than all these PTR_ERR, IS_ERR,ERR_PTR helpers, but can 
prevent expression split across  multiple lines due to 80char limit.

Probably the simplest solution is to drop this patch, I will do it then.

[1]: 
https://lwn.net/ml/linux-kernel/20181220102247.4911-4-a.hajda@samsung.com/


Regards

Andrzej


>
> (and then we can debate whether it should also convert NULL to -ENOMEM 
> and !IS_ERR to 0... :D)
>
> Robin.
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://protect2.fireeye.com/url?k=074420c0-5ada8e5a-0745ab8f-0cc47a336fae-bba8bb4caf96e14d&q=1&u=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel 
>
>
