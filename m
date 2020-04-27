Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5D1C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CA53214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CngydgbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgD0SQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:16:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56193 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725963AbgD0SQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588011387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u5dCro9WjZmhKkCxB8zwZkWvc6RXiKYMRKmddyP7nOQ=;
        b=CngydgbFqnA6k3wfMB2Szp0HMuY/9yRInKFqevN8js/h3vMH3dPh5DNcUWRv0OqKyBqD4z
        wzDKPyhjjSPo1y9lwiGumyONzRDWdVjahOVBDY8wO4ZVzlx+nAmkRl1EGE46n9vRC8V05j
        YpEPRXK6TP+VOgvf7tDN8KblDGCyzuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-xqSl2fuGM_q-PCBcurqp7g-1; Mon, 27 Apr 2020 14:16:25 -0400
X-MC-Unique: xqSl2fuGM_q-PCBcurqp7g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06C42107ACF4;
        Mon, 27 Apr 2020 18:16:24 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-176.rdu2.redhat.com [10.10.112.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6EF3210013A1;
        Mon, 27 Apr 2020 18:16:18 +0000 (UTC)
Subject: Re: [PATCH 2/2] mm/slub: Fix slab_mutex circular locking problem in
 slab_attr_store()
To:     Qian Cai <cai@lca.pw>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>
References: <20200424151225.10966-1-longman@redhat.com>
 <20200424151225.10966-2-longman@redhat.com>
 <0A3C34CA-F514-41C2-AC3F-E5925C7C0F9A@lca.pw>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <9fee780e-2c32-bb6a-08c0-cae8fdc58e9f@redhat.com>
Date:   Mon, 27 Apr 2020 14:16:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0A3C34CA-F514-41C2-AC3F-E5925C7C0F9A@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/20 12:16 PM, Qian Cai wrote:
>
>> On Apr 24, 2020, at 11:12 AM, Waiman Long <longman@redhat.com> wrote:
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 183ccc364ccf..255981180489 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -5567,13 +5567,30 @@ static ssize_t slab_attr_store(struct kobject =
*kobj,
>> 		return -EIO;
>>
>> 	err =3D attribute->store(s, buf, len);
>> -#ifdef CONFIG_MEMCG
>> -	if (slab_state >=3D FULL && err >=3D 0 && is_root_cache(s)) {
>> -		struct kmem_cache *c;
>> +#ifdef CONFIG_MEMCG_KMEM
>> +	if (slab_state >=3D FULL && err >=3D 0 && is_root_cache(s) &&
>> +	    !list_empty(&s->memcg_params.children)) {
>> +		struct kmem_cache *c, **pcaches;
>> +		int idx, max, cnt =3D 0;
>> +		size_t size =3D s->max_attr_size;
>> +		struct memcg_cache_array *arr;
>> +
>> +		/*
>> +		 * Make atomic update to s->max_attr_size.
>> +		 */
>> +		do {
>> +			if (len <=3D size)
>> +				break;
>> +		} while (!try_cmpxchg(&s->max_attr_size, &size, len));
>>
> try_cmpxchg() is only available on x86.
>
> mm/slub.c: In function =E2=80=98slab_attr_store=E2=80=99:
> mm/slub.c:5613:13: error: implicit declaration of function =E2=80=98try=
_cmpxchg=E2=80=99; did you mean =E2=80=98xa_cmpxchg=E2=80=99? [-Werror=3D=
implicit-function-declaration]
>     } while (!try_cmpxchg(&s->max_attr_size, &size, len));
>               ^~~~~~~~~~~
>               xa_cmpxchg
>
Oh, sorry about that. Will fix it and send out v2.

Cheers,
Longman

