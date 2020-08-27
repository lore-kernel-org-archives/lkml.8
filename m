Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C242FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 05:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 947352080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 05:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YuuWw0Cn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgH0FNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 01:13:54 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:27690 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgH0FNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 01:13:51 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200827051348epoutp02e65fc6fa20ee270f5cafada24ccc1061~vCAky5nyT1111711117epoutp020
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 05:13:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200827051348epoutp02e65fc6fa20ee270f5cafada24ccc1061~vCAky5nyT1111711117epoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598505228;
        bh=FwxbqIwlwHE2YxMbgHxzdrPe9rdtQUJU7pDa8Ygd5qQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=YuuWw0CnHqUJYrTSO+/wVGHhp+URg+lNIAEpUk4MggnGukqipdswWEq4kg3TDI8rk
         6jp+C8NTtsir4UStKyq+ikGRCIgpz+BTW/t79xAxt/aHWAADaPwDd3QWuiLUD9W6l8
         OwbKYclH6p173X+4VmoZsVGlDR2LcE22mTsFoDJA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200827051347epcas1p170b62056070661ea96780e988663d3ad~vCAkW6QZS1968319683epcas1p1B;
        Thu, 27 Aug 2020 05:13:47 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4BcW953ZQxzMqYlx; Thu, 27 Aug
        2020 05:13:45 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.3C.29173.901474F5; Thu, 27 Aug 2020 14:13:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200827051344epcas1p26ad02c360e00aaacd9f56aa74462aed5~vCAhpaCse0931509315epcas1p2z;
        Thu, 27 Aug 2020 05:13:44 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200827051344epsmtrp2b9503d7712bc056dd285eee2fad620d0~vCAholy8t1168611686epsmtrp2j;
        Thu, 27 Aug 2020 05:13:44 +0000 (GMT)
X-AuditID: b6c32a37-9cdff700000071f5-d7-5f474109ace1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.53.08303.801474F5; Thu, 27 Aug 2020 14:13:44 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200827051344epsmtip1ecd82c0f115d8ae5fb0d61ce7c9a6ce4~vCAhckrtN0755507555epsmtip1Z;
        Thu, 27 Aug 2020 05:13:44 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] extcon: ptn5150: Switch to GENMASK() and BIT()
 macros
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     vijaikumar.kanagarajan@gmail.com, krzk@kernel.org,
        myungjoo.ham@samsung.com, heikki.krogerus@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <8f26c8cb-3f6b-5933-a0f8-eb765ad5016a@samsung.com>
