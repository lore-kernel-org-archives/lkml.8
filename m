Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A8BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C5520829
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599150047;
	bh=80MRQcc/dskjVxhhaT5cX4wwojeRy/pJGcIGScdvztA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZGf/kA8Jcqc8A51ADodSeH/PX9Rfz1HlijgM3dNULU86F3rlhEsBtKOeaVBArA3vI
	 m1xF0UfawIhQwgyxWtXxndm7BS77oLDqE6Jz7psq93/woUf3ymwRAv/s2+Jmxe7+rX
	 aiWgDYo/2EA0ONEq4LT6co0Cmw45bvcGGDsPvCl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgICQUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:20:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgICQUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:20:45 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 145B920722;
        Thu,  3 Sep 2020 16:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599150042;
        bh=80MRQcc/dskjVxhhaT5cX4wwojeRy/pJGcIGScdvztA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qNepaLgRDuVK6ZUJqKnF2/scV78eTbDi8YF4m19LulhwH9BnwV1dUyv8xWqksGwyz
         MPXfjmPn7oTS754K0H1wVMunapfO/QoFT1Clbv1/1hUIQfrDpPMUEF0V80FEvjTzBI
         DC+Yq6dEmD9ANW9xYA5c6hif/lV2fpPGIyaEDj4M=
Date:   Thu, 3 Sep 2020 18:21:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frankie Chang <Frankie.Chang@mediatek.com>
Cc:     Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com, Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Subject: Re: [PATCH v7] binder: transaction latency tracking for user build
Message-ID: <20200903162105.GA371057@kroah.com>
References: <1596509145.5207.21.camel@mtkswgap22>
 <1596549552-5466-1-git-send-email-Frankie.Chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1596549552-5466-1-git-send-email-Frankie.Chang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 09:59:09PM +0800, Frankie Chang wrote:
> 
> Frankie.Chang (3):
>   binder: move structs from core file to header file
>   binder: add trace at free transaction.
>   binder: add transaction latency tracer
> 
>  drivers/android/Kconfig                 |    8 +
>  drivers/android/Makefile                |    1 +
>  drivers/android/binder.c                |  425 ++-----------------------------
>  drivers/android/binder_internal.h       |  417 ++++++++++++++++++++++++++++++
>  drivers/android/binder_latency_tracer.c |  112 ++++++++
>  drivers/android/binder_trace.h          |   49 ++++
>  6 files changed, 607 insertions(+), 405 deletions(-)  create mode 100644 drivers/android/binder_latency_tracer.c

This series blows up the build into lots of tiny pieces, how was it
tested?

Here's my error logs:

In file included from drivers/android/binderfs.c:37:
drivers/android/binder_internal.h:537:17: error: field ‘tv’ has incomplete type
  537 |  struct timeval tv;
      |                 ^~
In file included from drivers/android/binder_trace.h:12,
                 from drivers/android/binder_alloc.c:27:
drivers/android/binder_trace.h: In function ‘trace_binder_txn_latency_alloc’:
drivers/android/binder_trace.h:100:13: error: ‘e’ undeclared (first use in this function)
  100 |  TP_ARGS(t, e)
      |             ^
./include/linux/tracepoint.h:191:33: note: in definition of macro ‘__DO_TRACE’
  191 |     ((void(*)(proto))(it_func))(args); \
      |                                 ^~~~
./include/linux/tracepoint.h:236:5: note: in expansion of macro ‘TP_ARGS’
  236 |     TP_ARGS(data_args),   \
      |     ^~~~~~~
./include/linux/tracepoint.h:375:2: note: in expansion of macro ‘__DECLARE_TRACE’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~
./include/linux/tracepoint.h:378:4: note: in expansion of macro ‘PARAMS’
  378 |    PARAMS(__data, args))
      |    ^~~~~~
drivers/android/binder_trace.h:98:1: note: in expansion of macro ‘DECLARE_TRACE’
   98 | DECLARE_TRACE(binder_txn_latency_alloc,
      | ^~~~~~~~~~~~~
drivers/android/binder_trace.h:100:2: note: in expansion of macro ‘TP_ARGS’
  100 |  TP_ARGS(t, e)
      |  ^~~~~~~
drivers/android/binder_trace.h:100:13: note: each undeclared identifier is reported only once for each function it appears in
  100 |  TP_ARGS(t, e)
      |             ^
./include/linux/tracepoint.h:191:33: note: in definition of macro ‘__DO_TRACE’
  191 |     ((void(*)(proto))(it_func))(args); \
      |                                 ^~~~
./include/linux/tracepoint.h:236:5: note: in expansion of macro ‘TP_ARGS’
  236 |     TP_ARGS(data_args),   \
      |     ^~~~~~~
./include/linux/tracepoint.h:375:2: note: in expansion of macro ‘__DECLARE_TRACE’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~
./include/linux/tracepoint.h:378:4: note: in expansion of macro ‘PARAMS’
  378 |    PARAMS(__data, args))
      |    ^~~~~~
