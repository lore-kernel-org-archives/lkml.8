Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A88C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42EE32074D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbyolUhn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390045AbgF3RLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:11:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23337 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731558AbgF3RLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593537069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yhbgPy3RIqyVco+ZXtnNx1YEyJATW1/whGxTMYYXUd4=;
        b=HbyolUhnNLwBVpSElPLFXwTs47DHo8Afdz+jKYF7+NEkKNsEz2yMyKA77iExt6CR4BytrP
        9aYC5uv5oJgfMiCUGsDOv7o3xBgzNL8yZnEv2aR2lDC8FvP5ZwriCDRZb1Kpxf1E69sUV3
        45btHEs5QuV9FnIlyrfBlBgOW83dx0k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-qeez02lPMMKrZxAC5mVkyA-1; Tue, 30 Jun 2020 13:11:07 -0400
X-MC-Unique: qeez02lPMMKrZxAC5mVkyA-1
Received: by mail-wr1-f69.google.com with SMTP id c18so11579707wrp.15
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=yhbgPy3RIqyVco+ZXtnNx1YEyJATW1/whGxTMYYXUd4=;
        b=BRv+JqWnYuIlGwi/Se3g7aB/OK1IqXxAVKDpXe9T0HtJAZRk+USSJ9xRJfZzSqnFbZ
         DO3iACyPz9VJzAQKvKL+WyaU7XKofjyJ0UsT3T5v2aaHp36o502+rqk0Adr3qAQc2WTy
         GK+1+W9hr9H0LZJZgpxoTgS8Ly8IyJPB/Cbhoyv6DbmEcPBgZTKzhWd8Y5vP9BcZ2a4l
         wgcV3SNJFn5+kX6baCAJzAxQXeL++gUuRtwMZAG6crh8Qm89AFPf43iMDGLxYshPHD9h
         QlWfhySYjii4Iyp8J0egUw2EFlLVIsMMXJJ1YKWIYiVJsSNicGRXjsNxpzhgvfYaE2ZB
         ilpQ==
X-Gm-Message-State: AOAM533oDUysjrc7gCJEKHyW3QOvL7kPKF9IQhaFaPZ6EQLgLJxMxlWU
        lXh4Amf/qc7swG+fxbKymB5B2Jyth0EaeuPu56Xq9O4u5AADoAz7CBhN9GaZyyxFW+CO4F/mMKP
        SxsEUCT1+RGYClCuj/xWSkYvR
X-Received: by 2002:a05:600c:2058:: with SMTP id p24mr22262814wmg.74.1593537066600;
        Tue, 30 Jun 2020 10:11:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhWL0b5uQZGwO3pRNQJ9BrMkXvpSgnuuAKj9ZmkWwjoEQcUJ/87vEBLfiBSM7064L0HKcPHg==
X-Received: by 2002:a05:600c:2058:: with SMTP id p24mr22262797wmg.74.1593537066344;
        Tue, 30 Jun 2020 10:11:06 -0700 (PDT)
Received: from [192.168.3.122] (p4ff23ffe.dip0.t-ipconnect.de. [79.242.63.254])
        by smtp.gmail.com with ESMTPSA id v24sm5200496wrd.92.2020.06.30.10.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 10:11:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 1/2] mm/memblock: expose only miminal interface to add/walk physmem
Date:   Tue, 30 Jun 2020 19:11:04 +0200
Message-Id: <31512CDA-4B5E-447C-B84A-C1A592323975@redhat.com>
References: <bbd86b6e-e344-514f-7a10-e1078cb60e99@redhat.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-mm@kvack.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <bbd86b6e-e344-514f-7a10-e1078cb60e99@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 30.06.2020 um 18:58 schrieb David Hildenbrand <david@redhat.com>:
>=20
> =EF=BB=BF
>>=20
>>> extern struct memblock memblock;
>>> @@ -114,6 +110,19 @@ int memblock_remove(phys_addr_t base, phys_addr_t s=
ize);
>>> int memblock_free(phys_addr_t base, phys_addr_t size);
>>> int memblock_reserve(phys_addr_t base, phys_addr_t size);
>>> #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
>>> +/**
>>> + * for_each_physmem_range - iterate through physmem areas not included i=
n type.
>>> + * @i: u64 used as loop variable
>>> + * @type: ptr to memblock_type which excludes from the iteration, can b=
e %NULL
>>> + * @p_start: ptr to phys_addr_t for start address of the range, can be %=
NULL
>>> + * @p_end: ptr to phys_addr_t for end address of the range, can be %NUL=
L
>>> + */
>>> +#define for_each_physmem_range(i, type, p_start, p_end)            \
>>> +    for (i =3D 0, __next_physmem_range(&i, type, p_start, p_end);    \
>>> +         i !=3D (u64)ULLONG_MAX;                    \
>>> +         __next_physmem_range(&i, type, p_start, p_end))
>>> +void __next_physmem_range(u64 *idx, struct memblock_type *type,
>>> +              phys_addr_t *out_start, phys_addr_t *out_end);
>>=20
>> __next_physmem_range() is not really necessary, the
>> for_each_physmem_range() macro can use __next_mem_range() directly, but
>> I suspect it won't look nice :)
>>=20
>> Can you please make __next_physmem_range() static inline if we are to
>> keep it?
>=20
> The thing is, then I have to expose "physmem" to something outside
> memblock.c. That's what I wanted to avoid here. (instead, have a minimal
> interface that is sufficient enough for this special case of physmem -
> add memory during boot, walk memory after boot. Performance is not an
> issue).

... but it might do with an extern declaration within the inline function. W=
ill have a look tomorrow, thanks!=

