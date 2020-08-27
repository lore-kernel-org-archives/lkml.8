Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A4CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44D9120738
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bpwA3lBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgH0Ho0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:44:26 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:18160 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgH0HoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:44:24 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200827074421epoutp0389336825e7867a72a58d7f53db67b301~vEEBwJeDT2221422214epoutp038
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 07:44:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200827074421epoutp0389336825e7867a72a58d7f53db67b301~vEEBwJeDT2221422214epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598514261;
        bh=r4jhcseoHypqvXRZ/RixmNT6Bx53CHi5vw/qNzs71Ww=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=bpwA3lBBoncM5sqbAlD8FGqej9g0VLVV1+AkPjQ2bqQVucMYHobgRMU13Egh+gUD6
         0GFhbKz8FxqJJsi76eMcZ/5kHKhm1UTKNKlA/q2QYnEKMbUlyq+LgcEauxJWko8bjL
         pTY/wK4S3I7SAMRoldCBOARe6DD8WCkU7ujVaPUo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200827074420epcas1p13c51a1ef62d08ffa9af1173247dc69a6~vEEBEK3-q0033200332epcas1p18;
        Thu, 27 Aug 2020 07:44:20 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4BcZVq6MnQzMqYkZ; Thu, 27 Aug
        2020 07:44:19 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.47.18978.254674F5; Thu, 27 Aug 2020 16:44:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200827074418epcas1p445eee582dfa4a74becc65df4e6a4ba6a~vED_xdpCK0446304463epcas1p4z;
        Thu, 27 Aug 2020 07:44:18 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200827074418epsmtrp2343e66b2f90df69b0c0035cbe28cc421~vED_wjJay2482024820epsmtrp2d;
        Thu, 27 Aug 2020 07:44:18 +0000 (GMT)
X-AuditID: b6c32a35-5edff70000004a22-66-5f476452369e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.06.08303.254674F5; Thu, 27 Aug 2020 16:44:18 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200827074418epsmtip1c4f70f75890a78c85ffa1cb031ae9dca~vED_lqP5k2184021840epsmtip1F;
        Thu, 27 Aug 2020 07:44:18 +0000 (GMT)
Subject: Re: [PATCH v3 1/1] extcon: ptn5150: Set the VBUS and POLARITY
 property capability
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     vijaikumar.kanagarajan@gmail.com, krzk@kernel.org,
        myungjoo.ham@samsung.com, heikki.krogerus@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <e0ac8482-d607-6095-0d9b-2918f0e7a0f2@samsung.com>