drivers/android/binder_trace.h:98:1: note: in expansion of macro ‘DECLARE_TRACE’
   98 | DECLARE_TRACE(binder_txn_latency_alloc,
      | ^~~~~~~~~~~~~
drivers/android/binder_trace.h:100:2: note: in expansion of macro ‘TP_ARGS’
  100 |  TP_ARGS(t, e)
      |  ^~~~~~~
./include/linux/tracepoint.h:191:6: error: too many arguments to function ‘(void (*)(void *, struct binder_transaction *))it_func’
  191 |     ((void(*)(proto))(it_func))(args); \
      |     ~^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/tracepoint.h:234:4: note: in expansion of macro ‘__DO_TRACE’
  234 |    __DO_TRACE(&__tracepoint_##name,  \
      |    ^~~~~~~~~~
./include/linux/tracepoint.h:375:2: note: in expansion of macro ‘__DECLARE_TRACE’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~
drivers/android/binder_trace.h:98:1: note: in expansion of macro ‘DECLARE_TRACE’
   98 | DECLARE_TRACE(binder_txn_latency_alloc,
      | ^~~~~~~~~~~~~
drivers/android/binder_trace.h: In function ‘trace_binder_txn_latency_alloc_rcuidle’:
drivers/android/binder_trace.h:100:13: error: ‘e’ undeclared (first use in this function)
  100 |  TP_ARGS(t, e)
      |             ^
./include/linux/tracepoint.h:191:33: note: in definition of macro ‘__DO_TRACE’
  191 |     ((void(*)(proto))(it_func))(args); \
      |                                 ^~~~
./include/linux/tracepoint.h:210:5: note: in expansion of macro ‘TP_ARGS’
  210 |     TP_ARGS(data_args),   \
      |     ^~~~~~~
./include/linux/tracepoint.h:244:2: note: in expansion of macro ‘__DECLARE_TRACE_RCU’
  244 |  __DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~~~~~
./include/linux/tracepoint.h:245:37: note: in expansion of macro ‘PARAMS’
  245 |   PARAMS(cond), PARAMS(data_proto), PARAMS(data_args)) \
      |                                     ^~~~~~
./include/linux/tracepoint.h:375:2: note: in expansion of macro ‘__DECLARE_TRACE’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~
./include/linux/tracepoint.h:378:4: note: in expansion of macro ‘PARAMS’
  378 |    PARAMS(__data, args))
      |    ^~~~~~
drivers/android/binder_trace.h:98:1: note: in expansion of macro ‘DECLARE_TRACE’
   98 | DECLARE_TRACE(binder_txn_latency_alloc,
      | ^~~~~~~~~~~~~
drivers/android/binder_trace.h:100:2: note: in expansion of macro ‘TP_ARGS’
  100 |  TP_ARGS(t, e)
      |  ^~~~~~~
./include/linux/tracepoint.h:191:6: error: too many arguments to function ‘(void (*)(void *, struct binder_transaction *))it_func’
  191 |     ((void(*)(proto))(it_func))(args); \
      |     ~^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/tracepoint.h:208:4: note: in expansion of macro ‘__DO_TRACE’
  208 |    __DO_TRACE(&__tracepoint_##name,  \
      |    ^~~~~~~~~~
./include/linux/tracepoint.h:244:2: note: in expansion of macro ‘__DECLARE_TRACE_RCU’
  244 |  __DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~~~~~
./include/linux/tracepoint.h:375:2: note: in expansion of macro ‘__DECLARE_TRACE’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~
drivers/android/binder_trace.h:98:1: note: in expansion of macro ‘DECLARE_TRACE’
   98 | DECLARE_TRACE(binder_txn_latency_alloc,
      | ^~~~~~~~~~~~~
drivers/android/binder_trace.h: At top level:
drivers/android/binder_trace.h:111:4: error: expected ‘;’, ‘,’ or ‘)’ before ‘int’
  111 |    int from_proc, int from_thread
      |    ^~~
./include/linux/tracepoint.h:231:34: note: in definition of macro ‘__DECLARE_TRACE’
  231 |  static inline void trace_##name(proto)    \
      |                                  ^~~~~
./include/linux/tracepoint.h:375:24: note: in expansion of macro ‘PARAMS’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |                        ^~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
./include/linux/tracepoint.h:511:22: note: in expansion of macro ‘PARAMS’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |                      ^~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:110:2: note: in expansion of macro ‘TP_PROTO’
  110 |  TP_PROTO(struct binder_transaction *t
      |  ^~~~~~~~
drivers/android/binder_trace.h:111:4: error: expected ‘;’, ‘,’ or ‘)’ before ‘int’
  111 |    int from_proc, int from_thread
      |    ^~~
./include/linux/tracepoint.h:205:44: note: in definition of macro ‘__DECLARE_TRACE_RCU’
  205 |  static inline void trace_##name##_rcuidle(proto)  \
      |                                            ^~~~~
./include/linux/tracepoint.h:244:28: note: in expansion of macro ‘PARAMS’
  244 |  __DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),  \
      |                            ^~~~~~
./include/linux/tracepoint.h:375:2: note: in expansion of macro ‘__DECLARE_TRACE’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~
./include/linux/tracepoint.h:375:24: note: in expansion of macro ‘PARAMS’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |                        ^~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
./include/linux/tracepoint.h:511:22: note: in expansion of macro ‘PARAMS’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |                      ^~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:110:2: note: in expansion of macro ‘TP_PROTO’
  110 |  TP_PROTO(struct binder_transaction *t
      |  ^~~~~~~~
drivers/android/binder_trace.h:111:4: error: expected ‘;’, ‘,’ or ‘)’ before ‘int’
  111 |    int from_proc, int from_thread
      |    ^~~
./include/linux/tracepoint.h:247:38: note: in definition of macro ‘__DECLARE_TRACE’
  247 |  register_trace_##name(void (*probe)(data_proto), void *data) \
      |                                      ^~~~~~~~~~
./include/linux/tracepoint.h:377:4: note: in expansion of macro ‘PARAMS’
  377 |    PARAMS(void *__data, proto),   \
      |    ^~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
./include/linux/tracepoint.h:511:22: note: in expansion of macro ‘PARAMS’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |                      ^~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:110:2: note: in expansion of macro ‘TP_PROTO’
  110 |  TP_PROTO(struct binder_transaction *t
      |  ^~~~~~~~
./include/linux/tracepoint.h:247:51: error: expected ‘;’, ‘,’ or ‘)’ before ‘void’
  247 |  register_trace_##name(void (*probe)(data_proto), void *data) \
      |                                                   ^~~~
./include/linux/tracepoint.h:375:2: note: in expansion of macro ‘__DECLARE_TRACE’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:111:4: error: expected ‘;’, ‘,’ or ‘)’ before ‘int’
  111 |    int from_proc, int from_thread
      |    ^~~
./include/linux/tracepoint.h:253:43: note: in definition of macro ‘__DECLARE_TRACE’
  253 |  register_trace_prio_##name(void (*probe)(data_proto), void *data,\
      |                                           ^~~~~~~~~~
./include/linux/tracepoint.h:377:4: note: in expansion of macro ‘PARAMS’
  377 |    PARAMS(void *__data, proto),   \
      |    ^~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
./include/linux/tracepoint.h:511:22: note: in expansion of macro ‘PARAMS’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |                      ^~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:110:2: note: in expansion of macro ‘TP_PROTO’
  110 |  TP_PROTO(struct binder_transaction *t
      |  ^~~~~~~~
./include/linux/tracepoint.h:253:56: error: expected ‘;’, ‘,’ or ‘)’ before ‘void’
  253 |  register_trace_prio_##name(void (*probe)(data_proto), void *data,\
      |                                                        ^~~~
./include/linux/tracepoint.h:375:2: note: in expansion of macro ‘__DECLARE_TRACE’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:111:4: error: expected ‘;’, ‘,’ or ‘)’ before ‘int’
  111 |    int from_proc, int from_thread
      |    ^~~
