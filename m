Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C06C76199
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 16:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05D12086A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 16:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="TBtr+sFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgBPQGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 11:06:11 -0500
Received: from mout.web.de ([212.227.15.14]:52227 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbgBPQGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 11:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581869161;
        bh=AobHKk3vBm9FrVdMqe66B3ejvK1eiS83jlWFhdT/c70=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TBtr+sFo3loTjlzzWU6woP7mKt8KuLd5ONkSYSIhchvIcCJ+vtrnPuKszWfUW/CKS
         zk6fdy06gGKdzhBDFAhCL15WTNYGfvSeeBi74XIMbJsH5ltVYWpjJksBgh7/vwNAB8
         gxGlIGMIjlisDTUKXgCewb4WbHy1uTO7orVqNMeo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.10] ([95.157.55.156]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mck7d-1ilQ2S1ugz-00HsN2; Sun, 16
 Feb 2020 17:06:01 +0100
Subject: Re: [PATCH v2 2/3] riscv: End kernel region search in setup_bootmem
 earlier
To:     Alex Ghiti <alex@ghiti.fr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <cover.1581767384.git.jan.kiszka@web.de>
 <b11898805c2f9f01b10867a05701aa0fafeaa886.1581767384.git.jan.kiszka@web.de>
 <8f0ddf1f-1ea9-8bde-76a0-ba60788c2a2d@ghiti.fr>
From:   Jan Kiszka <jan.kiszka@web.de>
Message-ID: <f64451c2-48b4-c998-c89f-29b11b371e55@web.de>
Date:   Sun, 16 Feb 2020 17:06:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8f0ddf1f-1ea9-8bde-76a0-ba60788c2a2d@ghiti.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BNUGMNynh2H7lblQTG5gLUjL4r434OMOeK/3yasuqwSBf2uj4M1
 uwFfD1wA3Yb2iql9LqElWiM1YM7EP4WZpOKmQ9j6cZQyi+tuKEF7iIZR2rM2+NGXKQuGBZq
 C6G27L9LMUDiPglE49pHV5C7Tr0XhmpbLJigfrADJyetdgkVhpgh51I2OJxn0Yz9n/+Hzlj
 vcyY6emlVq4y0nMRlJ/aA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oNPKDImTF/Q=:3O7jbyb5rwmIMs1StldLZY
 hKYqBKBPdW+7ZaUWd/MEcybF0rcD3ym//65j7JafDK44leGZERr0pVuq4pZxecggFKYw2onjS
 GnKIYEg3FizrbUi5fLZ+0Hbf1zs3HlUs/RjNfmGdvQUNFLe17lK0FNzoBqXEqjYXzogb1USsQ
 UAdvTIG8e2bIhoJJNNrXRLks0F8EOpQVdmjwy58y/die8O2huI8qpauCquO4kL3U6NEfkKQVK
 rroMUymzW1uarZyPBkXZzzLFO/zREcVMllnVjP/wrnAtj6ADuSTpd8lOyn4kxq6iGtQDiqgGe
 vsdxbegbJ5kYw5lbTWJx4QNesyOWcZLpPC8tNAcom9lAj7iTmaDKPsFd6yX9kKDEgHhEp4/vW
 /clKvFIo4RcGDFJXEnASyj7KftYYALp5LmtumHLuai5isT2T56F7nOlKb7/KyuPyF9SiQilgP
 rKdeRF8IRKjbXD8I5J6zCjrhoSD6P+NSWtEWtcL505CGlruCLma6g3250cq5qPQfmGy75oW//
 poa+w7F3pLdldrAq16Ac3HpZzG6mFXx5NC/T67dtFXQbWTuL34UwuTEF/osrNv4TWSFTYca9x
 6a6km+nQbN4UzcEa4BFe7gaWJj/6OKxlDH/MeTrGORsPZLoVIWWKHIXmVR2UE3mq3AUORZSeN
 eBa+E5dL7EyvdwxZFNNCeh8Lo72e3gILdUcGUhu2M92LalIx8IkKWs6aF7+ujBKWXqEuYZkWl
 EKP6NHnZOiVHv7RG1qyoS+odr9xpMjLyaSAJQNxGipJgVQvTUGHq4yw+n5u6JQFCoa/RFvA8t
 mSnWcNs5LLPAOlKRshgn22AfYt/zG7aIXju+PwzmOvT8rNsXiu64e46qY/LPkjjmTegsua+oX
 w3Xq47ycWPebwmJuLq9McpkwpzjLyxxIMTbmjPTXc0NZVqh+3qofXHSjmjScPqvhRQvp6e0xj
 V2cgFD/c37gg7iFwM5cSMT29IErPRQMKRZsJ2uLkkzlKhNP30nFn+kC7AK6gQrca8weN5bZop
 DbpHN6vdEZPdeqRDETI7xc9VJubqGQPcnJHLMy6PKsEuaxIKn0io0kqRCadX4TDmJreJHLV1I
 6wyE7eKoKsCNyM/J7OIUkNcKQQEFz8MD3t64HYMIZ2ekoy+9FabEwzDiwMrW+UQ64uPGcCYYw
 WY/9TDIxDXosgrBkum64kjKw4S5HxSn/hdrs5ZYw4UV72iikWKmWM4lUsNj94dW+kQ5iol6kl
 XsIBpjbVEa23sgJ0B
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.02.20 15:42, Alex Ghiti wrote:
> Hi Jan,
>
> On 2/15/20 6:49 AM, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> No need to look further when that single region is found.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> =3D2D--
>> =A0 arch/riscv/mm/init.c | 2 ++
>> =A0 1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index aec39a56d6cf..a774547e9021 100644
>> =3D2D-- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -160,6 +160,8 @@ void __init setup_bootmem(void)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (reg->base + mem_size < end)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memblock_remove(reg=
->base + mem_size,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 end - reg->base - mem_size);
>> +
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>> =A0=A0=A0=A0=A0 }
>> =A0=A0=A0=A0=A0 BUG_ON(mem_size =3D3D=3D3D 0);
>> =3D2D-
>> 2.16.4
>>
>>
>
> I was looking at the test above that determines if the current memblock
> contains the kernel:
>
> if (reg->base <=3D vmlinux_end && vmlinux_end <=3D end)
>
> Shouldn't it be:
>
> if (reg->base <=3D vmlinux_start && vmlinux_end <=3D end)
>
> ?

Yes, I think you are right. Would you like to send a patch that fixes this=
?

>
> Otherwise, we can indeed stop as soon as we found the region containing
> the kernel, so feel free to add:
>
> Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>
>

Thanks,
Jan
