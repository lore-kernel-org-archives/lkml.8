Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A9FC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58F552074F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M7nPWDHV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgDWKKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:10:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51748 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726346AbgDWKKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587636651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cwncJtFmANA7ahNHzX6G+N5K7VEBjnzraBEERAzAMzc=;
        b=M7nPWDHVQXNs+xULD8aXNpc4xTWDptFL/STHOHdJH8pbI2JLDHn28qF8PBaPVc+bUYPJHm
        w0tsLRLZXZpTlEhl94g5BX89kNHrdARTrqczVC+t2edo6TF5s7Scs87F9haQg8GCSEf/sk
        OSJtD03QvWm5tdtWw9Ua64pmlzu6jZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-r7s57EkKMoiRHo4hSIDwKw-1; Thu, 23 Apr 2020 06:10:38 -0400
X-MC-Unique: r7s57EkKMoiRHo4hSIDwKw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BE3FDBA5;
        Thu, 23 Apr 2020 10:10:36 +0000 (UTC)
Received: from krava (unknown [10.40.196.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D17FD1000325;
        Thu, 23 Apr 2020 10:10:32 +0000 (UTC)
Date:   Thu, 23 Apr 2020 12:10:30 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/8] perf metrics: fix parse errors in cascade lake
 metrics
Message-ID: <20200423101030.GB1136647@krava>
References: <20200422074809.160248-1-irogers@google.com>
 <20200422074809.160248-3-irogers@google.com>
 <20200422143840.GJ608746@tassilo.jf.intel.com>
 <CAP-5=fUnWAycQehCJ9=btquV2c3DVDX+tTEc85H8py9Kfehq4w@mail.gmail.com>
 <CAP-5=fUMFqiSFLbKA-XWStrePwxiYfq7Jk6mS9=F56Q9y-KVsA@mail.gmail.com>
 <46e803f3-80a4-0d37-9d39-b625b947ac7f@linux.intel.com>
 <cb5fcb4b-3ac6-66b5-9f9e-7943f4a6dadf@linux.intel.com>
 <CAP-5=fXVF_ExxVuiivF0JY3MwgxrQZqyFoPwn-p7DPf6Gbdh0g@mail.gmail.com>
 <abec8f03-ecb5-9bfe-c8ab-2c6d2aad2a60@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abec8f03-ecb5-9bfe-c8ab-2c6d2aad2a60@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 03:51:18PM +0800, Jin, Yao wrote:
> Hi Ian,
> 
> On 4/23/2020 2:09 PM, Ian Rogers wrote:
> > On Wed, Apr 22, 2020 at 10:54 PM Jin, Yao <yao.jin@linux.intel.com> wrote:
> > > 
> > > Hi Jiri,
> > > 
> > > Bisected to this commit which introduced the regression.
> > > 
> > > 26226a97724d ("perf expr: Move expr lexer to flex")
> > > 
> > > Would you like to look at that?
> > 
> > Hi Jin,
> > 
> > that commit breaks parsing of things like ','. See fixes in this patch
> > set such as:
> > https://lore.kernel.org/lkml/20200422220430.254014-5-irogers@google.com/
> > Fixing the lex issues then exposes other bugs that need to be
> > corrected in the json. I've added Fixes to the commit message of:
> > https://lore.kernel.org/lkml/20200422220430.254014-3-irogers@google.com/
> > https://lore.kernel.org/lkml/20200422220430.254014-4-irogers@google.com/
> > and would be glad of a review. If we can land:
> > https://lore.kernel.org/lkml/20200422220430.254014-12-irogers@google.com/
> > then expr as the source of parse errors can go away :-) The next
> > problem is the parse events code, but some of that logic is dependent
> > on the machine it is running on. It'd be good to add a test that
> > parsed events code can handle the events in metrics too, filtering out
> > things like duration_time that are special to metrics.
> > 
> > Thanks,
> > Ian
> > 
> 
> Only with the fix
> "https://lore.kernel.org/lkml/20200422220430.254014-5-irogers@google.com/"
> (without other json modifications), the issue was still there.
> 
> localhost:~ # perf stat -M DRAM_Read_Latency
> event syntax error:
> '../event=0x36,,umask=0x21/,cha/event=0x35,cha_0/event=0x0/}:W,duration_time'
>                                   \___ parser error
> 
>  Usage: perf stat [<options>] [<command>]
> 
>     -M, --metrics <metric/metric group list>
>                           monitor specified metrics or metric groups
> (separated by ,)

hum, I don't have that metric, is there another example of broken metric?

[jolsa@krava perf]$ sudo ./perf stat -M DRAM_Read_Latency
Cannot find metric or group `DRAM_Read_Latency'

> 
> So you added other commits which changed the json to let the parse work. But
> I don't know if we have to do with this way because it should be a
> regression issue.
> 
> In my opinion, we'd better fix the issue in 26226a97724d ("perf expr: Move
> expr lexer to flex") and try not to change the json if possible.

yea, that change definitely had a potential of breaking things ;-)
but it should be easy to fix them

I'll go through the v3 of the patchset

thanks,
jirka