./include/linux/tracepoint.h:260:40: note: in definition of macro ‘__DECLARE_TRACE’
  260 |  unregister_trace_##name(void (*probe)(data_proto), void *data) \
      |                                        ^~~~~~~~~~
./include/linux/tracepoint.h:377:4: note: in expansion of macro ‘PARAMS’
  377 |    PARAMS(void *__data, proto),   \
      |    ^~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
./include/linux/tracepoint.h:511:22: note: in expansion of macro ‘PARAMS’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |                      ^~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:110:2: note: in expansion of macro ‘TP_PROTO’
  110 |  TP_PROTO(struct binder_transaction *t
      |  ^~~~~~~~
./include/linux/tracepoint.h:260:53: error: expected ‘;’, ‘,’ or ‘)’ before ‘void’
  260 |  unregister_trace_##name(void (*probe)(data_proto), void *data) \
      |                                                     ^~~~
./include/linux/tracepoint.h:375:2: note: in expansion of macro ‘__DECLARE_TRACE’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:111:4: error: expected ‘;’, ‘,’ or ‘)’ before ‘int’
  111 |    int from_proc, int from_thread
      |    ^~~
./include/linux/tracepoint.h:266:46: note: in definition of macro ‘__DECLARE_TRACE’
  266 |  check_trace_callback_type_##name(void (*cb)(data_proto)) \
      |                                              ^~~~~~~~~~
./include/linux/tracepoint.h:377:4: note: in expansion of macro ‘PARAMS’
  377 |    PARAMS(void *__data, proto),   \
      |    ^~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
./include/linux/tracepoint.h:511:22: note: in expansion of macro ‘PARAMS’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |                      ^~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:110:2: note: in expansion of macro ‘TP_PROTO’
  110 |  TP_PROTO(struct binder_transaction *t
      |  ^~~~~~~~
make[2]: *** [scripts/Makefile.build:283: drivers/android/binderfs.o] Error 1
make[2]: *** Waiting for unfinished jobs....
In file included from drivers/android/binder_latency_tracer.c:8:
drivers/android/binder_internal.h:141:20: error: ‘BINDERFS_MAX_NAME’ undeclared here (not in a function)
  141 |  char context_name[BINDERFS_MAX_NAME + 1];
      |                    ^~~~~~~~~~~~~~~~~
drivers/android/binder_internal.h:537:17: error: field ‘tv’ has incomplete type
  537 |  struct timeval tv;
      |                 ^~
In file included from drivers/android/binder_trace.h:12,
                 from drivers/android/binder_latency_tracer.c:9:
drivers/android/binder_trace.h: In function ‘trace_binder_txn_latency_alloc’:
drivers/android/binder_trace.h:100:13: error: ‘e’ undeclared (first use in this function)
  100 |  TP_ARGS(t, e)
      |             ^
./include/linux/tracepoint.h:191:33: note: in definition of macro ‘__DO_TRACE’
  191 |     ((void(*)(proto))(it_func))(args); \
      |                                 ^~~~
./include/linux/tracepoint.h:236:5: note: in expansion of macro ‘TP_ARGS’
  236 |     TP_ARGS(data_args),   \
      |     ^~~~~~~
./include/linux/tracepoint.h:375:2: note: in expansion of macro ‘__DECLARE_TRACE’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~
./include/linux/tracepoint.h:378:4: note: in expansion of macro ‘PARAMS’
  378 |    PARAMS(__data, args))
      |    ^~~~~~
drivers/android/binder_trace.h:98:1: note: in expansion of macro ‘DECLARE_TRACE’
   98 | DECLARE_TRACE(binder_txn_latency_alloc,
      | ^~~~~~~~~~~~~
drivers/android/binder_trace.h:100:2: note: in expansion of macro ‘TP_ARGS’
  100 |  TP_ARGS(t, e)
      |  ^~~~~~~
drivers/android/binder_trace.h:100:13: note: each undeclared identifier is reported only once for each function it appears in
  100 |  TP_ARGS(t, e)
      |             ^
./include/linux/tracepoint.h:191:33: note: in definition of macro ‘__DO_TRACE’
  191 |     ((void(*)(proto))(it_func))(args); \
      |                                 ^~~~
./include/linux/tracepoint.h:236:5: note: in expansion of macro ‘TP_ARGS’
  236 |     TP_ARGS(data_args),   \
      |     ^~~~~~~
./include/linux/tracepoint.h:375:2: note: in expansion of macro ‘__DECLARE_TRACE’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~
./include/linux/tracepoint.h:378:4: note: in expansion of macro ‘PARAMS’
  378 |    PARAMS(__data, args))
      |    ^~~~~~
