Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F56C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5AD20842
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="cTMcQkR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgCBSVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:21:04 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34943 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgCBSVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:21:04 -0500
Received: by mail-qt1-f196.google.com with SMTP id 88so724021qtc.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 10:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cBU8Ier2IxWlCcsZwrUrlK7su4p+SMh+cD7Y5IyZ64A=;
        b=cTMcQkR3vGvRQ81Eymbom4SohmSCDuLKOlpswzIzxRg7cUz+Xl1WeaE1A/nB8xIhsC
         ctOReOn74txQaY9oSZJero0a+zTz/5o1ilV2jBBX8PxAIuo7vNn8RoZ7TidKIFGtaAhE
         yppR5z6kl9vvFnkJ5oiE1j6pVZMfnWq6FxLZekhr0t2Tc0xbPiXgc0iqjEfhTYyYAUix
         eklu/MYfBxMuyMFNd5/t5vVC+PsX4NdglP5wInh7e0gbOyLorI20pHQinDgkIOKHygBB
         kZlPrDdzOoj1JoURXL98OwMItanNX09kp8bxgqwRrhX4GOdlxBF+8MQTaYiXbz7UJ3Kk
         GpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cBU8Ier2IxWlCcsZwrUrlK7su4p+SMh+cD7Y5IyZ64A=;
        b=lywUUhcEJRMZVbp4slvQLOmJkLJLHYfNuG4xqWUG/GKH14ATZglp5kbcZNHNVzckfC
         udpMxh74tKeaaO7WkviDW9rSpcp/CzAHV0rpbldoGdaJLlmjz8j0e4ymBBfAOHv+js1G
         wxMXXRpdk14YtnJcR701cH7K6qIGjnUqmqQ3I7D29yXkWg5BqchWkYVrRvwyfl0Co3iz
         yowCrvRUtFsHM4O5g66p/Q3CVYyApc6RpQVjobtatvSFWbjbaxMDMMMd+Bg2Qt+bY7Si
         53bSdpQJbhrg+gaiPqXXvWuVx+vakijYoDwhyk6/sGFXmKCFbQJaxpp0/cZhiAvZq5L/
         aodA==
X-Gm-Message-State: ANhLgQ1VjyFqW1uAtkZsthWwadDkOrxM5UqqqVaKgDyV3EX0qkbfban2
        7lxdxsS+FgjKkYne7GG/ercXFEXrUm8=
X-Google-Smtp-Source: ADFU+vsi7jrYHAkQMCx/fVJUy6eQGVwJqtf5E3YqQCpnVzMMU4QcpVT/pvaEYGeoaxAseVsIOF7jUw==
X-Received: by 2002:ac8:4c86:: with SMTP id j6mr933934qtv.139.1583173262521;
        Mon, 02 Mar 2020 10:21:02 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f19sm2681250qtp.46.2020.03.02.10.21.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 10:21:01 -0800 (PST)
Message-ID: <1583173259.7365.142.camel@lca.pw>
Subject: Re: + seq_read-info-message-about-buggy-next-functions.patch added
 to -mm tree
From:   Qian Cai <cai@lca.pw>
To:     linux-kernel@vger.kernel.org, dave@stgolabs.net,
        longman@redhat.com, manfred@colorfullife.com, mingo@redhat.com,
        mm-commits@vger.kernel.org, neilb@suse.com, oberpar@linux.ibm.com,
        rostedt@goodmis.org, viro@zeniv.linux.org.uk, vvs@virtuozzo.com
