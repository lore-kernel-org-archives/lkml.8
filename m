Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDECC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB6D2076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bkCkc4wU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgCRIVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 04:21:35 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:60661 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCRIVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 04:21:34 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200318082131epoutp04353de6bca66e8f5357abadf2e1e25128~9WEOhTAqS1316113161epoutp04I
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 08:21:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200318082131epoutp04353de6bca66e8f5357abadf2e1e25128~9WEOhTAqS1316113161epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584519691;
        bh=K81bm+DDzznDrTE0b/mo3qm3kll5lhB+L+37w1NPXyA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=bkCkc4wUu308dhRY/eQtyst5M2CNPevCNc1McxEScmwXeQRmSQopfj5mOZnZCXZJQ
         zFp2HGxIxtWO2wOHNyZUXmiYLMkue0FDEeCWaC+GbaP9nDSTvMrEyWLIlaLdjFrrfR
         ETZdJ2lQ5fLcvuNeSRPK3HX0U7EzQV1+dLmT77gY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200318082130epcas1p4f026be42e545d70af0f991829565f22a~9WEOCreUx2636426364epcas1p4P;
        Wed, 18 Mar 2020 08:21:30 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 48j30R3dYCzMqYkr; Wed, 18 Mar
        2020 08:21:27 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.E4.04140.10AD17E5; Wed, 18 Mar 2020 17:21:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200318082121epcas1p46a354e562e55f1c113b67c38f843ec72~9WEFNkijF1824418244epcas1p4r;
        Wed, 18 Mar 2020 08:21:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200318082121epsmtrp2d75b24a14016d9a4981e75220935358d~9WEFM2HDJ0190601906epsmtrp2g;
        Wed, 18 Mar 2020 08:21:21 +0000 (GMT)
X-AuditID: b6c32a36-fa3ff7000000102c-93-5e71da01d4e5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.7C.04024.10AD17E5; Wed, 18 Mar 2020 17:21:21 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200318082121epsmtip24507d49d585c36b6afcae3aaa240c086~9WEFALijS0977509775epsmtip2v;
        Wed, 18 Mar 2020 08:21:21 +0000 (GMT)
Subject: Re: [PATCH] extcon: Mark extcon_get_edev_name() function as
 exported symbol
