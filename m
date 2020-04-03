Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C77C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54CDB206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qoi89/YN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgDCTzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:55:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56135 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727322AbgDCTzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 15:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585943706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HF0Zwc1wocMpHH80a9Ld76/ETXaQKsm1NeNpR7kpIqs=;
        b=Qoi89/YNwf9Uv93xogFkD70bO4TlGN7pFpB53xHTO5zGTYxM722KZ03pnK1sJPgu+5SHKD
        dEKMGlilJrNcLXBlBxsXMc7C2NSdXi/Eq9B8Goqo18PTUQOYSUDWjoqSS7bQobnupUkypG
        ASmziJ8JdwnorWiTMy5+U5xWLwbaUhM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-tFVdUtmCPPOVpwS6u7veUg-1; Fri, 03 Apr 2020 15:55:04 -0400
X-MC-Unique: tFVdUtmCPPOVpwS6u7veUg-1
Received: by mail-wm1-f69.google.com with SMTP id f9so2516739wme.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 12:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=HF0Zwc1wocMpHH80a9Ld76/ETXaQKsm1NeNpR7kpIqs=;
        b=WeDUlMTKkxfvnO0gNJd4hy4K4RUIuG2xJiLSq9hOvyzXHPjiAz8UXDWOkgWgGUdP1A
         kWVpPBb21a6ZVy0aaFPvJIT97YIxdlchKCZeXGGdl9q0tw79FGpHvUn7ngYW9AtOcwpZ
         UtDebfMSFjPV9X6gfPIoklH4W9XyHY4qpueLZuxzgFkn5dOri5awse0DcNS/ieVuKxlu
         n1bGSvK6dIgikGKXL5c6QUHH3N28KYd0WfhCBH5AhC2XhTDLYdZzW/nf0StIB0X7pflR
         ENYy7AvMUePnUIdS5Ru7rxcQ/DVo78psdJX+Zc8F8y1KgPQ0wMauscOqPhoI/gBXeXm+
         C9Og==
X-Gm-Message-State: AGi0PubGmm72lkSW2oKQxQsKwx6o/l1zutAPs4EB+PrQxl9xytQMwd/3
        XHhE+seSjixntyw13mbpedqSLahArdUkYRbV0lbctWubOfAgpzQ3581LP1SIZLvwJPZOlIkL3EX
        UjUAUMX7fCPzL5JvS0d0XkeKx
X-Received: by 2002:a05:6000:51:: with SMTP id k17mr11032870wrx.148.1585943703357;
        Fri, 03 Apr 2020 12:55:03 -0700 (PDT)
X-Google-Smtp-Source: APiQypIMlN52jfL13U65g+yzderJRf7TKcAdljqBnIneSxRjajZqcZuVG4ls3JkT8t9gOas3TmozzA==
X-Received: by 2002:a05:6000:51:: with SMTP id k17mr11032855wrx.148.1585943703163;
        Fri, 03 Apr 2020 12:55:03 -0700 (PDT)
Received: from [192.168.3.122] (p5B0C69E0.dip0.t-ipconnect.de. [91.12.105.224])
        by smtp.gmail.com with ESMTPSA id y1sm5470162wmd.14.2020.04.03.12.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 12:55:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/5] KVM: s390: vsie: Fix region 1 ASCE sanity shadow address checks
Date:   Fri, 3 Apr 2020 21:55:02 +0200
Message-Id: <67F45F4F-33CB-455A-8CB8-7D20D9A2BF2F@redhat.com>
References: <59b411eb-dabe-8cac-9270-7a9f0faa63d5@de.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>, stable@vger.kernel.org
In-Reply-To: <59b411eb-dabe-8cac-9270-7a9f0faa63d5@de.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 03.04.2020 um 19:56 schrieb Christian Borntraeger <borntraeger@de.ibm.c=
om>:
>=20
> =EF=BB=BF
>=20
>> On 03.04.20 17:30, David Hildenbrand wrote:
>> In case we have a region 1 ASCE, our shadow/g3 address can have any value=
.
>> Unfortunately, (-1UL << 64) is undefined and triggers sometimes,
>> rejecting valid shadow addresses when trying to walk our shadow table
>> hierarchy.
>=20
> I thin the range of the addresses do not matter.
> Took me a while to understand maybe rephrase that:
>=20
> In case we have a region 1 the following calculation=20
> (31 + ((gmap->asce & _ASCE_TYPE_MASK) >> 2)*11)
> results in 64. As shifts beyond the size are undefined the compiler is fre=
e to use
> instructions like sllg. sllg will only use 6 bits of the shift value (here=
 64)
> resulting in no shift at all. That means that ALL addresses will be reject=
ed.

Interestingly, it would not fail when shadowing the r2t, but only when tryin=
g to shadow the r3t.

>=20
> With that this makes sense.=20
>=20
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>=20

In case there are no other comments, can you fixup when applying, or do you w=
ant me to resend?

Cheers=

