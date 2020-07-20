Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDEAC433ED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3219B22B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgGTWZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 18:25:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:58951 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgGTWZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 18:25:02 -0400
IronPort-SDR: AVmOq5gjxDHxbjoDH3SwJo6mrZBRqHye8C1lbG2U/HmjtXxUzE+guuGj+7KXnwowlXiLtKXjyu
 RXOnVoyn9DsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="234872346"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="234872346"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 15:25:02 -0700
IronPort-SDR: 7/8S0vjEb159Htfk5t56meupFSDitBKxBe6kaGNj3wIIqVks0Bb4VPnQ+m4WL92KaLYoq3eDWw
 8jQv1c4zitmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="318149101"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga008.jf.intel.com with ESMTP; 20 Jul 2020 15:25:02 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 21189301BF5; Mon, 20 Jul 2020 15:25:02 -0700 (PDT)
Date:   Mon, 20 Jul 2020 15:25:02 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 12/12] perf intel-pt: Add support for decoding PSB+
 only
Message-ID: <20200720222502.GC1180481@tassilo.jf.intel.com>
References: <20200710151104.15137-1-adrian.hunter@intel.com>
 <20200710151104.15137-13-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710151104.15137-13-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 06:11:04PM +0300, Adrian Hunter wrote:
> A single q option decodes ip from only FUP/TIP packets. Make it so that
> repeating the q option (i.e. qq) decodes only PSB+, getting ip if there is
> a FUP packet within PSB+ (i.e. between PSB and PSBEND).
> 
> Example:
> 
>  $ perf record -e intel_pt//u grep -rI pudding drivers
>  [ perf record: Woken up 52 times to write data ]
>  [ perf record: Captured and wrote 57.870 MB perf.data ]
>  $ time perf script --itrace=bi | wc -l
>  58948289
> 
>  real    1m23.863s
>  user    1m23.251s
>  sys     0m7.452s
>  $ time perf script --itrace=biq | wc -l
>  3385694
> 
>  real    0m4.453s
>  user    0m4.455s
>  sys     0m0.328s
>  $ time perf script --itrace=biqq | wc -l
>  1883
> 
>  real    0m0.047s
>  user    0m0.043s
>  sys     0m0.009s
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/Documentation/perf-intel-pt.txt     | 15 +++++++++++++++
>  .../util/intel-pt-decoder/intel-pt-decoder.c   | 18 ++++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
> index f9fe4a4040ba..d5a266d7f15b 100644
> --- a/tools/perf/Documentation/perf-intel-pt.txt
> +++ b/tools/perf/Documentation/perf-intel-pt.txt
> @@ -999,6 +999,21 @@ What *will* be decoded with the (single) q option:
>  Note the q option does not specify what events will be synthesized e.g. the p
>  option must be used also to show power events.
>  
> +Repeating the q option (double-q i.e. qq) results in even faster decoding and even
> +less detail.  The decoder decodes only extended PSB (PSB+) packets, getting the
> +instruction pointer if there is a FUP packet within PSB+ (i.e. between PSB and
> +PSBEND).  Note PSB packets occur regularly in the trace based on the psb_period
> +config term (refer config terms section).  There will be a FUP packet if the
> +PSB+ occurs while control flow is being traced.

Some estimate would be good how frequent that is.

If we assume one bit per instruction then a 2K period it's roughly 16k instructions,
with the 16K period roughly 128K instructions.

Could be added in a followon patch.

But looks overall the patches look good to me now.

(for the whole series)
Reviewed-by: Andi Kleen <ak@linux.intel.com>
