Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345DCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 106712088E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THZ2Sw3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391858AbgEZW2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 18:28:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34792 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389382AbgEZW2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590532083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zot0MumI80M6LltNRVCk3AF2xaXS+BMw2uFnGlBjtsM=;
        b=THZ2Sw3HZIJByQpON/sLWnQvVX3zsU5Bc7slCeroGFjkbjQyxFXFbkMzucN+ohkEzkfGTT
        QkA1ZTJJiLZqZiMPJ5sUeLiHP+/8zrZ4ITCi3R0vHGWALJ+jBvYPDEO9Lyyyf+zHcxrKge
        wRDibxsVFGyIuV2izzWCPnTRdm/SZmQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-cqUthT54M8-0PC-lCpDbEg-1; Tue, 26 May 2020 18:27:59 -0400
X-MC-Unique: cqUthT54M8-0PC-lCpDbEg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDA9B800688;
        Tue, 26 May 2020 22:27:57 +0000 (UTC)
Received: from llong.remote.csb (ovpn-115-53.rdu2.redhat.com [10.10.115.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F62760C05;
        Tue, 26 May 2020 22:27:55 +0000 (UTC)
Subject: Re: [PATCH] locking/lockdep: Increase MAX_LOCKDEP_ENTRIES by half
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Qian Cai <cai@lca.pw>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
References: <20200526174349.8312-1-longman@redhat.com>
 <20200526185850.GE991@lca.pw>
 <20200526195630.GF325280@hirez.programming.kicks-ass.net>
 <b88d5379-687d-8c14-40ae-221c79500996@redhat.com>
 <20200526212707.GE2483@worktop.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <7be0bc35-37cc-a325-ad1c-3017f6526768@redhat.com>
Date:   Tue, 26 May 2020 18:27:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200526212707.GE2483@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/20 5:27 PM, Peter Zijlstra wrote:
> On Tue, May 26, 2020 at 04:30:58PM -0400, Waiman Long wrote:
>> On 5/26/20 3:56 PM, Peter Zijlstra wrote:
>>> On Tue, May 26, 2020 at 02:58:50PM -0400, Qian Cai wrote:
>>>
>>>> I still don't understand why reading all sysfs files on this system
>>>> could increase that much, but here is the lockdep file after
>>>> running sysfs read to see if you could spot anything obviously,
>>>>
>>>> https://cailca.github.io/files/lockdep.txt
>>> 00000000f011a2a5 OPS:      20 FD:   45 BD:    1 .+.+: kn->active#834
>>>
>>> is that somewhere near the number of CPUs you have?
>>>
>>> Anyway, there's very long "kn->active#..." chains in there, which seems
>>> to suggest some annotation is all sorts of buggered.
>>>
>> It is actually one active lock per instance of the kerfs_node structures.
>> That means more than 800 sysfs files are accessed in some way. As we could
>> have much more than 800 sysfs files in the system, we could easily overwhelm
>> the lockdep tables if we really try to access all of them.
> A lock per instance is crazy, that's not what lockdep is made for.
> Fixing this seems like a far better idea than increasing the numbers.

Thinking about it, one lock per sysfs file does make sense as access to 
those sysfs files can invoke vastly different code path and unifying 
them into one single lock can easily lead to false positive warning.

Cheers,
Longman

