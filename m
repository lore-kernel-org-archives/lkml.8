Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62CCC8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFF57207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgD3M3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:29:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:60995 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgD3M3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:29:05 -0400
IronPort-SDR: qSVaK0BMnsHcN4YRcza5qNc79crZW/g6x09WG95ugX9ESf6QUqGhUBjw9rTa9HDUYYQ2c/dk/0
 lqpyekd46OfA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 05:28:58 -0700
IronPort-SDR: 6YSFMBYXwpyyXlV/vNuHpYZr8IU+P06e7otUPiRm/OpihspGoC2H+YvkzZJeP89mfL2WL7tcLt
 VskZaNDBg2qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,334,1583222400"; 
   d="scan'208";a="368130860"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga001.fm.intel.com with ESMTP; 30 Apr 2020 05:28:58 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 20C82301AAA; Thu, 30 Apr 2020 05:28:58 -0700 (PDT)
Date:   Thu, 30 Apr 2020 05:28:58 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] perf intel-pt: Update documentation about itrace G
 and L options
Message-ID: <20200430122858.GD874567@tassilo.jf.intel.com>
References: <20200429150751.12570-1-adrian.hunter@intel.com>
 <20200429150751.12570-9-adrian.hunter@intel.com>
 <20200429230356.GB874567@tassilo.jf.intel.com>
 <0938999b-00c0-25cf-9a87-a7abc1cbac1c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0938999b-00c0-25cf-9a87-a7abc1cbac1c@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > On Skylake/Goldmont the PEBS event contains the TSC and the time stamp reported by
> > perf should report the time the event was sampled based on that TSC. 
> > Or is that not working for some reason?
> 
> I guess it is not working like that, but perf tools would probably need
> special rules to sort the events because the they would break the rules of
> PERF_RECORD_FINISHED_ROUND, wouldn't they?

Yes it may violate finished round.

It should not be delayed longer than the next context switch though.

The documentation warning would be still correct, but only on Broadwell.

-Andi
