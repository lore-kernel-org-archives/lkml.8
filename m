Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C9FC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE0B206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMfzhTOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732853AbgDAOBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 10:01:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24746 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732760AbgDAOBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 10:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585749675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GXNdNVD3IK69jmOGf4VvMHtq24RJrzu9a8Iw9S/Tw0Q=;
        b=gMfzhTOwjpZeTE/iUVYXDgnK3JMqoC3aOVL5meRfGCjdRDMPC+yj0eEd5ZsZICt0qLbJgg
        dsKC1Rvo5ZkthvzzVvoh9GK8tqrAIUXz4Ph7huVi4tBbUIIdy1YAnehPRoskYeSziD8ACY
        t/rsiADNiw68UW0FQzu3diBG+hyJA6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-Kt5rQ1nMNOu5l5vtIlLJBA-1; Wed, 01 Apr 2020 10:01:13 -0400
X-MC-Unique: Kt5rQ1nMNOu5l5vtIlLJBA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC5B7DB61;
        Wed,  1 Apr 2020 14:01:10 +0000 (UTC)
Received: from krava (unknown [10.40.194.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 01B041036D12;
        Wed,  1 Apr 2020 14:01:08 +0000 (UTC)
Date:   Wed, 1 Apr 2020 16:01:06 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/8] perf: support resume and pause commands in stat
 and record modes
Message-ID: <20200401140106.GF2518490@krava>
References: <825a5132-b58d-c0b6-b050-5a6040386ec7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <825a5132-b58d-c0b6-b050-5a6040386ec7@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 11:34:54AM +0300, Alexey Budankov wrote:
> 
> The patch set implements handling of 'start paused', 'resume' and 'pause'
> external control commands which can be provided for stat and record modes
> of the tool from an external controlling process. 'start paused' command
> can be used to postpone enabling of events in the beginning of a monitoring
> session. 'resume' and 'pause' commands can be used to enable and disable
> events correspondingly any time after the start of the session.
> 
> The 'start paused', resume and 'pause' external control commands can be
> used to focus measurement on specially selected time intervals of workload
> execution. Focused measurement reduces tool intrusion and influence on
> workload behavior, reduces distortion and amount of collected and stored
> data, mitigates data accuracy loss because measurement and data capturing
> happen only during intervals of interest.
> 
> A controlling process can be a bash shell script [1], native executable or
> any other language program that can directly work with file descriptors,
> e.g. pipes [2], and spawn a process, specially the tool one.
> 
> -D,--delay <val> option is extended with -1 value to skip events enabling
> in the beginning of a monitoring session ('start paused' command). --ctl-fd
> and --ctl-fd-ack command line options are introduced to provide the tool
> with a pair of file descriptors to listen to 'resume' and 'pause' commands
> and reply to an external controlling process on the completion of received
> commands processing.
> 
> The tool reads two byte control command message from ctl-fd descriptor,
> handles the command and optionally replies two bytes acknowledgement message
> to fd-ack descriptor, if it is specified on the command line. 'resume' command
> is recognized as 'r' character message and 'pause' command is recognized as
> 'p' character message both received from ctl-fd descriptor. Completion message
> is 'a''\n' and sent to fd-ack descriptor.
> 
> Bash script demonstrating simple use case follows:
> 
> #!/bin/bash
> 
> ctl_dir=/tmp/
> 
> ctl_fifo=${ctl_dir}perf_ctl.fifo
> test -p ${ctl_fifo} && unlink ${ctl_fifo}
> mkfifo ${ctl_fifo} && exec {ctl_fd}<>${ctl_fifo}
> 
> ctl_ack_fifo=${ctl_dir}perf_ctl_ack.fifo
> test -p ${ctl_ack_fifo} && unlink ${ctl_ack_fifo}
> mkfifo ${ctl_ack_fifo} && exec {ctl_fd_ack}<>${ctl_ack_fifo}
> 
> perf stat -D -1 -e cpu-cycles -a -I 1000                \
>           --ctl-fd ${ctl_fd} --ctl-fd-ack ${ctl_fd_ack} \
>           -- sleep 40 &

hi,
is fifo the best choice? do you need it for plug perf in somewhere?
what's your use case for this?

fifos seem complicated because you need to create 2 of them, would
unix socket be better maybe? and do we really need that ack fd?

also you could pass just path and perf could create fifos from them

  # perf stat --control-fifo /tmp/...

or to get really creazy, we could add option that would make perf
to listen on socket or whatever and we would control it via another
perf command ;-)

  # perf stat --control ....
  control socket: /tmp/xxx

  # perf stat control -s /tmp/xxx disable
  # perf stat control -s /tmp/xxx  enable

but ATM I can't see too much use for this, so would be great to
know your usecase ;-)

thanks,
jirka