To:     Mayank Rana <mrana@codeaurora.org>, myungjoo.ham@samsung.com
Cc:     linux-kernel@vger.kernel.org, jackp@codeaurora.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <1ce81e60-8d71-de92-1295-93f9a59d0ada@samsung.com>
Date:   Wed, 18 Mar 2020 17:30:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <1584389672-9195-1-git-send-email-mrana@codeaurora.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdlhTT5fpVmGcQddCRov25xfYLC7vmsNm
        0XPyILPF7cYVbA4sHpf7epk8+rasYvT4vEkugDkq2yYjNTEltUghNS85PyUzL91WyTs43jne
        1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaJuSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYp
        tSAlp8CyQK84Mbe4NC9dLzk/18rQwMDIFKgwITtj8pnbbAV7uCvOLl7K2MC4ibOLkZNDQsBE
        4tjml8wgtpDADkaJppkZXYxcQPYnRok7PbcYIZxvjBJn5+5ggunYsPsdM0RiL6PEnuv9LBDt
        7xklWpvAxgoLhEl8nfQbqIGDQ0TAQWJTRyZImFnATGL3+btsIDabgJbE/hc3wGx+AUWJqz8e
        M4KU8wrYSdyb5QgSZhFQldhz4zVYiSjQxJPbWhhBbF4BQYmTM5+AbeUUcJGY/uY4O8R4cYlb
        T+YzQdjyEtvfzgE7U0LgDJvEkv0foO53kbh4dCUjhC0s8er4FnYIW0ri87u9bBB2tcTKk0fY
        IJo7GCW27L/ACpEwlti/dDLYX8wCmhLrd+lDhBUldv6eywixmE/i3dceVpASCQFeiY42IYgS
        ZYnLD+5CnSApsbi9k20Co9IsJO/MQvLCLCQvzEJYtoCRZRWjWGpBcW56arFhgRFyVG9iBCdD
        LbMdjIvO+RxiFOBgVOLh5dhQECfEmlhWXJl7iFGCg1lJhHdxYX6cEG9KYmVValF+fFFpTmrx
        IUZTYGhPZJYSTc4HJuq8knhDUyNjY2MLE0MzU0NDJXHeqddz4oQE0hNLUrNTUwtSi2D6mDg4
        pRoY9+3aU+f/sKN64p9423nxMi9f/r0vK8xe2uy2R7cq6m6c/esTDEks2ZY9F69Yr7VSWG/S
        FHtqTmz+syJ5bfVupSlJgrzlF1aXtU8KPDrjiGTRxPKWV8ETItbv3bUhi/HqFvtzC3ZkmX53
        jb9TfTaLV3Xiw69XzFY+vxRj3hyzr6abu82qqGy7EktxRqKhFnNRcSIAZVRtGJwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSvC7jrcI4g1e3BS3an19gs7i8aw6b
        Rc/Jg8wWtxtXsDmweFzu62Xy6NuyitHj8ya5AOYoLpuU1JzMstQifbsErozJZ26zFezhrji7
        eCljA+Mmzi5GTg4JAROJDbvfMXcxcnEICexmlNg25xgzREJSYtrFo0A2B5AtLHH4cDFEzVtG
        icnLDrOD1AgLhEnsnn6MCaRGRMBBYlNHJkiYWcBMYvf5u2wQ9dMZJRoXfGQDSbAJaEnsf3ED
        zOYXUJS4+uMxI0gvr4CdxL1ZjiBhFgFViT03XoOViAKN37nkMROIzSsgKHFy5hMWEJtTwEVi
        +pvj7BC71CX+zLvEDGGLS9x6Mp8JwpaX2P52DvMERuFZSNpnIWmZhaRlFpKWBYwsqxglUwuK
        c9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgiNDS3MH4+Ul8YcYBTgYlXh4EzYVxAmxJpYVV+Ye
        YpTgYFYS4V1cmB8nxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdp3rFIIYH0xJLU7NTUgtQimCwT
        B6dUA6P62V9lYbyRcxzZZywO31C2w/3C1v+Pp38tuee67K3YdbkTUieKDD50KUcG3ruqvlWh
        devhnf68m4JqTFJMZT7f1JxZozSJ6eK1Du6Yy+3/dmvPu17c8O7s/UvRdZKs318HHc61VOi8
        4uNqevliUXzsy6madxtn9KoKnFr4/GKXSORz4dqlL9yUWIozEg21mIuKEwHO0s4YiAIAAA==
X-CMS-MailID: 20200318082121epcas1p46a354e562e55f1c113b67c38f843ec72
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200316201450epcas1p3a20b0db35d64af8f50925079ca5fabf6
References: <CGME20200316201450epcas1p3a20b0db35d64af8f50925079ca5fabf6@epcas1p3.samsung.com>
        <1584389672-9195-1-git-send-email-mrana@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/20 5:14 AM, Mayank Rana wrote:
> extcon_get_edev_name() function provides client driver to request
> extcon dev's name. If extcon driver and client driver are compiled
> as loadable modules, extcon_get_edev_name() function symbol is not
> visible to client driver. Hence mark extcon_find_edev_name() function
> as exported symbol.
> 
> Signed-off-by: Mayank Rana <mrana@codeaurora.org>
> ---
>  drivers/extcon/extcon.c | 1 +
>  include/linux/extcon.h  | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index e055893..2dfbfec 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -1406,6 +1406,7 @@ const char *extcon_get_edev_name(struct extcon_dev *edev)
>  {
>  	return !edev ? NULL : edev->name;
>  }
> +EXPORT_SYMBOL_GPL(extcon_get_edev_name);
>  
>  static int __init extcon_class_init(void)
>  {
> diff --git a/include/linux/extcon.h b/include/linux/extcon.h
> index 1b1d77e..fd183fb 100644
> --- a/include/linux/extcon.h
> +++ b/include/linux/extcon.h
> @@ -286,6 +286,11 @@ static inline struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
>  {
>  	return ERR_PTR(-ENODEV);
>  }
> +
> +static inline const char *extcon_get_edev_name(struct extcon_dev *edev)
> +{
> +	return NULL;
> +}
>  #endif /* CONFIG_EXTCON */
>  
>  /*
> 

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
