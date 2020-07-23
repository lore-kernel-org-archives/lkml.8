Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3666C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 05:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CC1B20714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 05:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="QijmOulG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgGWFTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 01:19:38 -0400
Received: from mout.web.de ([217.72.192.78]:35839 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgGWFTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 01:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595481557;
        bh=ClTsD8Rcw32+nJqII3CCW0/k3+s5opd4aoG3zPy1pqk=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=QijmOulGoQw8EneR8v2g3JImUm4GrjoAqip9x3jMpQmHXlsd0xXTTsRjXFXueUuZq
         C79KjLsX3zVGGdwtq6NB1yBaAsrLT9mN11JGJLDJ9dIWdImCkyUEwa6n+SKGZapaWT
         TU7sxK51GiFWFy43cDdRCh2OaiQuMDnzdTSjNhdE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.132.31]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M0Qkb-1ko5eg3sT7-00uXZu; Thu, 23
 Jul 2020 07:19:16 +0200
To:     Hanjun Guo <guohanjun@huawei.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        =?UTF-8?Q?Felix_K=c3=bchling?= <Felix.Kuehling@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH] drm/amdkfd: Put ACPI table after using it
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <00444eb2-4bf4-bbe2-1727-d2f9eff110e2@web.de>
Date:   Thu, 23 Jul 2020 07:19:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I4XbwMvpiFRlf2ACj9dnzR8XtpooalMyKDMpRO3kfVl+Rv6BPZQ
 u5GA+7t/h0yvSuc8VQC8DRyCUE3jAKs+YXZjxW8fzvbNvWEUVLcH5eIUrpETcDAyxqD6ghE
 H/+g5ryp9kQeh+NhgAX3d6TfZDnqOk74tCe6hyxlhEO6pJVvVweDEzCXlR/K+y0+UemRfDt
 5TxbKXJsWi4PUYpui3rTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZzSa1J/6KTU=:xjua52co1Fhn5I6c/NqSG1
 v7iHaQT3cDbE/4pN7vN/rbe8jRvU7e6w0ZvALogAfCR6txRK95yotxvVwe4yCYnzXMtjMrbEb
 rHrx5sWrDl3/3qUJ8eOK1wP3n4bJ2el593Tj+F33iU2Pv7Ofhhs+Ep5Mv2YQ6qq8HG+Hyusb0
 PUgqHibWAN/M5hWnTa63VdZZKGyrxWkmxL5See0yCloDRe5EAaJWrm4RJ0+Jbv+hkzuj9tX2f
 zcHhpUGgaeyem1/ba8CjCtYx0zv81onh/zWrTgKNrCHQvWtSxvBhRCiynhMVSrZslMoYxbkNm
 DDlZHySNyfRc+6zmldSwrbSz30mgQNwag7I4RQ20gd76xL6b01JnZCW3VZBo/9T1HLTFaI3Gg
 d2Mb1uHeSQgo6aW4bF/VkO2+ym4bTadxyV3h0JP+zWJEE3wHpQx6cCk+xOx7Pr0TFnNmsGaRj
 TZqzPoElwK44zpnbOjjABl7hwiCJknQi60PKs+H01YXqHPDIShUUowwONu/dqlYXjDpZ5E8Vc
 L0ex6FPFEO4kCHcWxlBkOnTopAgIlcwu+maknN71IQVx1F0/DSxKGWibHPMTJsm7cIWrdmgLI
 x5Q0xM3tuzZR0NVCPoYutDwwnyTo98OfBaTlVZcBSr8okuTs5iSu3bNUaUw7qwXdbdcd/52Vf
 p8tF/5zgje6kDH9U8EMogShTFhFC+94TvPYVRO1iSS0rXv2swvyOL+3cRX9bRNxmC2h7q1pnM
 DLVkJlv5cL7NjEkvd+cfVa1tGj0SuFuBAo/slc5pahT/u+qXdkeVEohUxu6W6btTYilipJcvA
 4E7qo5P44Bb1Pr0sfdiYRO5sjRXWEWIsHHCANIkBknKmVyPSC8Q5QFm4mz/eVlV/Hmp8V1UZK
 sYLOXPUZQ5pvSmn4lZuJoNCmgxeOPcQSCcf4h4y2+WJCcVrAlkwMNlF+qZdEuzXwYWalrQusm
 4AQBEu7Rb0nbOSuGRz/DewfbOzXu3dpSBLSvo9vAZu09zBnECh1ZNM8GzKoODZkQhjk7PM7HL
 NNGXgRsPYSWVXlt03LA7JzvhZ43uJs4gTdaWSkTFPF+xSaqEd0izgxFLZT0U9Mov5GtGOc6i3
 qHeKiON7Ohi1O1AnS2lWwke8YGk0kDK7+xttUtm5ym3NiwszQZtaARmj4T7kFsU3vAt2XrETz
 IR7SomnLsFTnUQqv3fT55YEl/Ob0LmeoTadvrlBbYO6iDX/xscixiPx0LQ2WHM1gYKccSncAL
 vBNHAfT097vnunElkDN7Bd9rIVsw79Hom8d3gIw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> and in kfd_create_vcrat_image_cpu(), the acpi_table is only used to
> get the OEM info, so those table mappings need to be release after
=E2=80=A6

1. Please avoid a typo for this change description.

2. An imperative wording can be preferred here, can't it?

3. Will the tag =E2=80=9CFixes=E2=80=9D become helpful for the commit mess=
age?

Regards,
Markus
