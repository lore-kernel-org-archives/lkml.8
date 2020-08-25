Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A7CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B774020715
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ih1UP6+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgHYKdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:33:43 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:22499 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgHYKdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:33:41 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200825103336epoutp0382871002ba8a618634680e336c4dd0ff~ufFOeTAVA0792907929epoutp03c
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 10:33:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200825103336epoutp0382871002ba8a618634680e336c4dd0ff~ufFOeTAVA0792907929epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598351616;
        bh=l6bgua5qF1U2anSdUW95hVGgAsI0ptIuSgH/OBirhSk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Ih1UP6+rTm5eGdqOOIG3BeuEWCRiyEtOKa7ze0PDVaAqAC0xv50fLQJYKJzTkgZf9
         881HPYGlTiIrYnSyK3AJmuY8//f5DG3IO4m7i6kvF3yITapzx0jWzdbX5bicESM/H7
         OX/J9y/KBj0mJO4OZBBqm7HdOgXXQSvgcLX6iu+A=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200825103335epcas1p15a5a344977d6990c2058627888284a6f~ufFOC-eEo2081420814epcas1p1W;
        Tue, 25 Aug 2020 10:33:35 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4BbQM05WMQzMqYkZ; Tue, 25 Aug
        2020 10:33:32 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.F2.29173.CF8E44F5; Tue, 25 Aug 2020 19:33:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200825103331epcas1p341eca764a8accfad2113d7bed7a7e7fd~ufFJ85NCB0778707787epcas1p3J;
        Tue, 25 Aug 2020 10:33:31 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200825103331epsmtrp1618d954f3f43d77474fc6f156b57ed16~ufFJ2yIKL1149211492epsmtrp1m;
        Tue, 25 Aug 2020 10:33:31 +0000 (GMT)
X-AuditID: b6c32a37-9cdff700000071f5-5d-5f44e8fcdc23
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.14.08303.BF8E44F5; Tue, 25 Aug 2020 19:33:31 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200825103331epsmtip1dd254f71d0a0cbe244daedb4e2865ef8~ufFJnI14F1178111781epsmtip1Q;
        Tue, 25 Aug 2020 10:33:31 +0000 (GMT)
Subject: Re: [PATCH v1 1/1] extcon: ptn5150: Add usb-typec support for Intel
 LGM SoC
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     vijaikumar.kanagarajan@gmail.com, krzk@kernel.org,
        myungjoo.ham@samsung.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <4b1edd2e-4791-3f12-206f-9277435cdf59@samsung.com>