Date:   Thu, 27 Aug 2020 14:26:12 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200827035633.37348-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmri6no3u8wYJZ0hbX30ZYdK3eyWJx
        /vwGdovLu+awWdxuXMFm8aVjPZvFhmP32Sxe7p/OatHUdJzNgdNj56y77B6L97xk8ti0qpPN
        Y97JQI++LasYPT5vkgtgi8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvM
        TbVVcvEJ0HXLzAG6SUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFmgV5yYW1ya
        l66XnJ9rZWhgYGQKVJiQnXFh5zTWgsVyFT/3LWZvYLwg2cXIySEhYCIx7ecXJhBbSGAHo8Tr
        +/5djFxA9idGicOXPjBDOJ8ZJS5f38gI0/Hn61U2iMQuRokv35+yQrS/Z5RY/TgZxBYWCJY4
        efgGUJyDQ0QgX+LME0GQMLPAdkaJR6vrQWw2AS2J/S9usIHY/AKKEld/PAabzytgJ/F/1WIW
        EJtFQFXi/9NGdhBbVCBM4uS2FqgaQYmTM5+A1XAKBEo82DuTGWK+uMStJ/OZIGx5ie1v54A9
        ICGwhUNi88J+JpB7JARcJBb2BUL8Iizx6vgWdghbSuLzu71sEHa1xMqTR9ggejsYJbbsv8AK
        kTCW2L90MtgcZgFNifW79CHCihI7f89lhNjLJ/Huaw8rxCpeiY42IYgSZYnLD+4yQdiSEovb
        O9kmMCrNQvLNLCQfzELywSyEZQsYWVYxiqUWFOempxYbFhgjR/UmRnBi1TLfwTjt7Qe9Q4xM
        HIyHGCU4mJVEeAUvOscL8aYkVlalFuXHF5XmpBYfYjQFhu9EZinR5Hxgas8riTc0NTI2NrYw
        MTQzNTRUEud9eEshXkggPbEkNTs1tSC1CKaPiYNTqoEptWiNwtq2F3+3Bsn/ORx3lVHIS93p
        d0u35voJy7bUbv27L02gXaj0K9M6xtX8G9isijhNnQ27l1kl/F72asqftWuVT+RN1dFe6Zve
        6T1FfParaufd0z+Giqc78m2p36Ab23XKQKrqtkDfyY9G20uM7kyWNjomdOH4K4lLnOkG27d8
        brs7f/b/I3L3y3neT9NxPxb76WLdgdU6n36avWeI3ZCU1zv9nsctIcMr3ReuC3vrqjpZrtgR
        aDYpJqQ4YGH21gPW//a4JV++0f8q4961l+tmyBnZm2Qc9fv+7tc6g32GF34c/XfHYnM87/r0
        6c73/BrElJs3PLx2eHpMj+VX7cjbb5ov7/6m+UbS/Ef9dCWW4oxEQy3mouJEAPx+1Kk1BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSnC6Ho3u8weVGU4vrbyMsulbvZLE4
        f34Du8XlXXPYLG43rmCz+NKxns1iw7H7bBYv909ntWhqOs7mwOmxc9Zddo/Fe14yeWxa1cnm
        Me9koEffllWMHp83yQWwRXHZpKTmZJalFunbJXBlXNg5jbVgsVzFz32L2RsYL0h2MXJySAiY
        SPz5epWti5GLQ0hgB6PE7EtX2CASkhLTLh5l7mLkALKFJQ4fLoaoecso8X3KEkaQGmGBYImT
        h2+wgtgiAvkS72buZgUpYhbYzihx/Pw1FoiO14wS22e9YwepYhPQktj/4gbYBn4BRYmrPx6D
        TeIVsJP4v2oxC4jNIqAq8f9pI1i9qECYxM4lj5kgagQlTs58AlbDKRAo8WDvTGYQm1lAXeLP
        vEtQtrjErSfzmSBseYntb+cwT2AUnoWkfRaSlllIWmYhaVnAyLKKUTK1oDg3PbfYsMAoL7Vc
        rzgxt7g0L10vOT93EyM41rS0djDuWfVB7xAjEwfjIUYJDmYlEV7Bi87xQrwpiZVVqUX58UWl
        OanFhxilOViUxHm/zloYJySQnliSmp2aWpBaBJNl4uCUamBSm7Dg4uy/XUyiHjvzPly8lirN
        wmTmV2QzefbFeb5nDfj/nmyQ+c+56mpx90Z9ib7YwPna0tJRDgtdMibEhziL3knOyyvb5nel
        Y3nL1p+tQffvbVr5z9/lOMejG8Fn/DXZ7b5ZRE6bqKMgyPvR7v6O/P0/Huyrmafh+nTDhyUB
        r+JF1x/b5PIo7X79srepfa4LnrQ9+H9+MssCptKCb+xPfrmtFElkrnQpNf7eeTr2mPUTZe67
        ounbO++Hx7imbTsvnN+8hUfr3RG2hm+yJ82f/uCZ/JGZyY195/nOk+HLrXrf/72StyxhS8ib
        e8/aT5rylD5V99jQwci9s+qXeLhMheLZsskba8tuLE9vE9ijxFKckWioxVxUnAgAQ2YRLyQD
        AAA=
X-CMS-MailID: 20200827051344epcas1p26ad02c360e00aaacd9f56aa74462aed5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200827035649epcas1p3eb6c7abbcd8e0ac28df5be19c9ef3a32
References: <20200827035633.37348-1-vadivel.muruganx.ramuthevar@linux.intel.com>
        <CGME20200827035649epcas1p3eb6c7abbcd8e0ac28df5be19c9ef3a32@epcas1p3.samsung.com>
        <20200827035633.37348-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/20 12:56 PM, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Switch to GENMASK() and BIT() macros.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/extcon/extcon-ptn5150.c | 43 +++++++++++------------------------------
