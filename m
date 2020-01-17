Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74015C33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBFE2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgAQXWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 18:22:21 -0500
Received: from mga06.intel.com ([134.134.136.31]:9932 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730075AbgAQXWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 18:22:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 15:21:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,332,1574150400"; 
   d="scan'208";a="257996483"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jan 2020 15:21:54 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id C455B300DE4; Fri, 17 Jan 2020 15:21:54 -0800 (PST)
Date:   Fri, 17 Jan 2020 15:21:54 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Greg KH <gregkh@linux-foundation.org>
Cc:     roman.sudarikov@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, bgregg@netflix.com, kan.liang@linux.intel.com,
        alexander.antonov@intel.com
Subject: Re: [PATCH v4 2/2] perf =?iso-8859-1?Q?x86?=
 =?iso-8859-1?Q?=3A_Exposing_an_Uncore_unit_to_PMON_for_Intel_Xeon?=
 =?iso-8859-1?Q?=AE?= server platform
Message-ID: <20200117232154.GP302770@tassilo.jf.intel.com>
References: <20200117133759.5729-1-roman.sudarikov@linux.intel.com>
 <20200117133759.5729-3-roman.sudarikov@linux.intel.com>
 <20200117141944.GC1856891@kroah.com>
 <20200117162357.GK302770@tassilo.jf.intel.com>
 <20200117165406.GA1937954@kroah.com>
 <20200117172726.GM302770@tassilo.jf.intel.com>
 <20200117184249.GB1969121@kroah.com>
 <20200117191220.GN302770@tassilo.jf.intel.com>
 <20200117230356.GA2093716@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117230356.GA2093716@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Roman, 
> > 
> > I suppose you'll need something like
> > 
> > /sys/device/system/dieXXX/pci-pmon<0-3>/bus 
> > 
> > and bus could be a symlink to the pci bus directory.
> 
> Why do you need to link to the pci bus directory?

The goal is to identify which bus is counted by the perfmon
counter. I suppose it could be a field containing the bus
identifier too, but I think symlinks are used elsewhere.

> > The whole thing will be ugly and complicated and slow and difficult
> > to parse, but it will presumably follow Greg's rules.
> 
> Who needs to parse this?  What tool will do it and for what?

perf parses is to output PCI bandwidth per PCI device.

-Andi

