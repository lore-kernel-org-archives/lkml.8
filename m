Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA7EC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3111B206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410581AbgDORAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:00:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:49709 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728755AbgDORAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:00:02 -0400
IronPort-SDR: 1Fw8VJjsP4yX0PKZVR8VJEJ6N+UBQbVhC2Sjg1PNkToRaCFBzAVVK00F3hWw2zEKGGfWfkmgV4
 qOW8VodAhMYQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 09:59:59 -0700
IronPort-SDR: WTJJO6LeACN+mktwEZNgLHesc6i3gOBVsV+8y3ibNLMoskZ/2JKT/XtqTDBWMfL3X9hABISSOb
 UNK5AuNfFKog==
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; 
   d="scan'208";a="453993581"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.190.90])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 09:59:56 -0700
Message-ID: <12612c48b9d00d10350d5e07587d90ae3759101f.camel@linux.intel.com>
Subject: Re: [PATCH] tools/power/x86/intel-speed-select: Fix CLX-N package
 information output
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Date:   Wed, 15 Apr 2020 09:59:53 -0700
In-Reply-To: <20200415161043.GU185537@smile.fi.intel.com>
References: <20200402180732.24684-1-prarit@redhat.com>
         <20200415161043.GU185537@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-15 at 19:10 +0300, Andy Shevchenko wrote:
> On Thu, Apr 02, 2020 at 02:07:32PM -0400, Prarit Bhargava wrote:
> > On CLX-N the perf-profile output is missing the package, die, and
> > cpu
> > output.  On CLX-N the pkg_dev struct will never be evaluated by the
> > core
> > code so pkg_dev.processed is always 0 and the package, die, and cpu
> > information is never output.
> > 
> > Set the pkg_dev.processed flag to 1 for CLX-N processors.
> 
Sorry Prarit. It took long to respond. The patch is fine. I am applying
to my tree.

-Srinivas

> I will accept this with PR from Srinivas whenever he sends one to
> public mailing list.
> 
> > Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> > Cc: andriy.shevchenko@linux.intel.com
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: platform-driver-x86@vger.kernel.org
> > ---
> >  tools/power/x86/intel-speed-select/isst-config.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/power/x86/intel-speed-select/isst-config.c
> > b/tools/power/x86/intel-speed-select/isst-config.c
> > index d1ac57be0cbd..2e64b9b6eb2e 100644
> > --- a/tools/power/x86/intel-speed-select/isst-config.c
> > +++ b/tools/power/x86/intel-speed-select/isst-config.c
> > @@ -1169,6 +1169,7 @@ static void dump_clx_n_config_for_cpu(int
> > cpu, void *arg1, void *arg2,
> >  
> >  		ctdp_level = &clx_n_pkg_dev.ctdp_level[0];
> >  		pbf_info = &ctdp_level->pbf_info;
> > +		clx_n_pkg_dev.processed = 1;
> >  		isst_ctdp_display_information(cpu, outf, tdp_level,
> > &clx_n_pkg_dev);
> >  		free_cpu_set(ctdp_level->core_cpumask);
> >  		free_cpu_set(pbf_info->core_cpumask);
> > -- 
> > 2.18.2
> > 

