Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F086C3B1BF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 22:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1190520857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 22:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+RxyD7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgBPWyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 17:54:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58533 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726020AbgBPWyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 17:54:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581893658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wY+On70jeTKUmL93KlSyPFrtniUsOGRxpa63S3pqwMw=;
        b=E+RxyD7WY6rwAxx+c/H7KPmBgePy8emvnU/71QmeyPVQT13QhNzk/0UgPy8upv9IMT7FkS
        3/keRQO4MWwZut2REOnIT6TmrlCWrxIk8tzpckLRKfvx4t9s0ShzyoZN5asbsgCQjINtLy
        PTVWPwgHah+IyNhte8b/QpVVSrhbbrE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-OwOd2WqYNgWNfPa5oxo9PQ-1; Sun, 16 Feb 2020 17:54:14 -0500
X-MC-Unique: OwOd2WqYNgWNfPa5oxo9PQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7B878017CC;
        Sun, 16 Feb 2020 22:54:12 +0000 (UTC)
Received: from krava (ovpn-204-28.brq.redhat.com [10.40.204.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 78DD287058;
        Sun, 16 Feb 2020 22:54:10 +0000 (UTC)
Date:   Sun, 16 Feb 2020 23:54:07 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4] perf stat: Show percore counts in per CPU output
Message-ID: <20200216225407.GB157041@krava>
References: <20200214080452.26402-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214080452.26402-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 04:04:52PM +0800, Jin Yao wrote:

SNIP

>  CPU1               1,009,312      cpu/event=cpu-cycles,percore/
>  CPU2               2,784,072      cpu/event=cpu-cycles,percore/
>  CPU3               2,427,922      cpu/event=cpu-cycles,percore/
>  CPU4               2,752,148      cpu/event=cpu-cycles,percore/
>  CPU6               2,784,072      cpu/event=cpu-cycles,percore/
>  CPU7               2,427,922      cpu/event=cpu-cycles,percore/
> 
>         1.001416041 seconds time elapsed
> 
>  v4:
>  ---
>  Ravi Bangoria reports an issue in v3. Once we offline a CPU,
>  the output is not correct. The issue is we should use the cpu
>  idx in print_percore_thread rather than using the cpu value.

Acked-by: Jiri Olsa <jolsa@kernel.org>

btw, there's slight misalignment in -I output, but not due
to your change, it's there for some time now, and probably
in other agregation  outputs as well:


  $ sudo ./perf stat -e cpu/event=cpu-cycles/ -a -A  -I 1000
  #           time CPU                    counts unit events
       1.000224464 CPU0               7,251,151      cpu/event=cpu-cycles/                                       
       1.000224464 CPU1              21,614,946      cpu/event=cpu-cycles/                                       
       1.000224464 CPU2              30,812,097      cpu/event=cpu-cycles/                                       

should be (extra space after CPUX):

       1.000224464 CPU2               30,812,097      cpu/event=cpu-cycles/                                       

I'll put it on my TODO, but if you're welcome to check on it ;-)

thanks,
jirka

