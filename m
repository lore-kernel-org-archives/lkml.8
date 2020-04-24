Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795DDC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 07:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD8F20767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 07:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJ8rlnTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgDXHmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 03:42:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23780 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726028AbgDXHmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 03:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587714170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pq0rFxNzsbZeUDvLXFspcqTdSBmNA3D6pMBx0tH5494=;
        b=FJ8rlnTKTFmrpjMo3la/AVHQsxbvcJjzEm7VsF43k+/7H9prbkZ+HOZLilRtz1+Yu5uxKA
        mnQG0eGlDQWKXffAVfky+5fongxde7b3UPj6qwfkiUcwSFS9CISIaSjAha94R25Ug/JV54
        WlpN4dgWx/A3v/STWRErpGpyerCnykA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-otv2gPttOaS88ebr9Xc2PA-1; Fri, 24 Apr 2020 03:42:44 -0400
X-MC-Unique: otv2gPttOaS88ebr9Xc2PA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 633D6107ACCD;
        Fri, 24 Apr 2020 07:42:42 +0000 (UTC)
Received: from krava (unknown [10.40.192.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7C67600EF;
        Fri, 24 Apr 2020 07:42:38 +0000 (UTC)
Date:   Fri, 24 Apr 2020 09:42:36 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v5 0/3] perf synthetic events
Message-ID: <20200424074236.GA1255225@krava>
References: <20200415054050.31645-1-irogers@google.com>
 <CAM9d7cj4fMsnDLgq0rHwqb6_ZLKP-AOzyyAP4kd=b=P5-t5NGQ@mail.gmail.com>
 <20200423142431.GJ19437@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423142431.GJ19437@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 11:24:31AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Apr 16, 2020 at 11:19:19PM +0900, Namhyung Kim escreveu:
> > On Wed, Apr 15, 2020 at 2:40 PM Ian Rogers <irogers@google.com> wrote:
> > > v4 added a missing test file
> > > v3 improved documenation, return values and added testing to the io framework
> > >    following feedback from namhyung@kernel.org.
> > > v2 addressed single threaded synthesize benchmark issues from jolsa@redhat.com
> > > https://lore.kernel.org/lkml/20200402154357.107873-1-irogers@google.com/
> > >
> > > Ian Rogers (3):
> > >   perf bench: add a multi-threaded synthesize benchmark
> > >   tools api: add a lightweight buffered reading api
> > >   perf synthetic events: Remove use of sscanf from /proc reading
> > 
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Jiri, you seem to be ok with it, can I get your Acked-by or Reviewed-by
> as well?

yep, it's good for me.. and I just found out that the new
version has tests for io functions, great! :-)

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