drivers/android/binder_trace.h:98:1: note: in expansion of macro ‘DECLARE_TRACE’
   98 | DECLARE_TRACE(binder_txn_latency_alloc,
      | ^~~~~~~~~~~~~
drivers/android/binder_trace.h:100:2: note: in expansion of macro ‘TP_ARGS’
  100 |  TP_ARGS(t, e)
      |  ^~~~~~~
./include/linux/tracepoint.h:191:6: error: too many arguments to function ‘(void (*)(void *, struct binder_transaction *))it_func’
  191 |     ((void(*)(proto))(it_func))(args); \
      |     ~^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/tracepoint.h:234:4: note: in expansion of macro ‘__DO_TRACE’
  234 |    __DO_TRACE(&__tracepoint_##name,  \
      |    ^~~~~~~~~~
./include/linux/tracepoint.h:375:2: note: in expansion of macro ‘__DECLARE_TRACE’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~
drivers/android/binder_trace.h:98:1: note: in expansion of macro ‘DECLARE_TRACE’
   98 | DECLARE_TRACE(binder_txn_latency_alloc,
      | ^~~~~~~~~~~~~
drivers/android/binder_trace.h: At top level:
drivers/android/binder_trace.h:111:4: error: expected ‘;’, ‘,’ or ‘)’ before ‘int’
  111 |    int from_proc, int from_thread
      |    ^~~
./include/linux/tracepoint.h:231:34: note: in definition of macro ‘__DECLARE_TRACE’
  231 |  static inline void trace_##name(proto)    \
      |                                  ^~~~~
./include/linux/tracepoint.h:375:24: note: in expansion of macro ‘PARAMS’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |                        ^~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
./include/linux/tracepoint.h:511:22: note: in expansion of macro ‘PARAMS’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |                      ^~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:110:2: note: in expansion of macro ‘TP_PROTO’
  110 |  TP_PROTO(struct binder_transaction *t
      |  ^~~~~~~~
drivers/android/binder_trace.h:111:4: error: expected ‘;’, ‘,’ or ‘)’ before ‘int’
  111 |    int from_proc, int from_thread
      |    ^~~
./include/linux/tracepoint.h:247:38: note: in definition of macro ‘__DECLARE_TRACE’
  247 |  register_trace_##name(void (*probe)(data_proto), void *data) \
      |                                      ^~~~~~~~~~
./include/linux/tracepoint.h:377:4: note: in expansion of macro ‘PARAMS’
  377 |    PARAMS(void *__data, proto),   \
      |    ^~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
./include/linux/tracepoint.h:511:22: note: in expansion of macro ‘PARAMS’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |                      ^~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:110:2: note: in expansion of macro ‘TP_PROTO’
  110 |  TP_PROTO(struct binder_transaction *t
      |  ^~~~~~~~
./include/linux/tracepoint.h:247:51: error: expected ‘;’, ‘,’ or ‘)’ before ‘void’
  247 |  register_trace_##name(void (*probe)(data_proto), void *data) \
      |                                                   ^~~~
./include/linux/tracepoint.h:375:2: note: in expansion of macro ‘__DECLARE_TRACE’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:111:4: error: expected ‘;’, ‘,’ or ‘)’ before ‘int’
  111 |    int from_proc, int from_thread
      |    ^~~
./include/linux/tracepoint.h:253:43: note: in definition of macro ‘__DECLARE_TRACE’
  253 |  register_trace_prio_##name(void (*probe)(data_proto), void *data,\
      |                                           ^~~~~~~~~~
./include/linux/tracepoint.h:377:4: note: in expansion of macro ‘PARAMS’
  377 |    PARAMS(void *__data, proto),   \
      |    ^~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
./include/linux/tracepoint.h:511:22: note: in expansion of macro ‘PARAMS’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |                      ^~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:110:2: note: in expansion of macro ‘TP_PROTO’
  110 |  TP_PROTO(struct binder_transaction *t
      |  ^~~~~~~~
./include/linux/tracepoint.h:253:56: error: expected ‘;’, ‘,’ or ‘)’ before ‘void’
  253 |  register_trace_prio_##name(void (*probe)(data_proto), void *data,\
      |                                                        ^~~~
./include/linux/tracepoint.h:375:2: note: in expansion of macro ‘__DECLARE_TRACE’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:111:4: error: expected ‘;’, ‘,’ or ‘)’ before ‘int’
  111 |    int from_proc, int from_thread
      |    ^~~
./include/linux/tracepoint.h:260:40: note: in definition of macro ‘__DECLARE_TRACE’
  260 |  unregister_trace_##name(void (*probe)(data_proto), void *data) \
      |                                        ^~~~~~~~~~
./include/linux/tracepoint.h:377:4: note: in expansion of macro ‘PARAMS’
  377 |    PARAMS(void *__data, proto),   \
      |    ^~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
./include/linux/tracepoint.h:511:22: note: in expansion of macro ‘PARAMS’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |                      ^~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:110:2: note: in expansion of macro ‘TP_PROTO’
  110 |  TP_PROTO(struct binder_transaction *t
      |  ^~~~~~~~
./include/linux/tracepoint.h:260:53: error: expected ‘;’, ‘,’ or ‘)’ before ‘void’
  260 |  unregister_trace_##name(void (*probe)(data_proto), void *data) \
      |                                                     ^~~~
