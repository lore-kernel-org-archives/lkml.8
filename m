Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C618CC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33E720678
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388054AbgDBUmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 16:42:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:5472 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgDBUmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:42:09 -0400
IronPort-SDR: vnFhfmceGWd8DFaWmV3pNXFBy1mBSW+PKfe28nVcztVYWKrkO1xzsKzBCrr3j/jKxLMa5BQG47
 hHd2PfKoE6ng==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 13:42:07 -0700
IronPort-SDR: dsv12UYcSHLKqNQF74Motq/EX9D7xvMzgi32UbnDrmWg6Z/Sgm/2agiIymeOKwXeQBjWQC0rLF
 mXXC14UIZbig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="360320844"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2020 13:42:06 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 35467301813; Thu,  2 Apr 2020 13:42:06 -0700 (PDT)
Date:   Thu, 2 Apr 2020 13:42:06 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com,
        peterz@infradead.org, yao.jin@linux.intel.com, jolsa@kernel.org,
        kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de
Subject: Re: [PATCH v8 6/7] tools/perf: Enable Hz/hz prinitg for
 --metric-only option
Message-ID: <20200402204206.GB397326@tassilo.jf.intel.com>
References: <20200401203340.31402-1-kjain@linux.ibm.com>
 <20200401203340.31402-7-kjain@linux.ibm.com>
 <20200402124946.GH2518490@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402124946.GH2518490@krava>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index 9e757d18d713..679aaa655824 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -237,8 +237,6 @@ static bool valid_only_metric(const char *unit)
> >  	if (!unit)
> >  		return false;
> >  	if (strstr(unit, "/sec") ||
> > -	    strstr(unit, "hz") ||
> > -	    strstr(unit, "Hz") ||
> 
> will this change output of --metric-only for some setups then?
> 
> Andi, are you ok with this?

Yes should be ok

$ grep -i ScaleUnit.*hz arch/x86/*/* 
$ 

Probably was for some metric we later dropped.

-Andi
