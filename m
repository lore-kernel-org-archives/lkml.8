Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AFFC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 06:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FAC7208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 06:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DkcTQ0GH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgH1Ga3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 02:30:29 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:36135 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgH1Ga1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 02:30:27 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200828063024epoutp014b9ed95a1aface607873e1f270d68ee1~vWsvL6wkw1268412684epoutp01C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 06:30:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200828063024epoutp014b9ed95a1aface607873e1f270d68ee1~vWsvL6wkw1268412684epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598596224;
        bh=34hpsHmuRrmkqdsAu42m/cbI2yP+Tb9HwF0STwpoTus=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=DkcTQ0GHOoz0CE+j8nkz3TC0I40iHf2RiiICJ3KS0XKsmd6cghTrhdL11/aSbhmY/
         EoqBXV5ugRADW7yKSu06Ure5Pe9OrL45BbGW+ifIOZZuPl0E+aeHDBah0NOnQ60kgC
         0WS15uRmjgoyJt3Bm3mX3Nna1RnH56erGeDPOwvk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200828063023epcas1p4062460c2c92b669c7eeaa1bc1d157621~vWsuN_Hct2011820118epcas1p4o;
        Fri, 28 Aug 2020 06:30:23 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Bd8q0743czMqYm6; Fri, 28 Aug
        2020 06:30:20 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.FD.28578.C74A84F5; Fri, 28 Aug 2020 15:30:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200828063018epcas1p1a49154cf735d20d3700be19afeeae612~vWsqWr01g1738717387epcas1p1P;
        Fri, 28 Aug 2020 06:30:18 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200828063018epsmtrp2431b2895ffeb4756270e329412b610a1~vWsqVCRek2197821978epsmtrp2C;
        Fri, 28 Aug 2020 06:30:18 +0000 (GMT)
