Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F1CC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238AD2467C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vNzzFajp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgAUJF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:05:59 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36816 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgAUJF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:05:58 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200121090556euoutp0193d6cf1f06509726e0d5db30a4cb6b92~r25vl5lyz2027620276euoutp01M
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 09:05:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200121090556euoutp0193d6cf1f06509726e0d5db30a4cb6b92~r25vl5lyz2027620276euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579597556;
        bh=9xHQc8okiqybV1YN6dc4s7Wz7hhBmQY7/b9uNlqCsR0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=vNzzFajpHZ5qjD4s60UVmW0ZqSiYDw/NKgicN2G96qCsenKHD9rn9Q1DQNf0oYv0Z
         R/NtISWOncLa0Av84S2zC14KFl7pha7Hm3FVaoN8wDg8nnWwjQfdjslW5EHCwTgcmF
         EdtfGHg0RMoko2I2Zi/6o8IHQs8c9tKmkba6jiLI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200121090556eucas1p271ac049b78f8edb2d02c50d97f1e75cb~r25vJEoCW2931029310eucas1p23;
        Tue, 21 Jan 2020 09:05:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 38.34.60698.4FEB62E5; Tue, 21
        Jan 2020 09:05:56 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200121090556eucas1p23b76b9fbcc3d1795b07289b874411564~r25u2TK0e2932029320eucas1p2X;
        Tue, 21 Jan 2020 09:05:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200121090556eusmtrp19308df1748af91a600c0a6973b9311b8~r25u1ZEVX2107521075eusmtrp1f;
        Tue, 21 Jan 2020 09:05:56 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-17-5e26bef46499
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 76.A5.08375.4FEB62E5; Tue, 21
        Jan 2020 09:05:56 +0000 (GMT)
