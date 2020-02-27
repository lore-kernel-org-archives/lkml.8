Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF6CC4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1812467B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnBAZZ/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgB0MKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:10:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60990 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728856AbgB0MKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:10:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582805411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=47eZt9nqc2W9fzz4oCXWLbKvTh1nCIZ5kasqAm1JXXA=;
        b=SnBAZZ/a1KyCm+6q7ROFDYSbDEVegFU7JW3CvwdrR1U0o8k15bJwOUqlXQwwyBzqh6dbi8
        JZ0xVB+ujDeO2uFDPpF13U542KEhLUSfEFANPTRUI24GOvEU9HU+8utzSdeNir8ShldlN4
        yNhalJ4tsbGSRCK+N1g7+JJ5wyJMioA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-7e27G3WDNViPf9YEaXi6tA-1; Thu, 27 Feb 2020 07:10:07 -0500
X-MC-Unique: 7e27G3WDNViPf9YEaXi6tA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F9A713E6;
        Thu, 27 Feb 2020 12:10:05 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C0D8A90CD2;
        Thu, 27 Feb 2020 12:10:02 +0000 (UTC)
Date:   Thu, 27 Feb 2020 13:10:00 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCHv2 0/5] perf expr: Add flex scanner
Message-ID: <20200227121000.GE34774@krava>
References: <20200224082918.58489-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224082918.58489-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 09:29:13AM +0100, Jiri Olsa wrote:
> hi,
> while preparing changes for user defined metric expressions
> I also moved the expression manual parser to flex.
> 
> The reason is to have an easy and reasonable way to support
> and parse multiple user-defined metric expressions from
> command line or file.
> 
> I was posponing the change, but I just saw another update to
> the expr manual scanner (from Kajol Jain), so cherry picked
> just the expr flex code changes to get it out.
> 
> Kajol Jain,
> I think it should ease up your change for unknown values marked
> by '?'. Would you consider rebasing your changes on top of this?
> 
> 

kajoljain found and issue in this one, I'll send v3 as
soon as he confirms the fix

jirka


> v2 changes:
>   - handle special chars properly
>   - fix return value for expr__parse
> 
> Available also in:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/metric_flex
> 
> thanks,
> jirka
> 
> 
> ---
> Jiri Olsa (5):
>       perf expr: Add expr.c object
>       perf expr: Move expr lexer to flex
>       perf expr: Increase EXPR_MAX_OTHER
>       perf expr: Straighten expr__parse/expr__find_other interface
>       perf expr: Make expr__parse return -1 on error
> 
>  tools/perf/tests/expr.c       |  10 +++---
>  tools/perf/util/Build         |  11 ++++++-
>  tools/perf/util/expr.c        | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/expr.h        |   8 ++---
>  tools/perf/util/expr.l        |  87 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/expr.y        | 208 ++++++++++++++++++++++++++++++++-----------------------------------------------------------------------------------------
>  tools/perf/util/stat-shadow.c |   4 +--
>  7 files changed, 272 insertions(+), 168 deletions(-)
>  create mode 100644 tools/perf/util/expr.c
>  create mode 100644 tools/perf/util/expr.l
> 

