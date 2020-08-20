Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D55EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D95F920758
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VVD/MtAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgHTSBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:01:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:53201 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgHTSBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 14:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597946441;
        bh=OPEfw4YAAOZGBIcpHG2Oi4zU/Ust7YbtLhhZf2Gk7Jo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VVD/MtAB52OfPG/oYT2o7xhj+OsDuiiAe/mBFCzE7E8ckjpryuVA080HB0Kj6uIaQ
         M8t0fpcwYvVu1Vd2c2UTPbCCVSOW16h1i2SSzZXCKfMaRgVB2Cn3e19FK0qg4L40Dq
         SeZAuzGvO23qVg6mJWdpE2RKVEPb15kE8I5Pwf1M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from obelix.fritz.box ([46.142.24.146]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4s0t-1k7Rp00Om7-001yJp; Thu, 20
 Aug 2020 20:00:41 +0200
Subject: Re: BUG with 5.8.x and make xconfig
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <ab0cfaed-50bb-5b29-cb93-a2987c384af1@gmx.de>
 <CAK7LNASZ_sHPjDLd7+LTc0Sj9K+W51zoRq-=r-0_5AJC06jaEg@mail.gmail.com>
 <862c22df-9f9b-67b3-2b98-9109f26aaac8@gmx.de>
 <CAK7LNAQ3ZfuJTbJin8D7ksU0PxyUcLonuywMUAeAXj+h5xzifw@mail.gmail.com>
From:   Ronald Warsow <rwarsow@gmx.de>
Message-ID: <dd1d2d44-be64-552b-0727-c39f8999fb7a@gmx.de>
Date:   Thu, 20 Aug 2020 20:00:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQ3ZfuJTbJin8D7ksU0PxyUcLonuywMUAeAXj+h5xzifw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vw2KotrhePbBYIduQBrsHkf8Y+Ddf0f9X3oZdy9It0DmmLxF/om
 xn3uz61IfEdU6dCL8Dt9G99pqv00WEZGfKC/u4PWkDnNYpSkAyNnDnYU7Hb8vQAcfWqdedl
 uYRH3GLQyeM+aQtOajXVExLmfC7f+MANAbKgaU3Tyi/4bG3P08TFShGWweutIf1R61s24R0
 pTHaM+5NnFsVsJ2ktdmUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vi19VIKV68w=:F4ZxXn7hdG7L+55QDGtmOA
 gbDRbCe2xXubnLKLMzhFu3TUCcfbcc/mD2YyGy7ThSVCHYw4l3lYO8X0O3nieoD/dUwEBjbvf
 lvLiULiQtBZNcH/SVp/7Jab8H8F2TWGDURgTPIsZO7aFkhTi9DOEMnBuP8dQVv/OL+lDqKF/6
 Th+VuBA+NgmCTrcEvA+i7A/hLpvO+zz3ikZd6zr60crlUUtuzTM8/xscQH3vZqj45+jtRecCG
 o5egf0lJ6+0Qsl/VwflkKKnG0lw5YeKFJZlGd+akeeNovUOQOKHcMVAEvBJz94KXMt9tFB/0A
 65qkHAL17fW8dOdN5l19XD/pqAr7ZKA/mS1kVx8z3AjXMag36pZHOfciU5OQ7WVgJHJttDeVn
 ln1uvWLheOKzOtOcwUETwStzSzTI/3asOZYKSsOhdRbZz8ko5EhqLV890jZQaILVIFucn8V/D
 qvpkCVUw/Dhq8+yf99vJ8AEKzdzCyW1X/Wr4vwm5mW6RVkIPMaYNdArO8xJI+Upmz11Vu1kPZ
 LF+OXNCjBnUdOjAcaUlwKoJdZezTnnbYhac1xUBLqj6aTtAjJe2wRnljXA4zQ2N8II+3tJ9an
 L+vCIbH7xBtN2bT4HrV2M8SefeUBh/llmmojNFbw1q7JiatGffINGGnnfDAK5iQA71J/Hd9uz
 vWbJYiBTljl5p+wAW+PF/pgdzS15hlLO+a119yQSk5PDSHRnO/vFSTUZAjah/wSamd1zi99eg
 +hMkLZ9Q9ubdGyMG0gwzLVrFVJ5WyRYb7uHJYKDtvsBd1YTmnrktKnA+99Vz8I2ngG7LUM+Bv
 /mCzPCfRrFaNx5ODKlZtaSQHXlNIg0gW13XXO94YOXnlCQIGrmX4Awl/4BlVvcYK5YPxWxBWi
 zQdM+P5FzcJS/HXmRKS3FsElFaEMDjNvZyjMjASvdSiDv1JOtmGL9KaUmgESJT8u2EqyXsB7+
 Xws6ntSNWaCz6xBOMDZkPFAkhbnGclvvhKb+ZiH0RJq3/tM9m5Ng8jGQ+vuJMCBkxY7xigs1X
 BR6rJNRoz5uPFmJjS3jMvdRLzHMqkWHoFjEssPtW+WNKHD6zoWlWOthLJvwHI+wm+BfwfPKUs
 EsQNPq5nlwJwCXkg7BPrrDsQ3H0W2PVEzd/mVadqHjv0ARM1Oa3rGp8/7ARmcOyaE8LymM4mF
 ZFo6gfe3BDtxDpp1IKQp2Kv0zeuq26iuEq97IAh9HnLJR+jVeGwPC2IFajmlKivC5qorV4poK
 fNEua6aazTDla0z++
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.08.20 19:14, Masahiro Yamada wrote:
> On Fri, Aug 21, 2020 at 12:46 AM Ronald Warsow <rwarsow@gmx.de> wrote:
>>
...
>> qt-devel-4.8.7-55.fc32.x86_64
>
> This one is the Qt4 development package.
>

I thought that, but I wasn't 100 % sure.


>
> I do not know why, but both
> "dnf install qt-devel" and
> "dnf install qt4-devel"
> works equivalently.
>

something learned.

...

>
> I know, this was reported by somebody else before.
>
>
> I will fix this too.
>

Thanks again.

=2D-
regards

Ronald
