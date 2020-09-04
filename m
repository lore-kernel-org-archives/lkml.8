Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CE9C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 05:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E934B206F2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 05:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJtnTVnR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgIDFrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 01:47:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31593 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725812AbgIDFry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 01:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599198471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DMUyUiGxwLkuXRwzIZCI3aHeCKiCNs1za3sON+lkQV8=;
        b=HJtnTVnRM9ngK5mAWqdBkqRQGujohSM+55W45Qra0hBTcjOY6B9kheujpwEqP+HXEvHWMk
        AiekWO7AklCuakGv9g1Od9ro/9foVfusaioiwaDO4LKBq5Cxk1hxkmIttoa6DIlLQmR8ir
        nlZ6ql90Dais2UDrPSn8hecntBDaRUE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-Y-tLBApPMsWHLDV_nQtWiA-1; Fri, 04 Sep 2020 01:47:48 -0400
X-MC-Unique: Y-tLBApPMsWHLDV_nQtWiA-1
Received: by mail-ej1-f69.google.com with SMTP id q9so2093975ejr.21
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 22:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=DMUyUiGxwLkuXRwzIZCI3aHeCKiCNs1za3sON+lkQV8=;
        b=VKVK90G3YUbH2mkbSuy7GBsydVPGdfenSgenBSQJDaYyAD6BglsWMphATsNk9THrLj
         S+Am7DBGqHi/vB7Ww86PhSCJf6TPXEWcr7ajHaUaM7gwNrzEe+Xuw+Q6hXtBzdwoNNOJ
         dIlAgff4/1ckdCpc6ociJRy79e80Ybr+NrOr/gcZ/xLpPA6HohTPw17gV5ylsJf2SesM
         Nx1Uh2dOMa0duRCz+XGL9utcepeXi1dVVh+cbPluBLbHQSOOeQyrAJpgBY6ns3IioOuq
         XOqz9wH01dphJ7Dgg5Es+xEo7otMJXAPY5Lb/CoQtjSZql3sRgOxOR/6syig9EkE8LcK
         Pswg==
X-Gm-Message-State: AOAM5322UWasPQAL/dv1YnSjtwIzN+n+EmogkUaOvE1v30np4xjCa/5x
        8fgWD6Byxz8mMQ02FrauuPW3yY1o4c3Vfw9lPJB7B27QvR63AC9CYDtLf5guMV8e5pMOfVqKAgH
        tfnDD/u3xs/UymmeIQCmPBFzi
X-Received: by 2002:a17:907:2456:: with SMTP id yw22mr5574973ejb.337.1599198466998;
        Thu, 03 Sep 2020 22:47:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxc7rW0RenuGiOtkeMtq2rHckaWFc9OQqwxT2i2Vodnsx4LZRtXkGxrD95FE5I2p2oH/MgoBA==
X-Received: by 2002:a17:907:2456:: with SMTP id yw22mr5574963ejb.337.1599198466788;
        Thu, 03 Sep 2020 22:47:46 -0700 (PDT)
Received: from [192.168.3.122] (p4ff23fc5.dip0.t-ipconnect.de. [79.242.63.197])
        by smtp.gmail.com with ESMTPSA id o3sm4966419edt.79.2020.09.03.22.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 22:47:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 03/10] mm/memory_hotplug: simplify page offlining
Date:   Fri, 4 Sep 2020 07:47:45 +0200
Message-Id: <C2E636DD-EA64-4EC8-A33B-57DB26DB478C@redhat.com>
References: <20200903145844.2ead558f5bc3ef3d5230d30f@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
In-Reply-To: <20200903145844.2ead558f5bc3ef3d5230d30f@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: iPhone Mail (17G68)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 03.09.2020 um 23:58 schrieb Andrew Morton <akpm@linux-foundation.org>:
>=20
> =EF=BB=BFOn Wed, 19 Aug 2020 19:59:50 +0200 David Hildenbrand <david@redha=
t.com> wrote:
>=20
>> We make sure that we cannot have any memory holes right at the beginning
>> of offline_pages(). We no longer need walk_system_ram_range() and can
>> call test_pages_isolated() and __offline_isolated_pages() directly.
>>=20
>> offlined_pages always corresponds to nr_pages, so we can simplify that.
>=20
> This patch ran afoul of Pavel's "mm/memory_hotplug: drain per-cpu pages
> again during memory offline", here:
>=20
>> @@ -1481,7 +1459,7 @@ static int count_system_ram_pages_cb(unsigned long s=
tart_pfn,
>> int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>> {
>>    const unsigned long end_pfn =3D start_pfn + nr_pages;
>> -    unsigned long pfn, system_ram_pages =3D 0, offlined_pages =3D 0;
>> +    unsigned long pfn, system_ram_pages =3D 0;
>>    int ret, node, nr_isolate_pageblock;
>>    unsigned long flags;
>>    struct zone *zone;
>> @@ -1579,16 +1557,12 @@ int __ref offline_pages(unsigned long start_pfn, u=
nsigned long nr_pages)
>>            reason =3D "failure to dissolve huge pages";
>>            goto failed_removal_isolated;
>>        }
>> -        /* check again */
>> -        ret =3D walk_system_ram_range(start_pfn, end_pfn - start_pfn,
>> -                        NULL, check_pages_isolated_cb);
>> -    } while (ret);
>> -
>> -    /* Ok, all of our target is isolated.
>> -       We cannot do rollback at this point. */
>> -    walk_system_ram_range(start_pfn, end_pfn - start_pfn,
>> -                  &offlined_pages, offline_isolated_pages_cb);
>> -    pr_info("Offlined Pages %ld\n", offlined_pages);
>> +    } while (test_pages_isolated(start_pfn, end_pfn, MEMORY_OFFLINE));
>> +
>> +    /* Mark all sections offline and remove free pages from the buddy. *=
/
>> +    __offline_isolated_pages(start_pfn, end_pfn);
>> +    pr_info("Offlined Pages %ld\n", nr_pages);
>> +
>>    /*
>>     * Onlining will reset pagetype flags and makes migrate type
>=20
> I did this.  Looks OK?
>=20

Reading on my smartphone, it looks like you squashed both patches?

> From: David Hildenbrand <david@redhat.com>
> Subject: mm/memory_hotplug: simplify page offlining
>=20
> We make sure that we cannot have any memory holes right at the beginning
> of offline_pages().  We no longer need walk_system_ram_range() and can
> call test_pages_isolated() and __offline_isolated_pages() directly.
>=20
> offlined_pages always corresponds to nr_pages, so we can simplify that.
>=20
> Link: https://lkml.kernel.org/r/20200819175957.28465-4-david@redhat.com
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Charan Teja Reddy <charante@codeaurora.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Michel Lespinasse <walken@google.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>=20
> mm/memory_hotplug.c |   61 +++++++++++++++++-------------------------
> 1 file changed, 25 insertions(+), 36 deletions(-)
>=20
> --- a/mm/memory_hotplug.c~mm-memory_hotplug-simplify-page-offlining
> +++ a/mm/memory_hotplug.c
> @@ -1383,28 +1383,6 @@ do_migrate_range(unsigned long start_pfn
>    return ret;
> }
>=20
> -/* Mark all sections offline and remove all free pages from the buddy. */=

