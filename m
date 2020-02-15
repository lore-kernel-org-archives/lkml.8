Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6931EC4741C
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 14:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447722086A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 14:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="DPrn0GIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgBOO1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 09:27:11 -0500
Received: from mout.web.de ([212.227.15.3]:50529 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgBOO1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 09:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581776620;
        bh=+IsS2bFBZiIpX31dAAhhhaGIroM/ypljk2P1XOPGPYI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DPrn0GIxjtuEzcJ0799clUcaCqcY8ig/WiPGbC7V9sICZ8TSgacuRJ6OZ3edSJg5n
         VoO71BRcNDu/BzBdWzTj6V4BhaIZQlu9GqxNHkd5m49VzO9RfqXzQsZ4hm4sXQ4vDI
         ggWqKn14fDhChtS2QSAwBVKjCKGYdz1ibInuF8CQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [167.87.37.157] ([95.157.55.156]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MTuQz-1itnOE30Ur-00QiAG; Sat, 15
 Feb 2020 15:23:39 +0100
Subject: Re: [PATCH v2 1/3] riscv: Add support for mem=
To:     Nikolay Borisov <nborisov@suse.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <cover.1581767384.git.jan.kiszka@web.de>
 <617f75f4eaacb02cd9d0a7044434e3e9b65e9e8b.1581767384.git.jan.kiszka@web.de>
 <24bf6fae-27f4-dbdc-fcc5-6c3b65733ae6@suse.com>
From:   Jan Kiszka <jan.kiszka@web.de>
Message-ID: <0848ebec-3283-bb78-ace4-fd15360b41fe@web.de>
Date:   Sat, 15 Feb 2020 15:23:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <24bf6fae-27f4-dbdc-fcc5-6c3b65733ae6@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fpm+FTunoennvKmEhkKqsmWdYkI9FYpf+Rt9Y43H5GVqEoVLTof
 dD4zMclz6SGsLhdvpnBVCl7Mh1Sqb4W9bmFSxi1CAUv/blKfXteB3Jp5B8cD2Y4MpvO5waG
 PTU4LWo7AoFvWSoQy/qYM10rzCVJzW/s21ABSPalow+IA/i3YEXmH5a0nUue7DOAnrCe8ky
 f7xHEA6yOGhrmP8p86rWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:32RsqgmBv5U=:ZN1deSqh2tESCvEIZnshLz
 GPMF7mx23OAZQ72p6gfmSGdG1WEDMQOSd1x2bHDJUIKjeOVsJsbaf1Ja70cqk0hbUEz4hGruY
 gedS/cSuyWnEgKgAVIs3W1Pf3afdcx0lwrGTRP2hk5P7teeQoBwLZ3KuOQUM4ZyzePCokvdPJ
 Hp+L/xTia1Okk9LsVOvgzs6tAhVvYcHhifDKEP/SN3fUf/d/acCu/bSTckuFzNvgRVtnMdOs8
 wL7vHRq9G8Q/8zGKXs2MGcLUpC+yFQY+ZHDFXnsrkWpAuVqF7669Q6egV53iM09oOfLWMjVtw
 T1nV4TMwJnpGHbjuyhfWYiPaJU0m0ZdqJNsqEPJnk96AG2A4IYdsqur09/+ckeKUjTjsMu/ZQ
 g6omVa7tAP0GgjdVvnC/gr1izyyXlXN9u/DcW0tnEippE3WweXqL4sBn1GVhoAWOVSaHspH9K
 9Nt7YUR8RpRaOOpUEU5WUFoW3d48WRGcegg3GmGIQbivpgaJM0DUTY/sTBB+XGVukV6p7mZqY
 zDWolbukJIY02phLOZxoHe6dfo5o9TmXC3IXb+Tu+PSjTsNCVJBZuZxC8jJvDDFxYzz7A0rKi
 8lKG30uftTmbvHBXpk51g71HzhOjXLQn6ASHxQJjAckON947J0M9O7pi4GjGrM+tRV7kzjDSZ
 e8GffjkLuUgQAtWfg1FFJnpMoekhGqdSohg4LnFhzqdyZP6z+VD7oHHHvRU/d4fvUKHWp4D6a
 kkWyCvv9Jx5c+DyBTfuk4Wk1rFwTH5lLoJJKwA1LiinihZbD0UuzbbW8ChZNv/x1afJ3OqcOb
 jVn9vMjPBQYlCRnMiPm+YXWK8MkLNl/gJ/uhLRTa1aq9DjqjNfHD0LH/3JhSVTFqeZ9IoKg+R
 Rwz6OGS3vvkNPNC4xEvQzXy1cSWz6UOrhJ98538dya919SLIJFk7Zp5+W+t8Vl0wHvxr8yfVu
 NrX6Qbzho1GrSvYT2Gnd34R8hb0aG6m4xsTx0HFyMtM1PbohEYYB3/oKomMaOy8WsdzVRIGbo
 DAVVXwaSX8LyRg7SgP1fjz5ZHUYvXFnjgUk9UYPWYCqY3FEOG/L9KQcEcfiyGM9hgi2bns+pd
 nqjwzyLsAUqCcemCzJlwZrn3m+T6si2Pjpea3sXu2Dx2J2eA9gK2RKLTXEQ1QR8A0VXPaPVPE
 zJVkBcOy67ImkClaiVZchqv2m6v9YaFuZa0BN9A+C+JIdsIj26W0wZfMIgTovIDN4jEXckEG6
 VhDtCGchvT5f3ynHH
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.02.20 14:44, Nikolay Borisov wrote:
>
>
> On 15.02.20 =D0=B3. 13:49 =D1=87., Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This sets a memory limit provided via mem=3D3D on the command line,
>> analogously to many other architectures.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> =3D2D--
>>   arch/riscv/mm/init.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 965a8cf4829c..aec39a56d6cf 100644
>> =3D2D-- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -118,6 +118,23 @@ static void __init setup_initrd(void)
>>   }
>>   #endif /* CONFIG_BLK_DEV_INITRD */
>>
>> +static phys_addr_t memory_limit =3D3D PHYS_ADDR_MAX;
>
> 3d is the ascii code for =3D, meaning your client is somehow br0ken?

The client is called git send-email, and I just checked what was passed
to it - all fine. It must be my beloved freemail provider that enables
quoted-printable encoding for this series (interestingly not for another
one I sent to a different community today). I've resent the same patch
files to both corporate and private providers, and only the latter shows
this behavior. Sigh.

IIRC, git am processes this correctly, but I can resent via the
corporate server as well, whatever is preferred.

Thanks,
Jan
