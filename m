Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63C3C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 06:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03832082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 06:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fGTGoot6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgBLG5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 01:57:09 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48774 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgBLG5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 01:57:08 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200212065706euoutp01df0d3a4068fbf8dea85f91b01413b9e1~ylVhnp0hu1910219102euoutp01t
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 06:57:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200212065706euoutp01df0d3a4068fbf8dea85f91b01413b9e1~ylVhnp0hu1910219102euoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581490626;
        bh=Qi2L0/qFrU39J059L4ojbUoWxx0oQqH49+NwUwc6OBk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fGTGoot6TRWFFcFT8howmJ67PsAbGJI0Vw2lKeFRbbVfn8klIaqeQiKU9jLHZQzii
         dyHtSLB/IROhnkkT703JG/yoGYo9G4q4gOF5oIKJELpOyQ0ntAhnxKZ2nyMu1mdt6L
         oAUHr19A5MwT5b8L3TGK1xfg+8nuUB04KoA7by14=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200212065705eucas1p1c0d0e4662414f4a859e2ea9114a9d799~ylVhMecUJ2291722917eucas1p1_;
        Wed, 12 Feb 2020 06:57:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F6.3C.61286.1C1A34E5; Wed, 12
        Feb 2020 06:57:05 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200212065705eucas1p22893f304f142b69cd870fd7def75543c~ylVg1UIdw1277512775eucas1p2E;
        Wed, 12 Feb 2020 06:57:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200212065705eusmtrp13b0865839e3e604d8b288c39e45c5bfc~ylVg0toVo2515925159eusmtrp1W;
        Wed, 12 Feb 2020 06:57:05 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-a1-5e43a1c18785
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C2.CD.07950.1C1A34E5; Wed, 12
        Feb 2020 06:57:05 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200212065704eusmtip176323047560479d065afeab3ea9ca6ec~ylVgh3Ted0400704007eusmtip1X;
        Wed, 12 Feb 2020 06:57:04 +0000 (GMT)
Subject: Re: [PATCH] libfdt: place new nodes & properties after the parent's
 ones
To:     Rob Herring <robh@kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>
Cc:     Devicetree Compiler <devicetree-compiler@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <1cc6258c-5bf3-3d48-2d6d-1a7176af1459@samsung.com>
Date:   Wed, 12 Feb 2020 07:57:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJLLWnx-K9T5wv_i+FnPwbWpfak4RD_9P1Xz_2-XkYncA@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87oHFzrHGZzoUbLYOGM9q8XOQ63M
        Fh8ObmOyuLxrDpvF/z072B1YPSYueM/msWlVJ5tH35ZVjB6fN8kFsERx2aSk5mSWpRbp2yVw
        ZdyY0MdSMEeo4tWzF+wNjFf4uhg5OSQETCTWNT1m72Lk4hASWMEocfRREzOE84VRYvGybiaQ
        KiGBz0CZB/EwHU8aX7NBFC1nlNiy4hFUx1tGid7XTxhBqoQFgiU6909hBbFFBPwl5r1tYgEp
        YhbYxijx6lgLO0iCTcBQouttFxuIzStgJ3F7YRvYOhYBVYmlUzaC1YgKxEqcOfadFaJGUOLk
        zCcsIDanQKDE+55jYDXMAvIS29/OYYawxSVuPZnPBLJMQmAeu8S/XZeZIO52kdix5iGULSzx
        6vgWdghbRuL05B4WiIZmRomH59ayQzg9jBKXm2YwQlRZS9w59wvoVA6gFZoS63fpQ4QdJQ69
        b2cCCUsI8EnceCsIcQSfxKRt05khwrwSHW1CENVqErOOr4Nbe/DCJeYJjEqzkLw2C8k7s5C8
        Mwth7wJGllWM4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiBieb0v+OfdjB+vZR0iFGAg1GJ
        h9dhulOcEGtiWXFl7iFGCQ5mJRFe8UbnOCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8xotexgoJ
        pCeWpGanphakFsFkmTg4pRoY538R/SnwoiD0SGOw04tL1rwF6SERSbWZfOdfrTwpdM636Iv8
        +mnGcxbwPOc0v/xWOVCC6eRX3qzQ26t+bFxbd+2gGuNFIXVn3lP2KsYK3E0zrpvZdmr96oxQ
        PqVdwOF7Y6Jvl0+fwF3/irOSz59dCmyJWuV6mv9px9q/8Qe7PLdxnezZ7uuuxFKckWioxVxU
        nAgA1bJ9FzADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xu7oHFzrHGaw7xGuxccZ6Voudh1qZ
        LT4c3MZkcXnXHDaL/3t2sDuwekxc8J7NY9OqTjaPvi2rGD0+b5ILYInSsynKLy1JVcjILy6x
        VYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy7gxoY+lYI5QxatnL9gbGK/w
        dTFyckgImEg8aXzN1sXIxSEksJRRovdeOyNEQkbi5LQGVghbWOLPtS6ooteMEp3tu5hBEsIC
        wRKd+6eAFYkI+Eqs2XWACaSIWWAbo8T64zeYIDoeM0m8+fcOrIpNwFCi6y3IKE4OXgE7idsL
        25hAbBYBVYmlUzayg9iiArESx7a3sUPUCEqcnPmEBcTmFAiUeN9zDCzOLGAmMW/zQ2YIW15i
        +9s5ULa4xK0n85kmMArNQtI+C0nLLCQts5C0LGBkWcUoklpanJueW2ykV5yYW1yal66XnJ+7
        iREYW9uO/dyyg7HrXfAhRgEORiUeXofpTnFCrIllxZW5hxglOJiVRHjFG53jhHhTEiurUovy
        44tKc1KLDzGaAj03kVlKNDkfGPd5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtS
        i2D6mDg4pRoYmTa+/yVw+eRj6/ln7Q6kl3OZFvKcd/KdOzVYu2P6vkxJd15Oh1NJUjc7nEQ8
        +RTv+9se/fxYc9NRy/c80jN3rE/aUhUrUDRrX96tU7Nnib275Z/LfGLe3K9/rPY53nkaHx4U
        E1UXHKEopJ/R3jepaZL8/Xca1yZtsDAsYnsi1Ceyon3nqmweJZbijERDLeai4kQAnk7VocMC
        AAA=
