Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9A6C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18624217BA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJ40guHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgAaO5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 09:57:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53635 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728825AbgAaO5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 09:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580482637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=wYxTMN92UJeGxuOee9xVnQbx5leK71A77m0OcSn85Ew=;
        b=JJ40guHsDEPg5mrBQPrsLHMbQc7g2+RvPrYqxvZweUCvIOQbCXJdgEkcGTicvE53O5+oR0
        pVIy4q1eYqnfikx305f1Hu5ZyQ/sr//WqY0xphgpgFXi44XHOcRJNjweQIjTDXJeSE4WQn
        xN/aAvB8hpZkEX49C//kjr3SuxApcWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-8XSaAa0ANhqvNMq5Ig3NGQ-1; Fri, 31 Jan 2020 09:57:12 -0500
X-MC-Unique: 8XSaAa0ANhqvNMq5Ig3NGQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A12B5800D48;
        Fri, 31 Jan 2020 14:57:10 +0000 (UTC)
Received: from [10.36.117.243] (ovpn-117-243.ams2.redhat.com [10.36.117.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E3BD811E3;
        Fri, 31 Jan 2020 14:57:08 +0000 (UTC)
Subject: Re: [PATCH] mm: Allocate shrinker_map on appropriate NUMA node
To:     Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        mhocko@kernel.org, hannes@cmpxchg.org, shakeelb@google.com,
        vdavydov.dev@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <158047248934.390127.5043060848569612747.stgit@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 mQINBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABtCREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT6JAlgEEwEIAEICGwMFCQlmAYAGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl3pImkCGQEACgkQTd4Q
 9wD/g1o+VA//SFvIHUAvul05u6wKv/pIR6aICPdpF9EIgEU448g+7FfDgQwcEny1pbEzAmiw
 zAXIQ9H0NZh96lcq+yDLtONnXk/bEYWHHUA014A1wqcYNRY8RvY1+eVHb0uu0KYQoXkzvu+s
 Dncuguk470XPnscL27hs8PgOP6QjG4jt75K2LfZ0eAqTOUCZTJxA8A7E9+XTYuU0hs7QVrWJ
 jQdFxQbRMrYz7uP8KmTK9/Cnvqehgl4EzyRaZppshruKMeyheBgvgJd5On1wWq4ZUV5PFM4x
 II3QbD3EJfWbaJMR55jI9dMFa+vK7MFz3rhWOkEx/QR959lfdRSTXdxs8V3zDvChcmRVGN8U
 Vo93d1YNtWnA9w6oCW1dnDZ4kgQZZSBIjp6iHcA08apzh7DPi08jL7M9UQByeYGr8KuR4i6e
 RZI6xhlZerUScVzn35ONwOC91VdYiQgjemiVLq1WDDZ3B7DIzUZ4RQTOaIWdtXBWb8zWakt/
 ztGhsx0e39Gvt3391O1PgcA7ilhvqrBPemJrlb9xSPPRbaNAW39P8ws/UJnzSJqnHMVxbRZC
 Am4add/SM+OCP0w3xYss1jy9T+XdZa0lhUvJfLy7tNcjVG/sxkBXOaSC24MFPuwnoC9WvCVQ
 ZBxouph3kqc4Dt5X1EeXVLeba+466P1fe1rC8MbcwDkoUo65Ag0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAGJAiUEGAECAA8FAlXLn5ECGwwFCQlmAYAACgkQTd4Q
 9wD/g1qA6w/+M+ggFv+JdVsz5+ZIc6MSyGUozASX+bmIuPeIecc9UsFRatc91LuJCKMkD9Uv
 GOcWSeFpLrSGRQ1Z7EMzFVU//qVs6uzhsNk0RYMyS0B6oloW3FpyQ+zOVylFWQCzoyyf227y
 GW8HnXunJSC+4PtlL2AY4yZjAVAPLK2l6mhgClVXTQ/S7cBoTQKP+jvVJOoYkpnFxWE9pn4t
 H5QIFk7Ip8TKr5k3fXVWk4lnUi9MTF/5L/mWqdyIO1s7cjharQCstfWCzWrVeVctpVoDfJWp
 4LwTuQ5yEM2KcPeElLg5fR7WB2zH97oI6/Ko2DlovmfQqXh9xWozQt0iGy5tWzh6I0JrlcxJ
 ileZWLccC4XKD1037Hy2FLAjzfoWgwBLA6ULu0exOOdIa58H4PsXtkFPrUF980EEibUp0zFz
 GotRVekFAceUaRvAj7dh76cToeZkfsjAvBVb4COXuhgX6N4pofgNkW2AtgYu1nUsPAo+NftU
 CxrhjHtLn4QEBpkbErnXQyMjHpIatlYGutVMS91XTQXYydCh5crMPs7hYVsvnmGHIaB9ZMfB
 njnuI31KBiLUks+paRkHQlFcgS2N3gkRBzH7xSZ+t7Re3jvXdXEzKBbQ+dC3lpJB0wPnyMcX
 FOTT3aZT7IgePkt5iC/BKBk3hqKteTnJFeVIT7EC+a6YUFg=
Organization: Red Hat GmbH
Message-ID: <ebe1c944-2e0f-136d-dd09-0bb37d500fe2@redhat.com>
Date:   Fri, 31 Jan 2020 15:57:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <158047248934.390127.5043060848569612747.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.01.20 13:09, Kirill Tkhai wrote:
> Despite shrinker_map may be touched from any cpu
> (e.g., a bit there may be set by a task running
> everywhere); kswapd is always bound to specific
> node. So, we will allocate shrinker_map from
> related NUMA node to respect its NUMA locality.
> Also, this follows generic way we use for allocation
> memcg's per-node data.
> 
> Two hunks node_state() patterns are borrowed from
> alloc_mem_cgroup_per_node_info().
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  mm/memcontrol.c |   13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6f6dc8712e39..8ccc8ceb1b17 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -323,7 +323,7 @@ static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
>  					 int size, int old_size)
>  {
>  	struct memcg_shrinker_map *new, *old;
> -	int nid;
> +	int nid, tmp;
>  
>  	lockdep_assert_held(&memcg_shrinker_map_mutex);
>  
> @@ -333,8 +333,9 @@ static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
>  		/* Not yet online memcg */
>  		if (!old)
>  			return 0;
> -
> -		new = kvmalloc(sizeof(*new) + size, GFP_KERNEL);
> +		/* See comment in alloc_mem_cgroup_per_node_info()*/
> +		tmp = node_state(nid, N_NORMAL_MEMORY) ? nid : - 1;
> +		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, tmp);
>  		if (!new)
>  			return -ENOMEM;
>  
> @@ -370,7 +371,7 @@ static void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
>  static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
>  {
>  	struct memcg_shrinker_map *map;
> -	int nid, size, ret = 0;
> +	int nid, size, tmp, ret = 0;
>  
>  	if (mem_cgroup_is_root(memcg))
>  		return 0;
> @@ -378,7 +379,9 @@ static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
>  	mutex_lock(&memcg_shrinker_map_mutex);
>  	size = memcg_shrinker_map_size;
>  	for_each_node(nid) {
> -		map = kvzalloc(sizeof(*map) + size, GFP_KERNEL);
> +		/* See comment in alloc_mem_cgroup_per_node_info()*/
> +		tmp = node_state(nid, N_NORMAL_MEMORY) ? nid : - 1;
> +		map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, tmp);
>  		if (!map) {
>  			memcg_free_shrinker_maps(memcg);
>  			ret = -ENOMEM;
> 

I think it is preferred to use NUMA_NO_NODE instead of -1.


-- 
Thanks,

David / dhildenb

