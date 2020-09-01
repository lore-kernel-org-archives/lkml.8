Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B597C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 741232098B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 02:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CKILSkLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIACH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 22:07:56 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:19160 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgIACHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 22:07:55 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200901020751epoutp02ee1287ef3281e3d71a0fe5e20b6e0330~whspGyrLh1584215842epoutp02B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 02:07:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200901020751epoutp02ee1287ef3281e3d71a0fe5e20b6e0330~whspGyrLh1584215842epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598926071;
        bh=URBVDctkmVqca9PXVLh3E1qepQ6UHAxy0LP6rzedCbQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CKILSkLMlYAmu4KQQa14vuhNJ1+fl4TedF6kgW4ORdic7ONPcMl8zM3JKlF2J3ioP
         ZIWhhXpboR2VSTf5yLBSnxyFQlyK/2poHHC2tjcbcWGBSdqMBhvWhZef9zfnZCQ8Vf
         i+IKhJXfnpKMOhxIvi0SMf5GLNNfHG99Q3qVRT4k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200901020750epcas1p2d70205ed0566b254540c0bc25c9ac072~whsoQQHJp2039520395epcas1p2b;
        Tue,  1 Sep 2020 02:07:50 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.152]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4BgVpC1JpBzMqYm7; Tue,  1 Sep
        2020 02:07:47 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.04.28578.1FCAD4F5; Tue,  1 Sep 2020 11:07:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200901020745epcas1p33a9988253efe06f536ece4c24c830137~whsj6j1wS2865628656epcas1p3F;
        Tue,  1 Sep 2020 02:07:45 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200901020745epsmtrp2d906f389fe4a7a416ff22089a5800a88~whsj5FVt21929619296epsmtrp2P;
        Tue,  1 Sep 2020 02:07:45 +0000 (GMT)