X-CMS-MailID: 20200212065705eucas1p22893f304f142b69cd870fd7def75543c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204125854eucas1p19ace564a5f45b9231e0fba8af07009cd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204125854eucas1p19ace564a5f45b9231e0fba8af07009cd
References: <CGME20200204125854eucas1p19ace564a5f45b9231e0fba8af07009cd@eucas1p1.samsung.com>
        <20200204125844.19955-1-m.szyprowski@samsung.com>
        <20200205054508.GG60221@umbus.fritz.box>
        <bc380fd8-71bb-897e-f060-b51386dec9be@samsung.com>
        <20200210234406.GH22584@umbus.fritz.box>
        <CAL_JsqJLLWnx-K9T5wv_i+FnPwbWpfak4RD_9P1Xz_2-XkYncA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 11.02.2020 21:29, Rob Herring wrote:
> On Mon, Feb 10, 2020 at 5:44 PM David Gibson
> <david@gibson.dropbear.id.au> wrote:
>> On Mon, Feb 10, 2020 at 12:40:19PM +0100, Marek Szyprowski wrote:
>>> Hi David,
>>>
>>> On 05.02.2020 06:45, David Gibson wrote:
>>>> On Tue, Feb 04, 2020 at 01:58:44PM +0100, Marek Szyprowski wrote:
>>>>> While applying dt-overlays using libfdt code, the order of the applied
>>>>> properties and sub-nodes is reversed. This should not be a problem in
>>>>> ideal world (mainline), but this matters for some vendor specific/custom
>>>>> dtb files. This can be easily fixed by the little change to libfdt code:
>>>>> any new properties and sub-nodes should be added after the parent's node
>>>>> properties and subnodes.
>>>>>
>>>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>> I'm not convinced this is a good idea.
>>>>
>>>> First, anything that relies on the order of properties or subnodes in
>>>> a dtb is deeply, fundamentally broken.  That can't even really be a
>>>> problem with a dtb file itself, only with the code processing it.
>>> I agree about the properties, but generally the order of nodes usually
>>> implies the order of creation of some devices or objects.
>> Huh?  From the device tree client's point of view the devices just
>> exist - the order of creation should not be visible to it.
> I'm not sure if downstream is different, but upstream this stems from
> Linux initcalls being processed in link order within a given level.
> It's much better than it used to be, but short of randomizing the
> ordering, I'm not sure we'll ever find and fix all these hidden
> dependencies.

Downstream is probably much worse, because I've seen a lots of custom 
code iterating over the nodes and doing its initialization.

>>> This sometimes
>>> has some side-effects.
>> If those side effects matter, your code is broken.  If you need to
>> apply an order to nodes, you should be looking at 'reg' or other
>> properties.
> The general preference is to sort by 'reg'. And we try to catch and
> reject any node re-ordering patches.

If one applies an dt-overlay with current libfdt, the order of the all 
nodes from that overlay is reversed.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

