Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AE2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 256DC2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrUhU4Pp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgFZE7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 00:59:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50211 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725306AbgFZE7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593147558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nC5hQIPbomYodtg8E2eKGK2OslJrNc8ijS+OoKbuA3g=;
        b=GrUhU4Pp9pnyncR7GXa/0O7jjO6/cuW1WeHQUPlZPHm9dtol/KP6CsOWl94pNqpIW6sLTV
        B9U69BCA5VeDbbqKpZYWugpSkJOlb7M+WVCYzaCLJR5q3DX50o9MqmqdeHyrenoebdiB06
        WI2Rnmy63Eo/jzhtid8TFJuSxBNBkiA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-rQnVyVhoNnqiIgnsGNd2wg-1; Fri, 26 Jun 2020 00:59:14 -0400
X-MC-Unique: rQnVyVhoNnqiIgnsGNd2wg-1
Received: by mail-ed1-f71.google.com with SMTP id o3so6794993eda.23
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 21:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=nC5hQIPbomYodtg8E2eKGK2OslJrNc8ijS+OoKbuA3g=;
        b=g0Ri+oYA3b4a0c5z40pKNOH3EAae3Hy9MlQSCxG65mG0FF7UnH0Gh5/sLPAPMjG5ZB
         Rk/b5J2wuEmB6n+7jGEK84sQUD0WriFRcjeiF2iIiWcJWVBljRlHxIlQ/V3ZmnSMXEjw
         Sq3fi1M6DKb/JvFrweqphPq+yTOgb3CRVq2SX/weasiEC38nvMOTCCER2Wlh9ha6vw9s
         zn2kbXzTZ0UBLampKia/9OCstVOam8E2TF5F5F/BRzQL3gWkxg5HkhtrDmaaLdwGtOzy
         fyBu4ZhYgiNCpdi+6LtFIxr07GZrek0Y3jAdJh3nn3Imp46Dr04xNHmZJsC8HPJP/7Yh
         305w==
X-Gm-Message-State: AOAM531AO+/mB/UNBehan24qj+OExXCmTgXdhjAZ0S8o2rVEfS6NpZsa
        DPNZjj7uiSXm9m1JMMMdOlHVFGqK5Z7AMtlUXBVQ8WmqGtYzCrFUPkYYKDPGQc9cAfwWjnCJhFY
        qRI6Ig5AZ8GIJe7DZ1SeLkQUq
X-Received: by 2002:a50:ee84:: with SMTP id f4mr1495837edr.183.1593147553480;
        Thu, 25 Jun 2020 21:59:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx94lq3N/qM+1MWaVhHORkRbkIvC8QNtZ7Kv81w8Af0aY4pBglgBv3GcqUSklzjivfiZ3UGoQ==
X-Received: by 2002:a50:ee84:: with SMTP id f4mr1495831edr.183.1593147553327;
        Thu, 25 Jun 2020 21:59:13 -0700 (PDT)
Received: from [192.168.3.122] (p5b0c606f.dip0.t-ipconnect.de. [91.12.96.111])
        by smtp.gmail.com with ESMTPSA id t21sm12887992ejr.68.2020.06.25.21.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 21:59:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/spase: never partially remove memmap for early section
Date:   Fri, 26 Jun 2020 06:59:11 +0200
Message-Id: <5CA8ECA1-2360-4AAA-954F-931404EFEB2B@redhat.com>
References: <20200625223952.GA17926@L-31X9LVDL-1304.local>
Cc:     David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>, Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20200625223952.GA17926@L-31X9LVDL-1304.local>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 26.06.2020 um 00:40 schrieb Wei Yang <richard.weiyang@linux.alibaba.com=
>:
>=20
> =EF=BB=BFOn Thu, Jun 25, 2020 at 07:53:37AM +0200, David Hildenbrand wrote=
:
>>=20
>>=20
>>>> Am 25.06.2020 um 01:47 schrieb Dan Williams <dan.j.williams@intel.com>:=

>>>=20
>>> =EF=BB=BFOn Wed, Jun 24, 2020 at 3:44 PM Wei Yang
>>> <richard.weiyang@linux.alibaba.com> wrote:
>>> [..]
>>>>> So, you are right that there is a mismatch here, but I think the
>>>>> comprehensive fix is to allow early sections to be partially
>>>>> depopulated/repopulated rather than have section_activate() and
>>>>> section_deacticate() special case early sections. The special casing
>>>>> is problematic in retrospect as section_deactivate() can't be
>>>>> maintained without understand special rules in section_activate().
>>>>=20
>>>> Hmm... This means we need to adjust pfn_valid() too, which always retur=
n true
>>>> for early sections.
>>>=20
>>> Right, rather than carry workarounds in 3 locations, and the bug that
>>> has resulted from then getting out of sync, just teach early section
>>> mapping to allow for the subsection populate/depopulate.
>>>=20
>>=20
>> I prefer the easy fix first - IOW what we Here here. Especially, pfn_to_o=
nline_page() will need changes as well.
>>=20
>=20
> Hi, David,
>=20
> Which part of pfn_to_online_page() needs to be changed? pfn_valid_within()=

> would call pfn_valid() to check the pfn first. This looks enough for me.

Not for all configurations. For some (e.g., x86 iirc) it=E2=80=98s just a no=
p.=

