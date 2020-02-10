Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7143FC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7432080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKUM9DCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbgBJN2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:28:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54761 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727784AbgBJN2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581341294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mPXhabgczbTMf25Zh3H3ZWdppn7J5d5aXBKo4Z9Cwr8=;
        b=CKUM9DCvOwFT5hr6QxhzM4ap9u7cCJvjv3AlC27CmvnWbBckY6rV7OS3jRdjALct2fEWGC
        PBafNUMGUE140vb/fDGMmae64n6ASxhMMvAn17mnwM14qQiddQL3lfv/x9GLHpK3SBuJIX
        W68ArE+q5PjL83eTq7iweYjGwDq/giA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-uREGZ89FND6f_aVOJ9z3Aw-1; Mon, 10 Feb 2020 08:28:10 -0500
X-MC-Unique: uREGZ89FND6f_aVOJ9z3Aw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D0901857340;
        Mon, 10 Feb 2020 13:28:09 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 40BF05C1D6;
        Mon, 10 Feb 2020 13:28:07 +0000 (UTC)
Date:   Mon, 10 Feb 2020 14:28:04 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Show percore counts in per CPU output
Message-ID: <20200210132804.GA9922@krava>
References: <20200206015613.527-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206015613.527-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 09:56:13AM +0800, Jin Yao wrote:
> We have supported the event modifier "percore" which sums up the
> event counts for all hardware threads in a core and show the counts
> per core.
> 
> For example,
> 
>  # perf stat -e cpu/event=cpu-cycles,percore/ -a -A -- sleep 1
> 
>   Performance counter stats for 'system wide':
> 
>  S0-D0-C0                395,072      cpu/event=cpu-cycles,percore/
>  S0-D0-C1                851,248      cpu/event=cpu-cycles,percore/
>  S0-D0-C2                954,226      cpu/event=cpu-cycles,percore/
>  S0-D0-C3              1,233,659      cpu/event=cpu-cycles,percore/
> 
> This patch provides a new option "--percore-show-thread". It is
> used with event modifier "percore" together to sum up the event counts
> for all hardware threads in a core but show the counts per hardware
> thread.
> 
> For example,
> 
>  # perf stat -e cpu/event=cpu-cycles,percore/ -a -A --percore-show-thread  -- sleep 1
> 
>   Performance counter stats for 'system wide':
> 
>  CPU0               2,453,061      cpu/event=cpu-cycles,percore/
>  CPU1               1,823,921      cpu/event=cpu-cycles,percore/
>  CPU2               1,383,166      cpu/event=cpu-cycles,percore/
>  CPU3               1,102,652      cpu/event=cpu-cycles,percore/
>  CPU4               2,453,061      cpu/event=cpu-cycles,percore/
>  CPU5               1,823,921      cpu/event=cpu-cycles,percore/
>  CPU6               1,383,166      cpu/event=cpu-cycles,percore/
>  CPU7               1,102,652      cpu/event=cpu-cycles,percore/

I don't understand how is this different from -A output:

  # ./perf stat -e cpu/event=cpu-cycles/ -A  
  ^C
   Performance counter stats for 'system wide':

  CPU0              56,847,497      cpu/event=cpu-cycles/                                       
  CPU1              75,274,384      cpu/event=cpu-cycles/                                       
  CPU2              63,866,342      cpu/event=cpu-cycles/                                       
  CPU3              89,559,693      cpu/event=cpu-cycles/                                       
  CPU4              74,761,132      cpu/event=cpu-cycles/                                       
  CPU5              76,320,191      cpu/event=cpu-cycles/                                       
  CPU6              55,100,175      cpu/event=cpu-cycles/                                       
  CPU7              48,472,895      cpu/event=cpu-cycles/                                       

       1.074800857 seconds time elapsed

also the interval output is mangled:

  # ./perf stat -e cpu/event=cpu-cycles,percore/ -a -A --percore-show-thread  -I 1000
  #           time CPU                    counts unit events
     1.000177375      1.000177375 CPU0             138,483,540      cpu/event=cpu-cycles,percore/                                   
     1.000177375      1.000177375 CPU1             143,159,477      cpu/event=cpu-cycles,percore/                                   
     1.000177375      1.000177375 CPU2             177,554,642      cpu/event=cpu-cycles,percore/                                   
     1.000177375      1.000177375 CPU3             150,974,512      cpu/event=cpu-cycles,percore/                                   
     1.000177375      1.000177375 CPU4             138,483,540      cpu/event=cpu-cycles,percore/                                   
     1.000177375      1.000177375 CPU5             143,159,477      cpu/event=cpu-cycles,percore/                                   
     1.000177375      1.000177375 CPU6             177,554,642      cpu/event=cpu-cycles,percore/                                   

jirka