./include/linux/tracepoint.h:375:2: note: in expansion of macro ‘__DECLARE_TRACE’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:111:4: error: expected ‘;’, ‘,’ or ‘)’ before ‘int’
  111 |    int from_proc, int from_thread
      |    ^~~
./include/linux/tracepoint.h:266:46: note: in definition of macro ‘__DECLARE_TRACE’
  266 |  check_trace_callback_type_##name(void (*cb)(data_proto)) \
      |                                              ^~~~~~~~~~
./include/linux/tracepoint.h:377:4: note: in expansion of macro ‘PARAMS’
  377 |    PARAMS(void *__data, proto),   \
      |    ^~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
./include/linux/tracepoint.h:511:22: note: in expansion of macro ‘PARAMS’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |                      ^~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:110:2: note: in expansion of macro ‘TP_PROTO’
  110 |  TP_PROTO(struct binder_transaction *t
      |  ^~~~~~~~
In file included from drivers/android/binder.c:75:
drivers/android/binder_internal.h:537:17: error: field ‘tv’ has incomplete type
  537 |  struct timeval tv;
      |                 ^~
In file included from ./include/trace/syscall.h:5,
                 from ./include/linux/syscalls.h:84,
                 from drivers/android/binder.c:66:
drivers/android/binder_trace.h: In function ‘trace_binder_txn_latency_alloc’:
drivers/android/binder_trace.h:100:13: error: ‘e’ undeclared (first use in this function)
  100 |  TP_ARGS(t, e)
      |             ^
./include/linux/tracepoint.h:191:33: note: in definition of macro ‘__DO_TRACE’
  191 |     ((void(*)(proto))(it_func))(args); \
      |                                 ^~~~
./include/linux/tracepoint.h:236:5: note: in expansion of macro ‘TP_ARGS’
  236 |     TP_ARGS(data_args),   \
      |     ^~~~~~~
./include/linux/tracepoint.h:375:2: note: in expansion of macro ‘__DECLARE_TRACE’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~
./include/linux/tracepoint.h:378:4: note: in expansion of macro ‘PARAMS’
  378 |    PARAMS(__data, args))
      |    ^~~~~~
drivers/android/binder_trace.h:98:1: note: in expansion of macro ‘DECLARE_TRACE’
   98 | DECLARE_TRACE(binder_txn_latency_alloc,
      | ^~~~~~~~~~~~~
drivers/android/binder_trace.h:100:2: note: in expansion of macro ‘TP_ARGS’
  100 |  TP_ARGS(t, e)
      |  ^~~~~~~
drivers/android/binder_trace.h:100:13: note: each undeclared identifier is reported only once for each function it appears in
  100 |  TP_ARGS(t, e)
      |             ^
./include/linux/tracepoint.h:191:33: note: in definition of macro ‘__DO_TRACE’
  191 |     ((void(*)(proto))(it_func))(args); \
      |                                 ^~~~
./include/linux/tracepoint.h:236:5: note: in expansion of macro ‘TP_ARGS’
  236 |     TP_ARGS(data_args),   \
      |     ^~~~~~~
./include/linux/tracepoint.h:375:2: note: in expansion of macro ‘__DECLARE_TRACE’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~
./include/linux/tracepoint.h:378:4: note: in expansion of macro ‘PARAMS’
  378 |    PARAMS(__data, args))
      |    ^~~~~~
