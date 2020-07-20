Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0234CC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D229E22B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ifu9G7i5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgGTOqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGTOqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:46:47 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9435CC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 07:46:47 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o2so25503920wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 07:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bMY2bd7PftOqDtQBakPHJtZ+KfpWJcFf+u/c3vx0/DI=;
        b=Ifu9G7i5rsqyLIlW6JlN5zQrTfuHUixB6ByUZF4vvPANK9lqkf1rlUeUuRb4axmBqK
         T/xX8mpLoQMQ/Y84dHCnXXyomrVzvAEDHEwZOfOAa4HgOGLNlWriAZwo+sM5dftglChk
         4FsXPV1gMjq9wU3OvYwJjj+A6Cx1UcE1FYKHN9Oa5i/Qdyum8BLuXBveD+U1TdB/roKk
         QGsn7vcNxluF+FcslZjfjgentxP59frVS3EQvWsKqaNQO7k/WltlwYvS9GPQFiG/7G0I
         A0V1GchomdB4vd/yTxcCk4cyNUkx7dY/aKhT/28j6MXzJz6T1pxqNfL62x5FzQ11DXux
         EyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bMY2bd7PftOqDtQBakPHJtZ+KfpWJcFf+u/c3vx0/DI=;
        b=ABZqhOCF5hKZS4j7gciNW9OEnu6oM+JbhXYAO5Fy5iqR+RcoyFDT2YCDAEB0B25z1n
         q7Gc+vzFGItPX4q3dUcOyjvcOSa5MNhauagRepJ/yJZ4q9OcUIxEwmS2TrAUaq70jaPj
         1be+L85hz+y8L/9TPLzX3poUNYEl2ndZmZ1Im4RZUGm05TXwDOuuM+dtKoZDrEfQYABX
         iMOIKRBdfm86oei3I1u3pdaRBglo+Lj1i/x4CqJaP9CI7nq3u8NJRGW5TxOHsF17o//n
         JZcFr4bHT6rZO22cbMVkTNiJLvNYkryUzt+Hi4/7xZyPTkOKrghSN5gSaU190GhYvklB
         5nuA==
X-Gm-Message-State: AOAM533nSTzBXDrBd9eZGlJ5ILiwSBCNhHcMY7ytMo2JwyL5NzDwEsJv
        cky897XAKlzxvAuL2VWlzKyLCj203g==
X-Google-Smtp-Source: ABdhPJx/fqm8FZYrXJUrVv9fHFF6lRYTD7UrXijvZynTORUjibzGxBTYQQCdHqoTCQX//xqQrm8QDg==
X-Received: by 2002:a1c:98c1:: with SMTP id a184mr22266672wme.116.1595256406180;
        Mon, 20 Jul 2020 07:46:46 -0700 (PDT)
Received: from [192.168.200.34] (ip5b436a54.dynamic.kabel-deutschland.de. [91.67.106.84])
        by smtp.gmail.com with ESMTPSA id b8sm2579413wrv.4.2020.07.20.07.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 07:46:45 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_2/5=5d_drm=3a_rockchip=3a_add_missing_regi?=
 =?UTF-8?B?c3RlcnMgZm9yIFJLMzE4OOOAkOivt+azqOaEj++8jOmCruS7tueUsWxpbnV4LXJv?=
 =?UTF-8?Q?ckchip-bounces+andy=2eyan=3drock-chips=2ecom=40lists=2einfradead?=
 =?UTF-8?B?Lm9yZ+S7o+WPkeOAkQ==?=
To:     Andy Yan <andy.yan@rock-chips.com>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org
References: <20200718200323.3559-1-knaerzche@gmail.com>
 <20200718200323.3559-3-knaerzche@gmail.com>
 <871ce1ac-2d5b-c0a2-60a6-6aba0f296c18@rock-chips.com>
From:   Alex Bee <knaerzche@gmail.com>
Message-ID: <12296860-d6ed-5135-7c4e-545362829051@gmail.com>
Date:   Mon, 20 Jul 2020 16:46:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <871ce1ac-2d5b-c0a2-60a6-6aba0f296c18@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Am 20.07.20 um 10:22 schrieb Andy Yan:
> Hi Alex:
>
> On 7/19/20 4:03 AM, Alex Bee wrote:
>> This patch adds dither_up, dsp_lut_en, data_blank and dsp_data_swap
>> registers to enable their respective functionality for RK3188's VOP.
>>
>> Signed-off-by: Alex Bee <knaerzche@gmail.com>
>> ---
>>   drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c 
>> b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
>> index b046910129fb..971a6bda7458 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
>> @@ -512,6 +512,10 @@ static const struct vop_common rk3188_common = {
>>       .dither_down_en = VOP_REG(RK3188_DSP_CTRL0, 0x1, 11),
>>       .dither_down_mode = VOP_REG(RK3188_DSP_CTRL0, 0x1, 10),
>>       .dsp_blank = VOP_REG(RK3188_DSP_CTRL1, 0x3, 24),
>> +    .dither_up = VOP_REG(RK3188_DSP_CTRL0, 0x1, 9),
>> +    .dsp_lut_en = VOP_REG(RK3188_SYS_CTRL, 0x1, 28),
>> +    .data_blank = VOP_REG(RK3188_DSP_CTRL1, 0x1, 25),
>> +    .dsp_data_swap = VOP_REG(RK3188_DSP_CTRL1, 0x1f, 26),
>
>
>
> I can't find the definition of dsp_data_swap, or I missed something?
>
Note that .dsp_data_swap is not defined with that name in TRM (as it is 
not in RK3288/RK3328), since potentially more the one bit would have to 
be set for this (currently only RB_SWAP (0x2) is implemented in the VOP 
driver).

To be some kind of future proof (if BG_SWAP, RG_SWAP, DELTA_SWAP or 
DUMMY_SWAP ever get implemented) it should be aligned with what is 
defined for RK3288/RK3328 now to automatically benefit from that 
additions. And it would, since RK3288_DSP_CTRL0 BIT12, BIT13, BIT14, 
BIT15, BIT16 exactly matches with RK3188_DSP_CTRL1 BIT26, BIT27, BIT28, 
BIT29, BIT30.

Current implementation sets BIT13 for RK3288 and with this patch BIT27 
for RK3188 to enable RB_SWAP.

>
>
>>   };
>>     static const struct vop_win_data rk3188_vop_win_data[] = {
>
>
Regards,

Alex