X-AuditID: b6c32a39-8dfff70000006fa2-7c-5f48a47c191c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.6F.08303.A74A84F5; Fri, 28 Aug 2020 15:30:18 +0900 (KST)
Received: from [10.113.111.64] (unknown [10.113.111.64]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200828063018epsmtip10979e9530be6d44d217fecb6f100fe86~vWsp3apRq2895328953epsmtip18;
        Fri, 28 Aug 2020 06:30:18 +0000 (GMT)
Subject: Re: [PATCH 3/3] drm/vc4: hdmi: Add pixel bvb clock control
To:     Stefan Wahren <stefan.wahren@i2se.com>, nsaenzjulienne@suse.de,
        eric@anholt.net, maxime@cerno.tech
Cc:     devicetree@vger.kernel.org, tim.gover@raspberrypi.com,
        dave.stevenson@raspberrypi.com, sboyd@kernel.org,
        mturquette@baylibre.com, kdasu.kdev@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>
From:   Hoegeun Kwon <hoegeun.kwon@samsung.com>
Message-ID: <a19de8d5-2b01-cb62-38a2-b0732068025c@samsung.com>
Date:   Fri, 28 Aug 2020 15:30:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <84c423e8-25a6-8f23-cc80-7a17ce03fd1d@i2se.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVxjm9N7etmRd7grKSbfMcjNFlAK1Fi4O3Axuu8s2wzbiPsysN3BH
        GaXtesE5trgqMJQWBZEAZSBTTA1Y5vgKZTLlozLZBAkfkorAHM6BAzZYJ6LBlV7M+Pe873me
        8z7POXmFiOQBJhUm69IYo47WEpgv2tQRHCb/sopShzeejSTteU6UnC4/g5KnOnv45IB7FiMv
        H+oH5KwtFyMdA3aUrPttiE/+bRnlk/0t32Bkwc0LArJkYQmQfd2vkE1WG0bWuu5hZHZrp4Bc
        GvreIzg3jJG3i8bAy37U4dkrGDU7nC2grGPXMGqkpxejHNZbAqrRpaLqqo9i1Ji5i0fVV31F
        ZTsXUepYQzWg6n/+gpqvez5O/GFKtIahExmjjNEl6BOTdUkxxBvvqmPVqohwhVwRRUYSMh2d
        ysQQO9+Mk7+arPXEJGT7aW26pxVHsywRtj3aqE9PY2QaPZsWQzCGRK0hyhDK0qlsui4pNEGf
        uk0RHr5F5SHuS9F01rchhtGQA5lugwmMvpALREKIb4UlNXn8XOArlODNAA6a/hFwxRyAtXcf
        oVwxD+CA2YU8kdzp+hHjDloAdFgaeFwxDeCD8QbBMssPj4VFC238ZeyPa2DPYqv3XgT/CYE9
        S+e9V2G4HLotN3jLWIxvh1lFJq8AxdfD4fJiL2cN/gF03JkUcJxn4NXSCXQZi/BoWGiu9GIE
        XwczG8sQDgdA18QpryOIF4tgzqBtxfdOePXxHI/DfnCqi3MKcSmcn2nFOMzCgdIplBObADxe
        ULZCUsJLZws9YqFnQjD8riWMawdCx8NywA1+Gs64LfxlCsTF8MjXEo6yAf5uuszn8HOwO8+2
        YoGCs4UdgnwQaF0VzboqjnVVHOv/gysBWg3WMgY2NYlhFQbV6u+uA94d2BTVDIqn/wptBzwh
        aAdQiBD+4nvO19QScSL9eQZj1KuN6VqGbQcqz2MXINI1CXrPEunS1ArVFqVSSW5VRKgUCiJA
        /KtLppbgSXQak8IwBsb4RMcTiqQm3oagyqHFE/P5j8rGAwt2Hcs/KHnx+DsJuCarX7ZZ+qm2
        pdBlsCwJHubGjtR8IojG5WU+F4LNb1UE2X0m0pVy4sBidvx690Km8NJac8TuptgzNT7ZN+Zp
        uCNy44zv9epedp2jJGufePHkoGW84nDzCby9e6TKH/SV7gyMxmvjbymtorZfCsK/7X3KduS+
        qC/+3+qLDSNO4n5nBArv7j3qrMg4N/dSzNvlH1+XX4MBf0zGHrJsu3gwJifO90qNTXUyamNz
        UM5gZCK7Z3d8SMYOnz/32F+3Pn7/tHzXZsRx/r1JqfOj/X5jdSWVoTfdKbm36+3Phpz+LM4+
        Za75YToI6xvp2EugrIZWbEKMLP0fPQorKowEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYRyHeXfOzo6L0WlavaUYjaSQtNlFXsvEMutEREUU2c1WnqbkZZ2j
        5SVJrUGZmaIjmy27WOa6b8u0TJzOW5kWipqXjcoupmNFLq0PltsK/PbA73n4f/iTmLgLn0vG
        xCcybLwsVkII8Yp6ibdfaikdKS20BqB75xtwZNXcwFGJqY2POu02AtVmdgBkK8smUFXnPRzp
        PnTx0fccMx91PL1MoPy+hwJUND4B0JsX4ahCXUag+73DBFI+NwnQRNejyeB2D4Heqywg1J3O
        sjUStK1HKaDVllcE3d/WTtBV6gEB/bh3Ba3TniVoy7kmHq0vPUkrG37jdK5BC2j9yzT6h857
        q2i3MDiKiY05xrBLQg4Io016I6YwL04+ZVdkAPOCbOBGQmo5/NhUQ2QDISmmKgEcMAzyXYMX
        1F4wTDI5ye6wvp5zOcMAWtrMAofjToVB1bjR6XtQ0fBy/hXMIWFUIwYHCt5irsLMg3cLlTyH
        RVB+0J7T7WQRFQJPqzKcNU75wB7NRcxxbSYVAasqg1zKDNhyaRB3sBsVDAvOXXUyRgXCK/p3
        mIvnwVOPi//xbNg7WMLLA2L1lFw9JVFPSdRTkqsA14I5jIKLk8dxAYql8cxxf04WxyXFy/0P
        JcTpgPP1vr6VoFr7zb8O8EhQByCJSTxEww0bIsWiKFlKKsMmRLJJsQxXBzxJXDJbZFdf2y+m
        5LJE5gjDKBj2/8oj3eZm8Bj55k+ha90KxYE35++pLu8+rKqtr2mvNod/82DDWg+uufunfNHI
        daUqtTnwZ5L3inzRSHsSeenJphPS3OagoL1LWFjY0Tm+c3CPfMGJrOaFmuJn6+llfWHWooAt
        ueOGzHVDWWxt3mhr8mj4771sxed+7eKmUVnbypzSG2cyymwp84cj0j6FTGiPvbj+hez36bLv
        eD1KSrVbN7qPtCb2Kb3GYshV+46aQjR+/gapiD8UXX7L8yKX9ivlnbA5zehz50Hu522l5Ycs
        06xRG4p2iaL2zbKOJUpDNYLtmdvSW6bXhPqW1KqyjDsjSuxf9X6t6cWSMWi6adR57P6wOiby
        p8AgwbloWYAvxnKyv+qgdyZpAwAA
X-CMS-MailID: 20200828063018epcas1p1a49154cf735d20d3700be19afeeae612
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/20 6:49 PM, Stefan Wahren wrote:
> Am 27.08.20 um 06:35 schrieb Hoegeun Kwon:
>> Hi Stefan,
>>
>> Thank you for your review.
>>
>>
>> On 8/26/20 7:04 PM, Stefan Wahren wrote:
>>> Hi Hoeguen,
>>>
>>> Am 21.08.20 um 09:10 schrieb Hoegeun Kwon:
>>>> There is a problem that the output does not work at a resolution
>>>> exceeding FHD. To solve this, we need to adjust the bvb clock at a
>>>> resolution exceeding FHD.
>>> this patch introduces a mandatory clock, please update
>>> brcm,bcm2835-hdmi.yaml first.
>>>
>>> Is this clock physically available on BCM283x or only on BCM2711?
>> As far as I know, BCM2711 raspberry pi 4 supports 4k,
>>
>> don't supported on pi 3 and pi 3+.
>>
>> Since 4k is not supported in versions prior to Raspberry Pi 4,
>>
>> I don't think we need to modify the bvb clock.
>>
>>
>> So I think it is better to update 'brcm,bcm2711-hdmi.yaml'
>>
>> instead of 'brcm,bcm2835-hdmi.yaml'.
> You are correct please update only brcm,bcm2711-hdmi.yaml.
>
> My concern was that the function vc4_hdmi_encoder_pre_crtc_configure()
> is called on a non-bcm2711 platform or on a Raspberry Pi 4 with an older
> DTB. So making the BVB clock optional might be better?

You are right, if use old dtb, we have a problem with the hdmi driver.

So how about modifying it like this?

@@ -1614,8 +1614,8 @@ static int vc5_hdmi_init_resources(struct vc4_hdmi 
*vc4_hdmi)

         vc4_hdmi->pixel_bvb_clock = devm_clk_get(dev, "bvb");
         if (IS_ERR(vc4_hdmi->pixel_bvb_clock)) {
-               DRM_ERROR("Failed to get pixel bvb clock\n");
-               return PTR_ERR(vc4_hdmi->pixel_bvb_clock);
+               DRM_WARN("Failed to get pixel bvb clock\n");
+               vc4_hdmi->pixel_bvb_clock = NULL;
         }

         vc4_hdmi->reset = devm_reset_control_get(dev, NULL);

If we modify like this, if there is no bvb clock in dtb, then 
pixel_bvb_clock will be null

and it will not affect the clk control function below.

   - clk_set_rate()
   - clk_prepare_enable()
   - clk_disable_unprepare()


Best regards

Hoegeun

>
>> Please comment, what do you think?
>>
>>> I'm a little bit afraid, this change could break with older firmware
>>> versions on BCM283x.
>> Tested it several times with libdrm modetest.
>>
>> I expect there will be no problem.
>>
>>
>> Best regards,
>>
>> Hoegeun
>>
>>> Best regards
>>> Stefan
>>>
>>>> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
>>>> ---
>>>>    drivers/gpu/drm/vc4/vc4_hdmi.c | 25 +++++++++++++++++++++++++
>>>>    drivers/gpu/drm/vc4/vc4_hdmi.h |  1 +
>>>>    2 files changed, 26 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
>>>> index 95ec5eedea39..eb3192d1fd86 100644
>>>> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
>>>> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
>>>> @@ -80,6 +80,7 @@
>>>>    # define VC4_HD_M_ENABLE			BIT(0)
>>>>    
>>>>    #define CEC_CLOCK_FREQ 40000
>>>> +#define VC4_HSM_MID_CLOCK 149985000
>>>>    
>>>>    static int vc4_hdmi_debugfs_regs(struct seq_file *m, void *unused)
>>>>    {
>>>> @@ -380,6 +381,7 @@ static void vc4_hdmi_encoder_post_crtc_powerdown(struct drm_encoder *encoder)
>>>>    	HDMI_WRITE(HDMI_VID_CTL,
>>>>    		   HDMI_READ(HDMI_VID_CTL) & ~VC4_HD_VID_CTL_ENABLE);
>>>>    
>>>> +	clk_disable_unprepare(vc4_hdmi->pixel_bvb_clock);
>>>>    	clk_disable_unprepare(vc4_hdmi->hsm_clock);
>>>>    	clk_disable_unprepare(vc4_hdmi->pixel_clock);
>>>>    
>>>> @@ -638,6 +640,23 @@ static void vc4_hdmi_encoder_pre_crtc_configure(struct drm_encoder *encoder)
>>>>    		return;
>>>>    	}
>>>>    
>>>> +	ret = clk_set_rate(vc4_hdmi->pixel_bvb_clock,
>>>> +			(hsm_rate > VC4_HSM_MID_CLOCK ? 150000000 : 75000000));
>>>> +	if (ret) {
>>>> +		DRM_ERROR("Failed to set pixel bvb clock rate: %d\n", ret);
>>>> +		clk_disable_unprepare(vc4_hdmi->hsm_clock);
>>>> +		clk_disable_unprepare(vc4_hdmi->pixel_clock);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	ret = clk_prepare_enable(vc4_hdmi->pixel_bvb_clock);
>>>> +	if (ret) {
>>>> +		DRM_ERROR("Failed to turn on pixel bvb clock: %d\n", ret);
>>>> +		clk_disable_unprepare(vc4_hdmi->hsm_clock);
>>>> +		clk_disable_unprepare(vc4_hdmi->pixel_clock);
>>>> +		return;
>>>> +	}
>>>> +
>>>>    	if (vc4_hdmi->variant->reset)
>>>>    		vc4_hdmi->variant->reset(vc4_hdmi);
>>>>    
>>>> @@ -1593,6 +1612,12 @@ static int vc5_hdmi_init_resources(struct vc4_hdmi *vc4_hdmi)
>>>>    		return PTR_ERR(vc4_hdmi->audio_clock);
>>>>    	}
>>>>    
>>>> +	vc4_hdmi->pixel_bvb_clock = devm_clk_get(dev, "bvb");
>>>> +	if (IS_ERR(vc4_hdmi->pixel_bvb_clock)) {
>>>> +		DRM_ERROR("Failed to get pixel bvb clock\n");
>>>> +		return PTR_ERR(vc4_hdmi->pixel_bvb_clock);
>>>> +	}
>>>> +
>>>>    	vc4_hdmi->reset = devm_reset_control_get(dev, NULL);
>>>>    	if (IS_ERR(vc4_hdmi->reset)) {
>>>>    		DRM_ERROR("Failed to get HDMI reset line\n");
>>>> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
>>>> index 0806c6d9f24e..63c6f8bddf1d 100644
>>>> --- a/drivers/gpu/drm/vc4/vc4_hdmi.h
>>>> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
>>>> @@ -147,6 +147,7 @@ struct vc4_hdmi {
>>>>    	struct clk *pixel_clock;
>>>>    	struct clk *hsm_clock;
>>>>    	struct clk *audio_clock;
>>>> +	struct clk *pixel_bvb_clock;
>>>>    
>>>>    	struct reset_control *reset;
>>>>    
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
