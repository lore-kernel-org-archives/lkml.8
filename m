Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDECEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 05:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2EDF20771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 05:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="EK1m3f4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgGVFvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 01:51:07 -0400
Received: from mout.web.de ([212.227.17.11]:37439 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbgGVFvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 01:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595397057;
        bh=3izP8XYHA/yvm0I7CIvqICYR2MaUspjWymZm5rkHWLU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EK1m3f4LcGyzIW47a7ZGQfpbuL+L/Aq0VhYP+W41OQVv2xN6bUwLdhCv+2YsoKLzr
         nhCM9Mcz4ggPLcuDdsNOGhX+M8dA7R4aDqhkIRzggwlg7KFRvWFh9iBRBs1QjkqUdt
         R79sZS3oYluMtHgIBZxR/ECDEJiDzDgieUww2EFg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.82.161]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lhvpu-1kb2zD34FO-00nAIA; Wed, 22
 Jul 2020 07:50:57 +0200
Subject: Re: [PATCH v3 2/3] coccinelle: api: extend memdup_user rule with
 vmemdup_user()
To:     Julia Lawall <julia.lawall@inria.fr>,
        Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <e3d2ffb9-2a47-3d77-0501-9d48845435bd@web.de>
 <alpine.DEB.2.22.394.2007211158310.2487@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0b326e2b-723c-3482-c0ef-5d6592a9c6cb@web.de>
Date:   Wed, 22 Jul 2020 07:50:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2007211158310.2487@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X6M5Z+GHeifdLKxn1U0ULa4+yoQLXcCLD0b6Ltj4pPIOkiYuQ5B
 352zBVeOdEGN7SMazd/nMrFK2ZhC4EhT4ffXzkP+7cjfm2xs/DdqSteUO83Awqi2Ni0ZIno
 Lf7Ix2xf5S2macFMBqRx44/SqirgJaYhR79okFawYgsSlPiygBUDxdjPNnfdOPZljnMprr9
 gPdwMmMtDsjtHqMF4mpEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0glh+mEEE6w=:h5uu7lQgv/qiT+IbjmDzg+
 EC+kwUxwYSY5Bz5vkn2UEfAuP/NGbCflXrOC/rA0sGZUFcplYXkCeVc3j/Nz3bOuV425aq+2i
 HzBsdyKqoaiPetVw8u7Ol1e6liFMEc2iWs35ll+TKt1V77v3GlM3jK2w2rxhOOuIdJ0Rfbor3
 ll4TkpsMpq6ygrFdb8yLpYj/+MciJMyh5S+CoyWpLyQI/S3nh+ZZNhFgPc1KtIg7/8o2DHRVT
 zm7yY+9QXM14kXo26Pch1ttsAL39zSGkpTHh5dAwgNlH0HZu9dsio+dIxUukG6TKpenL1g0/f
 0o+w01iQrJaI9e9hGh/zzvjyMQtLLJq4hMeu6daTbbItveU3Lpw5J+QQ/8dJGwMha4tCMvDEx
 DyPcAoMBRtUjg1cN9aPCAytAKY2EQV3+9hkcZngZWe7k2I6u4lpDYQFP6yk/mYRNdEuwxPUxI
 L2Y6r2T13yHZSc7ZxlTZm22JhMLQbr1NmyqCNLcE/qXSG0QJP4Rpid79MGxtVjwCbcugDAvEA
 Vz21YoITySf0VRtjqOclJ7WZTZ3VSoYQpfq4cWo6Yuu7lI5zuNvbt95QF5hcpLzl5R2pkQebC
 4niD4igbUlZz4EVd2rU+W3TXcfFfL6GhOKseeAJqdRlejx5knFEMO2pLeXMn0DfD0ZvvOAGfj
 /gDADug2IFjM3R99Bt6hJebsHHU3VgX63uGta/CZIvf9/hxlYd9amGCzJh2LeHtOhV0Iaiji+
 0LVyp5Myub2zQ2DFlK2UDop73CJFc+EIxZe5xX5/0P0kE6SyIdd70f44R5Fxv6i1i4HdKwwyG
 Jid2CXW1G9Z6EDXhs5OjwE72Q7iOBfiE6SWaqx09GeiPCSLwMor0xGWzF8VsHkq3yiuglADB5
 PThDiFEFyXmUphQj1Mlrt2VG/HKT7S2kxOc5AgcJD+bX3rwnIf9P35MN95V6qchoCR4hJWuzL
 Mk2w8i1CV4fEBkWOI0lBXNME3QHa0XfpEfTKSUNP/tIHE2lUFjvgjzrpb8Boqtdg+UfCnCgzz
 Yi2ih4NJ0svBUyzbbkeOaF5TQP4ogdDDdth3O1xs2qJHrTdNbsGebB1yoWigqdgwCPboKfNdn
 /b7IR76yA6+2VtZ/7o6QZ1ObaSsCm1xNyruOIbPhX71B338GznxFKaoAbmHWPAS6GZld8BEjw
 QJ/AdOq4/bcL2e/o1Wbd6aBIDlAjkEh7IDPforN3BtSnuMofxeEuZEyTazJR6ehWgQlHvgJPi
 fOtLIdYag1KoU+RW4VbtTkWkUVWe23ZUmyL+//w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> +@depends on patch@
>>> +expression from,to,size;
>>> +identifier l1,l2;
>>> +@@
>>> +
>>> +-  to =3D \(kvmalloc\|kvzalloc\)(size,\(GFP_KERNEL\|GFP_USER\));
>>> ++  to =3D vmemdup_user(from,size);
>>
>> I propose to combine the desired adjustment with the previous SmPL rule
>> by using another disjunction.

How do you think about to check run time characteristics for
the following SmPL script sketches?

A)
@R1@
@@
// Change something

@R2@
@@
// Change another thing


B)
@Replacement_with_disjunction@
@@
(
// R1: Change something
|
// R2: Change another thing
)


>>> +@rv depends on !patch@
>>> +expression from,to,size;
>>> +position p;
>>> +statement S1,S2;
>>> +@@
>>> +
>>> +*  to =3D \(kvmalloc@p\|kvzalloc@p\)(size,\(GFP_KERNEL\|GFP_USER\));
>>> +   if (to=3D=3DNULL || ...) S1
>>> +   if (copy_from_user(to, from, size) !=3D 0)
>>> +   S2
>>
>> * Can it be helpful to omit the SmPL asterisk functionality from
>>   the operation modes =E2=80=9Corg=E2=80=9D and =E2=80=9Creport=E2=80=
=9D?
>>
>> * Should the operation mode =E2=80=9Ccontext=E2=80=9D work without an e=
xtra position metavariable?
>
> This is fine as is in all three aspects.

Is every technique from the Coccinelle software required for
each operation mode in such data processing approaches?

Regards,
Markus