drivers/android/binder_trace.h:98:1: note: in expansion of macro ‘DECLARE_TRACE’
   98 | DECLARE_TRACE(binder_txn_latency_alloc,
      | ^~~~~~~~~~~~~
drivers/android/binder_trace.h:100:2: note: in expansion of macro ‘TP_ARGS’
  100 |  TP_ARGS(t, e)
      |  ^~~~~~~
./include/linux/tracepoint.h:191:6: error: too many arguments to function ‘(void (*)(void *, struct binder_transaction *))it_func’
  191 |     ((void(*)(proto))(it_func))(args); \
      |     ~^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/tracepoint.h:234:4: note: in expansion of macro ‘__DO_TRACE’
  234 |    __DO_TRACE(&__tracepoint_##name,  \
      |    ^~~~~~~~~~
./include/linux/tracepoint.h:375:2: note: in expansion of macro ‘__DECLARE_TRACE’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~
drivers/android/binder_trace.h:98:1: note: in expansion of macro ‘DECLARE_TRACE’
   98 | DECLARE_TRACE(binder_txn_latency_alloc,
      | ^~~~~~~~~~~~~
drivers/android/binder_trace.h: In function ‘trace_binder_txn_latency_alloc_rcuidle’:
drivers/android/binder_trace.h:100:13: error: ‘e’ undeclared (first use in this function)
  100 |  TP_ARGS(t, e)
      |             ^
./include/linux/tracepoint.h:191:33: note: in definition of macro ‘__DO_TRACE’
  191 |     ((void(*)(proto))(it_func))(args); \
      |                                 ^~~~
./include/linux/tracepoint.h:210:5: note: in expansion of macro ‘TP_ARGS’
  210 |     TP_ARGS(data_args),   \
      |     ^~~~~~~
./include/linux/tracepoint.h:244:2: note: in expansion of macro ‘__DECLARE_TRACE_RCU’
  244 |  __DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~~~~~
./include/linux/tracepoint.h:245:37: note: in expansion of macro ‘PARAMS’
  245 |   PARAMS(cond), PARAMS(data_proto), PARAMS(data_args)) \
      |                                     ^~~~~~
./include/linux/tracepoint.h:375:2: note: in expansion of macro ‘__DECLARE_TRACE’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~
./include/linux/tracepoint.h:378:4: note: in expansion of macro ‘PARAMS’
  378 |    PARAMS(__data, args))
      |    ^~~~~~
drivers/android/binder_trace.h:98:1: note: in expansion of macro ‘DECLARE_TRACE’
   98 | DECLARE_TRACE(binder_txn_latency_alloc,
      | ^~~~~~~~~~~~~
drivers/android/binder_trace.h:100:2: note: in expansion of macro ‘TP_ARGS’
  100 |  TP_ARGS(t, e)
      |  ^~~~~~~
./include/linux/tracepoint.h:191:6: error: too many arguments to function ‘(void (*)(void *, struct binder_transaction *))it_func’
  191 |     ((void(*)(proto))(it_func))(args); \
      |     ~^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/tracepoint.h:208:4: note: in expansion of macro ‘__DO_TRACE’
  208 |    __DO_TRACE(&__tracepoint_##name,  \
      |    ^~~~~~~~~~
./include/linux/tracepoint.h:244:2: note: in expansion of macro ‘__DECLARE_TRACE_RCU’
  244 |  __DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~~~~~
./include/linux/tracepoint.h:375:2: note: in expansion of macro ‘__DECLARE_TRACE’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~
drivers/android/binder_trace.h:98:1: note: in expansion of macro ‘DECLARE_TRACE’
   98 | DECLARE_TRACE(binder_txn_latency_alloc,
      | ^~~~~~~~~~~~~
drivers/android/binder_trace.h: At top level:
drivers/android/binder_trace.h:111:4: error: expected ‘;’, ‘,’ or ‘)’ before ‘int’
  111 |    int from_proc, int from_thread
      |    ^~~
./include/linux/tracepoint.h:231:34: note: in definition of macro ‘__DECLARE_TRACE’
  231 |  static inline void trace_##name(proto)    \
      |                                  ^~~~~
./include/linux/tracepoint.h:375:24: note: in expansion of macro ‘PARAMS’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |                        ^~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
./include/linux/tracepoint.h:511:22: note: in expansion of macro ‘PARAMS’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |                      ^~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:110:2: note: in expansion of macro ‘TP_PROTO’
  110 |  TP_PROTO(struct binder_transaction *t
      |  ^~~~~~~~
drivers/android/binder_trace.h:111:4: error: expected ‘;’, ‘,’ or ‘)’ before ‘int’
  111 |    int from_proc, int from_thread
      |    ^~~
./include/linux/tracepoint.h:205:44: note: in definition of macro ‘__DECLARE_TRACE_RCU’
  205 |  static inline void trace_##name##_rcuidle(proto)  \
      |                                            ^~~~~
./include/linux/tracepoint.h:244:28: note: in expansion of macro ‘PARAMS’
  244 |  __DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),  \
      |                            ^~~~~~
./include/linux/tracepoint.h:375:2: note: in expansion of macro ‘__DECLARE_TRACE’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~
./include/linux/tracepoint.h:375:24: note: in expansion of macro ‘PARAMS’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |                        ^~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
./include/linux/tracepoint.h:511:22: note: in expansion of macro ‘PARAMS’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |                      ^~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:110:2: note: in expansion of macro ‘TP_PROTO’
  110 |  TP_PROTO(struct binder_transaction *t
      |  ^~~~~~~~
drivers/android/binder_trace.h:111:4: error: expected ‘;’, ‘,’ or ‘)’ before ‘int’
  111 |    int from_proc, int from_thread
      |    ^~~
./include/linux/tracepoint.h:247:38: note: in definition of macro ‘__DECLARE_TRACE’
  247 |  register_trace_##name(void (*probe)(data_proto), void *data) \
      |                                      ^~~~~~~~~~
./include/linux/tracepoint.h:377:4: note: in expansion of macro ‘PARAMS’
  377 |    PARAMS(void *__data, proto),   \
      |    ^~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
./include/linux/tracepoint.h:511:22: note: in expansion of macro ‘PARAMS’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |                      ^~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:110:2: note: in expansion of macro ‘TP_PROTO’
  110 |  TP_PROTO(struct binder_transaction *t
      |  ^~~~~~~~
./include/linux/tracepoint.h:247:51: error: expected ‘;’, ‘,’ or ‘)’ before ‘void’
  247 |  register_trace_##name(void (*probe)(data_proto), void *data) \
      |                                                   ^~~~
./include/linux/tracepoint.h:375:2: note: in expansion of macro ‘__DECLARE_TRACE’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:111:4: error: expected ‘;’, ‘,’ or ‘)’ before ‘int’
  111 |    int from_proc, int from_thread
      |    ^~~
./include/linux/tracepoint.h:253:43: note: in definition of macro ‘__DECLARE_TRACE’
  253 |  register_trace_prio_##name(void (*probe)(data_proto), void *data,\
      |                                           ^~~~~~~~~~
./include/linux/tracepoint.h:377:4: note: in expansion of macro ‘PARAMS’
  377 |    PARAMS(void *__data, proto),   \
      |    ^~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
./include/linux/tracepoint.h:511:22: note: in expansion of macro ‘PARAMS’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |                      ^~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:110:2: note: in expansion of macro ‘TP_PROTO’
  110 |  TP_PROTO(struct binder_transaction *t
      |  ^~~~~~~~
./include/linux/tracepoint.h:253:56: error: expected ‘;’, ‘,’ or ‘)’ before ‘void’
  253 |  register_trace_prio_##name(void (*probe)(data_proto), void *data,\
      |                                                        ^~~~
./include/linux/tracepoint.h:375:2: note: in expansion of macro ‘__DECLARE_TRACE’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:111:4: error: expected ‘;’, ‘,’ or ‘)’ before ‘int’
  111 |    int from_proc, int from_thread
      |    ^~~
