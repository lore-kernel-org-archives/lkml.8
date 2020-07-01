Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1384FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E56B6207D0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgjEtluE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbgGAPfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:35:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54393 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731399AbgGAPfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593617699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DVvafyNDOv03AqOZTolGY7IYO4hSglqR6MUFuKdIAyA=;
        b=SgjEtluEOgHNWZGFnVsWU9AHBxlJ5rDCnDgnJNTNOUy+PXU+jnkHSasGH5/7V11VaGCgAI
        Da2bxmFjMW4Q4TViRcesHq7+R6dah6g9ehdtHVcmpnh6TKizR/hWuEOdf5Nm9sU/VGm/9g
        T5rLe6jmP9/rpunY4Awc155Xa13KFro=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314--HXWtZb6MXq3px9eqioSFA-1; Wed, 01 Jul 2020 11:34:57 -0400
X-MC-Unique: -HXWtZb6MXq3px9eqioSFA-1
Received: by mail-wr1-f70.google.com with SMTP id s16so8152407wrv.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 08:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=DVvafyNDOv03AqOZTolGY7IYO4hSglqR6MUFuKdIAyA=;
        b=n1r8X/oR3JjjfXkFNXFvgdTBfaagxi1NFEv2Wu2cXDBIdReJ5mXo6ztgT9pXKkSLZ9
         Ltz7PkxGwli0JVpc0d0kYKAi5ysYxT+Zt4uQYRNWh1lf0lmDV2IxbrBAy8Lz9PFeaFM/
         VYC1c6Kb1tXXmz2FhD6ar30v3AGvZnej9HxyGmd9Uo78tRe2IXdHN7wWePWPNSCVBKmS
         /OH95ZFBfvplbRKOrwkJsWhm4RqCxz4Q880oA1PsxaIuOOfRLhwshOMhXz83LSwv+YkW
         wb516cCDfXhgaweXuZrn2mcaajdRXAqAWj7Wspg80I5vxGdNWln8rTVMh1dKTANnEv7O
         V9dA==
X-Gm-Message-State: AOAM5319Utu65QxxBDs8j7oZ9OHmlXkGLy7u07pR4AKa3pPY6bqmF2TC
        D99fxPK3T0I+5mvpY7cEDMvXBL4/w+dkVLVDHG6UwJpWIu3xrwH+DhNoVRlBvGgGOPGa4ZpvozC
        C1wXABcTIJn/kIK0u/VasoFQ7
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr26499037wmf.29.1593617696619;
        Wed, 01 Jul 2020 08:34:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSLRSauLQmUCOlKoZ6zhkxk/B9lCi8GzNaLObBIoBm96avDayWOtaDoizvp758LMBLXPYlzg==
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr26499020wmf.29.1593617696421;
        Wed, 01 Jul 2020 08:34:56 -0700 (PDT)
Received: from ?IPv6:2a01:598:b90d:c98:b442:aed2:92f6:a574? ([2a01:598:b90d:c98:b442:aed2:92f6:a574])
        by smtp.gmail.com with ESMTPSA id z1sm7776010wru.30.2020.07.01.08.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 08:34:55 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/2] mm/memblock: expose only miminal interface to add/walk physmem
Date:   Wed, 1 Jul 2020 17:34:54 +0200
Message-Id: <62588A3E-81FA-4C79-B215-D1D33887597C@redhat.com>
References: <20200701150643.GA2999146@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-mm@kvack.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20200701150643.GA2999146@linux.ibm.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 01.07.2020 um 17:07 schrieb Mike Rapoport <rppt@linux.ibm.com>:
>=20
> =EF=BB=BFHi David,
>=20
>> On Wed, Jul 01, 2020 at 04:18:29PM +0200, David Hildenbrand wrote:
>> "physmem" in the memblock allocator is somewhat weird: it's not actually
>> used for allocation, it's simply information collected during boot, which=

>> describes the unmodified physical memory map at boot time, without any
>> standby/hotplugged memory. It's only used on s390x and is currently the
>> only reason s390x keeps using CONFIG_ARCH_KEEP_MEMBLOCK.
>>=20
>> Physmem isn't numa aware and current users don't specify any flags. Let's=

>> hide it from the user, exposing only for_each_physmem(), and simplify. Th=
e
>> interface for physmem is now really minimalistic:
>> - memblock_physmem_add() to add ranges
>> - for_each_physmem() / __next_physmem_range() to walk physmem ranges
>>=20
>> Don't place it into an __init section and don't discard it without
>> CONFIG_ARCH_KEEP_MEMBLOCK. As we're reusing __next_mem_range(), remove
>> the __meminit notifier to avoid section mismatch warnings once
>> CONFIG_ARCH_KEEP_MEMBLOCK is no longer used with
>> CONFIG_HAVE_MEMBLOCK_PHYS_MAP.
>>=20
>> While fixing up the documentation, sneak in some related cleanups. We can=

>> stop setting CONFIG_HAVE_MEMBLOCK_PHYS_MAP for s390x next.
>=20
> As you noted in the previous version it should have been
> CONFIG_ARCH_KEEP_MEMBLOCK ;-)

Grml :) maybe maintainers can fix that up when applying in case there are no=
 other comments.

Thanks Mike for the fast review!=