Date:   Tue, 25 Aug 2020 19:46:00 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200825083147.25270-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmru6fFy7xBvcP61hcfxthcf78BnaL
        y7vmsFncblzBZvGlYz2bxYZj99ksXu6fzmrR1HSczYHDY+esu+wei/e8ZPLYtKqTzWPeyUCP
        vi2rGD0+b5ILYIvKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLx
        CdB1y8wBOkdJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BZoFecmFtcmpeul5yf
        a2VoYGBkClSYkJ1x6+su9oJ53BW7fx1gaWBcw9nFyMkhIWAi0fV8P0sXIxeHkMAORolnl9ZB
        OZ8YJc68XcMG4XxmlJiz5ywTTMvyv6+hErsYJWYffMAM4bxnlLhxtYkFpEpYIEzixuVu1i5G
        Dg4RgXyJM08EQcLMAtOAJq1hBLHZBLQk9r+4wQZi8wsoSlz98RgszitgJ/HgYBNYnEVAVWL7
        9jusILYo0MiT21qgagQlTs58AraKUyBQ4vfSu0wQ88Ulbj2ZD2XLS2x/OwfsNgmBpRwSH67f
        YoT4wEVi3cG1rBC2sMSr41vYIWwpiZf9bVB2tcTKk0fYIJo7GCW27L8A1WAssX/pZCaQx5gF
        NCXW79KHCCtK7Pw9lxFiMZ/Eu689YL9LCPBKdLQJQZQoS1x+cBcaiJISi9s72SYwKs1C8s4s
        JC/MQvLCLIRlCxhZVjGKpRYU56anFhsWGCPH9iZGcFLVMt/BOO3tB71DjEwcjIcYJTiYlUR4
        BS86xwvxpiRWVqUW5ccXleakFh9iNAUG8ERmKdHkfGBazyuJNzQ1MjY2tjAxNDM1NFQS5314
        SyFeSCA9sSQ1OzW1ILUIpo+Jg1OqgelekbinoN2Vb8WS39O9FdlqWMocEp/0KxT5d8czsGZl
        B94SzNjS1r/zQOfdW7eWWciffN0tHTU7c6rJtHWFpXMKrxz46h+/Y6NYu7xF01muKbY6jzll
        Y7TkP67bfDBI2NGWbXmNbMrlqV9msD492ya+fuv0bO8XIs/M7hxWLk23vOb/2K+rNlaIVeMY
        o8SOElad067ydQ/z7H41KtmELxQ1FeKIyhR5Grl/hXfqmtWRX2+Xm+/YJf0iVL325vmX7S+y
        vkltZMkX//2PO35acGvE0i1V14wPaBZvvTrT+cDvdbMOvaqdq6n3sLR5rd+p3+lvnCd9nzdl
        +SrzpeGW4asUnTv2hOv8Wy40k0fgsxJLcUaioRZzUXEiAHkPruEzBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJTvf3C5d4gy/3hSyuv42wOH9+A7vF
        5V1z2CxuN65gs/jSsZ7NYsOx+2wWL/dPZ7VoajrO5sDhsXPWXXaPxXteMnlsWtXJ5jHvZKBH
        35ZVjB6fN8kFsEVx2aSk5mSWpRbp2yVwZdz6uou9YB53xe5fB1gaGNdwdjFyckgImEgs//ua
        rYuRi0NIYAejxJ/N81ghEpIS0y4eZe5i5ACyhSUOHy6GqHnLKPF5xhpGkBphgTCJG5e7wepF
        BPIl3s3czQpSxCwwjVHi//E2VoiO14wSa1avA6tiE9CS2P/iBhuIzS+gKHH1x2OwSbwCdhIP
        DjaBxVkEVCW2b78DVi8KtGHnksdMEDWCEidnPmEBsTkFAiV+L70LFmcWUJf4M+8SM4QtLnHr
        yXyouLzE9rdzmCcwCs9C0j4LScssJC2zkLQsYGRZxSiZWlCcm55bbFhglJdarlecmFtcmpeu
        l5yfu4kRHGFaWjsY96z6oHeIkYmD8RCjBAezkgiv4EXneCHelMTKqtSi/Pii0pzU4kOM0hws
        SuK8X2ctjBMSSE8sSc1OTS1ILYLJMnFwSjUwXbmtKlSu8uyobtm5addfsn4/ouC9Rf62f6U4
        9zY3MxuhX8ZdOuuMWcseJOg05a6cr+3Gkj3h8Nmns5etU/qXqyOsxbSA73//avldHoIiG/xf
        crZXdrxdKyjt05Yb9mrOxLfWxjwnBNpb260a5U/v3RBeq3Ao9OqF05f3xl68si3n79MpVm8n
        RBk7F3QyzxOKWfLP2dJyX4jt1othMWJbH7ezOK+7VeQTH1n6hiG0ump+a5po/vFdkpGW5+zm
        344zYKoLa9hlPquHdeXy6sZtzY4sk1iarD9XMERO58uoz1OM1D505fe6T/m7Ttcke7yY/f6e
        dOrKd+duTVBP31kUvefd4T1bk+yO3Oib9nmBEktxRqKhFnNRcSIAzIcoIx8DAAA=
X-CMS-MailID: 20200825103331epcas1p341eca764a8accfad2113d7bed7a7e7fd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200825083202epcas1p39a30661dd7ae7e5b4f8645a7cfcedd1d
References: <20200825083147.25270-1-vadivel.muruganx.ramuthevar@linux.intel.com>
        <CGME20200825083202epcas1p39a30661dd7ae7e5b4f8645a7cfcedd1d@epcas1p3.samsung.com>
        <20200825083147.25270-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/25/20 5:31 PM, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add usb-typec detection support for Intel LGM SoC based
> boards.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  drivers/extcon/extcon-ptn5150.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
> index 8ba706fad887..60355a1b5cb2 100644
> --- a/drivers/extcon/extcon-ptn5150.c
> +++ b/drivers/extcon/extcon-ptn5150.c
> @@ -300,6 +300,8 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
>  		return ret;
>  	}
>  
> +	extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
> +				       EXTCON_PROP_USB_TYPEC_POLARITY);

extcon_set_property_capability() just sets the capability
of EXTCON_PROP_USB_TYPEC_POLARITY property.

If you want to set the value (0 or 1) of EXTCON_PROP_USB_TYPEC_POLARITY,
we have to call extcon_set_property() function. But, this patch doesn't
set the any value of EXTCON_PROP_USB_TYPEC_POLARITY property.

Why do you only use extcon_set_property_capability()
without the proper extcon_set_property()?

>  	/* Initialize PTN5150 device and print vendor id and version id */
>  	ret = ptn5150_init_dev_type(info);
>  	if (ret)
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
