Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473D5C2BABC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 02:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D24D206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 02:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgK2DZga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgDGCQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 22:16:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50224 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726287AbgDGCQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 22:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586225775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LE82/FZcwe9r070oAqWiHB0/uFWMlEacVo8VBYOQZEM=;
        b=YgK2DZga/8V5rvUeFXtawT1mng6liKEhvDDO/YZCs7efblmgpaiPCfj0S/4BjphEd1ojLA
        uQKe4PHEjT/Q6UlTmAJdz1Om0AZNGWR3RErQdQFGarHYWM4CR8ktUxgRjBO+TrT86Riu/I
        jvISe8WxCWiyCISbfXzqEbaBqOSKqXQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-isqSLhojMVqpZAgjGf2_FA-1; Mon, 06 Apr 2020 22:16:11 -0400
X-MC-Unique: isqSLhojMVqpZAgjGf2_FA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8249F1005514;
        Tue,  7 Apr 2020 02:16:09 +0000 (UTC)
Received: from llong.remote.csb (ovpn-115-20.rdu2.redhat.com [10.10.115.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90BE6118F52;
        Tue,  7 Apr 2020 02:16:04 +0000 (UTC)
Subject: Re: [PATCH v2] mm: Add kvfree_sensitive() for freeing sensitive data
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
References: <20200406185827.22249-1-longman@redhat.com>
 <c2c8adf48be7cb18bbdf0aef7d21e2defe3d2183.camel@perches.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <1e4a6174-04be-6c05-fd6e-b43fefd317fc@redhat.com>
Date:   Mon, 6 Apr 2020 22:16:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c2c8adf48be7cb18bbdf0aef7d21e2defe3d2183.camel@perches.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/20 3:38 PM, Joe Perches wrote:
> On Mon, 2020-04-06 at 14:58 -0400, Waiman Long wrote:
>> For kvmalloc'ed data object that contains sensitive information like
>> cryptographic key, we need to make sure that the buffer is always
>> cleared before freeing it. Using memset() alone for buffer clearing may
>> not provide certainty as the compiler may compile it away. To be sure,
>> the special memzero_explicit() has to be used.
> [] 
>>  extern void kvfree(const void *addr);
>> +extern void kvfree_sensitive(const void *addr, size_t len);
> Question: why should this be const?
>
> 2.1.44 changed kfree(void *) to kfree(const void *) but
> I didn't find a particular reason why.

I am just following the function prototype used by kvfree(). Even
kzfree(const void *) use const. I can remove "const" if others agree.

Cheers,
Longman

