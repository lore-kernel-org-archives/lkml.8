Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E28C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 905172087D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597406256;
	bh=wJusBf6LdcWDSYclsK9iAJ6MNgqPGSFoHcShJF0eJjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t50DOyDc8TjeJUt64j7SN9gpXC9vic/TGDR/3YhQ1ngNJQNMjNe/XS524//YMSMCi
	 FcXsQdAcUKwf7xL0FvDuLfOloTisbl/zP8Iw6H0Xkr0hXohRYo3XyuxUJJyAo0b78r
	 dGUpezgfw8TCwuGRrmy726aWXaFALO7v78L3EQjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgHNL5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:57:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbgHNL5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:57:34 -0400
Received: from quaco.ghostprotocols.net (177.207.136.251.dynamic.adsl.gvt.net.br [177.207.136.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92318207DA;
        Fri, 14 Aug 2020 11:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597406253;
        bh=wJusBf6LdcWDSYclsK9iAJ6MNgqPGSFoHcShJF0eJjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yEs01YSKRfZiNXfLfvDweQTKEN6FYJwG+rrhR37w+XVFDZtZDcpwyM2STK8syHOL9
         cZ054yGLboYkm738acYnUbeoIqiX4NYs2jzDU0lLAgm3VWPhbENxwb91URgdOwzJaZ
         TZkdGrU4/NUVwc/v9/KDHX28+Xtq0gegOF5X8khE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D39754097F; Fri, 14 Aug 2020 08:57:31 -0300 (-03)
Date:   Fri, 14 Aug 2020 08:57:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 05/18] perf ftrace: show trace column header
Message-ID: <20200814115731.GV13995@kernel.org>
References: <20200808023141.14227-1-changbin.du@gmail.com>
 <20200808023141.14227-6-changbin.du@gmail.com>
 <20200814115655.GU13995@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814115655.GU13995@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 14, 2020 at 08:56:55AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Sat, Aug 08, 2020 at 10:31:28AM +0800, Changbin Du escreveu:
> > This makes perf-ftrace display column header before printing trace.
> > 
> >   $ sudo perf ftrace
> >   # tracer: function
> >   #
> >   # entries-in-buffer/entries-written: 0/0   #P:8
> >   #
> >   #            TASK-PID     CPU#   TIMESTAMP  FUNCTION
> >   #              | |         |       |         |
> >              <...>-9246  [006]  10726.262760: mutex_unlock <-rb_simple_write
> >              <...>-9246  [006]  10726.262764: __fsnotify_parent <-vfs_write
> >              <...>-9246  [006]  10726.262765: fsnotify <-vfs_write
> >              <...>-9246  [006]  10726.262766: __sb_end_write <-vfs_write
> >              <...>-9246  [006]  10726.262767: fpregs_assert_state_consistent <-do_syscall_64
> 
> We have:
> 
>   # perf report -h header
>   
>    Usage: perf report [<options>]
>   
>           --header          Show data header.
>           --header-only     Show only data header.
>   
>   #
> 
> So perhaps we should have those as well, in the 'ftrace' case one would
> perhaps want to use --no-header, for instance, to do some scripting
> parsing just the trace lines.

This as well can be done after I process this series, to make progress.

Applied.

- Arnaldo
