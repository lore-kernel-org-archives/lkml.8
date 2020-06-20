Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C51C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 12:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D6E923A69
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 12:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="liqNX3vs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgFTM5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 08:57:05 -0400
Received: from mout.web.de ([212.227.15.14]:53021 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728127AbgFTM47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 08:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592657807;
        bh=ypxhGWOAU0x47edkgXOGRtJjGgNSKxoy9ckaT3hv3bQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=liqNX3vsW6V+2jwh0SjfGLYRVnHO5z7lieVqJROiAaJwLkmG2Qv956evJbEH8CDlF
         IXZx8rJFMTPUYgbsGDJfz6Ef3vmdPFf3GCw3dmvudRP4xDnb+9KtblUnBC8ZuQ2yIt
         qwW0xz+4QSkSNsw89vPqWWysXjU8QSDXUMlnkfRI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.139.185]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mrwrx-1j8OE61yib-00o0QC; Sat, 20
 Jun 2020 14:56:47 +0200
Subject: Re: [PATCH v2] drm/amdkfd: Fix memory leaks according to error
 branches
To:     Julia Lawall <julia.lawall@inria.fr>,
        Bernard Zhao <bernard@vivo.com>, opensource.kernel@vivo.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        =?UTF-8?Q?Felix_K=c3=bchling?= <Felix.Kuehling@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
References: <0e76e678-94b1-8f69-d52c-2b67608d5ef8@web.de>
 <alpine.DEB.2.22.394.2006201126130.2918@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8527c6b5-c3ed-340d-4ba0-6396d6cc5da2@web.de>
Date:   Sat, 20 Jun 2020 14:56:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2006201126130.2918@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oP/ITVu7Ur7FRnqxphsFlkED4ONhpXaAiJsEuKf9/0MgSVrW+y4
 kr5hR6VqA5ilXfaiZeFoCQG21Bh2egYUEI70MpkvV5i18PMvkCBjoTYgCrVrwVzWrLH+uj0
 SdJw/jjUlxxxeAkVVWIQgdY+3RKmJ1Qnbcv6RwEFxEhP/egG9Yt13hAoi/4KEDJcVAOgS+k
 o+iLN2RMr3faFOtWDmUng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jh3yB5aGkpw=:+v9f+1BB+3Sm2Ymjgxa9zS
 lj8fsxCEIncQ+bgNyRhnkReXmvU1fhLGWNdinP+7VTNY/t+QO6VSOx8KMumxhNjyEysMEOL27
 gLJkTCmp1h0Nwfj4DX+O902bH9BGjHufO7m+ZhQi8Xk+FJR6oEB2AjmDV7s89aHCagy0MmNlD
 YpsSEXn1ehnKMI0x0Hk0Ge5LVS5yXkYPQ/5gXBBIrax6qkch9+w5JXdgJDAu+nP8q2+fq2MOJ
 pcXXI/llj0WAzCOkv2XOyV06ai/A7SnVnPCjEyWFB9+07i13tn+0CIpLxZRPG/zh82BnkSLwH
 V1eAzTKCdYY9B9vL1rKviC5p9sjR2AKKWGYVLgW4AULk0gSHnKH9VU3uyRj2lvbt8fHbhDWrY
 WCuxYTbLBCK8pZ2crpeuxiO/2jCziFOYc9kJtjLqCxB35j+7L8hCMTwHnI0AuoKOHQHVmtNOa
 MjEcPB4V+9JZmWH2DUaV8q6Xx2kGHTyvg3O1zI0+4LBKDczbia4g7XmRO3LMSIjjHPX0ZuwnD
 ETDPWZUQYHLw4Xqm5eW+EF0FmWNDMXixUmNi41729acgzXfI3AO23pbmSUMSfAwZsHGywZ93R
 QxveplmbHvIWTJn3qlP2rHuh8sLNrkSQd8gyDZqXApPVmbTogyE3OFijYmKQnzt2aHTBlJGUP
 1Q3XNnuY+v8B797WuruUPgvIIWnG4A8IT11QpGfGt4QucXFwLXcwqpDSX8BabA34pVD47Rugh
 NVdTk4rIE+2o3SQUj2AlDSrbPXAwKapnCVAtCK5gpnnmAP3P/LFZ/4gz+mgh0M/YT/NDtZS/j
 LevJr4XPgUT4DDyFz3aV01gr4mMwBwRM30swmoUuES1dg1Zb8F3keaBRnO9Z58EYwT5iOVpmC
 LEIqZ8BX8PFrQ29lYzWcvWEewcmabXe1aRdk3t99IeCwcgVhfxris6NeXSBsI11GkGI70HoDg
 qQHijnze4DSk7cm3Is0hoMxIUmEdkLCq6M/r+jvlkKR4vum/RLxHTDDfDlIf1vXpa4k+reC2g
 xOSe5JjDhvDi5hEGiOy93+/PyJARlVYmio964Vaso6PekB4ff2SyOsNQuxSGzecRJZg9BifUv
 Lu417UKmg7KoCbQTE5tcPARp495PNfEIluY121lKp2REF2V4nOCV6xtXAppPHsvoizXBzxFOC
 qBJ0hgmiiJ4/HB9NuMiGJwsZksfn515rP2JK/D/KsBow0t6sRGqDmZsOC/abYXLwVmDAu0HDA
 PzyMN9hCOhM6fZFnu
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I suggest to improve this change description.
>>
>> * Can an other wording variant be nicer?
>
> Markus's suggestion is as usual extremely imprecise.

I pointed a general possibility out. I did not propose an exact wording
alternative as it happened for other patches.


> However, I also find the message quite unclear.

I find this response interesting.


> It would be good to always use English words.

I am curious how this review will evolve further with such information
also after the third patch version.
https://lore.kernel.org/lkml/20200620091152.11206-1-bernard@vivo.com/
https://lore.kernel.org/patchwork/patch/1260303/

Regards,
Markus
