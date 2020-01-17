Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10396C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 19:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03612082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 19:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="buqxbhss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbgAQTPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 14:15:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47655 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726761AbgAQTPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 14:15:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579288539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nwe+1XUBl6SaBx9EMqRD4Ccsy9Ue9YSlhzPwxha7bRM=;
        b=buqxbhssQ15Wozl4IrvYh/gl5KeqxkXy+SpPogXY4kKg2Du+C4gZiNSwXBQ5zRWMfYojPo
        J8BGrRnQr6oxYXDoZv00saN50M9p0/58hSy8DtvHpqhn/Ry87opQFk0BeYebHZwcpwfks6
        Or3HG5NoOLt+gY0XYBgF/S6xD6rGPPo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-nFx3Nvx2MZS7uE2tVtaDpg-1; Fri, 17 Jan 2020 14:15:38 -0500
X-MC-Unique: nFx3Nvx2MZS7uE2tVtaDpg-1
Received: by mail-wm1-f71.google.com with SMTP id b9so2619884wmj.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 11:15:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=nwe+1XUBl6SaBx9EMqRD4Ccsy9Ue9YSlhzPwxha7bRM=;
        b=OAyRM08V3Lx9SONJFn/w1YZlJh0IKNgaTBAtdTcGmv+l+i1q7/eCtoJje9znPISZQZ
         Bm1mYtOdw+V6eF6CH/yu2nhfUb4HNrFciW5jbf6J/LFUUJjPA1tT1vM6AlbYVcgVCYap
         BzodrbbxH4s/RltHjdzaDKixCmPVZx+dW1SBDO+ueeynyQMwI0UR6i+G1NRqSIFHGq6P
         5VadBaFXbUhjOclYRTORM9KHzgaUMbI1K5hT113O3GgDSWujbayI/Y328QNICA86+9ZL
         6JY3WnNoBtHEozXRO/MSJb26LUnxrAIpu3MYYGwHyMbubf0XdqXc4PIPjeYBR4TabolD
         PXlg==
X-Gm-Message-State: APjAAAUGvasxx1GtToJnn3frgs44Sq+gJHXh+MCYR22g0lx1hgJIa1E2
        eM25EP9eAPvfIv8qKE8VTIT93OgzU7s42kCcw45XWiw3WQcw/VpkpVfwa6Tpjd7TydijKuNwFS7
        9sfkl8+QEfpJwAM0Ksr9F00Lo
X-Received: by 2002:a5d:484d:: with SMTP id n13mr4620202wrs.420.1579288536737;
        Fri, 17 Jan 2020 11:15:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqxwcK5zj69WxNnfd1ulvLRRj6Rg1KOev0KYGd681rjTyqgHG+JDs901E1WCSA93e4UAl+j2oA==
X-Received: by 2002:a5d:484d:: with SMTP id n13mr4620182wrs.420.1579288536488;
        Fri, 17 Jan 2020 11:15:36 -0800 (PST)
Received: from [192.168.3.122] (p4FF231F7.dip0.t-ipconnect.de. [79.242.49.247])
        by smtp.gmail.com with ESMTPSA id f207sm421909wme.9.2020.01.17.11.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 11:15:35 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next v4] mm/hotplug: silence a lockdep splat with printk()
Date:   Fri, 17 Jan 2020 20:15:34 +0100
Message-Id: <06AE045D-F167-406B-A78B-CAE246058C9D@redhat.com>
References: <00155F33-17C6-4051-A8F9-CCD9414F400D@lca.pw>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <00155F33-17C6-4051-A8F9-CCD9414F400D@lca.pw>
To:     Qian Cai <cai@lca.pw>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 17.01.2020 um 19:49 schrieb Qian Cai <cai@lca.pw>:
>=20
> =EF=BB=BF
>=20
>> On Jan 17, 2020, at 10:46 AM, Michal Hocko <mhocko@kernel.org> wrote:
>>=20
>>> On Fri 17-01-20 10:05:12, Qian Cai wrote:
>>>=20
>>>=20
>>>> On Jan 17, 2020, at 9:39 AM, Michal Hocko <mhocko@kernel.org> wrote:
>>>>=20
>>>> Thanks a lot. Having it in a separate patch would be great.
>>>=20
>>> I was thinking about removing that WARN together in this v5 patch,
>>> so there is less churn to touch the same function again. However, I
>>> am fine either way, so just shout out if you feel strongly towards a
>>> separate patch.
>>=20
>> I hope you meant moving rather than removing ;). The warning is useful
>> because we shouldn't see unmovable pages in the movable zone. And a
>> separate patch makes more sense because the justification is slightly
>> different. We do not want to have a way for userspace to trigger the
>> warning from userspace - even though it shouldn't be possible, but
>> still. Only the offlining path should complain.
>=20
> Something like this?
>=20
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 621716a25639..32c854851e1f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8307,7 +8307,6 @@ struct page *has_unmovable_pages(struct zone *zone, s=
truct page *page,
>        }
>        return NULL;
> unmovable:
> -       WARN_ON_ONCE(zone_idx(zone) =3D=3D ZONE_MOVABLE);
>        return pfn_to_page(pfn + iter);
> }
>=20
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index e70586523ca3..08571b515d9f 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -54,9 +54,11 @@ static int set_migratetype_isolate(struct page *page, i=
nt migratetype, int isol_
>=20
> out:
>        spin_unlock_irqrestore(&zone->lock, flags);
> +
>        if (!ret)
>                drain_all_pages(zone);
>        else if ((isol_flags & REPORT_FAILURE) && unmovable)

We have a dedicated flag for the offlining part.

> +               WARN_ON_ONCE(zone_idx(zone) =3D=3D ZONE_MOVABLE);
>                /*
>                 * printk() with zone->lock held will guarantee to trigger a=

>                 * lockdep splat, so defer it here.
>=20

So, are we fine with unmovable data ending up in ZONE_MOVABLE as long as we c=
an offline it?=20

This might make my life in virtio-mem a little easier (I can unplug chunks f=
alling into ZONE_MOVABLE).=

