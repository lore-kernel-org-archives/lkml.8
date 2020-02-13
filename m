Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34237C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E919124650
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWMyyaPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbgBMLLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 06:11:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38100 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgBMLLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 06:11:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so6144972wrh.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 03:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L9JM14o5NHo4GbLAJ0H/dsJLDqMk2Gl9hpjsbfLJ6yQ=;
        b=nWMyyaPIrkjaKpA08eFZuYNkgfNKVBdLKx6PqaYMX+VUGv3FtQx7gA3zezxtagi5K2
         l4SuptRdkYIdTSZQAdzsxSyQjp0Eyy9YzRE3AHOtscQtgMk+1tza4LBPh8rPFzLUq+J4
         N9VW2oRLNE65z3FfnVt/TkcpbRYP63Z9L2bKRNtJrSUQCM+bJL39qiPoWzgdGBAxMtnu
         Pei7jiVrpx5QR9k6xh1TjkKxT1lJUAAlUaDQbxwC2RPBrJ5/lCCxg5C6l0eScySU+brO
         /qPhxDgoKtFb3HJFvK0PkJBWu+stsR7IJ7j6qrylRcsTE5I8xj51gi6XCtXD/gEQSIwq
         MPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=L9JM14o5NHo4GbLAJ0H/dsJLDqMk2Gl9hpjsbfLJ6yQ=;
        b=Z2Ca/Ck1TDbV4V/uCndVRPwWJ7aXmJWIZCh0ZuWcFDE1f4/VdnmptZ96eoyZSWc6hh
         cZ8dCtZsuYuRl2mX7UjC8rcmgZSWhLUG6OymPBdqi4TYjg9rF0LZ/RE0ck+XYgrswIUt
         k51Kec8P7gWvI9r6RQeUN7aK6cHXc5kMjMb+dJfGrOy6IVvBmdmRflwtxLYyzlyUVDZz
         YPkweHhpa7bPHYX9ntbSngTMezj4G177ASSnsiUcyaQPU+hdAMtOXW7he0IkWvj2uVc8
         KBLwnPUp/6jB8WFVJnObKTF/15xeJ3DvFZLgYmoBdDTpdtXRRSOg0J8cJPjFlYvwTdyt
         Wk8A==
X-Gm-Message-State: APjAAAV5JumBFOauBV2fnR0nQuXInUJnvXGaOVNGbCDNlSQjLmuwQ1gQ
        WNwcjfvrAN+c4Jy20TteRsY=
X-Google-Smtp-Source: APXvYqwMRKrLFKB6fNF6OjOpVjhZ4HMlT3mmg5227wydPiCL0iUke/GTJ6vT5kck8LPkJ844wBb3qw==
X-Received: by 2002:a5d:4289:: with SMTP id k9mr21971809wrq.280.1581592263107;
        Thu, 13 Feb 2020 03:11:03 -0800 (PST)
Received: from ziggy.stardust ([213.195.124.40])
        by smtp.gmail.com with ESMTPSA id t1sm2620021wma.43.2020.02.13.03.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 03:11:02 -0800 (PST)
Subject: Re: [PATCH v11 04/10] soc: mediatek: Add multiple step bus protection
 control
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
References: <1576813564-23927-1-git-send-email-weiyi.lu@mediatek.com>
 <1576813564-23927-5-git-send-email-weiyi.lu@mediatek.com>
 <9cafe21c-2bd2-7ee6-9e7f-ce238b935069@gmail.com>
 <1581476150.22901.35.camel@mtksdaap41>
 <28bcbd36-c2b9-d69e-55b2-508ad7b63887@gmail.com>
 <1581560153.19424.6.camel@mtksdaap41>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5993dd29-199a-dc1a-4daa-5105c3ec17fa@gmail.com>
Date:   Thu, 13 Feb 2020 12:11:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581560153.19424.6.camel@mtksdaap41>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/02/2020 03:15, Weiyi Lu wrote:
> On Wed, 2020-02-12 at 10:23 +0100, Matthias Brugger wrote:
>>
>> On 12/02/2020 03:55, Weiyi Lu wrote:
>>> On Tue, 2020-02-11 at 18:49 +0100, Matthias Brugger wrote:
>>>>
>>>> On 20/12/2019 04:45, Weiyi Lu wrote:
>>>>> Both MT8183 & MT6765 have more control steps of bus protection
>>>>> than previous project. And there add more bus protection registers
>>>>> reside at infracfg & smi-common. Also add new APIs for multiple
>>>>> step bus protection control with more customized arguments.
>>>>> And then use bp_table for bus protection of all compatibles,
>>>>> instead of mixing bus_prot_mask and bus_prot_reg_update.
>>>>>
>>>>> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
>>>>> ---
>>>>>  drivers/soc/mediatek/Makefile         |   2 +-
>>>>>  drivers/soc/mediatek/mtk-scpsys-ext.c | 101 +++++++++++++++++++++++++++++
>>>>>  drivers/soc/mediatek/mtk-scpsys.c     | 117 +++++++++++++++++++++-------------
>>>>>  drivers/soc/mediatek/scpsys-ext.h     |  67 +++++++++++++++++++
>>>>>  4 files changed, 240 insertions(+), 47 deletions(-)
>>>>>  create mode 100644 drivers/soc/mediatek/mtk-scpsys-ext.c
>>>>>  create mode 100644 drivers/soc/mediatek/scpsys-ext.h
>>>>>
>>>>> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
>>>>> index b017330..b442be9 100644
>>>>> --- a/drivers/soc/mediatek/Makefile
>>>>> +++ b/drivers/soc/mediatek/Makefile
>>>>> @@ -1,5 +1,5 @@
>>>>>  # SPDX-License-Identifier: GPL-2.0-only
>>>>>  obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
>>>>> -obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
>>>>> +obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o mtk-scpsys-ext.o
>>>>
>>>> It seems that we would need another patch which get's rid of the mtk-infracfg
>>>> first and then add stuff like the possibility to have different steps.
>>>>
>>>
>>> Actually I have a PATCH 05/11 to remove the mtk-infracfg.
>>> In this patch, I have some changes, like calling
>>> mtk_scpsys_ext_set_bus_protection(...) instead of
>>> mtk_infracfg_set_bus_protection(...) in scpsys_bus_protect_enable(...)
>>> and replacing bus_prot_mask by bp_table.
>>> I thought I should introduce the new method first and remove useless one
>>> later. What do you think?
>>
>> Yes, but first patch would be a step to get rid of mtk-infracfg and a second
>> patch add bp_table and the like.
>>
> 
> OK, I'll split into such sequence.
> 
>>>
>>>>>  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
>>>>>  obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
>>>>> diff --git a/drivers/soc/mediatek/mtk-scpsys-ext.c b/drivers/soc/mediatek/mtk-scpsys-ext.c
>>>>> new file mode 100644
>>>>> index 0000000..df402ac
>>>>> --- /dev/null
>>>>> +++ b/drivers/soc/mediatek/mtk-scpsys-ext.c
>>>>
>>>> I'm not quite sure why we should put this into a new file. I suppose the
>>>> rational behind it is the fact that we access other blocks through regmap.
>>>>
>>>
>>> Yes, those operation are accross infracfg and smi-common so we put these
>>> into new files.
>>
>> Are you exepct other drivers to use this functions? If not I will have to think
>> again, but I don't see any reason to put it into a new file.
>>
> 
> I thought no other driver would use these functions unless there will
> have drivers want to take over the bus protection process by themselves.
> 
> Do you prefer just putting these functions into mtk-scpsys.c?
> 

Yes I'd prefer that.

Regards,
Matthias
