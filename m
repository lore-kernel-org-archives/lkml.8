Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC63C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE7120719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFyLTh26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgCZHyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:54:11 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:55654 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbgCZHyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585209249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qql73jNfeDPnZ1XbHZy/14bgCxWzkLKp7JWHPRCQOTQ=;
        b=NFyLTh2698I3xao4nzxSM99rD+jtQGodXyIPHNE1WZifmhk3hBTVuQhpo7w+c25ntyN9nC
        zVRHW6rnt6YnfR9b+DBGcFhxU5TOvysG7N8qi8ySXXjyX8uTsV3N48y5IKAM0E4Oepwj+y
        2eh7o1ywll9g+sSbtLE5F1HOdR7/m8s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-6hUiXkhBP8KDNAI6_PNt9g-1; Thu, 26 Mar 2020 03:54:07 -0400
X-MC-Unique: 6hUiXkhBP8KDNAI6_PNt9g-1
Received: by mail-wm1-f70.google.com with SMTP id f207so2109757wme.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 00:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Qql73jNfeDPnZ1XbHZy/14bgCxWzkLKp7JWHPRCQOTQ=;
        b=SWXb27M8T4WJ9CoP4xVhSWj2kS6LrsVgFwJNb7q+YDCPjyXOTARND/Sab3AntW3jku
         H8I8CPiiRaf35ZwnzOPMAhLXfaHOPq2G0azKQbPsIzLnmmsIpL0TKWGN2XO+BAGL7AAg
         eXbsnPVnxi3V6TxUV161pgo1/r2npDGhsBY6Dsevr4DZfSST7XgebJKg35ptWnm/iss2
         KR5c5MJU6bu8Ayv4S1tt63lq8CU2ofq6bsJwIXEZPTy1ZLa8pZqWG5XoT5VOskVRgTQ+
         DmFrRXksx0YPvQUyp62i6APuimYFXjgI1tb5DmbPPw0T27ROyycRhE3QUnc4cSsnDpnH
         P33Q==
X-Gm-Message-State: ANhLgQ0/JH5mxZCneYWOgVdFFqybA/hZNaGkL5966icTup8ZXiDoFT6C
        EzxgMi/KQolR4twnjk15uL7J7vCGCYeQbUaJ4cEk9rOVA7NDrDsGchG+N68rWnKwxAYbAQkWhKx
        7wr/3r8IqCDwoqmIQ+nE7mxjd
X-Received: by 2002:a1c:5506:: with SMTP id j6mr1794731wmb.127.1585209246376;
        Thu, 26 Mar 2020 00:54:06 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsFiiPx40ICgltZ/bol/CKCo9kj2UWVxCUn27QCXL8zjviDH6XzIhY9x6yyTt09drMK3JIEew==
X-Received: by 2002:a1c:5506:: with SMTP id j6mr1794715wmb.127.1585209246127;
        Thu, 26 Mar 2020 00:54:06 -0700 (PDT)
Received: from [192.168.3.122] (p5B0C669F.dip0.t-ipconnect.de. [91.12.102.159])
        by smtp.gmail.com with ESMTPSA id c189sm2366124wmd.12.2020.03.26.00.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 00:54:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER to handle THP spilt issue
Date:   Thu, 26 Mar 2020 08:54:04 +0100
Message-Id: <C4C6BAF7-C040-403D-997C-48C7AB5A7D6B@redhat.com>
References: <20200326031817-mutt-send-email-mst@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, Hui Zhu <teawater@gmail.com>,
        jasowang@redhat.com, akpm@linux-foundation.org, pagupta@redhat.com,
        mojha@codeaurora.org, namit@vmware.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        Hui Zhu <teawaterz@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
In-Reply-To: <20200326031817-mutt-send-email-mst@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 26.03.2020 um 08:21 schrieb Michael S. Tsirkin <mst@redhat.com>:
>=20
> =EF=BB=BFOn Thu, Mar 12, 2020 at 09:51:25AM +0100, David Hildenbrand wrote=
:
>>> On 12.03.20 09:47, Michael S. Tsirkin wrote:
>>> On Thu, Mar 12, 2020 at 09:37:32AM +0100, David Hildenbrand wrote:
>>>> 2. You are essentially stealing THPs in the guest. So the fastest
>>>> mapping (THP in guest and host) is gone. The guest won't be able to mak=
e
>>>> use of THP where it previously was able to. I can imagine this implies a=

>>>> performance degradation for some workloads. This needs a proper
>>>> performance evaluation.
>>>=20
>>> I think the problem is more with the alloc_pages API.
>>> That gives you exactly the given order, and if there's
>>> a larger chunk available, it will split it up.
>>>=20
>>> But for balloon - I suspect lots of other users,
>>> we do not want to stress the system but if a large
>>> chunk is available anyway, then we could handle
>>> that more optimally by getting it all in one go.
>>>=20
>>>=20
>>> So if we want to address this, IMHO this calls for a new API.
>>> Along the lines of
>>>=20
>>>    struct page *alloc_page_range(gfp_t gfp, unsigned int min_order,
>>>                    unsigned int max_order, unsigned int *order)
>>>=20
>>> the idea would then be to return at a number of pages in the given
>>> range.
>>>=20
>>> What do you think? Want to try implementing that?
>>=20
>> You can just start with the highest order and decrement the order until
>> your allocation succeeds using alloc_pages(), which would be enough for
>> a first version. At least I don't see the immediate need for a new
>> kernel API.
>=20
> OK I remember now.  The problem is with reclaim. Unless reclaim is
> completely disabled, any of these calls can sleep. After it wakes up,
> we would like to get the larger order that has become available
> meanwhile.
>=20

Yes, but that=E2=80=98s a pure optimization IMHO.

So I think we should do a trivial implementation first and then see what we g=
ain from a new allocator API. Then we might also be able to justify it using=
 real numbers.

>=20
>> --=20
>> Thanks,
>>=20
>> David / dhildenb
>=20

