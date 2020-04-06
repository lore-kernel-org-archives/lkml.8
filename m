Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B8EC2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132482463C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3v4bwST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgDFOkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:40:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60769 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728566AbgDFOkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586184040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3K6eQ8d690wdZUosmRaUm071ZY/MVjAka/1m9mc596s=;
        b=E3v4bwSTax1zv19Kxkbw2o7i3myvyVXz31wOFRNSvay3dS5I61sd5s9MFbceCOaH/1xVyR
        JrdDYnhn0pNcQB9Aq5Xl+tgpBBUpxZCfBiwfjs0epCFRK0gl90PD0EXsht6/jifZW80sMo
        QXSVOA5BEwj1DYzDUH6XxC39SwhEEqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-AJQidAWJNPCLNVntPw2esg-1; Mon, 06 Apr 2020 10:40:39 -0400
X-MC-Unique: AJQidAWJNPCLNVntPw2esg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B4CB8018A5;
        Mon,  6 Apr 2020 14:40:37 +0000 (UTC)
Received: from llong.remote.csb (ovpn-115-20.rdu2.redhat.com [10.10.115.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6B0360BE0;
        Mon,  6 Apr 2020 14:40:35 +0000 (UTC)
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data
 objects
To:     David Howells <dhowells@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200406023700.1367-1-longman@redhat.com>
 <102082.1586183529@warthog.procyon.org.uk>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <04045dde-aa1a-5e7c-5a71-6b4a52c2fbb7@redhat.com>
Date:   Mon, 6 Apr 2020 10:40:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <102082.1586183529@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/20 10:32 AM, David Howells wrote:
> Waiman Long <longman@redhat.com> wrote:
>
>> +static inline void kvfree_sensitive(const void *addr, size_t len)
> Linus suggested making it non-inline.

Sorry, I misread his comment. Will send a v2 to fix that.

Cheers,
Longman

