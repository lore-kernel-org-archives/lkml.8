Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B271C55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3375A2077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LkkP80Z5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgDWODJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:03:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20623 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726060AbgDWODI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587650587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bwq59lAwZcqWx6DoQUqW9btvyMCwQqbrPUnucuTaXSI=;
        b=LkkP80Z5PKs2UlufakMswl3jS+dwuCFbPBM+eS8TBWkJyNJaUXbH1Ng+/gkbVMy5bU8Dhu
        laOi8S1drBcC6um7zbXRDT/tbC5FtaYHMIwu065KlB0g5zyn5jyR/LzGoX3bTvIOe9vUl+
        SWqgInMZefWYGcrQC+hyKt2bpBlQdFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-Hj0OtouUMO2odi5YGP4xCg-1; Thu, 23 Apr 2020 10:03:01 -0400
X-MC-Unique: Hj0OtouUMO2odi5YGP4xCg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD9508014D8;
        Thu, 23 Apr 2020 14:02:58 +0000 (UTC)
Received: from krava (ovpn-115-157.ams2.redhat.com [10.36.115.157])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 570A45D9D3;
        Thu, 23 Apr 2020 14:02:52 +0000 (UTC)
Date:   Thu, 23 Apr 2020 16:02:49 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 00/11] perf metric fixes and test
Message-ID: <20200423140249.GA1199027@krava>
References: <20200422220430.254014-1-irogers@google.com>
 <20200423112825.GD1136647@krava>
 <1dd2e280-d711-2dda-61b1-b81609af6467@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dd2e280-d711-2dda-61b1-b81609af6467@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 09:44:24PM +0800, Jin, Yao wrote:
> Hi Jiri,
> 
> On 4/23/2020 7:28 PM, Jiri Olsa wrote:
> > On Wed, Apr 22, 2020 at 03:04:19PM -0700, Ian Rogers wrote:
> > > Add a test that all perf metrics (for your architecture) are
> > > parsable. Fix bugs in the expr parser and in x86 metrics. Untested on
> > > architectures other than x86.
> > > 
> > > v2 adds Fixes tags to commit messages for when broken metrics were
> > >    first added. Adds a debug warning for division by zero in expr, and
> > >    adds a workaround for id values in the expr test necessary for
> > >    powerpc. It also fixes broken power8 and power9 metrics.
> > 
> > looks good to me
> > 
> > Jin Yao, is there a metric that's not working for you with this patchset
> > applied?
> > 
> > thanks,
> > jirka
> > 
> 
> Let me look for a CLX for testing, but maybe need some time.
> 
> BTW, suppose this patchset can work well, does it mean we will change the
> json file format in future?
> 
> For example,
> 
> before:
> cha@event\\=0x36\\\\\\
> 
> after:
> cha@event\\=0x36\\
> 
> "\\\\" are removed.
> 
> If so, we need to change our event generation script.

ok, maybe I got the wrong idea that the extra \\\\ were just
superfluous, what was the actual error there? and what's the
reason for that many '\' in there?

jirka

