Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A90C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A517207D0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgGIR7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:59:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:23953 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbgGIR7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:59:37 -0400
IronPort-SDR: +tFsXOP94UBMuWy7psc7A0fx68aWM1M6JGWS8vJJLvAJGdcceZsggERalC/bl0VnwkrNRJrS/j
 6sVBZ94F6GFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="148055093"
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="148055093"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 10:59:37 -0700
IronPort-SDR: pugdhxVyIR+ZTz7+RikkSRiRG5MaDlYQ5m4X1hd8XQo9cpWZBV/Nn7Xn5VjU2hTU7P4ldF1lmN
 dQB7WH5mWCLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,332,1589266800"; 
   d="scan'208";a="284237438"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga006.jf.intel.com with ESMTP; 09 Jul 2020 10:59:37 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 0F2F1301B2A; Thu,  9 Jul 2020 10:59:37 -0700 (PDT)
Date:   Thu, 9 Jul 2020 10:59:37 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] perf intel-pt: Add support for decoding PSB+ only
Message-ID: <20200709175937.GE1126680@tassilo.jf.intel.com>
References: <20200709173628.5613-1-adrian.hunter@intel.com>
 <20200709173628.5613-12-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709173628.5613-12-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
> index 758295a7e3d6..849474629fe7 100644
> --- a/tools/perf/Documentation/perf-intel-pt.txt
> +++ b/tools/perf/Documentation/perf-intel-pt.txt
> @@ -973,6 +973,9 @@ useful only if the control flow of interest is represented or indicated by FUP,
>  TIP, TIP.PGE, or TIP.PGD packets.  However the q option could be used to find
>  time ranges that could then be decoded fully using the --time option.
>  
> +Repeating the q option (i.e. qq) decodes only PSB+, getting ip if there is a
> +FUP packet within PSB+ (i.e. between PSB and PSBEND).

Also need high level description without PT jargon
(and perhaps also reference how to configure PSB frequency)

Other than that great feature. I'll be an enthuisastic user :-)

-Andi
> 