Cc:     akpm@linux-foundation.org
Date:   Mon, 02 Mar 2020 13:20:59 -0500
In-Reply-To: <20200226035621.4NlNn738T%akpm@linux-foundation.org>
References: <20200226035621.4NlNn738T%akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-25 at 19:56 -0800, Andrew Morton wrote:
> ------------------------------------------------------
> From: Vasily Averin <vvs@virtuozzo.com>
> Subject: fs/seq_file.c: seq_read(): add info message about buggy .next functions
> 
> Patch series "seq_file .next functions should increase position index".
> 
> In Aug 2018 NeilBrown noticed commit 1f4aace60b0e ("fs/seq_file.c:
> simplify seq_file iteration code and interface")
> 
> "Some ->next functions do not increment *pos when they return NULL... 
> Note that such ->next functions are buggy and should be fixed.  A simple
> demonstration is dd if=/proc/swaps bs=1000 skip=1 Choose any block size
> larger than the size of /proc/swaps.  This will always show the whole last
> line of /proc/swaps"
> 
> Described problem is still actual.  If you make lseek into middle of last
> output line following read will output end of last line and whole last
> line once again.
> 
> $ dd if=/proc/swaps bs=1  # usual output
> Filename				Type		Size	Used	Priority
> /dev/dm-0                               partition	4194812	97536	-2
> 104+0 records in
> 104+0 records out
> 104 bytes copied
> 
> $ dd if=/proc/swaps bs=40 skip=1    # last line was generated twice
> dd: /proc/swaps: cannot skip to specified offset
> v/dm-0                               partition	4194812	97536	-2
> /dev/dm-0                               partition	4194812	97536	-2 
> 3+1 records in
> 3+1 records out
> 131 bytes copied
> 
> There are lot of other affected files, I've found 30+ including
> /proc/net/ip_tables_matches and /proc/sysvipc/*
> 
> I've sent patches into maillists of affected subsystems already, this
> patch-set fixes the problem in files related to pstore, tracing, gcov,
> sysvipc and other subsystems processed via linux-kernel@ mailing list
> directly
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=206283
> 
> 
> This patch (of 4):
> 
> Add debug code to seq_read() to detect missed or out-of-tree incorrect
> .next seq_file functions.

This patch spams the console like crazy while reading sysfs,

# dmesg | grep 'buggy seq_file' | wc -l
4204

[ 9505.321981] LTP: starting read_all_proc (read_all -d /proc -q -r 10)
[ 9508.222934] buggy seq_file .next function xt_match_seq_next [x_tables] did
not updated position index
[ 9508.223319] buggy seq_file .next function xt_match_seq_next [x_tables] did
not updated position index
[ 9508.223654] buggy seq_file .next function xt_match_seq_next [x_tables] did
not updated position index
[ 9508.223994] buggy seq_file .next function xt_match_seq_next [x_tables] did
not updated position index
[ 9508.224337] buggy seq_file .next function xt_match_seq_next [x_tables] did
not updated position index
...


> 
> https://bugzilla.kernel.org/show_bug.cgi?id=206283
> Link: http://lkml.kernel.org/r/244674e5-760c-86bd-d08a-047042881748@virtuozzo.com
> Link: http://lkml.kernel.org/r/7c24087c-e280-e580-5b0c-0cdaeb14cd18@virtuozzo.com
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> Cc: NeilBrown <neilb@suse.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Manfred Spraul <manfred@colorfullife.com>
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Cc: Waiman Long <longman@redhat.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  fs/seq_file.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> --- a/fs/seq_file.c~seq_read-info-message-about-buggy-next-functions
> +++ a/fs/seq_file.c
> @@ -256,9 +256,12 @@ Fill:
>  		loff_t pos = m->index;
>  
>  		p = m->op->next(m, p, &m->index);
> -		if (pos == m->index)
> -			/* Buggy ->next function */
> +		if (pos == m->index) {
> +			pr_info("buggy seq_file .next function %ps "
> +				"did not updated position index\n",
> +				m->op->next);
>  			m->index++;
> +		}
>  		if (!p || IS_ERR(p)) {
>  			err = PTR_ERR(p);
>  			break;
> _
> 
> Patches currently in -mm which might be from vvs@virtuozzo.com are
> 
> seq_read-info-message-about-buggy-next-functions.patch
> pstore_ftrace_seq_next-should-increase-position-index.patch
> gcov_seq_next-should-increase-position-index.patch
> sysvipc_find_ipc-should-increase-position-index.patch
> 
