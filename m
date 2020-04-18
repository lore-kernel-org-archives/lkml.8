Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913EDC352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 18:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6660120724
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 18:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="oaBNuP9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgDRSS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 14:18:27 -0400
Received: from mout.web.de ([212.227.15.4]:58459 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgDRSS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 14:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587233889;
        bh=vH4kv+zAOYriDerXBYuJyXeMG/UMWETZBnRPa4scLRs=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=oaBNuP9frWGacySfLZNpUqjr5UZmHBhNburufDBa5fg20ANoQ/2h9oXbhZdnLP67k
         zsvbtXoNyWql1rabiwFxuq5Jc/34UfhPy6ENyFSXhJjpWCV6c2YMyWkouWOK5UkFqu
         qi+TgckNdltsGIlZ/vOCSI9IZ3QJzytCi2oNz3qs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.116.87]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MVLY6-1jkCyd2afG-00Yka0; Sat, 18
 Apr 2020 20:18:09 +0200
To:     Bernard Zhao <bernard@vivo.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?Q?Felix_K=c3=bchling?= <Felix.Kuehling@amd.com>,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
        Chunming Zhou <David1.Zhou@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH] drm/amdgpu: Remove an unnecessary condition check in
 reserve_bo_and_cond_vms()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3dedf704-896c-b1c1-2609-066522f89274@web.de>
Date:   Sat, 18 Apr 2020 20:18:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c4XtGVphCtLiCSGmpuQDxk4y/D81bApdqWv+ZW8Y/LlrUM+XmPd
 95/v+QUGHvmYD+n3C4o1/usl2rO1M1ySaNXMqTg8ixgm19fh16KhJMPtYdJQugMYlD4x73t
 M9kQE0dWa6WsOqQ9sRJkCdYM9wsLJ/qzzxCIsS8LvCXSwOBPc7X2MKc/4WNP6RQBkCp/YWI
 +Jn1HiKwA5jCauB+S/9Zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yOqBPuac5Fs=:6haPW986vUtYVkbTK8C0Fz
 5e9sk1ey8c5MdRWiCOmQFos8SL2csFQ/w1G5R7bcwWF04/Sx4QgUpgJlGVmUWc7mMWl4A2nA2
 Xgu7lrS+6jph0qOmCT4OrifTNSp1b8rCzQ9FxaztpZ6otpORLP9WLahzvZ6g4z4ycgogp0JyL
 xOYTHNaqbzZOxfjR0n0IvV6LBVI3U2VxZsL8mUY5xHqTTPQ2UKLsIdD7/K3VwfbkRPTDMMExE
 Bx0PyUOSWpsFGK/+Aca2wYp/iT8IUWMy5hdylOarbZaWJkjYQQGO4a7LUQ9Z/fffBG1HM4Saa
 I+izIOA6KexflLcv98ipkLD/y6TUoTv1BvSzef2p75GXsIAPMvMX+FnYwy4Csiil4fBx1jm+L
 dTjZlCpcD4CzxoatVIdSRbQrbufhDtONRPSiNYlm3p8+exAiwNvQxoTEAYBjDSOf5z6qF1cfx
 MY8fEoVeCEkIjnZFDVH00TjM6kfupeZs2nRYGUKuyYOHcIk8kM4OyjFop60gV7n6IOakGrcKw
 RSwoX0DM/v7+8H61EXNm+mA7hTMYi+YiswOrzSelZWhuRPFBygvvijVJFhe99TshI8NbOt+Gp
 TfEF+RrAUc31uwpRbk95DE/92D5jv6OHzNJnhaxkdlgtAKW+S9Nl+GqzO0tquM7ovN5qZuVl0
 EYKufsccgTuWOwOEMlE6KKgCqXGYKBpjlITXwdqxogljQKrQQMLhcvwNQIR/51ehUTNsZiuFa
 Ibw3OjUtFJFLc32D5ZZepLItq0HNMCTOV2Crp7khuyvSttzbb8eOCfPdoilUMvn3aZp8CcArd
 AbZA9EkT3G360gfdOzeuVWFqRLesDtyvohutRRG5gqIpBiYFbqtwD8G2PhS6ZoyZs0wXZGofj
 7iXJkFkqsC6p1g2oShZR1Nv1o0x2R+gWdTWqQDrSVpICC0Oqhi6MQK33el6Dyj0S3+EOa919u
 QHqTGVUjdwewNE8wg0aPHhBHrKnMMWnY0CROoboUT3ojace/eaAVEoM4dlqWQp018NYP8+s1k
 kIcmN3iRSFUdEiSCNoiXmZVsmkaRWtOOxhmD64+KZLz799jra/oaRVJWbCCZDmfNYlyO6+4J2
 X1FAAfdgfNLrO7jQaGkjbdSaPbV/6RaizjfjYcw+wQIKDE+D/DfV67fkiMknICDD7LknnGKnL
 4/RzcCwxRn4nv+Rz1UO+qGwyyBfzcDc10wp2FPOv+TsKqbkFBxYFASc462Vh63S/bNKI28AbK
 xkiMhOz1av26Ytotu
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> There is no need to if check again,

Thanks for this information.

* Should the function name be mentioned in this change description?

* Would you like to adjust the patch subject?


> maybe we could merge into the above else branch.

I suggest to reconsider this wording.


=E2=80=A6
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -735,10 +735,8 @@ static int reserve_bo_and_cond_vms(struct kgd_mem *=
mem,
=E2=80=A6

I propose to take further coding style aspects into account.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?id=3D90280eaa88ac1a9140dc759941123530=
d5545bb6#n191

Possible refactoring:
	if (ret) {
		pr_err(=E2=80=A6);
		=E2=80=A6
	} else {
		ctx->reserved =3D true;
	}


How do you think about to add the tag =E2=80=9CFixes=E2=80=9D?

Regards,
Markus