>  1 file changed, 11 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
> index 8ba706fad887..8b930050a3f1 100644
> --- a/drivers/extcon/extcon-ptn5150.c
> +++ b/drivers/extcon/extcon-ptn5150.c
> @@ -7,6 +7,7 @@
>  // Author: Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
>  // Copyright (c) 2020 Krzysztof Kozlowski <krzk@kernel.org>
>  
> +#include <linux/bitfield.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> @@ -35,29 +36,13 @@ enum ptn5150_reg {
>  #define PTN5150_UFP_ATTACHED			0x2
>  
>  /* Define PTN5150 MASK/SHIFT constant */
> -#define PTN5150_REG_DEVICE_ID_VENDOR_SHIFT	0
> -#define PTN5150_REG_DEVICE_ID_VENDOR_MASK	\
> -	(0x3 << PTN5150_REG_DEVICE_ID_VENDOR_SHIFT)
> +#define PTN5150_REG_DEVICE_ID_VERSION		GENMASK(7, 3)
> +#define PTN5150_REG_DEVICE_ID_VENDOR		GENMASK(2, 0)
>  
> -#define PTN5150_REG_DEVICE_ID_VERSION_SHIFT	3
> -#define PTN5150_REG_DEVICE_ID_VERSION_MASK	\
> -	(0x1f << PTN5150_REG_DEVICE_ID_VERSION_SHIFT)
> -
> -#define PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT	2
> -#define PTN5150_REG_CC_PORT_ATTACHMENT_MASK	\
> -	(0x7 << PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT)
> -
> -#define PTN5150_REG_CC_VBUS_DETECTION_SHIFT	7
> -#define PTN5150_REG_CC_VBUS_DETECTION_MASK	\
> -	(0x1 << PTN5150_REG_CC_VBUS_DETECTION_SHIFT)
> -
> -#define PTN5150_REG_INT_CABLE_ATTACH_SHIFT	0
> -#define PTN5150_REG_INT_CABLE_ATTACH_MASK	\
> -	(0x1 << PTN5150_REG_INT_CABLE_ATTACH_SHIFT)
> -
> -#define PTN5150_REG_INT_CABLE_DETACH_SHIFT	1
> -#define PTN5150_REG_INT_CABLE_DETACH_MASK	\
> -	(0x1 << PTN5150_REG_CC_CABLE_DETACH_SHIFT)
> +#define PTN5150_REG_CC_PORT_ATTACHMENT		GENMASK(4, 2)
> +#define PTN5150_REG_CC_VBUS_DETECTION		BIT(7)
> +#define PTN5150_REG_INT_CABLE_ATTACH_MASK	BIT(0)
> +#define PTN5150_REG_INT_CABLE_DETACH_MASK	BIT(1)
>  
>  struct ptn5150_info {
>  	struct device *dev;
> @@ -95,9 +80,7 @@ static void ptn5150_check_state(struct ptn5150_info *info)
>  		return;
>  	}
>  
> -	port_status = ((reg_data &
> -			PTN5150_REG_CC_PORT_ATTACHMENT_MASK) >>
> -			PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT);
> +	port_status = FIELD_GET(PTN5150_REG_CC_PORT_ATTACHMENT, reg_data);
>  
>  	switch (port_status) {
>  	case PTN5150_DFP_ATTACHED:
> @@ -107,8 +90,7 @@ static void ptn5150_check_state(struct ptn5150_info *info)
>  		break;
>  	case PTN5150_UFP_ATTACHED:
>  		extcon_set_state_sync(info->edev, EXTCON_USB, false);
> -		vbus = ((reg_data & PTN5150_REG_CC_VBUS_DETECTION_MASK) >>
> -			PTN5150_REG_CC_VBUS_DETECTION_SHIFT);
> +		vbus = FIELD_GET(PTN5150_REG_CC_VBUS_DETECTION, reg_data);
>  		if (vbus)
>  			gpiod_set_value_cansleep(info->vbus_gpiod, 0);
>  		else
> @@ -191,11 +173,8 @@ static int ptn5150_init_dev_type(struct ptn5150_info *info)
>  		return -EINVAL;
>  	}
>  
> -	vendor_id = ((reg_data & PTN5150_REG_DEVICE_ID_VENDOR_MASK) >>
> -				PTN5150_REG_DEVICE_ID_VENDOR_SHIFT);
> -	version_id = ((reg_data & PTN5150_REG_DEVICE_ID_VERSION_MASK) >>
> -				PTN5150_REG_DEVICE_ID_VERSION_SHIFT);
> -
> +	vendor_id = FIELD_GET(PTN5150_REG_DEVICE_ID_VENDOR, reg_data);
> +	version_id = FIELD_GET(PTN5150_REG_DEVICE_ID_VERSION, reg_data);
>  	dev_dbg(info->dev, "Device type: version: 0x%x, vendor: 0x%x\n",
>  		version_id, vendor_id);
>  
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
