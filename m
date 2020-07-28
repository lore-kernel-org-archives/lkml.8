Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BABC433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 685AD206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="JMG0GNhq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbgG1Ou3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 10:50:29 -0400
Received: from mout.web.de ([212.227.15.4]:51971 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730335AbgG1OuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 10:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595947809;
        bh=Z3Hak45Jy5qRqJuyduAoDInGrdWB/KFGrw09UzXKMU0=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=JMG0GNhqsF2fYLpn7G1t8GfqiSxpgSKcv2zyp3VMQPaW4FLKvXIUMAxHvcG5avH7R
         ukGabFolVS62YVpHCKaJ5nH27oDSm4mtzPG3dyQfdDDRgf0t4mxliX3CbJZM55YCm9
         zwooVmRhzQPfzuSBNOuHEy6C6fEI8JVh4ysm9viQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.153.150]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiMAE-1kfntf2XTS-00fUxd; Tue, 28
 Jul 2020 16:50:09 +0200
To:     Qinglang Miao <miaoqinglang@huawei.com>,
        linux-m68k@lists.linux-m68k.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] m68k/amiga: Add missing platform_device_unregister() call
 in amiga_init_devices()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1e12105b-aa72-11a2-74f6-c789f8ceaaa3@web.de>
Date:   Tue, 28 Jul 2020 16:50:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c2id3vlAmACwXpzsKMA+ojVKSnbY+G7P2AKC98o7Mc6NqwdwSpQ
 ODY3KgoCxm2K1s+/IdclDkweqUN5I52dDnONRidfGxWIGmnfVSJu3b0Oy5nFk4R+nKJSmWc
 Y9rIzvAf626u0p4/tISrdKC5J4lwbwHUsyShLYYYgLdMcVq6nRBUo8SU/q3bF7VaIErBXKb
 QNMzNNwW9AL/0aALCTjOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cC8XwfV2OFQ=:HnPEZeYKPhGd5Jpk4pL5Bd
 NGW5IiWireeyc80IoTMcHmPJVvSvvt9Emum9BYPBIovuU5dUGspPoRz14c8ng3nnODKakHqOx
 xX1BDHIRtJS0UIZwv3nmwErJm6QljWyCR8MpNNo2P1hLQ2dEyhwmp+9XZUQ8fti+Mq5LADWUv
 GRrHLLW2ojLJqsihtU0mzkVWgyCcyjQkAniHr1GDIAFR/lFZqtJFg4YL1r2ejTQLWx2kVQ/PP
 eA8HobmRwfz23X3JJqyzkFwhJKRqADjpuuqkKMfpDkbwv7U30TPwfNWCxK+4hHr4eKg9RCtQG
 vknrPTkrV6oe2+0XM7oJgu4kyo47mVxCUmAIsCLWLpVfEiilpmYXsWzQhEk7LhrcKFv+NW7FE
 Tx0EmwfZNntcg/ePTvTyhwCNlquIbVcDuAWiHGnnFS8uxpjCjAGD2+cgOHJf8ynZAfNT++K9M
 Aon44kN4USJfjs+lYt5kiaDU4Yxzl8efspswIcOPG2om7M/Fk8nsT2ktCJbBwP2U/HT4/dA0h
 WUPJp83KYWwClF7V3c+112ov6m0z8yKSk/WtVV3uItDOgbq3RoUCWPr55hHjdIKuzgiOdUVbd
 BJBJbZVXSVM9zTrTmOFYkrsHAwKCZTEDD/puNSoc9p+vdEiPMiIgLO6zG9CYu0nSv9I60YfXz
 T4KIE9S+gKmzObZoZxFoFAHuQcSiUTgZenAH/xTvVSAMI8SfCQshKSjnJhU9/Jz54SPW4N19Z
 +gBqGKz2o3NBHgs9qxtHaMPtJPmzH4M4FT49edeUNvzwbLhuiNLmxHM1JQAtPvmjJ+2iEM4Ay
 K2Qks+mbTMREfZCoyD30FIKsDEl9JlfMq+AWcbYjRf3LgRFUipvGjsU5qarWz7dNvdpdU8VPN
 DAmx5KM5sRN1DKSWsORuoEfK6+C5eIjFYbfzVYp9IHKTmMtJfe4Fi679S/mINSrXJJElDATRn
 LivunoP7w6SYPqd0vunokfK9hVIHvFemAJPHz45TRER9u//S50+bgJSSqGApRWDRMgUYtQyIc
 dNR144qPgk66a3EwNcVutPp0NAqfYp/A9igEL9WlZmjPfMfHOgcroK4Iqbuw0PFWjImHu7F63
 kbSy05siJwYml7Paa3Y+vAbtb5vdTCK53HERVM1/rkt/CgWSlQXGcGWiGjiCG46t8xMG3VlWA
 HE8e5U9m1XOCUurD+c8rs2/jiefltN33P/QoVbM6GKraAeIFqDh+JhkgzwmHy+5C7UTjHB/pN
 L5dtcRkQ/7aRLtUgas+mWIGLRE7E+KbRdUvlx9A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Add the missing platform_device_unregister() before return
> from amiga_init_devices() in the error handling case.

Will the tag =E2=80=9CFixes=E2=80=9D become helpful for the commit message=
?


=E2=80=A6
> +++ b/arch/m68k/amiga/platform.c
> @@ -188,8 +188,10 @@  static int __init amiga_init_devices(void)
>  			return PTR_ERR(pdev);
>  		error =3D platform_device_add_data(pdev, &a1200_ide_pdata,
>  						 sizeof(a1200_ide_pdata));
> -		if (error)
> +		if (error) {
> +			platform_device_unregister(pdev);
>  			return error;
> +		}
>  	}
=E2=80=A6

I suggest to add a jump target for the desired exception handling.

 		if (error)
+			goto unregister_device;


Regards,
Markus