X-AuditID: b6c32a39-8dfff70000006fa2-85-5f4dacf11fcf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.03.08303.1FCAD4F5; Tue,  1 Sep 2020 11:07:45 +0900 (KST)
Received: from [10.113.111.64] (unknown [10.113.111.64]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200901020745epsmtip1ab493178da14b7dbe6bd1200a8620199~whsjiI7Pv0918909189epsmtip1h;
        Tue,  1 Sep 2020 02:07:45 +0000 (GMT)
Subject: Re: [PATCH 3/3] drm/vc4: hdmi: Add pixel bvb clock control
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>, devicetree@vger.kernel.org,
        Tim Gover <tim.gover@raspberrypi.com>, kdasu.kdev@gmail.com,
        sboyd@kernel.org, mturquette@baylibre.com,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Phil Elwell <phil@raspberrypi.com>, robh+dt@kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>
From:   Hoegeun Kwon <hoegeun.kwon@samsung.com>
Message-ID: <f84797d1-22b6-7673-d0dd-398d339a5ed2@samsung.com>
Date:   Tue, 1 Sep 2020 11:07:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPY8ntDeLOb+GvpLDX1BFrhtYyGQzJ01pWHiS30r-2ZUJTg8Gw@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfVBUVRjGO7t37y7kNpev9kQUcMsUJj4WWD04fDQD1i38oKgx+KP1xt6A
        WHZ39oJjZAQUybegELLAgGBCiyiBEiAbKwo7gWgFCEO6lLhOYrAIQ2M0YbtcnPjved/ze857
        nnPmiPjOq7i7KEWVzmhVtJLEHbGuKz7+fktn98oDx4w81FYyiKH5uiYM1V+9LkDjK1YcGXPG
        ALI2F+KoZ7wNQx2zNwXoYbFZgMZ6a3FU/mu7EJ18tAbQz8O7UZeuGUfnph/gKM9wVYjWbn5n
        M7RM4ehO5Qx4zYXKtQ7hlHUqT0jpZkZx6tb1GzjVo7stpC5Oy6gOfQFOzRSZeFTn6c+pvMFV
        jCq9oAdU58in1HLHi7HihNSwZIZWMFovRpWoVqSoksLJmDh5lFy2I1DqJw1FO0kvFZ3GhJPR
        e2L9Xk9R2mKSXodoZYatFUuzLBkQEaZVZ6QzXslqNj2cZDQKpSZU48/SaWyGKsk/UZ22SxoY
        GCSzgQdTk09apvia2y8c7tdN4tngB0khcBBBIgS2990SFgJHkTPRDeDYwH3AFUsAHn3cJ+CK
        ZQC75ur5Tyz6qZENqhdA8xnzBjUPoMlSuk65EFGw8tFlgV27Eu/Da8aidQefmMRgVckCbl/A
        CT+4UjzJs2sxEQFXF//E7BojXoZ3ZoeBXbsR8bDHcl/IMU7wx+q764wD8TYsaGpY34dPeMLv
        52v5nJbA6bv1PPswSNQ4wL8HxoTcuaPh+faJjQwucM50YaPvDpcXDDinWThePYdx5mwAj5XX
        bEDBsP+bE7ZdRbYJPvB8bwDX9oY9/9QBbvAzcGGlWGBHICGG+V85c8gr8F62UcBpDzhc0szj
        NAWtJ64Iy4C3blM03aY4uk1xdP8PbgCYHjzLaNi0JIaVamSb37sDrH8C39BuUDW/6D8AeCIw
        AKCIT7qKjb0xcmexgv4kk9Gq5doMJcMOAJntssv57m6JatsvUqXLpbKg4OBgFCLdIZNKSYn4
        92kvuTORRKczqQyjYbRPfDyRg3s277Q2PDLuAJO6NORUGuBmHt0/KjmVdeTUe8PB8Q/fjdxm
        kbTnYtD6Rv5ZfdCZhJzWoNzDsuKoyMYJC/bTS6bFrZn7DrgsPN3aaj7kWyb0VDusSRIOdp/b
        2+R3qSDSUpeM8TwR6dpwby3nsewtNn7/8Zrjf/gox6s9Luqk2eOoXJGv/uw5a0HPHkPJq9u/
        3tJocIopW9uZtWXrzL5vh6uibjg2xv3WUmwQeLdsr5gVVFz70LOKHzGzANT0Xx7bhEXm/sHO
        lIlay1MeYUc/uFyRNcU3/vLRv/NfTl5KqWxTv5lzhIl+Z2jZpDMoRoriMnfpP+7LwaczviB3
        Pz8HcVNhSN+DOBJjk2mpL1/L0v8BV5IXro0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsWy7bCSnO7HNb7xBh2nBC3W9h5lsXg7dzGL
        xfwj51gtrnx9z2ZxoPEyo8X75V1sFjuvrGWx2PT4GqvFx557rBaXd81hs5h4ewO7xYwf/xgt
        Lp5ytdg2azmbxbpbr9ksWvceYbf4d20jUMOKG2wWj6beZ3QQ9mh6f4zN4/2NVnaPWffPsnnc
        OXeezWPnrLvsHltvmXpsWtXJ5nG/+ziTx+Yl9R6tR3+xePRtWcXosfl0tcfnTXIBvFFcNimp
        OZllqUX6dglcGTOe3mAuuCtbsX/WdbYGxn3iXYycHBICJhKrbpxm7GLk4hAS2MEo8f/YP0aI
        hIzEqv4trF2MHEC2sMThw8UQNa8ZJSYsu8sKUiMs4Cwx9cdBMFtEIELizKq5YIOYBW6ySGzq
        /8oOkhAS2MMiMfWYFIjNJqAr8bXnOhOIzStgJ/HrwxsWEJtFQEXi0eNTjCDLRAUiJXbusIQo
        EZQ4OfMJWAmnQKBE5+IFbCA2s4CZxLzND5khbHmJ7W/nQNniEreezGeawCg0C0n7LCQts5C0
        zELSsoCRZRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnDUa2ntYNyz6oPeIUYmDsZD
        jBIczEoivAd2eccL8aYkVlalFuXHF5XmpBYfYpTmYFES5/06a2GckEB6YklqdmpqQWoRTJaJ
        g1OqgenAjguskjrnQqSU/Z0fOnw2yJW42O5ipfYpwpt52YO2+KaSDGm2qKlsWr/+ql4xjY1n
        2e1aUPRGxeW30xQT7Y3hJ6X8z23R18r9e9hp8bxPojEVf5iL5EIWTt+6J7lmYpf28z8pgp8Y
        4j2PiEex2t67wvFuWqnM+Yq9NxTV6wqfvr9dFPd6yu3lTq1X2xYeWKUkejsooZ6rUnNFpfD0
        m+mX+8I6LWoPP9YVM9wrPe1if/3LNQsC85YaXtwX4cX0O6jnEEPHynjuCumWft/Uh9Ocfr1Z
        eWy5jVHEXSfl5jyPZMGNTa42rT7F8wzMA3Iyqqx/axw4XyJi1d1aeWLe1LRJ+hM+2WwM3Bm9
        cIWaEktxRqKhFnNRcSIA/lK3z2kDAAA=
X-CMS-MailID: 20200901020745epcas1p33a9988253efe06f536ece4c24c830137
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200821071122epcas1p3d00dda4665f94192ac5e9ee829d0557d
References: <20200821071045.24501-1-hoegeun.kwon@samsung.com>
        <CGME20200821071122epcas1p3d00dda4665f94192ac5e9ee829d0557d@epcas1p3.samsung.com>
        <20200821071045.24501-4-hoegeun.kwon@samsung.com>
        <61c199bf-852f-82d3-089a-a0a435343acf@i2se.com>
        <80749dcd-d4b2-68a1-f3ca-c19a120f6f7b@samsung.com>
        <84c423e8-25a6-8f23-cc80-7a17ce03fd1d@i2se.com>
        <a19de8d5-2b01-cb62-38a2-b0732068025c@samsung.com>
        <a3231281-3bd0-e7c9-1bb0-f05848621e82@i2se.com>
        <20200828152510.jhhqvka6fmouozff@gilmour.lan>
        <CAPY8ntDeLOb+GvpLDX1BFrhtYyGQzJ01pWHiS30r-2ZUJTg8Gw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you reviews by Dave, Maxime and Stefan.

On 8/29/20 12:37 AM, Dave Stevenson wrote:
> Hi Maxime, Stefan, and Hoegeun
>
> On Fri, 28 Aug 2020 at 16:25, Maxime Ripard <maxime@cerno.tech> wrote:
>> Hi,
>>
>> On Fri, Aug 28, 2020 at 02:45:49PM +0200, Stefan Wahren wrote:
>>> Am 28.08.20 um 08:30 schrieb Hoegeun Kwon:
>>>> On 8/27/20 6:49 PM, Stefan Wahren wrote:
>>>>> Am 27.08.20 um 06:35 schrieb Hoegeun Kwon:
>>>>>> Hi Stefan,
>>>>>>
>>>>>> Thank you for your review.
>>>>>>
>>>>>>
>>>>>> On 8/26/20 7:04 PM, Stefan Wahren wrote:
>>>>>>> Hi Hoeguen,
>>>>>>>
>>>>>>> Am 21.08.20 um 09:10 schrieb Hoegeun Kwon:
>>>>>>>> There is a problem that the output does not work at a resolution
>>>>>>>> exceeding FHD. To solve this, we need to adjust the bvb clock at a
>>>>>>>> resolution exceeding FHD.
>>>>>>> this patch introduces a mandatory clock, please update
>>>>>>> brcm,bcm2835-hdmi.yaml first.
>>>>>>>
>>>>>>> Is this clock physically available on BCM283x or only on BCM2711?
>>>>>> As far as I know, BCM2711 raspberry pi 4 supports 4k,
>>>>>>
>>>>>> don't supported on pi 3 and pi 3+.
>>>>>>
>>>>>> Since 4k is not supported in versions prior to Raspberry Pi 4,
>>>>>>
>>>>>> I don't think we need to modify the bvb clock.
>>>>>>
>>>>>>
>>>>>> So I think it is better to update 'brcm,bcm2711-hdmi.yaml'
>>>>>>
>>>>>> instead of 'brcm,bcm2835-hdmi.yaml'.
>>>>> You are correct please update only brcm,bcm2711-hdmi.yaml.
>>>>>
>>>>> My concern was that the function vc4_hdmi_encoder_pre_crtc_configure()
>>>>> is called on a non-bcm2711 platform or on a Raspberry Pi 4 with an older
>>>>> DTB. So making the BVB clock optional might be better?
>>>> You are right, if use old dtb, we have a problem with the hdmi driver.
>>>>
>>>> So how about modifying it like this?
>>>>
>>>> @@ -1614,8 +1614,8 @@ static int vc5_hdmi_init_resources(struct vc4_hdmi
>>>> *vc4_hdmi)
>>>>
>>>>           vc4_hdmi->pixel_bvb_clock = devm_clk_get(dev, "bvb");
>>>>           if (IS_ERR(vc4_hdmi->pixel_bvb_clock)) {
>>>> -               DRM_ERROR("Failed to get pixel bvb clock\n");
>>>> -               return PTR_ERR(vc4_hdmi->pixel_bvb_clock);
>>>> +               DRM_WARN("Failed to get pixel bvb clock\n");
>>>> +               vc4_hdmi->pixel_bvb_clock = NULL;
>>>>           }
>>> i think the better solution would be devm_clk_get_optional(), which
>>> return NULL in case the clock doesn't exist.
>> It's not really optional though. BCM2711 will require it in order to run
>> properly (as Hoegeun experienced), and the previous SoCs won't.
>>
>> If we use clk_get_optional and that the DT is missing the clock on the
>> BCM2711, we will silently ignore it which doesn't sound great.
> Am I missing something here? (I know I missed this earlier)
> We're in vc5_hdmi_init_resources, which is inherently bcm2711 only.
> bcm283x will go through vc4_hdmi_init_resources.
>
> As long as vc4_hdmi_init_resources has left vc4_hdmi->pixel_bvb_clock
> at NULL, then the clock framework will be happy to do a nop.
>
> For BCM2711 an old DT would have issues, but, as Maxime has stated, no
> binding or upstream DTB has been merged yet, so it can be made
> mandatory.

If so, it seems good to set bvb_clock to mandatory without taking into

account the BCM2711 an old DTB as it hasn't been merged yet.

I will send version 2 patches.

> Making it optional drops you back on whatever the firmware might have
> set it to, which may be sufficient for some resolutions but not
> others.

As a result of checking by adding bvb_clock when I operated it with

the firmware, it was confirmed that the firmware increased the bvb_clock

from 75000000 to 150000000 when the FHD was exceeded.


Best regards

Hoegeun

>
>    Dave
>