./include/linux/tracepoint.h:260:40: note: in definition of macro ‘__DECLARE_TRACE’
  260 |  unregister_trace_##name(void (*probe)(data_proto), void *data) \
      |                                        ^~~~~~~~~~
./include/linux/tracepoint.h:377:4: note: in expansion of macro ‘PARAMS’
  377 |    PARAMS(void *__data, proto),   \
      |    ^~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
./include/linux/tracepoint.h:511:22: note: in expansion of macro ‘PARAMS’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |                      ^~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:110:2: note: in expansion of macro ‘TP_PROTO’
  110 |  TP_PROTO(struct binder_transaction *t
      |  ^~~~~~~~
./include/linux/tracepoint.h:260:53: error: expected ‘;’, ‘,’ or ‘)’ before ‘void’
  260 |  unregister_trace_##name(void (*probe)(data_proto), void *data) \
      |                                                     ^~~~
./include/linux/tracepoint.h:375:2: note: in expansion of macro ‘__DECLARE_TRACE’
  375 |  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
      |  ^~~~~~~~~~~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:111:4: error: expected ‘;’, ‘,’ or ‘)’ before ‘int’
  111 |    int from_proc, int from_thread
      |    ^~~
./include/linux/tracepoint.h:266:46: note: in definition of macro ‘__DECLARE_TRACE’
  266 |  check_trace_callback_type_##name(void (*cb)(data_proto)) \
      |                                              ^~~~~~~~~~
./include/linux/tracepoint.h:377:4: note: in expansion of macro ‘PARAMS’
  377 |    PARAMS(void *__data, proto),   \
      |    ^~~~~~
./include/linux/tracepoint.h:511:2: note: in expansion of macro ‘DECLARE_TRACE’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |  ^~~~~~~~~~~~~
./include/linux/tracepoint.h:511:22: note: in expansion of macro ‘PARAMS’
  511 |  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
      |                      ^~~~~~
