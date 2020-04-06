Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB0AC2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43FF24630
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ck690N2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgDFOgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:36:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55274 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728630AbgDFOgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586183773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0nkfLsT2lQqitstTJWq4FYuR1t+BsPNmrkLpwDWnJdI=;
        b=Ck690N2itVI10ztlckgwbjSQlxISUuKVi1auNknOM4UUwB6YIRWnCBmgpcDK4n8ZWh5uo2
        jpJUUWTvfmiUUQSN52p5SoA45Y7eh085DlYpuoleXNrSCsBA3zQvEcfTN1TI6l9jcfxxQJ
        xhYAu9UnFhwrWwT1Ku5i4AfHoKZSjYA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-nI0v8Z2RN-uPTgsg4y3jrw-1; Mon, 06 Apr 2020 10:36:12 -0400
X-MC-Unique: nI0v8Z2RN-uPTgsg4y3jrw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13AD0107ACCA;
        Mon,  6 Apr 2020 14:36:10 +0000 (UTC)
Received: from llong.remote.csb (ovpn-115-20.rdu2.redhat.com [10.10.115.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75CCD94B5A;
        Mon,  6 Apr 2020 14:36:08 +0000 (UTC)
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data
 objects
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200406023700.1367-1-longman@redhat.com>
 <alpine.DEB.2.21.2004052119530.243304@chino.kir.corp.google.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <3f6658e5-0082-7759-1d08-eda9cb3eba2f@redhat.com>
Date:   Mon, 6 Apr 2020 10:36:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004052119530.243304@chino.kir.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/20 12:20 AM, David Rientjes wrote:
> On Sun, 5 Apr 2020, Waiman Long wrote:
>
>> For kvmalloc'ed data object that contains sensitive information like
>> cryptographic key, we need to make sure that the buffer is always
>> cleared before freeing it. Using memset() alone for buffer clearing ma=
y
>> not provide certainty as the compiler may compile it away. To be sure,
>> the special memzero_explicit() has to be used.
>>
>> This patch introduces a new kvfree_sensitive() for freeing those
>> sensitive data objects allocated by kvmalloc(). The relevnat places
>> where kvfree_sensitive() can be used are modified to use it.
>>
>> Fixes: 4f0882491a14 ("KEYS: Avoid false positive ENOMEM error on key r=
ead")
>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  include/linux/mm.h       | 17 +++++++++++++++++
>>  security/keys/internal.h | 11 -----------
>>  security/keys/keyctl.c   | 16 +++++-----------
>>  3 files changed, 22 insertions(+), 22 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 7dd5c4ccbf85..c26f279f1956 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -758,6 +758,23 @@ static inline void *kvcalloc(size_t n, size_t siz=
e, gfp_t flags)
>> =20
>>  extern void kvfree(const void *addr);
>> =20
>> +/**
>> + * kvfree_sensitive - free a data object containing sensitive informa=
tion
>> + * @addr - address of the data object to be freed
>> + * @len  - length of the data object
>> + *
>> + * Use the special memzero_explicit() function to clear the content o=
f a
>> + * kvmalloc'ed object containing sensitive data to make sure that the
>> + * compiler won't optimize out the data clearing.
>> + */
>> +static inline void kvfree_sensitive(const void *addr, size_t len)
>> +{
>> +	if (addr) {
> Shouldn't this be if (unlikely(ZERO_OR_NULL_PTR(addr))?
>
ZERO_OR_NULL_PTR is defined in slab.h. Using it may cause some header
file dependency problem. To guard against the possibility of 0-length
allocation request, how about just

=A0=A0=A0 if (likely(addr && len)) {

Cheers,
Longman

