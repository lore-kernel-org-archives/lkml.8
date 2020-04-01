Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7026C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FE4206CC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkivHTlm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732910AbgDAS34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:29:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60448 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732316AbgDAS34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 14:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585765794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nDE5CEyvsIMs+xZyRTX9QXhEgx9VjZ6qiFhRrwoxgiU=;
        b=bkivHTlmnyUtSmcIYKLSipetBOZ8qlWnoheAeos5xv7JP2hVVj5QNZlsiZgWk1uKJHIqIJ
        z0XrqfIDEh7FhN1bh0t454LYvaUQ6DVzcv3rkx3ROZ87YE5HtBeT6YnP+4//0Te2Y4M+Dc
        y3SqunQvI79l/pLqOgquNHCz32g6Xvo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-rxX66QKLOu2a3Lk06wE5qg-1; Wed, 01 Apr 2020 14:29:53 -0400
X-MC-Unique: rxX66QKLOu2a3Lk06wE5qg-1
Received: by mail-wm1-f71.google.com with SMTP id t65so328110wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 11:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=nDE5CEyvsIMs+xZyRTX9QXhEgx9VjZ6qiFhRrwoxgiU=;
        b=JYicsEzFHANbK73lX3j7ADMWHazsfvuS6QIGbRKEso6h/599SOAoyZLioyPOK5V3UQ
         f2LVBtseR3hriGRm/DODZZSXsQGUo81ZIx3iGrtFcAbfTISvD1ypjBC8HAfQkGeiwZEW
         13BBZSNIcp7g8cxclSIq9ioprbr2oB1ZqiR6l0PIilNkjEsyUYkCMbfFFOO9f0kI2AUv
         f5KBCq0QprJ6ScqfFh80M49ktPfN5Da0v5O+xEPYm6iksnkZPYKMQZCt59twzQcYopLP
         MEDtANVZ7zBBxfmRdL5A0/bLxAEkH/ue2oKAxHbLlXiwAWQ1NVqcuHfTMhiOJRUUWSV1
         MXOg==
X-Gm-Message-State: ANhLgQ3wmCjVeLYQCMya4fykgjenk4s8FegzGdp/FjQjYU634qppuq/e
        OD3elH505tlvjHyx3WIoiSYvdQLLLP5cjbMNJjPTg446VAWMS9/GuSb6hqiybrjFi5pYaP8VdUd
        KGBsohUvQ3D06ELVouVrc4TAU
X-Received: by 2002:a5d:55cb:: with SMTP id i11mr26781307wrw.305.1585765791927;
        Wed, 01 Apr 2020 11:29:51 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu56Ft10eF66sLj0BaXYHttJXH0gOaGlyNcbrPPWXSAIIirRtIfT7hslznfpHWmCi+vIkTi2Q==
X-Received: by 2002:a5d:55cb:: with SMTP id i11mr26781284wrw.305.1585765791745;
        Wed, 01 Apr 2020 11:29:51 -0700 (PDT)
Received: from [192.168.3.122] (p5B0C67D1.dip0.t-ipconnect.de. [91.12.103.209])
        by smtp.gmail.com with ESMTPSA id h26sm3561554wmb.19.2020.04.01.11.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 11:29:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 0/2] mm/page_alloc: fix stalls/soft lockups with huge VMs
Date:   Wed, 1 Apr 2020 20:29:46 +0200
Message-Id: <26A3B286-7090-4DD2-8E30-C2BA846AF699@redhat.com>
References: <20200401110624.e5caf6632215004a18a3757b@linux-foundation.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Yiqian Wei <yiwei@redhat.com>
In-Reply-To: <20200401110624.e5caf6632215004a18a3757b@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 01.04.2020 um 20:06 schrieb Andrew Morton <akpm@linux-foundation.org>:
>=20
> =EF=BB=BFOn Wed, 1 Apr 2020 10:45:29 -0400 Daniel Jordan <daniel.m.jordan@=
oracle.com> wrote:
>=20
>> On Wed, Apr 01, 2020 at 04:31:51PM +0200, Pankaj Gupta wrote:
>>>>> On 01.04.20 12:41, David Hildenbrand wrote:
>>>>>> Two fixes for misleading stall messages / soft lockups with huge node=
s /
>>>>>> zones during boot without CONFIG_PREEMPT.
>>>>>>=20
>>>>>> David Hildenbrand (2):
>>>>>>  mm/page_alloc: fix RCU stalls during deferred page initialization
>>>>>>  mm/page_alloc: fix watchdog soft lockups during set_zone_contiguous(=
)
>>>>>>=20
>>>>>> mm/page_alloc.c | 2 ++
>>>>>> 1 file changed, 2 insertions(+)
>>>>>>=20
>>>>>=20
>>>>> Patch #1 requires "[PATCH v3] mm: fix tick timer stall during deferred=

>>>>> page init"
>>>>>=20
>>>>> https://lkml.kernel.org/r/20200311123848.118638-1-shile.zhang@linux.al=
ibaba.com
>>>=20
>>> Thanks! Took me some time to figure it out.
>>=20
>> FYI, I'm planning to post an alternate version of that fix, hopefully tod=
ay if
>> all goes well with my testing.
>=20
> I assume you'll redo this two-patch series to apply on top of this
> forthcoming patch?
>=20

Yes, will wait until the old one in -next has been replaced by a revised one=
. Thanks!=

