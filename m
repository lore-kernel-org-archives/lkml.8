Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA85EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79EF4206F5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="aEcItKWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgGMTvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:51:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51395 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgGMTvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 15:51:55 -0400
Received: from [IPv6:2601:646:8600:3281:dcc1:f8b3:2766:5f92] ([IPv6:2601:646:8600:3281:dcc1:f8b3:2766:5f92])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 06DJpdJE1976736
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 13 Jul 2020 12:51:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 06DJpdJE1976736
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020062301; t=1594669902;
        bh=xsbJbZCdYxgAVLE9/erfYMtoi9stuou0k1pR0NinwvU=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=aEcItKWwPyhV0FS1rLyTeoj17iXzSEJsBZReuYGCs9al2tqbKSm+GMoKIwSXdm94Y
         U3Bt5JO+5j7sG6/c8CS/uw18vK43k0z8iFs+nD7gnhutfLMXd0aAYiiMQN2tLXzEzC
         /CoahDO5+K1/8rUTf0ys4gtSpNFvwlESNe7Fyx/sZ9IQhQoRZMxdgfCf4vECfjwfxn
         BvZrDAgQimYCfMeT6+L45rmV79C2lARAqGYWu/cNUjMM9RcDIuhdgMiOpzPYO75avT
         9otjsvoASBbOH2BR99Wh1h+E/jpTOVsLMdRyPo0uK4FESZYaDvhMuFjKt07A7KsqNt
         55ym9cR+HAlMQ==
Date:   Mon, 13 Jul 2020 12:51:30 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <6a73bb96-1390-ecca-2429-12b71e2aefc2@redhat.com>
References: <20200712125952.8809-1-trix@redhat.com> <639c8ef5-2755-7172-fbb8-ce45c8637feb@zytor.com> <9af191c2-0f2c-7637-433a-b557a07590ca@redhat.com> <EE11D4F0-8DA4-4030-800E-516423293987@zytor.com> <6a73bb96-1390-ecca-2429-12b71e2aefc2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] decompress_bunzip2: fix sizeof type in start_bunzip
To:     Tom Rix <trix@redhat.com>, alain@knaff.lu
CC:     linux-kernel@vger.kernel.org
From:   hpa@zytor.com
Message-ID: <D21C36E5-964B-4492-8104-3F56559D30FD@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 13, 2020 12:27:02 PM PDT, Tom Rix <trix@redhat=2Ecom> wrote:
>
>On 7/12/20 3:21 PM, hpa@zytor=2Ecom wrote:
>> On July 12, 2020 8:12:43 AM PDT, Tom Rix <trix@redhat=2Ecom> wrote:
>>> On 7/12/20 6:09 AM, H=2E Peter Anvin wrote:
>>>> On 2020-07-12 05:59, trix@redhat=2Ecom wrote:
>>>>> From: Tom Rix <trix@redhat=2Ecom>
>>>>>
>>>>> clang static analysis flags this error
>>>>>
>>>>> lib/decompress_bunzip2=2Ec:671:13: warning: Result of 'malloc' is
>>> converted
>>>>>   to a pointer of type 'unsigned int', which is incompatible with
>>> sizeof
>>>>>   operand type 'int' [unix=2EMallocSizeof]
>>>>>         bd->dbuf =3D large_malloc(bd->dbufSize * sizeof(int));
>>>>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>
>>>>> Reviewing the bunzip_data structure, the element dbuf is type
>>>>>
>>>>> 	/* Intermediate buffer and its size (in bytes) */
>>>>> 	unsigned int *dbuf, dbufSize;
>>>>>
>>>>> So change the type in sizeof to 'unsigned int'
>>>>>
>>>> You must be kidding=2E
>>>>
>>>> If you want to change it, change it to sizeof(bd->dbuf) instead,
>but
>>> this flag
>>>> is at least in my opinion a total joke=2E For sizeof(int) !=3D
>>> sizeof(unsigned
>>>> int) is beyond bizarre, no matter how stupid the platform=2E
>>> Using the actual type is more correct that using a type of the same
>>> size=2E
>>>
>>> trix
>>>
>>>> 	-hpa
>>>>
>> "More correct?" All it is is more verbose=2E
>>
>> Using the sizeof of the actual object at least adds some actual
>safety=2E
>
>Sorry, I am being pedantic, I mean anything that produces the correct
>assembly is correct=2E But there are different path to being correct=2E=
=C2=A0
>The path I was suggesting to follow the type of the element/final
>pointer when allocating an memory=2E
>
>large_malloc(bd->dbufSize * sizeof(*bd->dbuf)) would also work
>
>I will respin=2E
>
>trix

This isn't Linux style, but in the NASM source I have been migrating to ma=
cros:

nasm_new(ptr);
nasm_newn(ptr,n);

=2E=2E=2E using sizeof() in exactly this manner=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
