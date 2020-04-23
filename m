Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4926EC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2177B20663
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYW1Md3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbgDWRyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 13:54:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53221 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729919AbgDWRyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 13:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587664480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zQYM7DAdgloihb4r4wvFK5egz1Cicb1Ni3LFaRhaezE=;
        b=HYW1Md3Fv7cEw68pvmswL9bYhHjDNOk+tGdfz+XTxBlrXN1SY5XER/ionekjWQGm/Ba3lv
        YGmezA8EmD9VwE/3IHUdMpyMYCpq2eK6+so1qE9zE8K9xqZmRKvUImEusBaKEsYfyXul3J
        /73qQCm5a+iVSac9Rt0NL1nimmeye/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-2Lbw4eM7Ni6Qd0yzIoVSyA-1; Thu, 23 Apr 2020 13:54:37 -0400
X-MC-Unique: 2Lbw4eM7Ni6Qd0yzIoVSyA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C2E4107ACCA;
        Thu, 23 Apr 2020 17:54:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.28])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5165D10016EB;
        Thu, 23 Apr 2020 17:54:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 23 Apr 2020 19:54:36 +0200 (CEST)
Date:   Thu, 23 Apr 2020 19:54:33 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 0/2] proc: Calling proc_flush_task exactly once per
 task
Message-ID: <20200423175432.GA18034@redhat.com>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
 <87ftcv1nqe.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftcv1nqe.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/22, Eric W. Biederman wrote:
>
> Eric W. Biederman (2):
>       proc: Use PIDTYPE_TGID in next_tgid
>       proc: Ensure we see the exit of each process tid exactly once
>
>  fs/exec.c           |  5 +----
>  fs/proc/base.c      | 16 ++--------------
>  include/linux/pid.h |  1 +
>  kernel/pid.c        | 16 ++++++++++++++++
>  4 files changed, 20 insertions(+), 18 deletions(-)
>
> ---
> Oleg if these look good I will add these onto my branch of proc changes
> that includes Alexey's changes.

Eric, sorry, where can I find these 2 patches?

Oleg.

