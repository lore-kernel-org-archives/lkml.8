Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD52DC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 01:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99A9E2073C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 01:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ouxne/II"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgD1Bj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 21:39:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43371 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726259AbgD1Bj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 21:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588037995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AWt0oKx+pB01zuowl3HYopTA8sOUDIn9j7BD+UlNWuQ=;
        b=Ouxne/IIEAnH0KL7fRqf8jqXc+MyoCV+MG/DFOHJ2JUOiZWOuIpHSckKTXcIFMkQAxrB7G
        58ELjB7iHbLsKus6uw70DYwyKKInSklS92JQ/pOnZKSYmGcT+mpp5ETiS+GfH5pZN24O8Y
        1qHmFOMifiyQz0FKGI+wCgOVSAFj2ss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369--721LIx2PCSItKIXH4hrrA-1; Mon, 27 Apr 2020 21:39:53 -0400
X-MC-Unique: -721LIx2PCSItKIXH4hrrA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A52B835B40;
        Tue, 28 Apr 2020 01:39:50 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-176.rdu2.redhat.com [10.10.112.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F8A4196AE;
        Tue, 28 Apr 2020 01:39:44 +0000 (UTC)
Subject: Re: [PATCH v2 4/4] mm/slub: Fix sysfs shrink circular locking
 dependency
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
References: <20200427235621.7823-5-longman@redhat.com>
 <55509F31-A503-4148-B209-B4D062AD0ED7@lca.pw>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <dbbfe685-7374-9a96-b7c2-684142746e30@redhat.com>
Date:   Mon, 27 Apr 2020 21:39:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <55509F31-A503-4148-B209-B4D062AD0ED7@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/20 8:13 PM, Qian Cai wrote:
>
>> On Apr 27, 2020, at 7:56 PM, Waiman Long <longman@redhat.com> wrote:
>>
>> A lockdep splat is observed by echoing "1" to the shrink sysfs file
>> and then shutting down the system:
>>
>> [  167.473392] Chain exists of:
>> [  167.473392]   kn->count#279 --> mem_hotplug_lock.rw_sem --> slab_mu=
tex
>> [  167.473392]
>> [  167.484323]  Possible unsafe locking scenario:
>> [  167.484323]
>> [  167.490273]        CPU0                    CPU1
>> [  167.494825]        ----                    ----
>> [  167.499376]   lock(slab_mutex);
>> [  167.502530]                                lock(mem_hotplug_lock.rw=
_sem);
>> [  167.509356]                                lock(slab_mutex);
>> [  167.515044]   lock(kn->count#279);
>> [  167.518462]
>> [  167.518462]  *** DEADLOCK ***
>>
>> It is because of the get_online_cpus() and get_online_mems() calls in
>> kmem_cache_shrink() invoked via the shrink sysfs file. To fix that, we
>> have to use trylock to get the memory and cpu hotplug read locks. Sinc=
e
>> hotplug events are rare, it should be fine to refuse a kmem caches
>> shrink operation when some hotplug events are in progress.
> I don=E2=80=99t understand how trylock could prevent a splat. The funda=
mental issue is that in sysfs slab store case, the locking order (once tr=
ylock succeed) is,
>
> kn->count =E2=80=94> cpu/memory_hotplug
>
> But we have the existing reverse chain everywhere.
>
> cpu/memory_hotplug =E2=80=94> slab_mutex =E2=80=94> kn->count
>
The sequence that was prevented by this patch is "kn->count -->=20
mem_hotplug_lock.rwsem". This sequence isn't directly in the splat. Once=20
this link is broken, the 3-lock circular loop cannot be formed. Maybe I=20
should modify the commit log to make this point more clear.

Cheers,
Longman


