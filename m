Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1848C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A893622B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiTtAYWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgGTITz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:19:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38634 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725845AbgGTITz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595233193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GTGhFmOt6nh9DWYCFCmLMonMPaGDn7DEOdXhvc0J0fk=;
        b=RiTtAYWaKmV8uPDo8r5Nx/ULYxLPUpakTfijiwB7tA8K4eFWMlSS0QJ3fezm30/fjD3ddd
        acvWPSXjeWZrG2dsh1PySvgIxLGyb+6cRMbk/rCnz25H24AnERYkAiaV5UfDFY6d+6dqj4
        CezuJ9jjd8F5Pd4GPrNCASyRRek84LY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-Qv1HR-_COtiESlQ66cdNYg-1; Mon, 20 Jul 2020 04:19:49 -0400
X-MC-Unique: Qv1HR-_COtiESlQ66cdNYg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2C14107ACCA;
        Mon, 20 Jul 2020 08:19:47 +0000 (UTC)
Received: from krava (unknown [10.40.192.229])
        by smtp.corp.redhat.com (Postfix) with SMTP id C32241001B07;
        Mon, 20 Jul 2020 08:19:44 +0000 (UTC)
Date:   Mon, 20 Jul 2020 10:19:43 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCHv3 00/19] perf metric: Add support to reuse metric
Message-ID: <20200720081943.GE760733@krava>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <dbe59791-937d-de95-4ba0-c34e7a1cd273@linux.ibm.com>
 <20200720072237.GC760733@krava>
 <6cb72b48-5244-9faf-a9e5-67858c732b83@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cb72b48-5244-9faf-a9e5-67858c732b83@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 01:39:24PM +0530, kajoljain wrote:

SNIP

> This is with your perf/metric branch:
> command# ./perf stat -M PowerBUS_Frequency -C 0 -I 1000
> assertion failed at util/metricgroup.c:709
> #           time             counts unit events
>      1.000054545          7,807,505      hv_24x7/pm_pb_cyc,chip=0/ #      2.0 GHz  PowerBUS_Frequency_0
>      1.000054545          7,807,485      hv_24x7/pm_pb_cyc,chip=1/                                   
>      2.000232761          7,807,500      hv_24x7/pm_pb_cyc,chip=0/ #      2.0 GHz  PowerBUS_Frequency_0
>      2.000232761          7,807,478      hv_24x7/pm_pb_cyc,chip=1/                                   
>      3.000363762          7,799,665      hv_24x7/pm_pb_cyc,chip=0/ #      1.9 GHz  PowerBUS_Frequency_0
>      3.000363762          7,807,502      hv_24x7/pm_pb_cyc,chip=1/                                   
> ^C     3.259418599          2,022,150      hv_24x7/pm_pb_cyc,chip=0/ #      0.5 GHz  PowerBUS_Frequency_0
>      3.259418599          2,022,164      hv_24x7/pm_pb_cyc,chip=1/                                   
> 
>  Performance counter stats for 'CPU(s) 0':
> 
>         25,436,820      hv_24x7/pm_pb_cyc,chip=0/ #      6.4 GHz  PowerBUS_Frequency_0
>         25,444,629      hv_24x7/pm_pb_cyc,chip=1/                                   
> 
>        3.259505529 seconds time elapsed

I found the bug, we are not adding runtime metrics as standalone ones,
but as referenced metrics.. will fix and try to add test for that

as for testing.. do I need some special ppc server to have support for this? 

thanks,
jirka

