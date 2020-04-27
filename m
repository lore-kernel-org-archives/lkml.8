Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30BEC55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D126206CD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+Y1Fu2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgD0N4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:56:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26194 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727012AbgD0N4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 09:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587995798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dy0jYuo6XaGKYlQX4BRkBSzyIkCSqXOzYVYleb3WUHA=;
        b=X+Y1Fu2SteaBaqQWe9P3+5t2lQKzCzM8d6gggM8QgbILPc1QkHxQ8ZVvGHlon33wlJvJha
        WyJB7S1Mnk82BYjOu8Szw/iSa1KGHYLiM78oZ4oQb054mN7DGvgMSxnvMjJOQ57sp5EbtQ
        OS7moTnSAC9j13/WXvo4wSKY90iPnuc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-wADzoOmYO7WC06KpCjHJqg-1; Mon, 27 Apr 2020 09:56:34 -0400
X-MC-Unique: wADzoOmYO7WC06KpCjHJqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AA6E464;
        Mon, 27 Apr 2020 13:56:31 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-57.rdu2.redhat.com [10.10.118.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E2B46062A;
        Mon, 27 Apr 2020 13:56:29 +0000 (UTC)
Subject: Re: [PATCH] mm/slub: Fix incorrect checkings of s->offset
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
References: <20200427020212.5222-1-longman@redhat.com>
 <20200427123814.GE29705@bombadil.infradead.org>
 <891a7635-9074-d320-9571-74f584401f01@redhat.com>
 <b4d05ff7-0fe2-67d8-f2a7-6d0c2ab19408@redhat.com>
 <20200427133807.GF29705@bombadil.infradead.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <5e529523-c3ea-954e-a0d0-70d9e2345dda@redhat.com>
Date:   Mon, 27 Apr 2020 09:56:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200427133807.GF29705@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/20 9:38 AM, Matthew Wilcox wrote:
> On Mon, Apr 27, 2020 at 09:29:41AM -0400, Waiman Long wrote:
>> On 4/27/20 9:18 AM, Waiman Long wrote:
>>> On 4/27/20 8:38 AM, Matthew Wilcox wrote:
>>>> On Sun, Apr 26, 2020 at 10:02:12PM -0400, Waiman Long wrote:
>>>>> In a couple of places in the slub memory allocator, the code uses
>>>>> "s->offset" as a check to see if the free pointer is put right
>>>>> after the
>>>>> object. That check is no longer true with commit 3202fa62fb43 ("slu=
b:
>>>>> relocate freelist pointer to middle of object").
>>>>>
>>>>> As a result, echoing "1" into the validate sysfs file, e.g. of dent=
ry,
>>>>> may cause a bunch of "Freepointer corrupt" error reports to appear =
with
>>>>> the system in panic afterwards.
>>>>>
>>>>> To fix it, use the check "s->offset =3D=3D s->inuse" instead.
>>>> I think a little refactoring would make this more clear.
>>>>
>>>> unsigned int track_offset(const struct kmem_cache *s)
>>>> {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0return s->inuse + (s->offset =3D=3D s->inus=
e) ? sizeof(void *) : 0;
>>>> }
>>> Yes, that was what I am thinking of doing in v2.
>> BTW, "+" has a higher priority than "?:". So we need a parenthesis aro=
und
>> "?:".
> That seems like a good reason to not use ?:
>
> unsigned int track_offset(const struct kmem_cache *s)
> {
> 	if (s->offset !=3D s->inuse)
> 		return s->inuse;
> 	return s->inuse + sizeof(void *);
> }
>
> Also this needs a comment about why we're doing this ... something abou=
t
> the freelist pointer, I think?
>
I can see a simple if-else to make it easier to read.

Thanks,
Longman

