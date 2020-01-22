Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD8EC33CAA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 00:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8583221734
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 00:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="F8/KEzOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgAVAxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 19:53:00 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:19588 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgAVAxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 19:53:00 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200122005256epoutp015c1151730ce1df35c1ac588a1e92f818~sD0lCZEKr0517705177epoutp01e
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 00:52:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200122005256epoutp015c1151730ce1df35c1ac588a1e92f818~sD0lCZEKr0517705177epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579654376;
        bh=DfMv8N5K2TGBtbRDVetyXTHpNJdbQVw+CVRNPX6dVxk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=F8/KEzOkZuhGmthwJDp+0uyef6i0UjlqUOlcMPxdGvqwYbR6+YTE4MS0fBPHjDlQr
         Wv+N5JnOe31xeaNmD6xq2jSo8ujn0UqootisWwrjTKsFr4Q+oFT0NAUAhCZSGPvMad
         MVLR8m+lO4mSuez+2h++/Hyzzay7cCw4rUbadwAg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200122005256epcas1p4d662afb8240222bae1a456d57aa2f73f~sD0klDDzk0621906219epcas1p4S;
        Wed, 22 Jan 2020 00:52:56 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.158]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 482Rhk04k9zMqYkk; Wed, 22 Jan
        2020 00:52:54 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.09.57028.5EC972E5; Wed, 22 Jan 2020 09:52:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200122005253epcas1p326c9970bcfebf5bf26198b3604f1bfd2~sD0hvJPw32721027210epcas1p3D;
        Wed, 22 Jan 2020 00:52:53 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200122005253epsmtrp27388d73bf4216e9d08e09efb0b76b1a0~sD0huM_km1843618436epsmtrp2V;
        Wed, 22 Jan 2020 00:52:53 +0000 (GMT)
X-AuditID: b6c32a35-50bff7000001dec4-52-5e279ce5baad
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.3D.06569.4EC972E5; Wed, 22 Jan 2020 09:52:52 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200122005252epsmtip2de611a287484621a756e9372e010957b~sD0hiuf3D2165721657epsmtip2m;
        Wed, 22 Jan 2020 00:52:52 +0000 (GMT)
