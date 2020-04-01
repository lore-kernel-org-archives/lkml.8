Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14104C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D137E20714
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bAFfLXaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732983AbgDAO0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 10:26:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24802 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732749AbgDAO0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 10:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585751172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=8tB83+dbj/600s4YRU2mDkikcjzMDvEbsmaON6HB5KA=;
        b=bAFfLXaWXaeM2mGfBdr8IkWAeipznvWwB/McBCJWmYSBDNSOllkP7Wh8EkA52Ror1zu+im
        qA8rib2IRZWArudCzdOG2fYyK+8XqtZAKYFt++7+Qv93vNNWb6nwQp56LbOfRiqr/7xxzH
        lqKgdddrY9mUazWKuYOGF1VwGHytd/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-sfGd8DJKOUGMlyAd9TRAOg-1; Wed, 01 Apr 2020 10:26:10 -0400
X-MC-Unique: sfGd8DJKOUGMlyAd9TRAOg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66A8918AB2E4;
        Wed,  1 Apr 2020 14:26:08 +0000 (UTC)
Received: from [10.36.114.59] (ovpn-114-59.ams2.redhat.com [10.36.114.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E859410016EB;
        Wed,  1 Apr 2020 14:26:06 +0000 (UTC)
Subject: Re: [PATCH v3] mm: fix tick timer stall during deferred page init
To:     Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200311123848.118638-1-shile.zhang@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <1ca342ec-23e7-7884-5758-2b14675266e4@redhat.com>
Date:   Wed, 1 Apr 2020 16:26:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200311123848.118638-1-shile.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.20 13:38, Shile Zhang wrote:
> When 'CONFIG_DEFERRED_STRUCT_PAGE_INIT' is set, 'pgdatinit' kthread wil=
l
> initialise the deferred pages with local interrupts disabled. It is
> introduced by commit 3a2d7fa8a3d5 ("mm: disable interrupts while
> initializing deferred pages").
>=20
> On machine with NCPUS <=3D 2, the 'pgdatinit' kthread could be bound to
> the boot CPU, which could caused the tick timer long time stall, system
> jiffies not be updated in time.
>=20
> The dmesg shown that:
>=20
>     [    0.197975] node 0 initialised, 32170688 pages in 1ms
>=20
> Obviously, 1ms is unreasonable.
>=20
> Now, fix it by restore in the pending interrupts for every 32*1204 page=
s
> (128MB) initialized, give the chance to update the systemd jiffies.
> The reasonable demsg shown likes:
>=20
>     [    1.069306] node 0 initialised, 32203456 pages in 894ms
>=20
> Fixes: 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferre=
d pages").
>=20
> Co-developed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
> ---
>  mm/page_alloc.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>=20
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3c4eb750a199..a3a47845e150 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1763,12 +1763,17 @@ deferred_init_maxorder(u64 *i, struct zone *zon=
e, unsigned long *start_pfn,
>  	return nr_pages;
>  }
> =20
> +/*
> + * Release the pending interrupts for every TICK_PAGE_COUNT pages.
> + */
> +#define TICK_PAGE_COUNT	(32 * 1024)
> +
>  /* Initialise remaining memory on a node */
>  static int __init deferred_init_memmap(void *data)
>  {
>  	pg_data_t *pgdat =3D data;
>  	const struct cpumask *cpumask =3D cpumask_of_node(pgdat->node_id);
> -	unsigned long spfn =3D 0, epfn =3D 0, nr_pages =3D 0;
> +	unsigned long spfn =3D 0, epfn =3D 0, nr_pages =3D 0, prev_nr_pages =3D=
 0;
>  	unsigned long first_init_pfn, flags;
>  	unsigned long start =3D jiffies;
>  	struct zone *zone;
> @@ -1779,6 +1784,7 @@ static int __init deferred_init_memmap(void *data=
)
>  	if (!cpumask_empty(cpumask))
>  		set_cpus_allowed_ptr(current, cpumask);
> =20
> +again:
>  	pgdat_resize_lock(pgdat, &flags);
>  	first_init_pfn =3D pgdat->first_deferred_pfn;
>  	if (first_init_pfn =3D=3D ULONG_MAX) {
> @@ -1790,7 +1796,6 @@ static int __init deferred_init_memmap(void *data=
)
>  	/* Sanity check boundaries */
>  	BUG_ON(pgdat->first_deferred_pfn < pgdat->node_start_pfn);
>  	BUG_ON(pgdat->first_deferred_pfn > pgdat_end_pfn(pgdat));
> -	pgdat->first_deferred_pfn =3D ULONG_MAX;
> =20
>  	/* Only the highest zone is deferred so find it */
>  	for (zid =3D 0; zid < MAX_NR_ZONES; zid++) {
> @@ -1809,9 +1814,23 @@ static int __init deferred_init_memmap(void *dat=
a)
>  	 * that we can avoid introducing any issues with the buddy
>  	 * allocator.
>  	 */
> -	while (spfn < epfn)
> +	while (spfn < epfn) {
>  		nr_pages +=3D deferred_init_maxorder(&i, zone, &spfn, &epfn);
> +		/*
> +		 * Release the interrupts for every TICK_PAGE_COUNT pages
> +		 * (128MB) to give tick timer the chance to update the

Nit: 128MB is only true for 4k pages.

> +		 * system jiffies.
> +		 */
> +		if ((nr_pages - prev_nr_pages) > TICK_PAGE_COUNT) {
> +			prev_nr_pages =3D nr_pages;
> +			pgdat->first_deferred_pfn =3D spfn;
> +			pgdat_resize_unlock(pgdat, &flags);
> +			goto again;
> +		}
> +	}
> +

I find that deferred page init code horribly complicated to understand,
but that's a different story.

Your change looks sane to me and survives my basic testing. Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

--=20
Thanks,

David / dhildenb

