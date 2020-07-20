Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4858EC433FB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA1A22CE3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ItIoDYI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgGTMtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 08:49:45 -0400
Received: from mout.web.de ([212.227.15.14]:37055 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728743AbgGTMtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 08:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595249363;
        bh=AHmNfJS+mHBQaE2Wm+D3CXhES2+POrXjo7/PczLeBu8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ItIoDYI1AOqnuKrU1Ut2b+ED1favjQMPZD87RGTt5NV2gDJTwSmGNNqQ48A/QOeRw
         uNmD0jI+b5Vl4RKvZGzKMGl9z/8FrHmQE/6hrAiKfr2IVPSfDE6KsTgjuNzE77gmBI
         ZNX0BQYmG2nL26BsgumYqvZdgT4a+gnaUgkbHlXc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.85.87]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lvk9E-1ktl9z2cd2-017RtL; Mon, 20
 Jul 2020 14:49:23 +0200
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: Avoid memory leak on
 cc->cpages
To:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
References: <6074306e-e909-e17f-900c-320245a8f869@web.de>
 <8be91065-7c85-9501-f1c2-3cf11aab85a5@huawei.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <cd74c280-80e2-910b-0770-72e19d68573f@web.de>
Date:   Mon, 20 Jul 2020 14:49:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8be91065-7c85-9501-f1c2-3cf11aab85a5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QXnBLnkvHco5KeL1z1qol69sM9TrLUJZ3+uRoBBIec9C3CBVXtQ
 STrO0geYL1PQ7kCYzJpqeErGP8IteuoJaEJatSHXToa1335jMR3+Y9O24DymQtjO0VJDcNV
 e8hvS/XVbjINNxlCp/CXvNKJoOIcvDi8Hpvsq8OPpNmlMZm4buGjwKQHiwzAjPMNso07b6x
 9YS6BodWfcxUxkS3U8NSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l2I0rgVWuMk=:4rJhMW2iLqpY9lKVUGpRlQ
 oazIc5Wji9ZkMv2HyRXA9pYjPNdnkb8E6m3uvmutojrFThYbnDoveeak4lslCYKhYa8kJPMbD
 eBc23DNrDE87F9zVdvfFd/kW4QqLBCmzTfSKua/u8uSwWhNDClM+0ZF4w6XTE68UdLzCVtRKi
 tCEszf4Yp9Rf96WB7Dm5kmz44vhrNFpPjdWHsQPN6iESnYqVrl4WJ5KXuy+5SXyRAbW5tivAY
 zt6CC7TAOq5j0vHIM3QF2z8wzZPGcMgYFADpODpv5Z4wq7lzMLFSU+ArBJnf06DMADOapm+AI
 KKXNyJTu+bFxyID3B8yV8rV+9KJ+JSS7+JDBq26KaIye+GC8SUUbcLkXL18s4O7fB+DjJPkd8
 QswOwNSm3mXctKd0iIbA3Z9YpDAk/hZ0cWpo/h/+sxzfF/PsdOxRnPhNXF2Q60V3Qquv8EJYI
 tBdhlCMfPb7NJWkpsDadY1/0CG9Z+r+1I9VoVxvVbG5rpzDk52nAzG+Sk3TzjbviNLBxNaCdq
 odlWt07ukCXnp2/6C18Pl+jRfO/UpkLs3PKbqWU80GuhtjmMihZLEFFz37sCXs38l7KvwUYPo
 jtIp513IWcsUgdT8DTegF7s91pbMk9K1pLWUsd7if8mKf1yYvXxkcpzwM77muFk5dEYFgICKt
 vBMO2eQomvuZxl4f1LoBeBNjlLYn3Tq/HPhgL/ucQun0U7+o2kHEJGzgBqxOY1O78ZvNlE6m9
 YJV0X6hPtiJTIer0ThUOxgI8RQVbVD03jBC5rtUgvDtJPKr125j8v475dGN5DXnGkGKbge7g3
 xVKkJ3/OGTVGFB4VxtjZlrCK0uIjgioz9DOOIU79TLMtCdZy1nYizcIZrdUqxxBTYlkLnkcr4
 lIjzZLkDD6E7LBZBaSkibF5ewiL8phlBzpPoK/NZp8rDP6gbw9X93tHBhJNrcBjpwoda45HnP
 zLxy+5AbMwC1F8h+9pS0cbMAp+7k9/BdrkIYCiCY5kr/Ie30v8rANVurWpt29jRZK8Rw6zIsD
 XgI3uesg6IGRVaRSKIwiDT+SAlr59KBLF2wpcCtUClv4DUXOPROKGeSkdLHgEa/OyfYvF0viR
 DLxDlBYmzU0gJB8sah0qdW90UuabxVi0oYPaMyQxPmkDDyA/nxGHC28lqL+xThgx+NxlzzYl1
 KpqbqJ17/nP+AMHePmYninavG2+CtIOMIPBxs6f02cRO+8oGQdTiB66qLlMlcpjbqbG34BqXJ
 Z7ydNM4RIRY/94+q/SzgZA0rIPuRmXIbCV6MC9w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Memory allocated for storing compressed pages' poitner should be
>>> released after f2fs_write_compressed_pages(), otherwise it will
>>> cause memory leak issue.
>>
>> * Would an imperative wording be more appropriate (without a typo)
>> =C2=A0 for the change description?
>>
>> * Will the tag =E2=80=9CFixes=E2=80=9D become helpful for the commit me=
ssage?
>
> It looks this is replied from patch-robot? since I found all comments
> you replied are almost the same.

I dare to repeat such suggestions because several patches contain
improvable details (not only in the affected source code).

Regards,
Markus
