Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCA8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 20:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1F021734
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 20:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STJAmv29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgAWUjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:39:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23985 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726167AbgAWUjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 15:39:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579811950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MyE9Ytq4amd8dy1aNSoOTSin79NmbQ0RcZM9I95mUT0=;
        b=STJAmv29aw/1UJ5kiPoVoiX31pHlUVqSiD3QvSucw6+MOPoQ/LsXdhOqYdH3dKd2eEl6aI
        +HsKMftT4pwm5x0vc0MCJvj36xW2uK/gnqB/UHpkEEd83NL6TpIQO1XjtuyG1Gsz3OK50U
        65AZ8Ktj012bFhWLYkHrtTX6HxccPOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-D5EjJrCwNdypAXS4I0YCEQ-1; Thu, 23 Jan 2020 15:39:06 -0500
X-MC-Unique: D5EjJrCwNdypAXS4I0YCEQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08E1F14E2;
        Thu, 23 Jan 2020 20:39:04 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 50FE185741;
        Thu, 23 Jan 2020 20:39:01 +0000 (UTC)
Subject: Re: [PATCH v9 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
From:   Waiman Long <longman@redhat.com>
To:     Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        guohanjun@huawei.com, jglauber@marvell.com
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <20200115035920.54451-5-alex.kogan@oracle.com>
 <f5e31716-d687-f64c-0fc5-f1c9b539c4ff@redhat.com>
Organization: Red Hat
Message-ID: <5f865b62-4867-2c7b-715a-0605759e647f@redhat.com>
Date:   Thu, 23 Jan 2020 15:39:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <f5e31716-d687-f64c-0fc5-f1c9b539c4ff@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/20 2:55 PM, Waiman Long wrote:
> Playing with lock event counts, I would like you to change the meaning
> intra_count parameter that you are tracking. Instead of tracking the
> number of times a lock is passed to a waiter of the same node
> consecutively, I would like you to track the number of times the head
> waiter in the secondary queue has given up its chance to acquire the
> lock because a later waiter has jumped the queue and acquire the lock
> before it. This value determines the worst case latency that a secondary
> queue waiter can experience. So

Well, that is not strictly true as a a waiter in the middle of the
secondary queue can go back and fro between the queues for a number of
times. Of course, if we can ensure that when a FLUSH_SECONDARY_QUEUE is
issued, those waiters that were in the secondary queue won't be put back
into the secondary queue again. The parameter will then really determine
the worst case latency.

One way to do it is to store the tail of the secondary queue into the
CNA node and passed it down the queue until it matches the current
encoded tail. That will require changing both numa_node and intra_count
into u16 to squeeze out space for another u32.

That will also make the code a bit easier to analyze.

Cheers,
Longman