> -static int
> -offline_isolated_pages_cb(unsigned long start, unsigned long nr_pages,
> -            void *data)
> -{
> -    unsigned long *offlined_pages =3D (unsigned long *)data;
> -
> -    *offlined_pages +=3D __offline_isolated_pages(start, start + nr_pages=
);
> -    return 0;
> -}
> -
> -/*
> - * Check all pages in range, recorded as memory resource, are isolated.
> - */
> -static int
> -check_pages_isolated_cb(unsigned long start_pfn, unsigned long nr_pages,
> -            void *data)
> -{
> -    return test_pages_isolated(start_pfn, start_pfn + nr_pages,
> -                   MEMORY_OFFLINE);
> -}
> -
> static int __init cmdline_parse_movable_node(char *p)
> {
>    movable_node_enabled =3D true;
> @@ -1491,7 +1469,7 @@ static int count_system_ram_pages_cb(uns
> int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
> {
>    const unsigned long end_pfn =3D start_pfn + nr_pages;
> -    unsigned long pfn, system_ram_pages =3D 0, offlined_pages =3D 0;
> +    unsigned long pfn, system_ram_pages =3D 0;
>    int ret, node, nr_isolate_pageblock;
>    unsigned long flags;
>    struct zone *zone;
> @@ -1589,16 +1567,27 @@ int __ref offline_pages(unsigned long st
>            reason =3D "failure to dissolve huge pages";
>            goto failed_removal_isolated;
>        }
> -        /* check again */
> -        ret =3D walk_system_ram_range(start_pfn, end_pfn - start_pfn,
> -                        NULL, check_pages_isolated_cb);
> -    } while (ret);
> -
> -    /* Ok, all of our target is isolated.
> -       We cannot do rollback at this point. */
> -    walk_system_ram_range(start_pfn, end_pfn - start_pfn,
> -                  &offlined_pages, offline_isolated_pages_cb);
> -    pr_info("Offlined Pages %ld\n", offlined_pages);
> +
> +        /*
> +         * per-cpu pages are drained in start_isolate_page_range, but if
> +         * there are still pages that are not free, make sure that we
> +         * drain again, because when we isolated range we might
> +         * have raced with another thread that was adding pages to pcp
> +         * list.
> +         *
> +         * Forward progress should be still guaranteed because
> +         * pages on the pcp list can only belong to MOVABLE_ZONE
> +         * because has_unmovable_pages explicitly checks for
> +         * PageBuddy on freed pages on other zones.
> +         */
> +        if (ret)
> +            drain_all_pages(zone);
> +    } while (test_pages_isolated(start_pfn, end_pfn, MEMORY_OFFLINE));

I think we have to do

ret =3D test_pages_isolated()
if (ret)
...
} while (ret);

So keeping the old code flow. I cannot resend before next Tuesday.

> +
> +    /* Mark all sections offline and remove free pages from the buddy. */=

> +    __offline_isolated_pages(start_pfn, end_pfn);
> +    pr_info("Offlined Pages %ld\n", nr_pages);
> +
>    /*
>     * Onlining will reset pagetype flags and makes migrate type
>     * MOVABLE, so just need to decrease the number of isolated
> @@ -1609,11 +1598,11 @@ int __ref offline_pages(unsigned long st
>    spin_unlock_irqrestore(&zone->lock, flags);
>=20
>    /* removal success */
> -    adjust_managed_page_count(pfn_to_page(start_pfn), -offlined_pages);
> -    zone->present_pages -=3D offlined_pages;
> +    adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
> +    zone->present_pages -=3D nr_pages;
>=20
>    pgdat_resize_lock(zone->zone_pgdat, &flags);
> -    zone->zone_pgdat->node_present_pages -=3D offlined_pages;
> +    zone->zone_pgdat->node_present_pages -=3D nr_pages;
>    pgdat_resize_unlock(zone->zone_pgdat, &flags);
>=20
>    init_per_zone_wmark_min();
> _
>=20

