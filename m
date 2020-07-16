Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F2BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABCED2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="caM4RhAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgGPLbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 07:31:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49853 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726350AbgGPLbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 07:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594899083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=59yLxtJ7mnARTTGB6sdN6bKh/2yVY9duMo19XJB54YQ=;
        b=caM4RhAvj5rElUybHAx/Bk7kbBDtL5VtQMwZ3mkRH3vWJ4QSEkxNAun9Tla3K6RbwBgfoF
        wEY97KSudNVf0vufpxxDX7+aYRWVJW1eu/h314Dmkn+OAeGh7n/lsbdNi0HBd6uXRLzXSl
        mRPTu9yc7xaPyifpUCKa9Ki8flCrUUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-1Fs4RPxzPZ-wYfkPHj2yAw-1; Thu, 16 Jul 2020 07:31:19 -0400
X-MC-Unique: 1Fs4RPxzPZ-wYfkPHj2yAw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B330100CCC1;
        Thu, 16 Jul 2020 11:31:17 +0000 (UTC)
Received: from krava (unknown [10.40.192.177])
        by smtp.corp.redhat.com (Postfix) with SMTP id AFCEB724C2;
        Thu, 16 Jul 2020 11:31:13 +0000 (UTC)
Date:   Thu, 16 Jul 2020 13:31:12 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Paul A. Clarke" <pc@us.ibm.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 00/18] perf metric: Add support to reuse metric
Message-ID: <20200716113112.GC391962@krava>
References: <20200712132634.138901-1-jolsa@kernel.org>
 <20200715183327.GA21935@oc3272150783.ibm.com>
 <20200715214134.GW183694@krava>
 <20200716012504.GA27583@oc3272150783.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716012504.GA27583@oc3272150783.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 08:25:04PM -0500, Paul A. Clarke wrote:

SNIP

> # perf --version
> perf version 4.18.0-214.el8.ppc64le
> # perf stat --metrics cpi_breakdown ./load >/dev/null             
> failed: way too many variables                                                               
>  Performance counter stats for './load':                                                     
>                                                                                              
>            818,130      pm_cmplu_stall_bru        #      0.0 bru_stall_cpi            (0.45%)
>      5,013,082,026      pm_run_inst_cmpl                                              (0.45%)
>                  0      pm_cmplu_stall_crypto     #      0.0 crypto_stall_cpi         (0.89%)
>      6,580,655,094      pm_run_inst_cmpl                                              (0.89%)
>         25,729,751      pm_cmplu_stall_dcache_miss #      0.0 dcache_miss_stall_cpi    (1.77%)
>      6,690,035,175      pm_run_inst_cmpl                                              (1.77%)
>                  0      pm_cmplu_stall_dflong     #      0.0 dflong_stall_cpi         (1.77%)
>      6,769,854,632      pm_run_inst_cmpl                                              (1.77%)
>                  0      pm_cmplu_stall_dfu        #      0.0 dfu_other_stall_cpi      (0.89%)
> [...and LOTS more...]
> ```
> 
> The second example in my previous post was from
> git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> branch perf/metric
> ```
> commit 7dd02cf0b9f04ca5339fa97f9a2280ebdd60b1db (grafted, HEAD -> perf/metric, origin/perf/metric)
> Author: Jiri Olsa <jolsa@kernel.org>
> Date:   Thu Jul 9 13:45:30 2020 +0200
> 
>     perf metric: Rename group_list to list
> ```
> 
> This build of `perf` fails:
> ```
> # ~/install/bin/perf --version
> perf version 5.8.rc4.g7dd02cf0b9f0
> # ~/install/bin/perf stat --metrics cpi_breakdown ./load >/dev/null
> 
>  Performance counter stats for './load':
> 
>      6,729,400,541      pm_run_inst_cmpl          #     0.00 bru_stall_cpi          
>             57,953      pm_cmplu_stall_bru                                          
> 
>        1.127319209 seconds time elapsed
> 
>        1.124906000 seconds user
>        0.000890000 seconds sys
> ```

ok, I can see that as well.. will fix in next version

thanks,
jirka

