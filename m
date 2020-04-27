Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B51C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BA23214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHhUcIlh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgD0Rm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:42:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26041 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726189AbgD0Rm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588009344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BD9Ux2rotiSjTPZ2hlJsLZhxqqennPEzsoDGF8K2prU=;
        b=EHhUcIlhhATQMr8LuW+hWHUq7KfR8EIJgsB8Iv+NlykPkNMlFM3BvfbWUuapZ7iVj1rDUv
        QHeLbqNjmYJunPX+CVyOh1ZM1fSTL33J/6HM9LknuACVUb409niM9RQOQA/vAdEVvVY13o
        7fED4gnbpqhMC2sWDSCAiUAlja4f2Mo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-BNByyRKcMPuYJKIaVg48Fw-1; Mon, 27 Apr 2020 13:42:20 -0400
X-MC-Unique: BNByyRKcMPuYJKIaVg48Fw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D175E801504;
        Mon, 27 Apr 2020 17:42:17 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-176.rdu2.redhat.com [10.10.112.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B032C60300;
        Mon, 27 Apr 2020 17:42:12 +0000 (UTC)
Subject: Re: [PATCH v2] mm/slub: Fix incorrect interpretation of s->offset
To:     Christopher Lameter <cl@linux.com>
Cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20200427140822.18619-1-longman@redhat.com>
 <alpine.DEB.2.21.2004271606390.26716@www.lameter.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <9a12baf2-eaa8-c820-ef9d-1f29819a0c43@redhat.com>
Date:   Mon, 27 Apr 2020 13:42:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004271606390.26716@www.lameter.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/20 12:10 PM, Christopher Lameter wrote:
> On Mon, 27 Apr 2020, Waiman Long wrote:
>
>> To fix it, use the check "s->offset =3D=3D s->inuse" in the new helper
>> function freeptr_after_object() instead. Also add another helper funct=
ion
>> get_info_end() to return the end of info block (inuse + free pointer
>> if not overlapping with object).
>>
>> Fixes: 3202fa62fb43 ("slub: relocate freelist pointer to middle of obj=
ect")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/slub.c | 37 ++++++++++++++++++++++---------------
>>   1 file changed, 22 insertions(+), 15 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 0e736d66bb42..68f1b4b1c309 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -551,15 +551,29 @@ static void print_section(char *level, char *tex=
t, u8 *addr,
>>   	metadata_access_disable();
>>   }
>>
>> +static inline bool freeptr_after_object(struct kmem_cache *s)
> bool freeptr_outside_of_object()?
>
I can change to that name. It doesn't really matter to me.
>> +{
>> +	return s->offset =3D=3D s->inuse;
> s->offset >=3D s->inuse?
>
> There may be a redzone after the object.
>
Technically inuse is object + red zone. According to calculate_sizes():

 =A0=A0=A0=A0=A0=A0=A0 s->inuse =3D size;

 =A0=A0=A0=A0=A0=A0=A0 if (((flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)=
) ||
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 s->ctor)) {
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Relocate free pointer=
 after the object if it is not
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * permitted to overwrit=
e the first word of the object on
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * kmem_cache_free.
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * This is the case if w=
e do RCU, have a constructor or
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * destructor or are poi=
soning the objects.
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 s->offset =3D size;
 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size +=3D sizeof(void *);

So (s->offset =3D=3D s->inuse) when the free pointer is outside of the ob=
ject.

>> +static inline unsigned int get_info_end(struct kmem_cache *s)
> static inline track_offset()?
>
The main reason why I don't use that is because there is a track data=20
structure in slub. There are functions name get_track() and set_track().=20
I don't want to confuse with them.

Cheers,
Longman

