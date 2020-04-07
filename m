Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CEBC2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2ED120730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KeRcVe+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgDGUp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:45:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36351 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726437AbgDGUp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586292356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8tsRuRFXODf5QqTn1oeK1OTxqbe8Dg3SrZmZfgBM20M=;
        b=KeRcVe+2OWkQty7tEbX+rmuD/OzDSgZDSenG8GKI0bYnfviv8YwYl4HypvOlhN7RPDEPiL
        +ZmUuSnlQ+lhWhc86AEn8gEAlSn4Fib1LtmwImdIbOqTmDjXksjIu1LAceka47rwvnMDBc
        a7MwEYEBVSnlxzwJqTy4AE7F6UUiSz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256--KYHo8WyOAC325KBq-9lFA-1; Tue, 07 Apr 2020 16:45:52 -0400
X-MC-Unique: -KYHo8WyOAC325KBq-9lFA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F61C190D34B;
        Tue,  7 Apr 2020 20:45:50 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-180.rdu2.redhat.com [10.10.117.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0DA55DDA5;
        Tue,  7 Apr 2020 20:45:45 +0000 (UTC)
Subject: Re: [PATCH v3] mm: Add kvfree_sensitive() for freeing sensitive data
 objects
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-mm@kvack.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
References: <20200407200318.11711-1-longman@redhat.com>
 <0fe5dcaf078be61ef21c7f18b750c5dc14c69dd7.camel@perches.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <67c51b03-192c-3006-5071-452f351aee67@redhat.com>
Date:   Tue, 7 Apr 2020 16:45:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <0fe5dcaf078be61ef21c7f18b750c5dc14c69dd7.camel@perches.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/20 4:31 PM, Joe Perches wrote:
> On Tue, 2020-04-07 at 16:03 -0400, Waiman Long wrote:
>> For kvmalloc'ed data object that contains sensitive information like
>> cryptographic key, we need to make sure that the buffer is always
>> cleared before freeing it. Using memset() alone for buffer clearing may
>> not provide certainty as the compiler may compile it away. To be sure,
>> the special memzero_explicit() has to be used.
>>
>> This patch introduces a new kvfree_sensitive() for freeing those
>> sensitive data objects allocated by kvmalloc(). The relevnat places
>> where kvfree_sensitive() can be used are modified to use it.
> []
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
> []
>> @@ -757,6 +757,7 @@ static inline void *kvcalloc(size_t n, size_t size, gfp_t flags)
>>  }
>>  
>>  extern void kvfree(const void *addr);
>> +extern void kvfree_sensitive(const void *addr, size_t len);
> Why should size_t len be required?
>
> Why not do what kzfree does and memset
> the entire allocation? (area->size)

If the memory is really virtually mapped, the only way to find out the
size of the object is to use find_vm_area() which can be relatively high
cost and no simple helper function is available. On the other hand, the
length is readily available in the callers. So passing the length
directly to the kvfree_sensitive is simpler.

Cheers,
Longman

