Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A84C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C27C20720
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FyQnY2lM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgA2KNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:13:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50899 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726010AbgA2KNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 05:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580292811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=L+qbZWj1Dq9DCN3UBjsOR3vQdK9aGNYKvjc0qSPat1g=;
        b=FyQnY2lM+gm2Hz1F9lkfUAFOwFjQpxapJKfW76WEo5sb4K0eMyNmOqgRldZYVUbBwEcm39
        FxnysfkHc61CW6Q5osaJMZbxrwSwrHD9ultx1/sjjKF4422J+79EDG4O1XUfVDsFdWXacs
        DwN9N602D9kOfHtF5dgTyV3iUA0y1kM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-i1THwa0_OyqgxQMseuaPCA-1; Wed, 29 Jan 2020 05:13:28 -0500
X-MC-Unique: i1THwa0_OyqgxQMseuaPCA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C648A1800D41;
        Wed, 29 Jan 2020 10:13:25 +0000 (UTC)
Received: from [10.36.118.36] (unknown [10.36.118.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3710960BE0;
        Wed, 29 Jan 2020 10:13:24 +0000 (UTC)
Subject: Re: [Patch v2 4/4] mm/migrate.c: handle same node and add failure in
 the same way
To:     Wei Yang <richardw.yang@linux.intel.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        yang.shi@linux.alibaba.com, rientjes@google.com
References: <20200122011647.13636-1-richardw.yang@linux.intel.com>
 <20200122011647.13636-5-richardw.yang@linux.intel.com>
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
Message-ID: <17796dbb-b9b6-9481-5048-addfa5eec51e@redhat.com>
Date:   Wed, 29 Jan 2020 11:13:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200122011647.13636-5-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.01.20 02:16, Wei Yang wrote:
> When page is not queued for migration, there are two possible cases:
>=20
>   * page already on the target node
>   * failed to add to migration queue
>=20
> Current code handle them differently, this leads to a behavior
> inconsistency.
>=20
> Usually for each page's status, we just do store for once. While for th=
e
> page already on the target node, we might store the node information fo=
r
> twice:
>=20
>   * once when we found the page is on the target node
>   * second when moving the pages to target node successfully after abov=
e
>     action
>=20
> The reason is even we don't add the page to pagelist, but store_status(=
)
> does store in a range which still contains the page.
>=20
> This patch handles these two cases in the same way to reduce this
> inconsistency and also make the code a little easier to read.
>=20

I'd rephrase to

"mm/migrate.c: unify "not queued for migration" handling in do_pages_move=
()

It can currently happen that we store the status of a page twice:
* Once we detect that it is already on the target node
* Once we moved a bunch of pages, and a page that's already on the
  target node is contained in the current interval.

Let's simplify the code and always call do_move_pages_to_node() in
case we did not queue a page for migration. Note that pages that are
already on the target node are not added to the pagelist and are,
therefore, ignored by do_move_pages_to_node() - there is no functional
change.

The status of such a page is now only stored once.
"

> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/migrate.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 80d2bba57265..591f2e5caed6 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1654,18 +1654,18 @@ static int do_pages_move(struct mm_struct *mm, =
nodemask_t task_nodes,
>  		err =3D add_page_for_migration(mm, addr, current_node,
>  				&pagelist, flags & MPOL_MF_MOVE_ALL);
> =20
> -		if (!err) {
> -			/* The page is already on the target node */
> -			err =3D store_status(status, i, current_node, 1);
> -			if (err)
> -				goto out_flush;
> -			continue;
> -		} else if (err > 0) {
> +		if (err > 0) {
>  			/* The page is successfully queued for migration */
>  			continue;
>  		}
> =20
> -		err =3D store_status(status, i, err, 1);
> +		/*
> +		 * Two possible cases for err here:
> +		 * =3D=3D 0: page is already on the target node, then store
> +		 *       current_node to status
> +		 * <  0: failed to add page to list, then store err to status
> +		 */

I'd shorten that to

/*
 * If the page is already on the target node (!err), store the node,
 * otherwise, store the err.
*/

> +		err =3D store_status(status, i, err ? : current_node, 1);
>  		if (err)
>  			goto out_flush;
> =20
>=20

Thanks!

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20
Thanks,

David / dhildenb

