Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF5EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8E2B2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgH0Pfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:35:52 -0400
Received: from out28-125.mail.aliyun.com ([115.124.28.125]:45466 "EHLO
        out28-125.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgH0Pfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:35:51 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436283|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0142134-0.00410037-0.981686;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03268;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.IOqof6y_1598542530;
Received: from 192.168.178.128(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.IOqof6y_1598542530)
          by smtp.aliyun-inc.com(10.147.41.143);
          Thu, 27 Aug 2020 23:35:31 +0800
Subject: Re: [PATCH 1/1] USB: PHY: JZ4770: Fix uninitialized value written to
 HW register
To:     Paul Cercueil <paul@crapouillou.net>,
        Felipe Balbi <balbi@kernel.org>
Cc:     =?UTF-8?B?5ZGo5q2j?= <sernia.zhou@foxmail.com>,
        =?UTF-8?B?5ryG6bmP5oyv?= <aric.pzqi@ingenic.com>, od@zcrc.me,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200827124308.71963-1-paul@crapouillou.net>
 <20200827124308.71963-2-paul@crapouillou.net> <87v9h4i6t5.fsf@kernel.org>
 <PN4QFQ.KWNBY2ZWQ7XC2@crapouillou.net> <87bliwi5kx.fsf@kernel.org>
 <HG6QFQ.KLMIR92DB2D02@crapouillou.net>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <ccfb841c-b518-3107-eb9b-a62169970bb1@wanyeetech.com>
Date:   Thu, 27 Aug 2020 23:35:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <HG6QFQ.KLMIR92DB2D02@crapouillou.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

在 2020/8/27 下午9:50, Paul Cercueil 写道:
>
>
> Le jeu. 27 août 2020 à 16:25, Felipe Balbi <balbi@kernel.org> a écrit :
>>
>> Hi,
>>
>> Paul Cercueil <paul@crapouillou.net> writes:
>>>>>   @@ -172,7 +172,8 @@ static int ingenic_usb_phy_init(struct usb_phy
>>>>>  *phy)
>>>>>            return err;
>>>>>        }
>>>>>
>>>>>   -    priv->soc_info->usb_phy_init(phy);
>>>>>   +    reg = priv->soc_info->usb_phy_init(phy);
>>>>>   +    writel(reg, priv->base + REG_USBPCR_OFFSET);
>>>>
>>>>  not fixing any bug.
>>>>
>>>>  Looking at the code, the bug follows after this line. It would 
>>>> suffice
>>>>  to read REG_USBPCR_OFFSET in order to initialize reg. This bug fix
>>>>  could
>>>>  have been a one liner.
>>>
>>>  There's no need to re-read a register when you have the value readily
>>>  available. It just needs to be returned from the usb_phy_init
>>>  callbacks. But yes, it's not a one-liner.
>>
>> there's a difference between making a bug fix and reworking the behavior
>> of the driver ;-)
>
> The one-liner is actually what changes the behavior of the driver, 
> since previously the code did not read back the register.
>
> In this case I guess it's fine, because the register does not have 
> volatile bits.
>
>>>>>   @@ -195,19 +196,15 @@ static void ingenic_usb_phy_remove(void *phy)
>>>>>        usb_remove_phy(phy);
>>>>>    }
>>>>>
>>>>>   -static void jz4770_usb_phy_init(struct usb_phy *phy)
>>>>>   +static u32 jz4770_usb_phy_init(struct usb_phy *phy)
>>>>
>>>>  not a bug fix
>>>>
>>>>>    {
>>>>>   -    struct jz4770_phy *priv = phy_to_jz4770_phy(phy);
>>>>>   -    u32 reg;
>>>>>   -
>>>>>   -    reg = USBPCR_AVLD_REG | USBPCR_COMMONONN | 
>>>>> USBPCR_IDPULLUP_ALWAYS
>>>>>  |
>>>>>   +    return USBPCR_AVLD_REG | USBPCR_COMMONONN |
>>>>>  USBPCR_IDPULLUP_ALWAYS |
>>>>>            USBPCR_COMPDISTUNE_DFT | USBPCR_OTGTUNE_DFT |
>>>>>  USBPCR_SQRXTUNE_DFT |
>>>>>            USBPCR_TXFSLSTUNE_DFT | USBPCR_TXRISETUNE_DFT |
>>>>>  USBPCR_TXVREFTUNE_DFT |
>>>>>            USBPCR_POR;
>>>>>   -    writel(reg, priv->base + REG_USBPCR_OFFSET);
>>>>
>>>>  not a bug fix
>>>>
>>>>>    }
>>>>>
>>>>>   -static void jz4780_usb_phy_init(struct usb_phy *phy)
>>>>>   +static u32 jz4780_usb_phy_init(struct usb_phy *phy)
>>>>
>>>>  not a bug fix
>>>>
>>>>>   @@ -216,11 +213,10 @@ static void jz4780_usb_phy_init(struct
>>>>>  usb_phy *phy)
>>>>>            USBPCR1_WORD_IF_16BIT;
>>>>>        writel(reg, priv->base + REG_USBPCR1_OFFSET);
>>>>>
>>>>>   -    reg = USBPCR_TXPREEMPHTUNE | USBPCR_COMMONONN | USBPCR_POR;
>>>>>   -    writel(reg, priv->base + REG_USBPCR_OFFSET);
>>>>>   +    return USBPCR_TXPREEMPHTUNE | USBPCR_COMMONONN | USBPCR_POR;
>>>>
>>>>  not a bug fix
>>>>
>>>>>    }
>>>>>
>>>>>   -static void x1000_usb_phy_init(struct usb_phy *phy)
>>>>>   +static u32 x1000_usb_phy_init(struct usb_phy *phy)
>>>>
>>>>  not a bug fix
>>>>
>>>>>    {
>>>>>        struct jz4770_phy *priv = phy_to_jz4770_phy(phy);
>>>>>        u32 reg;
>>>>>   @@ -228,13 +224,12 @@ static void x1000_usb_phy_init(struct usb_phy
>>>>>  *phy)
>>>>>        reg = readl(priv->base + REG_USBPCR1_OFFSET) |
>>>>>  USBPCR1_WORD_IF_16BIT;
>>>>>        writel(reg, priv->base + REG_USBPCR1_OFFSET);
>>>>>
>>>>>   -    reg = USBPCR_SQRXTUNE_DCR_20PCT | USBPCR_TXPREEMPHTUNE |
>>>>>   +    return USBPCR_SQRXTUNE_DCR_20PCT | USBPCR_TXPREEMPHTUNE |
>>>>>            USBPCR_TXHSXVTUNE_DCR_15MV | USBPCR_TXVREFTUNE_INC_25PPT |
>>>>>            USBPCR_COMMONONN | USBPCR_POR;
>>>>>   -    writel(reg, priv->base + REG_USBPCR_OFFSET);
>>>>
>>>>  not a bug fix
>>>>
>>>>>    }
>>>>>
>>>>>   -static void x1830_usb_phy_init(struct usb_phy *phy)
>>>>>   +static u32 x1830_usb_phy_init(struct usb_phy *phy)
>>>>
>>>>  not a bug fix
>>>>
>>>>>    {
>>>>>        struct jz4770_phy *priv = phy_to_jz4770_phy(phy);
>>>>>        u32 reg;
>>>>>   @@ -246,9 +241,8 @@ static void x1830_usb_phy_init(struct usb_phy
>>>>>  *phy)
>>>>>            USBPCR1_DMPD | USBPCR1_DPPD;
>>>>>        writel(reg, priv->base + REG_USBPCR1_OFFSET);
>>>>>
>>>>>   -    reg = USBPCR_IDPULLUP_OTG | USBPCR_VBUSVLDEXT
>>>>>  |    USBPCR_TXPREEMPHTUNE |
>>>>>   +    return USBPCR_IDPULLUP_OTG | USBPCR_VBUSVLDEXT |
>>>>>  USBPCR_TXPREEMPHTUNE |
>>>>>            USBPCR_COMMONONN | USBPCR_POR;
>>>>>   -    writel(reg, priv->base + REG_USBPCR_OFFSET);
>>>>
>>>>  not a bug fix
>>>
>>>  Well, if you don't like my bug fix, next time wait for my Reviewed-by.
>>
>> why so angry? Take a break every once in a while. Besides, someone else
>> already sent the oneliner before you ;-)
>
> I'm just pissed that this patch has not been tested. I don't like 
> sloppy work.
>
This is my fault. This error occurred in the v5 version, but was 
corrected in the v6 version, but I don't know why v5 was merged into the 
mainline and v6 was not merged, which caused this problem.


>> In any case, why should I wait for your Reviewed-by? Get maintainer
>> doesn't list you as the maintainer for it. Do you want to update
>> MAINTAINERS by any chance?
>
> Yes, I thought I was (I'm maintainer of all Ingenic drivers), that 
> also explains why I wasn't Cc'd for the oneliner patch you mentioned...
>
I checked again, get_maintainer did not give the correct information, 
which caused my script to not add Paul to the cc list.
> IIRC Zhou has a patch to move the driver to drivers/phy/, I'll add 
> myself as maintainer once it's moved there.
>
I'll resend it soon.


Thanks and best regards!

> -Paul
>
