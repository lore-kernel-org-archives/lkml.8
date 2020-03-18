Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983F6C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A2A20780
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cyIQZRoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgCRSem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:34:42 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:33661 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbgCRSem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 14:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584556481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ErsZoLMrL+thfUVb/I3GceTUQrmbRqvx5UmwuzPOWAQ=;
        b=cyIQZRocPpgIFPtG4Zd6wAejWd7S/CNv9Xl19BtAD85EiPSpDbE1JTXuirLbmJCdkKELOm
        EEzuTuNWRMtnJSnTVlYjE0ifeK0ryqJgusD9FGDAGtgzFUd0m9OeBOIA7MuGHUKPjVJJPU
        z/zeDpS3gStY9diFJvUmtCEGVXJ0NTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-3fDY5p_2MBmsW5IZjKvp7Q-1; Wed, 18 Mar 2020 14:34:33 -0400
X-MC-Unique: 3fDY5p_2MBmsW5IZjKvp7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CDBF8010C8;
        Wed, 18 Mar 2020 18:34:29 +0000 (UTC)
Received: from treble (unknown [10.10.110.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E1056EF81;
        Wed, 18 Mar 2020 18:34:28 +0000 (UTC)
Date:   Wed, 18 Mar 2020 13:34:25 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [RFC][PATCH v2 20/19] kbuild/objtool: Add objtool-vmlinux.o pass
Message-ID: <20200318183425.54xgldze5tfdnugz@treble>
References: <20200317170234.897520633@infradead.org>
 <20200318131845.GG20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200318131845.GG20730@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 02:18:45PM +0100, Peter Zijlstra wrote:
> 
> This seems to 'work', must be perfect etc..
> 
> ---
> 
> Subject: kbuild/objtool: Add objtool-vmlinux.o pass
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed Mar 18 13:33:54 CET 2020
> 
> Now that objtool is capable of processing vmlinux.o and actually has
> something useful to do there, (conditionally) add it to the final link
> pass.
> 
> This will increase build time by a few seconds.

This looks fine (with the -z fix), but I'm guessing you haven't tried it
on an allyesconfig kernel yet?  For example I'd expect the crypto code
to give trouble.

I actually have some code to fix that stashed away somewhere...

-- 
Josh

