Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932BBC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B09B2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="hlwP5D3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgD2IBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:01:10 -0400
Received: from mout.web.de ([212.227.17.12]:50205 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbgD2IBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588147254;
        bh=9QDM0Gu4JTamtmtUcXKNKff1o8EUfWMQ4dR3JBPTuVM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hlwP5D3Rv0lACcuTGQbAwApX8J1jXiab9t61Z8jcduuZM3VJWtJZ6tz/Agg6rphny
         lpfDfvU3kHQjmvHjnCrXjVFyFPsVroZgvmbinNIYKqABqIO3N/umY7L8u1/+89fRSB
         JAgYjNMv5cBuIO9OQYnqrbVsAZoMMlnqhGOwb9MI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.72.72]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MFtH8-1jQtoe0vx8-00Er1F; Wed, 29
 Apr 2020 10:00:54 +0200
Subject: Re: mm/slub: do not place freelist pointer to middle of object if
 redzone is on
To:     Changbin Du <changbin.du@gmail.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Pekka Enberg <penberg@kernel.org>,
        Waiman Long <longman@redhat.com>
References: <ca36745b-1939-2640-aeed-390c8c39114e@web.de>
 <20200425235105.sye7fsbndbv24b46@mail.google.com>
 <dc9bcaad-ee13-5359-5d99-7ecb8cb1d46b@web.de>
 <20200428231855.5czf4penpbowliz6@mail.google.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b1b93915-696b-c6e2-d122-f01121188bdc@web.de>
Date:   Wed, 29 Apr 2020 10:00:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428231855.5czf4penpbowliz6@mail.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:rzMxGYTtGgAI8tT2Xt3UGt8m5LySzn7oR3wcK87V29rNqnKiTWF
 8iburajuA7iwAdpJ+xj7Gm46wUOgbEBz0CUDEuzir3dMyEC4OvotNdwhgW9/7yCD196JWRK
 JixGyRIkGu+vCrSOzjgDKVMgqIMa6G90lcvONEzZPLk6XJ8fVQ2laz1wCWOfRZeNzb2OzYG
 yNOFGzhkCKUbn/Yo0fnRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0QUR8JtCDyI=:C0Kr+x1qj3GNq44pAzSNBY
 cwmOEhz0tOgidlPXFZ2ahpIf5JXpfTzjb0tJf6ovI5xGnYzgWKa+vvlAKQCdNLBErfhVKluau
 /qEXTmjiB4dtrwFto1buf2P021eUm9h6H0Qzk9kNL09mRsxEXVT69F/UgVp1qiu7pfFRbnSY+
 VOfLl5U9olWGMfL0F7B5FmRnzxaC1gPHVJSAFXGrRoVrgqSBt0P6sG7//XJvGwyvKOuM5qSWX
 NOD2uHEp0SftSnlknP0aAp8iV0lIbyWHkg8OTAnRBq5xpEqb2605CuTMngWQrV0+daTr3C2Os
 CG8Dt9DCZjp0GSQydxQgj/uMvKO8jqFJi6y2w3zBFZ+HRZ20bUQ4H3IjpqjpU7hGBUbZHim5w
 GfO8d0QC4l5BUP0X3OhraDSFjIZYl1AujN41XwOHA9nK7eAtfksOk1sz21v6dzEi/jarNimxA
 0NI91CgZXCuD96yn/ATwQnjMUZcPVBkPztfF8peBAusB2ytX4W/yhzW36oVcBjgzFhPLocHb3
 i/NQHwzG6Wt1YXXWs5HEJWYreDwb5yGgCfZYCVP9nbtROUtM1TqxmsHdQavIz43wtgRV4U0gZ
 dabq85mVN4w8WsowgsgbVZuS4mIArGHspb+RB2WVGI4G/uxEfTNZ4HoGSP27bhSU4spNTiw83
 y00PXBthWPqvy+DiOdd5a8k6SpVDfanH9bdBlj8qmCbLC2jH7mimtqoOCanxDE0ypHMGveI+b
 o1vNLbzKmfMO6wFJgt33B2mQnVk7JS5kN9NV7rhdV8dakgLYq8nOGMxmRI1fussXeqfXxC0yY
 pwJPyCSN/H1r9QucB4PuqvUKrNuFtB2uuqc1BCOPAGG2K+zFpq3voEVd8JtZxYys9F40cNGe5
 bO8ekd3fl/KtUdQCPkwdNr2y3StVj7upbpypaIduA81UUyZSxyWi3Pwlpwsbol1XKbaH9Qbgz
 81yF9s5US1cBF9RrIVx32sHS5CfdZEoBT99QZVfkIVhJbfP2wViigJeYehAvP28MA+J/TJe9G
 FnWiooC/w795Coso73luP3aoXt1L8/RDC1R+4N/5RmVaO3s7XMnlC3cmpGlolHl3T4dB+oErY
 kW8cPrsGK8/oEXJaPlbylPBOQ3FvJvsjRzfFj89OOFlB6UlWfFxQKvO/j6YvgpbA4fl4q4VmW
 xt+X0G97o4xwBEPgkZ2Uew+dTVpxk78bdeWrnqWjZhX6gh2UDivcWSsd4aTg7grG2z1U7yaFC
 6bkZ7WExdrJU5/xdJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Waiman just posted another fix for this issue. Let's use that patch instead.

With which patches should the situation be finally improved
also for this software component?
https://lore.kernel.org/patchwork/project/lkml/list/?submitter=21412

Regards,
Markus
