Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261ECC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 16:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85E92084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 16:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ry52QdFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbgBDQpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:45:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40011 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727296AbgBDQpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 11:45:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580834721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=feetbkeHDvzfuB6p159wOfJOT+uwOceTNFOTbiH83zM=;
        b=Ry52QdFsibVZoxUMaAgzd1a3uN6GaB34k9eR4fF15+1x53OjZt3nyGynF9IMeOyTJhjfeg
        39CMkI52KeGkJMkzchNPVPOHUAdeZHi2HQ+QDChn0KkmxpScsHX4eK6Xcy13Xn1CUYd6Gp
        fF8NgHmbKyRRO2dp1VQoIeV/d5zKeVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-0QPicVDRPBKYs4utQEu0CA-1; Tue, 04 Feb 2020 11:45:17 -0500
X-MC-Unique: 0QPicVDRPBKYs4utQEu0CA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78C77108442E;
        Tue,  4 Feb 2020 16:45:16 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE6517FB79;
        Tue,  4 Feb 2020 16:45:15 +0000 (UTC)
Subject: Re: [PATCH v5 6/7] locking/lockdep: Reuse freed chain_hlocks entries
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20200203164147.17990-1-longman@redhat.com>
 <20200203164147.17990-7-longman@redhat.com>
 <20200204123629.GO14914@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <8fd7ce61-d8eb-6bde-7d41-54b9920e3e39@redhat.com>
Date:   Tue, 4 Feb 2020 11:45:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200204123629.GO14914@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/20 7:36 AM, Peter Zijlstra wrote:
> --- a/kernel/locking/lockdep_proc.c
> +++ b/kernel/locking/lockdep_proc.c
> @@ -278,9 +278,11 @@ static int lockdep_stats_show(struct seq
>  #ifdef CONFIG_PROVE_LOCKING
>  	seq_printf(m, " dependency chains:             %11lu [max: %lu]\n",
>  			lock_chain_count(), MAX_LOCKDEP_CHAINS);
> -	seq_printf(m, " dependency chain hlocks:       %11lu [max: %lu]\n",
> -			MAX_LOCKDEP_CHAIN_HLOCKS - nr_free_chain_hlocks,
> +	seq_printf(m, " dependency chain hlocks used:  %11lu [max: %lu]\n",
> +			MAX_LOCKDEP_CHAIN_HLOCKS - (nr_free_chain_hlocks - nr_lost_chain_hl=
ocks),
>  			MAX_LOCKDEP_CHAIN_HLOCKS);
> +	seq_printf(m, " dependency chain hlocks free:  %11lu\n", nr_free_chai=
n_hlocks);
> +	seq_printf(m, " dependency chain hlocks lost:  %11lu\n", nr_lost_chai=
n_hlocks);

I do have some comments on this. There are three buckets now - free,
lost, used. They add up to MAX_LOCKDEP_CHAIN_HLOCKS. I don't think we
need to list all three. We can compute the third one by subtracting max
from the other two.

Something like:

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.=
c
index 14932ea50317..6fe6a21c58d3 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -278,9 +278,12 @@ static int lockdep_stats_show(struct seq_file *m,
void *v)
=C2=A0#ifdef CONFIG_PROVE_LOCKING
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(m, " dependency cha=
ins:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 %11lu [max: %lu]\n",
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock_chai=
n_count(), MAX_LOCKDEP_CHAINS);
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(m, " dependency chain hl=
ocks:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 %11lu [max: %lu]\n",
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX_LOCKDEP_=
CHAIN_HLOCKS - nr_free_chain_hlocks,
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(m, " dependency chain hl=
ocks used:=C2=A0 %11lu [max: %lu]\n",
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX_LOCKDEP_=
CHAIN_HLOCKS -
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (nr_free_cha=
in_hlocks + nr_lost_chain_hlocks),
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAX_LOCKD=
EP_CHAIN_HLOCKS);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 seq_printf(m, " dependency chain hl=
ocks lost:=C2=A0 %11lu\n",
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nr_lost_chai=
n_hlocks);
=C2=A0#endif
=C2=A0
=C2=A0#ifdef CONFIG_TRACE_IRQFLAGS

Cheers,
Longman

