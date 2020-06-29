Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65EBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A26122053B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/jvES4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbgF2TED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:04:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34729 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730618AbgF2TDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593457433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FWDtF1fQ/mXJTKG1mwwIfkBgzU8jxhcN0FwqgicX+To=;
        b=M/jvES4G3CoUZJddXdRBmRJ0jT5g9ZJs0WmaPGVizDc/+bgoJWeAZ9lYLBuJ1zD5kvxRKo
        9E3t1zAnj0wNYWuwlBPrDZrE5IgR5rmsqimHVdD2LCdV+puzf/HCeVJJUH89wbyIdgT+2J
        jeif31mEmTPbTDTJH7iwhDPg6QmXX7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-lK8K4gwJN_moy10V8QBKFw-1; Mon, 29 Jun 2020 08:02:23 -0400
X-MC-Unique: lK8K4gwJN_moy10V8QBKFw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C07480401D;
        Mon, 29 Jun 2020 12:02:21 +0000 (UTC)
Received: from Diego (unknown [10.40.208.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96CFC7CAC5;
        Mon, 29 Jun 2020 12:02:17 +0000 (UTC)
Date:   Mon, 29 Jun 2020 14:02:04 +0200 (CEST)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     Andi Kleen <ak@linux.intel.com>
cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [RFC 00/10] perf tools: Add support to reuse metric
In-Reply-To: <20200626215759.GG818054@tassilo.jf.intel.com>
Message-ID: <alpine.LRH.2.20.2006291344440.4075@Diego>
References: <20200626194720.2915044-1-jolsa@kernel.org> <20200626212522.GF818054@tassilo.jf.intel.com> <CAP-5=fVMs4Ok3=gYmzheNTzbBUGGHbCr0cpJSm9TV45aeZb4Ng@mail.gmail.com> <20200626215759.GG818054@tassilo.jf.intel.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jun 2020, Andi Kleen wrote:
> > The name could be a metric or an event, the logic for each is quite
> 
> I would say collisions are unlikely. Event names follow quite structured
> patterns.

But across various architectures? I guess event names can be arbitrary.
In perftool-testsuite, I use the following regexp to match event names:
[\w\-\:\/_=,]+

> 
> > different. You could look up an event and when it fails assume it was
> > a metric, but I like the simplicity of this approach.
> 
> I don't think it's simpler for the user.
>
I think it should be clear at the user level whether they're using an event
or a metric (basically a couple of events together). I don't hiding too
much of details from users is any good.

> > Maybe this
> > change could be adopted more widely with something like "perf stat -e
> > metric:IPC -a -I 1000" rather than the current "perf stat -M IPC -a -I
> > 1000".
> 
> I thought about just adding metrics to -e, without metric: of course.
> 
> -Andi
> 
> 

