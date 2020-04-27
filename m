Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5C6C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 578C7206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGKOIT7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgD0KfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:35:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22495 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726504AbgD0KfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587983712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Limd025CqTlYHqx8+IfIv5PLeJKlBPlxkwPw54+yeek=;
        b=ZGKOIT7hojxRwqUyOBqRQcOajnexIdwv9NWbA13tkIj77zPP3j6jN4TSNiJGsytMKIS8+o
        fVK1b/GZZBYqJKS01LFwQRcEY1FBRWNkHvDjixl8VrdOdKBPfgih/LEcr6AjJTEV2/04OD
        KgGx1MEYhaTIiWgBvIQWSHARFD2M3K8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-uM6Xv3C2O3iKsN90FxOlbg-1; Mon, 27 Apr 2020 06:35:11 -0400
X-MC-Unique: uM6Xv3C2O3iKsN90FxOlbg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6231C800C78;
        Mon, 27 Apr 2020 10:35:09 +0000 (UTC)
Received: from krava (unknown [10.40.195.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 598715D70C;
        Mon, 27 Apr 2020 10:35:07 +0000 (UTC)
Date:   Mon, 27 Apr 2020 12:35:05 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Nick Gasson <nick.gasson@arm.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 0/3] perf jvmti: Various fixes to JVMTI agent
Message-ID: <20200427103505.GA1476763@krava>
References: <20200427061520.24905-1-nick.gasson@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427061520.24905-1-nick.gasson@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 02:15:13PM +0800, Nick Gasson wrote:
> Hi,

adding Stephane to the loop

jirka

> 
> These three patches fix a couple of issues I ran into while using the
> jitdump JVMTI agent to profile the SPECjbb benchmark.
> 
> Tested with OpenJDK 8 and 14.
> 
> Thanks,
> Nick
> 
> 
> Nick Gasson (3):
>   perf jvmti: Fix jitdump for methods without debug info
>   perf jvmti: Do not report error when missing debug information
>   perf jvmti: Fix demangling Java symbols
> 
>  tools/perf/jvmti/libjvmti.c           | 24 +++++++--------
>  tools/perf/tests/Build                |  1 +
>  tools/perf/tests/builtin-test.c       |  4 +++
>  tools/perf/tests/demangle-java-test.c | 42 +++++++++++++++++++++++++++
>  tools/perf/tests/tests.h              |  1 +
>  tools/perf/util/demangle-java.c       | 13 +++++----
>  6 files changed, 66 insertions(+), 19 deletions(-)
>  create mode 100644 tools/perf/tests/demangle-java-test.c
> 
> -- 
> 2.26.1
> 

