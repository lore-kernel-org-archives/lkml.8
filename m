Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFE0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D611920715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="svDu8YJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgGFOFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:05:53 -0400
Received: from mout.web.de ([217.72.192.78]:33967 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbgGFOFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1594044257;
        bh=txLFHk4sKswUobcyqE5f9RkYwUgc2JM+KiU/kOsvK8E=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=svDu8YJYzpJR794LiTYnvaMqQIuimLitSl84yooBmQ3oC5NT2xtvrmHA4HlZwhW2s
         XcXuHUsJnWGHcHaKOJ/uv662URyBHVXbm+ShqtDYj37g+Hgdje5lJxboYC9bjr9QNE
         R2qiqlMq/HfV36U7bjGLC2JTzGdU3P1jTloGBFSs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.113.119]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6mPA-1koxhl2kLM-00wRIo; Mon, 06
 Jul 2020 16:04:17 +0200
Subject: Re: [RFC PATCH] vfio: type1: fix kthread use case
To:     Hillf Danton <hdanton@sina.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        iommu@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>
References: <20200706104915.11460-1-hdanton@sina.com>
 <20200706124241.4392-1-hdanton@sina.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <69f9079f-b1b0-3296-4536-8f0a051a96c2@web.de>
Date:   Mon, 6 Jul 2020 16:04:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200706124241.4392-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S6iuadSuppITYZ9YHAjzGVbigTb8/nLwzmleYDcKmFolGDCGlwt
 vUVVYSUv69Yrvfko9y5sTRXBzPUy4C0JdxeZyz2JUAGMbu596PvOG2GPjx9HyYBR/h8o9E6
 MConKpwivqH0INVe95xeFaeoha1CYYwA3PKQIUyqjJeRgZOslWERpmupVtsdH30kDJAoC29
 b7QLRVlfgxIws8Mb+hxVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zTcJAye6cAU=:MgITDtimfovCc5DxsHQxsa
 1b5dtbrusuDkN0HGL0HXBawJMGKykNPHkk8HE3Ep+kVhncfhcmDp6UIKN1Yx2rAvzfdM/bMwf
 M+gGmlrH0IC/bAPzyw/Y5PjjUKDJhz+S6lgfKCbgoA7WKmXBbQnN489X+ATc39E14ii3NYNE0
 BvLaMD49mrXqHdSJkTNQOw4V8Zg7PPJ0IvhSu25wOucTfY/Vp8VCiJiS3U9E1x0O/xSrB75x7
 CwmiTi5Y0SXbZdR6WM2kFl5p4tmmQqVbPEwoeD/Ae6d1qLTI1D4iYdzHSQeGaQHOLg2Hi/XyL
 HlG75+yiSOhoZ88v+iiN+FUEObL/q9z5xWGYN/2vU57YZU+AVG3XqzO2rI9a7I/qkcuiI6gpQ
 w3TTDFqMd80if2IaG6Txf8JgC8CCMNK9GbgNZvcA4msiG6D580VU+AuY2HtlS/zQEuRzhfutE
 1aYPMw+aB8alh7N7HE4OwBzyAaCjPP0/XNXNW4b3xkUV9HQhJpHipd3AkgenbxogifExw1OTV
 zmt3Emm/PYIuqxonmgvv6+pcc0h8LjsyOOPWBGhb5k26rhE0GybH36TSkYaKwDxOv4zhqWf6O
 cul4sCiWzkZ3kb40hspUwO32EOSGb9Fz4NtDc/T4MoS85WHhXjTAZkzvvRVNJQNSLUTtpfgNN
 pYAtudM7PkOmS1h8jnFws4zy4yobwRpRRFF704i0URQAZoZwzxaaEkvj2ESCrO8RFpus/TUZX
 37Q/kC0zhsF9x5BeqYlzID/kpQuUa/NjXF5C9/QCvGmLVA/LlIHxrUts3g2InT72Ur/ka8wFd
 guMgOt8A0cHgVKyqJjq6n6RtG5gkZLMxoJ24j1zJ9MHQ6BtRYWO0+IUepEn02BLgJx9LMWu2S
 hm3k4qENh8SDDv5O8ILN/iHVDrGXctKf7jktk4W/PhuwamKd3Pvhooh1t3cVoDwX4IhOQEElS
 ZGy9M2e2YomecOwvnyoObH3p0ShIbdmrzsqAEtuzgD2viDk1AmoyUSlMnUHI7wr8LjDJ4FvpY
 tj22Nw3CX2Qzr3YUxjTD99nZ1vJjJlwqUJLwC6L7x2Nd++NvC4l6VgoT1VUAEw2KAfUFmyXGV
 38ELMJwuT6HKydo7rg81sTlqHakI78YXtKhtl7Mz1466FpCZ+LCcZX8A8ejWZqFmjANYYUnAP
 IdfR6ibAffMgoJ3G0iV7oDTNYGO6LAd/UYTNg5y1GLpI5PsX/mGKCa58NL2AbFA/p5QXdWAKC
 Kpxc8olQsz4pRGlrClLF4wMfKkTXV5TFH/R0+lg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ b/drivers/vfio/vfio_iommu_type1.c
=E2=80=A6
> @@ -2812,11 +2815,10 @@ static int vfio_iommu_type1_dma_rw_chunk
=E2=80=A6
>  	if (!mm)
>  		return -EPERM;
>
> -	if (kthread)
> +	if (kthread && use_mm)

Can another design approach make sense here?

+	bool thread_use_mm =3D ((current->flags & PF_KTHREAD) && !current->mm);
+	if (thread_use_mm)


>  		kthread_use_mm(mm);
=E2=80=A6

Regards,
Markus