Subject: Re: [PATCH] clk: samsung: Remove redundant check in
 samsung_cmu_register_one
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <62afcecb-e019-eae2-c92d-a9cb2bc04592@samsung.com>
Date:   Wed, 22 Jan 2020 10:00:19 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20200121233349.28627-1-pakki001@umn.edu>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm29nOtmz1tazeRtg6YZGh7rgdO5VWkMUoo0GRETQ96MGJu7Ez
        IytKumkS0Y3SNbtpRYuMbFmuTLKkjMqFaBEZXbSidNLdMqptx8h/z3t5vud93u9VEOpLpEZR
        YHfzLjtnpcgR0vpbM5ITe7zTzbqSirns3aMP5OzH3c9lbHvAS7IVbTck7KN7i9jqMz8Qe6u3
        VMb+7rwoZX2BX2iB0tj/ZIfc2ODpkhvrfLtI4x6/Dxk7TmyVGz/XxZnINYVpFp7L411a3p7r
        yCuw56dTS1dkL8xmUnV0Ij2bnUVp7ZyNT6cyMk2Jiwus4aEo7TrOWhROmThBoJLnpbkcRW5e
        a3EI7nSKd+ZZnbOdSQJnE4rs+Um5DtscWqdLYcKNOYWWD/09UqdPuf7yywFUgtrk5UipAGwA
        b1mQiGA1voqg/qS2HI0I408IOq/VysXgG4KLLQHJP0bv78NILDQiCLx5TIpBP4Luqpbou2Nx
        Fnj3n44yYvFUqNn2RxppIvB+CQT7fVFBEidA07snZASPxlOgY+A1imAVngehikPRvBTHw6v3
        ZdIIHodXQWv99qGeMdBa2R3NK3Eq1NcGo5jAE+Bp9zGJiCfDlT4vEREGXCqHwSOD4ekU4SAD
        nv+JFe2Mhfd3/EPL0MDnUCMp4o1wtvU2KXLLEPibgjKxoIemUwckkXcIPAMuBJLF9BRoGKxC
        ou4oCH3dLROlVFC2Uy22TIX2F11DW5wI1aW7yL2I8gxz4xnmwDPMgee/2HEk9aHxvFOw5fMC
        7aSH/3Ydih5sAnMVHXyY2YywAlEjVZaeaWa1jFsnFNuaESgIKlZ1fGu8Wa3K44o38C5HtqvI
        ygvNiAkvex+hGZfrCJ+/3Z1NMyl6vZ410KkMTVMTVIcztGY1zufcfCHPO3nXP55EodSUoFNk
        Fnf/e3H7xt6u24/iAngNm+il3pZvoupavmSYpi9Z6TeF7vvjxmRt9r0tgbTG0p6UytXfB26e
        2zA6lKQXYvZ9YHKSfWZHX+WWhsy1oRt9z2o0XTHnf3YcymE6C9vYj7WMTmWodhgMwYZPV15l
        Lluyl5s/M7DJWLM8ZlL8weuUVLBwdALhEri/EJ6ZHsYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7bCSvO7TOepxBk9cLU7MO8tu8bHnHqvF
        5V1z2CxmnN/HZHHxlKvF4uU/GS0Ov2lntfh3bSOLxapdfxgdOD3e32hl99g56y67x6ZVnWwe
        fVtWMXpcXdjE7vF5k1wAWxSXTUpqTmZZapG+XQJXxuv3T1kKVnFWbH34g7GB8Tx7FyMnh4SA
        icSbf9MZuxi5OIQEdjNKvGq/DpWQlJh28ShzFyMHkC0scfhwMUTNW0aJJ/93gNUIC4RLzJm0
        jAnEFhFQlljS/J8FpIhZYAqTxOoFc1khOjoZJU70fwKrYhPQktj/4gYbiM0voChx9cdjRhCb
        V8BO4t2MaWBxFgFViUevOlhAbFGBMImdSx4zQdQISpyc+QQszilgJrFt3QUwm1lAXeLPvEvM
        ELa4xK0n85kgbHmJ7W/nME9gFJ6FpH0WkpZZSFpmIWlZwMiyilEytaA4Nz232LDAKC+1XK84
        Mbe4NC9dLzk/dxMjONa0tHYwnjgRf4hRgINRiYc346lanBBrYllxZe4hRgkOZiUR3gVNqnFC
        vCmJlVWpRfnxRaU5qcWHGKU5WJTEeeXzj0UKCaQnlqRmp6YWpBbBZJk4OKUaGMseB8x4vPuS
        7nPubp2ksOKjRXqCiS8PmWZF7zr9iV9+Q4ei1t3LxzfU2Dq9Ccn5kBz93X9x77Od5/crG6sL
        Ni7cf3Zn1Ifd+zavEA998jCrMSLk2Rzz6izLxrvbduw9rnPV7VFAzPS0hXZ+j3ar1k5g+jbz
        utOBZc2eNy8Ud9xL+ND+YN2/pblKLMUZiYZazEXFiQAaOcmgsQIAAA==
X-CMS-MailID: 20200122005253epcas1p326c9970bcfebf5bf26198b3604f1bfd2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200121233357epcas1p2ed13efb902d2b30c0ddd426e84351b9f
References: <CGME20200121233357epcas1p2ed13efb902d2b30c0ddd426e84351b9f@epcas1p2.samsung.com>
        <20200121233349.28627-1-pakki001@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/20 8:33 AM, Aditya Pakki wrote:
> Consistent with other instances of samsung_clk_init, the check
> if ctx is NULL is redundant. The function currently does not
> return NULL.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/clk/samsung/clk.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
> index dad31308c071..1949ae7851b2 100644
> --- a/drivers/clk/samsung/clk.c
> +++ b/drivers/clk/samsung/clk.c
> @@ -356,10 +356,6 @@ struct samsung_clk_provider * __init samsung_cmu_register_one(
>  	}
>  
>  	ctx = samsung_clk_init(np, reg_base, cmu->nr_clk_ids);
> -	if (!ctx) {
> -		panic("%s: unable to allocate ctx\n", __func__);
> -		return ctx;
> -	}
>  
>  	if (cmu->pll_clks)
>  		samsung_clk_register_pll(ctx, cmu->pll_clks, cmu->nr_pll_clks,
> 

If samsung_clk_init() fail to allocate the memory for 'ctx',
call panic() without return. As the patch description,
samsung_clk_init() either call panic() or return
the correct 'ctx' instance. It looks good to me.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
