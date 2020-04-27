Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1074EC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2C2B206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RtX1Iyz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgD0N3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:29:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30703 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726721AbgD0N3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 09:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587994190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gS95wjKy60cEwsXFyEUIQThnhVIXKZuaJZ5nhfw8iW4=;
        b=RtX1Iyz0CpyMM0cXV4H2oRifzR3jor+HcCdNGgdeMQQt2PzH4mD2CwsCP/XCTv4XfHaEym
        1nLmER/lwrHRemR9wamH21/XC/hO7natP5JQ5gUz1RuFs+EyYqldvNSEaOA5n3tueB3/iR
        Rqbc+fkVumFqnUixTvUXIJayUZFrhdk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-KzTyk5ORMKy8UcvAq6OMsw-1; Mon, 27 Apr 2020 09:29:46 -0400
X-MC-Unique: KzTyk5ORMKy8UcvAq6OMsw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8ACC0835B41;
        Mon, 27 Apr 2020 13:29:44 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-57.rdu2.redhat.com [10.10.118.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35C1E50A9C;
        Mon, 27 Apr 2020 13:29:42 +0000 (UTC)
Subject: Re: [PATCH] mm/slub: Fix incorrect checkings of s->offset
From:   Waiman Long <longman@redhat.com>
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
Organization: Red Hat
Message-ID: <b4d05ff7-0fe2-67d8-f2a7-6d0c2ab19408@redhat.com>
Date:   Mon, 27 Apr 2020 09:29:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <891a7635-9074-d320-9571-74f584401f01@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/20 9:18 AM, Waiman Long wrote:
> On 4/27/20 8:38 AM, Matthew Wilcox wrote:
>> On Sun, Apr 26, 2020 at 10:02:12PM -0400, Waiman Long wrote:
>>> In a couple of places in the slub memory allocator, the code uses
>>> "s->offset" as a check to see if the free pointer is put right after=20
>>> the
>>> object. That check is no longer true with commit 3202fa62fb43 ("slub:
>>> relocate freelist pointer to middle of object").
>>>
>>> As a result, echoing "1" into the validate sysfs file, e.g. of dentry=
,
>>> may cause a bunch of "Freepointer corrupt" error reports to appear wi=
th
>>> the system in panic afterwards.
>>>
>>> To fix it, use the check "s->offset =3D=3D s->inuse" instead.
>> I think a little refactoring would make this more clear.
>>
>> unsigned int track_offset(const struct kmem_cache *s)
>> {
>> =C2=A0=C2=A0=C2=A0=C2=A0return s->inuse + (s->offset =3D=3D s->inuse) =
? sizeof(void *) : 0;
>> }
>
> Yes, that was what I am thinking of doing in v2.=20

BTW, "+" has a higher priority than "?:". So we need a parenthesis=20
around "?:".

Cheers,
Longman

