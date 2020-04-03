Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EBCC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA97C208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="D9FzOY9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388680AbgDCHBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:01:44 -0400
Received: from mout.web.de ([217.72.192.78]:46685 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730759AbgDCHBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 03:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585897268;
        bh=EkV2SM14PkS2hH7V11heDo3fj9DuvpM/R4jaqXFljrg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=D9FzOY9AF0+AbIWnOYrgGijKr17JTsYJGIVBqrxKGkLKafqaUXIjW4TmZ4TKg1LRX
         +52J+WZkfuk+Gd8ThqMM+7EBs9qhTLclZUpO/vLooTV3ULxmecQ/pYmkmy4TIUwIbt
         8Ie4yO6e8l8kGFr8jwjZ+i+Sej5PebC4k8nPH5Mg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.25.116]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M4ZPc-1j7vZI1YM8-00ykb1; Fri, 03
 Apr 2020 09:01:08 +0200
Subject: Re: [PATCH v2] ARM: zx: Delete duplicate error message in
 zx296702_pd_probe()
To:     Tang Bin <tangbin@cmss.chinamobile.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Jun Nie <jun.nie@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>
References: <20200403013541.20904-1-tangbin@cmss.chinamobile.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <cc86a4d1-ab0c-f820-79f0-50604e42b4d7@web.de>
Date:   Fri, 3 Apr 2020 09:00:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200403013541.20904-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nJ+YRSw1ed2LHI/C4P88llob8EijjSn4+UvXigEIPHrVui05bMv
 o6PaXknS11NLLIIlkjI0Thff3VnvyEp5r+ikiorsOzU8AdNVFow/jv3f/xtdIRpypuiYsBs
 J36+lUdyJm+uAKHLM8bonMR5d2SrBlVFCoWTzddAusnpCvChuu3VYtU3pCiW1fE2pszDw1Q
 LN/PHkF3X53GP+h/+godw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j96MO/R3ojU=:xsd4H2t+Lo6eROsmJNFsHI
 ZXuOu7GdsTeqOj8CN0182Gxhc0RsoRB6zULTKWYot8fri4q15PTjombo+KSSERB1ZF+buuaKZ
 DxObddH0dxprawyzzYgiTIDsqP0FqH7W/5ej78+gAKZl8TxGQDTcsZoLFZNoH6K8NPbjrb1rF
 sDCsIoS58PE6u4D0/GeYVf1YPyboqYhHd2Ie9WjuT0Ij6sR4uOdfeRE3+r6rzC1dKLedyB7r9
 vXxndRuT7PXvwn4dTaVZo41lDzLeV8XRmWa9h+1bfOhiexb0YciN7DOfQbk4b0WLHJWTwGhk9
 g345y/TE8lpXEPieJ6sI/kJsezElqF3DWpabOQXBhrifI7f2u69OyP6lgSbT/8/kQzl1TtdN1
 pxa8D0UGafaU2pl9783EhI1GO6xg4jxyrd0kQ5tB5uWeilKS0a2rCwk9T0vQeqijYiUiDtpa4
 ktoqctZLRiNUUIJwkGj2cA9ygkHFq1La3AhlC8rWrVkyWnPiy6GHG1JYTCeZ3YYhS83ySsQ5W
 t7kR0Nbio7EQXrvloE7HJqedKcBc1JRMs9teWZvjTG0rRSaIbcBlOwKosBuZvVpWZ97jbMvFy
 I8sf1RADdaLInhRn5kOl+YqsKE8pSbQ6w30GNmrCtDlKttXLIovTBu+1bzGNv/OouYuz9qDG0
 mg7crkGI8NMhR67LBRlbM/0rQxAYpB+0F4E5BI0ET5m6mz5VGDiq+2saV2w/Hv2lWUTH479AU
 1tgWdb8JSAkYQ1nVzAfMxNcUovMjfGUx/eslinan+6N7K2Ud9W6Y2TJhx6s6hnzOC9m3t8bGc
 xHDg2MRTjH6AvZURUnrPYF032iFr6I0l2ZalJUdoqIO7kF14vWPAiwq26K8BseO42LcT8nAUk
 JDJJ4BhtfTPGJwXQhDbf4E3TS645KwskKs/6X6W81XmbZ2esF/M7fDxWkQeAL/2Ugsbiut/ro
 tl3J03Np7HYlAfbsR8uxJCppYOUUCdmXlYRPGle3ZEtjaDRxdTh3L/Ym7WJkVexHtyVSV+sIl
 IjkMCRyL+7GjRdkknszFtwZCjxKYoWrAtjURi5xKCj+ge16iMPfi5I1Sx0sNyvLQPVBAT+pYF
 Ll9aeb7gippnrodXo2IJ/Kb1+MvaPdI1HusRPxkpeuf2/yUakK98am429Iqc5jhf3toXrjOdV
 lHdOAQQB5rg1EcXlwEIgQWnFotlWzON9EI2kNo6R0gV7lJEnO/dS/jxfhHEfFM9bQBLnSdSOT
 FdfV58KQq+fy8jO0G
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In this place,devm_ioremap_resource() has already contains error
> message, so delete the duplicate dev_err message.

Please fix such a commit message.

* I find an other wording more appropriate.

* It seems that you stumble on challenges to add space characters
  (after double colons or commas).

* This is another attempt for the previous update suggestion
  =E2=80=9CARM:mach-zx=EF=BC=9Aremove duplicate debug message=E2=80=9D.
  https://lore.kernel.org/patchwork/patch/1203764/
  https://lore.kernel.org/linux-arm-kernel/20200303031725.14560-1-tangbin@=
cmss.chinamobile.com/


> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

I find this tag interesting in a specific way.
Will the use of your real name trigger any more consequences also
on other patches?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3Dbef7b2a7be28638770972ab270=
9adf11d601c11a#n458


How do you think about to change any more source files
in a systematic way?

Regards,
Markus