Received: from [106.120.51.74] (unknown [106.120.51.74]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200121090555eusmtip14f01174020b8a5776563945a29e58c1b~r25t-MZ691588815888eusmtip1V;
        Tue, 21 Jan 2020 09:05:55 +0000 (GMT)
Subject: Re: [PATCH v4 3/3] dt-bindings: drm: bridge: adv7511: Add ADV7535
 support
To:     Bogdan Togorean <bogdan.togorean@analog.com>,
        dri-devel@lists.freedesktop.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, gregkh@linuxfoundation.org,
        tglx@linutronix.de, sam@ravnborg.org, alexander.deucher@amd.com,
        matt.redfearn@thinci.com, robdclark@chromium.org,
        wsa+renesas@sang-engineering.com, linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <5e6fbff8-435a-33b8-241d-5ade2d635a16@samsung.com>
Date:   Tue, 21 Jan 2020 10:05:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121082719.27972-4-bogdan.togorean@analog.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se2xLbxjHvec9PT1dfl3edaRPViEac0tcK7z5+YVNJDshEgkJIS4HJyPW
        kh5z+0fpxozNGJttWLHFwphsOlZWMpdZ0G6srosaNTZsxLZf6jZtD7H/Pu/3eb7P832Sl8e6
        w1wcv9ayUbJaxBQjF8VW3w56xna7Ryyb0FUcR7M8DQzNa7miojvTD2HaV30A0+aeLo7aT1Vw
        1Pd/O6YNH3ws3XOgRE0fuo5ytPRxE0NdfgdD67KX0EfB15im195U07KgE9GqysOYZnuSEnRC
        +oMfnNDhSxTKj5cjoetJuloosjWxQm2vgxWKMgpUQuWZPZxwJ+cBI3R6PGrhUu9LlXDtWLla
        8O+tZ4SSPB8ntJ2oYIXrWbnsPN3iqP9WSylrN0nW8dNXRK356bZzGzqZLY+/u1U2dJHJRBoe
        yGSo+rRfFWYdKUNwzjZK4W4EpX1JmSgqxF8QXN3r5P4Y0vx2rBROI/B6rzHK4yMCd04nG+6K
        JQvgXcUrdZgHkvnQ8zmXDTdhko2h+9wOHC5wZDT8qHoaGsvzWjIdgm8NYZkl8fDQ0RfxDiKL
        IND8OhJPS2KgoSAQma8hCVAdaIvomAwFu7MIK6yHZ4HiSCAgjTw0ek9hJfYscKV9UykcCx31
        F9UKD4a7uftYhbeDvywNK+YMBM4LNb/N06DF8zUSFIdCV7jGK3Ii3Oj4EJGBRMOTjzFKhmg4
        WJ2PFVkLGbt0Svcw8N93/h6oh9LGHi4HGQv7XVbY75rCftcU/t3rQOwZpJdSZXOyJJss0uZx
        smiWUy3J41atN1ei0Ge9+7O+5zJyf19ZhwiPjP9oE/Lil+lU4iZ5q7kOAY+NA7WOnSFJu1rc
        uk2yrl9uTU2R5Dpk4FmjXms62b5UR5LFjdI6SdogWf9UGV4TZ0M1vvISMxN4H5y0ON8wI9Gb
        ubtrYeuzT1PPTku6WRYT+6K1JfWkTHfHXDdNej9gdmb+nPZ/54qGrHsLN7fWu2py2s5/Oyre
        Gtk75IjhTW2B/uqVIJkyeeYx9dR2m8YCpm3Jp/Psw19pvLG2e3M7UoY9iibeNFvz9vgm04TO
        HQ3m5yuMrLxGnDgGW2XxF+UPaI6oAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfSzUcRzH+/6e7qe59nPId6rVblNT67hDvlqJrda39U+rVo3ExW9Yzul+
        p6e1si4rjNGDcsK1sJhljihGdQm3coUUPYzqSJTWk1x56Dht/nvt/fm83ttn+7CkpIz2ZOMT
        tbwmUZkgZRZSj6da36792bTygK/tO4kyLWYC5b5poNGZ1Eskmq7NIdHzX18ZpLtRyaDu359I
        ZP7cTaG0nGIR6qq/xqCSlx0Equ8zEMiUFY5e2D6QKLWxWYRu2m4DVG28TKIsy9YQCU7tnGTw
        cHcoriisAPhrT6oI56d0ULhxzEDh/PN5NDaWpzG4LbuTwKMWiwjXjfXT+F5BhQj3ZbQSuDi3
        m8GD1yspfD/zIrVDEibboFEna/kVcWpBu1EaLkcKmTwIyRT+QTK5X2DEekWA1Cd4QwyfEH+E
        1/gER8nippp0TNIocezlRBOdAmqIdODEQs4fnu3TkelgISvhSgAcLrhKOgYesKHoyxy7wokX
        6YxjaQTAdt2TWduV2w2HKt+LZtiN2wW/TfbMMsllkbD9j5dDMAOov/x5VmA4bzhZ3WtvYlkx
        FwxtH5fMxBTnBbsM07OuO7cPfvnbS8+wmHOB5jwrNcNOXAistQ7Sjv5VcKKwk3Twcqi7nT/H
        HvCVtYjIBhL9PF0/T9HPU/TzFAOgyoEbnyyoYlWCXCYoVUJyYqwsWq0yAvub1LbYqu+Azqpd
        JsCxQOosDsn1OiChlUeE4yoTgCwpdRMbztgjcYzy+Aleo47UJCfwggkE2I/LIT3do9X2p0vU
        RsoD5IEoSB7oF+i3Dkk9xOe5B/slXKxSyx/i+SRe898jWCfPFKDW7qQLD/aPb7ulWhNO6BaE
        FA5IMt41+U4f7bU+jDNs3CNu2AtGlh6O2G5UN1wJvXHh1FiVwjIqaiGVbXm4P/TupvG6Z86v
        x7NLs3IVh4011ke1mwkXz9LKgR/+6xalNDee5hed7Bo0WqKmWMu5pwFlzmFbtnQ4L/5o/mQa
        8u5YJqWEOKV8NakRlP8A863J2TwDAAA=
X-CMS-MailID: 20200121090556eucas1p23b76b9fbcc3d1795b07289b874411564
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200121084137eucas1p1832626abf31456285276d322495ba6ed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200121084137eucas1p1832626abf31456285276d322495ba6ed
References: <20200121082719.27972-1-bogdan.togorean@analog.com>
        <CGME20200121084137eucas1p1832626abf31456285276d322495ba6ed@eucas1p1.samsung.com>
        <20200121082719.27972-4-bogdan.togorean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.01.2020 09:27, Bogdan Togorean wrote:
> ADV7535 is a part compatible with ADV7533 but it supports 1080p@60hz and
> v1p2 supply is fixed to 1.8V
>
> Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej

