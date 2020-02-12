Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87367C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2E42467B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SdWdMuL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgBLUkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:40:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50725 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727692AbgBLUkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581540033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FU9K5GWsa21uvs0AcqaFfxjWaFZIHI89x78NP4SVkT4=;
        b=SdWdMuL7Fm7KxecVFyLDsxBny0YqBDqfjZTjlVBo6zAe3F6mzrPk07WpVjbVOvIa5cy5On
        c6kSZI2SFNRZw1oJC8NO0VTce1eb1YuDgK0pYPaDNEqZqRBVVGok8tdlrBNRgLw6gkbN7U
        i5FiSlxkblUaJzM6cViusd7JAsBQEQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-gKJPKTCwPlOYNOk3jZSCJg-1; Wed, 12 Feb 2020 15:40:29 -0500
X-MC-Unique: gKJPKTCwPlOYNOk3jZSCJg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81990800D4C;
        Wed, 12 Feb 2020 20:40:26 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47D871001B08;
        Wed, 12 Feb 2020 20:40:25 +0000 (UTC)
Subject: Re: [PATCH 3/3] mm/slub: Fix potential deadlock problem in
 slab_attr_store()
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20200210204651.21674-1-longman@redhat.com>
 <20200210204651.21674-4-longman@redhat.com>
 <20200210140343.09ac0f5d841a0c9ed5034107@linux-foundation.org>
 <0cb70f4a-7fa0-5567-02fc-955e0406a4e7@redhat.com>
 <20200210151008.1c1d74c1876e363b729f5b1c@linux-foundation.org>
 <54380181-84d6-4611-fc5e-daed82b73743@redhat.com>
Organization: Red Hat
Message-ID: <fd1c1576-7524-ed1c-a886-852511d1f4cf@redhat.com>
Date:   Wed, 12 Feb 2020 15:40:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <54380181-84d6-4611-fc5e-daed82b73743@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/20 6:30 PM, Waiman Long wrote:
> On 2/10/20 6:10 PM, Andrew Morton wrote:
>> On Mon, 10 Feb 2020 17:14:31 -0500 Waiman Long <longman@redhat.com> wr=
ote:
>>
>>>>> --- a/mm/slub.c
>>>>> +++ b/mm/slub.c
>>>>> @@ -5536,7 +5536,12 @@ static ssize_t slab_attr_store(struct kobjec=
t *kobj,
>>>>>  	if (slab_state >=3D FULL && err >=3D 0 && is_root_cache(s)) {
>>>>>  		struct kmem_cache *c;
>>>>> =20
>>>>> -		mutex_lock(&slab_mutex);
>>>>> +		/*
>>>>> +		 * Timeout after 100ms
>>>>> +		 */
>>>>> +		if (mutex_timed_lock(&slab_mutex, 100) < 0)
>>>>> +			return -EBUSY;
>>>>> +
>>>> Oh dear.  Surely there's a better fix here.  Does slab really need t=
o
>>>> hold slab_mutex while creating that sysfs file?  Why?
>>>>
>>>> If the issue is two threads trying to create the same sysfs file
>>>> (unlikely, given that both will need to have created the same cache)
>>>> then can we add a new mutex specifically for this purpose?
>>>>
>>>> Or something else.
>>>>
>>> Well, the current code iterates all the memory cgroups to set the sam=
e
>>> value in all of them. I believe the reason for holding the slab mutex=
 is
>>> to make sure that memcg hierarchy is stable during this iteration
>>> process.
>> But that is unrelated to creation of the sysfs file?
>>
> OK, I will take a closer look at that.

During the creation of a sysfs file:

static int sysfs_slab_add(struct kmem_cache *s)
{
=A0 :
=A0=A0=A0=A0=A0=A0=A0 if (unmergeable) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Slabcache can never be=
 merged so we can use the name
proper.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * This is typically the =
case for debug situations. In that
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * case we can catch dupl=
icate names easily.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sysfs_remove_link(&slab_kse=
t->kobj, s->name);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 name =3D s->name;

The code is trying to remove sysfs files of a cache with conflicting
name. So it seems like kmem_cache_create() is called with a name that
has been used before. If it happens that a write to one of the sysfs
files to be removed happens at the same time, a deadlock can happen.

In this particular case, the kmem_cache_create() call comes from the
mlx5_core module.

=A0=A0=A0=A0=A0=A0=A0 steering->fgs_cache =3D kmem_cache_create("mlx5_fs_=
fgs",
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sizeof=
(struct
mlx5_flow_group), 0,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0, NUL=
L);

Perhaps the module is somehow unloaded and then loaded again. Unfortunate=
ly
this lockdep error was seen once. It is hard to find out how to fix it
without an easy way to reproduce it.

So I will table this for now until there is a way to reproduce it.

Thanks,
Longman

