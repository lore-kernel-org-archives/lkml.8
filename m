Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16230C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC8220855
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cd9LLIF5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgHUP4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgHUPz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:55:59 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE14C061573;
        Fri, 21 Aug 2020 08:55:59 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id v15so1190411pgh.6;
        Fri, 21 Aug 2020 08:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=CYqbyAN4+wCFmqIPMue1r9GUuNUIlDRO4Pd0DEtyTi0=;
        b=cd9LLIF5v0WJwJ1oEid1AMiambDyTkdS6i9H374Iu0gmYVyg19E/DvREXR+dqCJAZk
         T3Sht+qOF1udwiVkx1GzHkcb0Ud+TQ+6HR4CBGZv42Z4RiHd1Sj2xnf7AMPzsOho4ouV
         d7qKcY10eBIM347R/jRzRcdWR2BuqyZtPm5hcyJ7clV2k55wHT481KvDVjlnRO/NQmzp
         AY+jd8FRUwdRU0ZAIeqtNpBcihYFHOIwX3ZsKJA1M51qfk90tKecpR4yZb4gcMwn7i10
         n5BA3f2IQNgGCKnWPs0EBXR3f51ULz+5kLL6S/fizGqCnaZWnjALZY47flucCF6RD39d
         Mv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=CYqbyAN4+wCFmqIPMue1r9GUuNUIlDRO4Pd0DEtyTi0=;
        b=bzS926x/JjQq/DW7fGypnshYaIfGTb9TNZzC/r/JqJ8NEJfrQUum9ZLIn0ViqpXlaz
         EnRsQHyOyW7HVoIwSRUAcBCkeBG20G6tYshh5qTLYC6USCXSWoVamtFpmTdm9qmgjhjz
         6Gxoow8BoFmFZI50qtDqDEydGsiOZQnxGErXAaEvjuUSp3XyY2dZsFN0lUwnqj5bHWb6
         vlpkI8qzyEM0lz0I6CkTz6LONgCQQALtnSqids2nFhVzLDigznC4krUEVeQH6cwtKsiv
         imnJr1kI5vTAgOcJJSMRgVBt7NO27Fz7CetEkyOZgJwXWqGT/23aXXQPwKtU18SSNzXa
         hBvg==
X-Gm-Message-State: AOAM531tgpFSVlkGzVaaZKSjVxiCEtU+qVv+TMYZhygxvnXlOyLX72mn
        /FXZ5L0KB320uIylTWb/cG/Dec9Ofzo=
X-Google-Smtp-Source: ABdhPJxHssuPQvmEmm7qjqRN5aTYh6aUr3m9ywm2ikiNkc7d5ThlWDR2lVK5+/x4Xth+oc+FAbDuDQ==
X-Received: by 2002:a65:610f:: with SMTP id z15mr2808856pgu.123.1598025358533;
        Fri, 21 Aug 2020 08:55:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e3sm2507747pgu.40.2020.08.21.08.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 08:55:57 -0700 (PDT)
Subject: Re: [PATCH] drivers/hwmon/adm1177.c: use simple i2c probe
To:     Stephen Kitt <steve@sk2.org>
Cc:     Beniamin Bia <beniamin.bia@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200813160958.1506536-1-steve@sk2.org>
 <20200814151358.GA256451@roeck-us.net>
 <20200821132456.0c9a7b54@heffalump.sk2.org>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <3a4dbcf2-db9e-cde0-6c62-ad8751237934@roeck-us.net>
Date:   Fri, 21 Aug 2020 08:55:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821132456.0c9a7b54@heffalump.sk2.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rnWCnQtq2SNP3kpEgIMcWH510ibFfHh1p"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rnWCnQtq2SNP3kpEgIMcWH510ibFfHh1p
Content-Type: multipart/mixed; boundary="ge33NPJdwGnMs9gfpdZQXzz93rzYoM46Q"

--ge33NPJdwGnMs9gfpdZQXzz93rzYoM46Q
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/21/20 4:25 AM, Stephen Kitt wrote:
> On Fri, 14 Aug 2020 08:13:58 -0700, Guenter Roeck <linux@roeck-us.net> =
wrote:
>> On Thu, Aug 13, 2020 at 06:09:58PM +0200, Stephen Kitt wrote:
>>> This driver doesn't use the id information provided by the old i2c
>>> probe function, so it can trivially be converted to the simple
>>> ("probe_new") form.
>>>
>>> Signed-off-by: Stephen Kitt <steve@sk2.org> =20
>>
>> I'll apply the entire series, but please don't use entire path names
>> as tag in the future but follow bubsystem rules.
>=20

"bubsystem". Sigh. Me and my fat fingers.

Guenter


--ge33NPJdwGnMs9gfpdZQXzz93rzYoM46Q--

--rnWCnQtq2SNP3kpEgIMcWH510ibFfHh1p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEiHPvMQj9QTOCiqgVyx8mb86fmYEFAl8/7osACgkQyx8mb86f
mYEFMQ/9HfeVru3tlL8U3tzOGyWHJ84jCHqb+BfyHZ8Mn5SfRqja1gEfeN5uqsBP
n0ax6XiUKA/4m6JKhNtyHf2LTz+A6Kk2TuAE1UEosgKVfbTazRLK8YyKJDRk/WIY
M3c7ve77zn5LmCUgJ2wKQ8/UXn5OA5acTOFtbdnuGTUOxIGnUQZgMYbmZGMp009K
evjgT2Nca7yWB/UrMUU9T4OpLuoqPgJwNvoMUfRPq8fe6TG0mt4rnMbbUCEvElQO
4d+8BQQz/1rlc/wIr7n0ShzJDGD3U49rYNVRHyBE4PBnk+z9eWma2oPiDOzbQGYe
MXLclXCzUaUR4h0BsvyGMD91fa6vSziWRh9fukbYuKRxSBzRTOO0WxZZTTq+ODi4
DqmVNAkcAZ5NpKs+c8nyAV+3qE774ObjCkPm0wrvKWurlegyX9is4ZS15rt/cdxn
djV7NEf7dHOJTs9I+YkZN+qP/Nl5i61tzKaaReYJLN/zNZwmwfYTMJrvA7P6J4ET
4M5JYuwlOEAD71HM1gZB5FCYPevATK9ggM9P8KKzsh+BxRykYuiO8pqUmfvHG5Xp
LO3+DoC0hnL70j9Nef2ZtTJ4uxXeWMVgGB5GS545wC2d/tIyIq1bpxe06XvYJYNX
tl6HrOomGGvZa6lPuBWKW78QfsczCR4FFqfBELizp+3kaEvINjk=
=I4Qz
-----END PGP SIGNATURE-----

--rnWCnQtq2SNP3kpEgIMcWH510ibFfHh1p--