drivers/android/binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/binder_trace.h:110:2: note: in expansion of macro ‘TP_PROTO’
  110 |  TP_PROTO(struct binder_transaction *t
      |  ^~~~~~~~
drivers/android/binder_latency_tracer.c: In function ‘probe_binder_txn_latency_free’:
drivers/android/binder_latency_tracer.c:43:2: error: implicit declaration of function ‘rtc_time_to_tm’; did you mean ‘rtc_ktime_to_tm’? [-Werror=implicit-function-declaration]
   43 |  rtc_time_to_tm(t->tv.tv_sec, &tm);
      |  ^~~~~~~~~~~~~~
      |  rtc_ktime_to_tm
make[2]: *** [scripts/Makefile.build:283: drivers/android/binder_alloc.o] Error 1
drivers/android/binder_latency_tracer.c: In function ‘init_binder_latency_tracer’:
drivers/android/binder_latency_tracer.c:89:2: error: implicit declaration of function ‘register_trace_binder_txn_latency_free’; did you mean ‘register_trace_binder_txn_latency_info’? [-Werror=implicit-function-declaration]
   89 |  register_trace_binder_txn_latency_free(
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |  register_trace_binder_txn_latency_info
drivers/android/binder_latency_tracer.c: In function ‘exit_binder_latency_tracer’:
drivers/android/binder_latency_tracer.c:101:2: error: implicit declaration of function ‘unregister_trace_binder_txn_latency_free’; did you mean ‘unregister_trace_binder_txn_latency_info’? [-Werror=implicit-function-declaration]
  101 |  unregister_trace_binder_txn_latency_free(
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |  unregister_trace_binder_txn_latency_info
cc1: some warnings being treated as errors
make[2]: *** [scripts/Makefile.build:283: drivers/android/binder_latency_tracer.o] Error 1
drivers/android/binder.c: In function ‘binder_txn_latency_free’:
drivers/android/binder.c:1522:2: error: implicit declaration of function ‘trace_binder_txn_latency_free’; did you mean ‘trace_binder_txn_latency_info’? [-Werror=implicit-function-declaration]
 1522 |  trace_binder_txn_latency_free(t, from_proc, from_thread, to_proc, to_thread);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |  trace_binder_txn_latency_info
In file included from ./include/trace/define_trace.h:102,
                 from drivers/android/binder_trace.h:448,
                 from drivers/android/binder.c:5822:
drivers/android/./binder_trace.h: At top level:
drivers/android/./binder_trace.h:111:4: error: expected ‘;’, ‘,’ or ‘)’ before ‘int’
  111 |    int from_proc, int from_thread
      |    ^~~
./include/trace/trace_events.h:510:58: note: in definition of macro ‘DECLARE_EVENT_CLASS’
  510 |  struct trace_event_data_offsets_##call *__data_offsets, proto) \
      |                                                          ^~~~~
./include/trace/trace_events.h:76:9: note: in expansion of macro ‘PARAMS’
   76 |         PARAMS(proto),         \
      |         ^~~~~~
drivers/android/./binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/./binder_trace.h:110:2: note: in expansion of macro ‘TP_PROTO’
  110 |  TP_PROTO(struct binder_transaction *t
      |  ^~~~~~~~
In file included from ./include/trace/define_trace.h:102,
                 from drivers/android/binder_trace.h:448,
                 from drivers/android/binder.c:5822:
drivers/android/./binder_trace.h:111:4: error: expected ‘;’, ‘,’ or ‘)’ before ‘int’
  111 |    int from_proc, int from_thread
      |    ^~~
./include/trace/trace_events.h:674:44: note: in definition of macro ‘DECLARE_EVENT_CLASS’
  674 | trace_event_raw_event_##call(void *__data, proto)   \
      |                                            ^~~~~
./include/trace/trace_events.h:76:9: note: in expansion of macro ‘PARAMS’
   76 |         PARAMS(proto),         \
      |         ^~~~~~
drivers/android/./binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/./binder_trace.h:110:2: note: in expansion of macro ‘TP_PROTO’
  110 |  TP_PROTO(struct binder_transaction *t
      |  ^~~~~~~~
drivers/android/./binder_trace.h: In function ‘ftrace_test_probe_binder_txn_latency_free’:
./include/trace/trace_events.h:709:2: error: implicit declaration of function ‘check_trace_callback_type_binder_txn_latency_free’; did you mean ‘check_trace_callback_type_binder_txn_latency_info’? [-Werror=implicit-function-declaration]
  709 |  check_trace_callback_type_##call(trace_event_raw_event_##template); \
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/trace/trace_events.h:81:2: note: in expansion of macro ‘DEFINE_EVENT’
   81 |  DEFINE_EVENT(name, name, PARAMS(proto), PARAMS(args));
      |  ^~~~~~~~~~~~
drivers/android/./binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
./include/trace/trace_events.h:709:35: error: ‘trace_event_raw_event_binder_txn_latency_free’ undeclared (first use in this function); did you mean ‘trace_event_raw_binder_txn_latency_free’?
  709 |  check_trace_callback_type_##call(trace_event_raw_event_##template); \
      |                                   ^~~~~~~~~~~~~~~~~~~~~~
./include/trace/trace_events.h:81:2: note: in expansion of macro ‘DEFINE_EVENT’
   81 |  DEFINE_EVENT(name, name, PARAMS(proto), PARAMS(args));
      |  ^~~~~~~~~~~~
drivers/android/./binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/./binder_trace.h: At top level:
drivers/android/./binder_trace.h:111:4: error: expected ‘;’, ‘,’ or ‘)’ before ‘int’
  111 |    int from_proc, int from_thread
      |    ^~~
./include/trace/trace_events.h:618:34: note: in definition of macro ‘_TRACE_PERF_PROTO’
  618 |  perf_trace_##call(void *__data, proto);
      |                                  ^~~~~
./include/trace/trace_events.h:733:25: note: in expansion of macro ‘PARAMS’
  733 | _TRACE_PERF_PROTO(call, PARAMS(proto));     \
      |                         ^~~~~~
./include/trace/trace_events.h:75:2: note: in expansion of macro ‘DECLARE_EVENT_CLASS’
   75 |  DECLARE_EVENT_CLASS(name,          \
      |  ^~~~~~~~~~~~~~~~~~~
./include/trace/trace_events.h:76:9: note: in expansion of macro ‘PARAMS’
   76 |         PARAMS(proto),         \
      |         ^~~~~~
drivers/android/./binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/./binder_trace.h:110:2: note: in expansion of macro ‘TP_PROTO’
  110 |  TP_PROTO(struct binder_transaction *t
      |  ^~~~~~~~
In file included from ./include/trace/define_trace.h:102,
                 from drivers/android/binder_trace.h:448,
                 from drivers/android/binder.c:5822:
./include/trace/trace_events.h:740:13: error: ‘trace_event_raw_event_binder_txn_latency_free’ undeclared here (not in a function); did you mean ‘trace_event_raw_binder_txn_latency_free’?
  740 |  .probe   = trace_event_raw_event_##call,  \
      |             ^~~~~~~~~~~~~~~~~~~~~~
./include/trace/trace_events.h:75:2: note: in expansion of macro ‘DECLARE_EVENT_CLASS’
   75 |  DECLARE_EVENT_CLASS(name,          \
      |  ^~~~~~~~~~~~~~~~~~~
drivers/android/./binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
In file included from ./include/trace/define_trace.h:102,
                 from drivers/android/binder_trace.h:448,
                 from drivers/android/binder.c:5822:
./include/trace/trace_events.h:621:17: error: ‘perf_trace_binder_txn_latency_free’ undeclared here (not in a function); did you mean ‘print_fmt_binder_txn_latency_free’?
  621 |  .perf_probe  = perf_trace_##call,
      |                 ^~~~~~~~~~~
./include/trace/trace_events.h:742:2: note: in expansion of macro ‘_TRACE_PERF_INIT’
  742 |  _TRACE_PERF_INIT(call)      \
      |  ^~~~~~~~~~~~~~~~
./include/trace/trace_events.h:75:2: note: in expansion of macro ‘DECLARE_EVENT_CLASS’
   75 |  DECLARE_EVENT_CLASS(name,          \
      |  ^~~~~~~~~~~~~~~~~~~
drivers/android/./binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
In file included from ./include/trace/define_trace.h:103,
                 from drivers/android/binder_trace.h:448,
                 from drivers/android/binder.c:5822:
drivers/android/./binder_trace.h:111:4: error: expected ‘;’, ‘,’ or ‘)’ before ‘int’
  111 |    int from_proc, int from_thread
      |    ^~~
./include/trace/perf.h:33:33: note: in definition of macro ‘DECLARE_EVENT_CLASS’
   33 | perf_trace_##call(void *__data, proto)     \
      |                                 ^~~~~
./include/trace/trace_events.h:76:9: note: in expansion of macro ‘PARAMS’
   76 |         PARAMS(proto),         \
      |         ^~~~~~
drivers/android/./binder_trace.h:109:1: note: in expansion of macro ‘TRACE_EVENT’
  109 | TRACE_EVENT(binder_txn_latency_free,
      | ^~~~~~~~~~~
drivers/android/./binder_trace.h:110:2: note: in expansion of macro ‘TP_PROTO’
  110 |  TP_PROTO(struct binder_transaction *t
      |  ^~~~~~~~
cc1: some warnings being treated as errors
make[2]: *** [scripts/Makefile.build:283: drivers/android/binder.o] Error 1
make[1]: *** [scripts/Makefile.build:500: drivers/android] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1788: drivers] Error 2