Date:   Thu, 27 Aug 2020 16:56:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200827065128.55094-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmgW5winu8QcNBRovrbyMsulbvZLE4
        f34Du8XlXXPYLG43rmCz+NKxns1iw7H7bBYv909ntWhqOs7mwOmxc9Zddo/Fe14yeWxa1cnm
        Me9koEffllWMHp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXm
        ptoqufgE6Lpl5gDdpKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpsCzQK07MLS7N
        S9dLzs+1MjQwMDIFKkzIzjj6fw9rQTN3ReevFrYGxv8cXYycHBICJhLLXjxj6mLk4hAS2MEo
        8fvRQ2YI5xOjxOyXl1ggnM+MEv/OHGDvYuQAa/k5jwcivotRoq3vBVT7e6CiOfeZQIqEBWIk
        Pi6QAzFFBPIlzjwRBNnGLLCdUeLR6noQm01AS2L/ixtsIDa/gKLE1R+PGUFsXgE7iZ7dc5lA
        bBYBVYnGljXMILaoQJjEyW0tUDWCEidnPmEBsTkFAiUmNK9mgpgvLnHryXwoW15i+9s5YM9I
        CKzlkDh98hELxP0uEqdW6kB8Lyzx6vgWdghbSuLzu71sEHa1xMqTR9ggejsYJbbsv8AKkTCW
        2L90MtiLzAKaEut36UOEFSV2/p7LCLGXT+Ld1x5WiFW8Eh1tQhAlyhKXH9xlgrAlJRa3d7JN
        YFSaheSbWUg+mIXkg1kIyxYwsqxiFEstKM5NTy02LDBEjupNjODEqmW6g3Hi2w96hxiZOBgP
        MUpwMCuJ8ApedI4X4k1JrKxKLcqPLyrNSS0+xGgKDN+JzFKiyfnA1J5XEm9oamRsbGxhYmhm
        amioJM778JZCvJBAemJJanZqakFqEUwfEwenVAPTUkV2obku7y8EBvS+T/AP9Z/COzF6u/GD
        6Twsl51vnzgqlPSw33jir99OJ1uz5l7xeD8xs/M885LIWZ+aBK5oqstlf7q1jqX8V8WjwGWm
        iZrh/3gW6RRNabPemCV4ryPb6tWHfhZj98JOlyWMQT8eTyyRPB9wuLm86O3TwGzORcf1NlX9
        ZlGZsF2huGyP9/KInu8VGh4Lhb0vfTTIt5Dd2Jnv3HWi5oT8gRLp65eCLt+KWlNq+/uh88mG
        vZqZFYsYj6UfdGLo+n7foTLY+Nsl1RcFMmtqLsfnaNbf6/QsmWgvcpAlQ976bY3gHosbU5r2
        6bs5v3+0v+j1zcb/ScvFbnzhFPn4e2VNbtB9261KLMUZiYZazEXFiQBhNDcTNQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJTjcoxT3e4PQ+SYvrbyMsulbvZLE4
        f34Du8XlXXPYLG43rmCz+NKxns1iw7H7bBYv909ntWhqOs7mwOmxc9Zddo/Fe14yeWxa1cnm
        Me9koEffllWMHp83yQWwRXHZpKTmZJalFunbJXBlHP2/h7Wgmbui81cLWwPjf44uRg4OCQET
        iZ/zeLoYuTiEBHYwSuz/vIa9i5ETKC4pMe3iUWaIGmGJw4eLIWreMkq8OtLMCBIXFoiR+LhA
        DqRcRCBf4t3M3awgNcwC2xkljp+/xgKSEBJ4DdSwiAnEZhPQktj/4gYbiM0voChx9cdjRhCb
        V8BOomf3XLAaFgFVicaWNcwgtqhAmMTOJY+ZIGoEJU7OfAI2k1MgUGJC82qwOLOAusSfeZeY
        IWxxiVtP5kPF5SW2v53DPIFReBaS9llIWmYhaZmFpGUBI8sqRsnUguLc9NxiwwKjvNRyveLE
        3OLSvHS95PzcTYzgKNPS2sG4Z9UHvUOMTByMhxglOJiVRHgFLzrHC/GmJFZWpRblxxeV5qQW
        H2KU5mBREuf9OmthnJBAemJJanZqakFqEUyWiYNTqoHJ7tkXQW2dR2/Cf5s36nxKEg35d1/X
        pOOsxM9Cy3jrm55RsT7OTFdmtcwVi0i016ufyOpyzez5Q45+pl0L5qr6PPuV0qp9Mu2k+9zU
        V0tKFfvvLWO+7Gxx9l7j6WBJYd/NrnMWaMQWfJb4d6S76PD2+sh5c95af5U/Erck2ufdWR0V
        vwdL+kqzkx5Mz56WJCd0bGbbMvbN15W1U5/quf9YaWV11OHUcTuuKxt5rv+/OH9l/LXPV/tv
        L/TtKFd7cCbbtTmOo2ma4Kkb124YStbM8/nW4xTXWnPtY5X3+t3SBRMYZ2x+Mj8z6k9rWDyv
        /eZr9iyMf975nn8cfedM7yGnOU0C+69LF+8IbkthPiGoxFKckWioxVxUnAgAKXbcYiEDAAA=
X-CMS-MailID: 20200827074418epcas1p445eee582dfa4a74becc65df4e6a4ba6a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200827065143epcas1p3da86f8d70e6d78c64a925f4d9c0f92eb
References: <20200827065128.55094-1-vadivel.muruganx.ramuthevar@linux.intel.com>
        <CGME20200827065143epcas1p3da86f8d70e6d78c64a925f4d9c0f92eb@epcas1p3.samsung.com>
        <20200827065128.55094-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/20 3:51 PM, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Set the capability value of property for VBUS and POLARITY.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  drivers/extcon/extcon-ptn5150.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
> index 841c9fe211f1..20d49a54c36e 100644
> --- a/drivers/extcon/extcon-ptn5150.c
> +++ b/drivers/extcon/extcon-ptn5150.c
> @@ -275,6 +275,13 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
>  		return ret;
>  	}
>  
> +	extcon_set_property_capability(info->edev, EXTCON_USB,
> +				       EXTCON_PROP_USB_VBUS);
> +	extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
> +				       EXTCON_PROP_USB_VBUS);
> +	extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
> +				       EXTCON_PROP_USB_TYPEC_POLARITY);

Above codes used the space for the indentation to keep the vertical line.
I think that we better to use tab for the indentation.

If there are no objection, I'll fix and then apply it. 

> +
>  	/* Initialize PTN5150 device and print vendor id and version id */
>  	ret = ptn5150_init_dev_type(info);
>  	if (ret)
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
