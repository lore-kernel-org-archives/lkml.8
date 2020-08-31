Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFBBC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 735862072D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgHaHE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 03:04:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:32881 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgHaHEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 03:04:25 -0400
IronPort-SDR: c836ObG9SCR551eSOm/x+vng0TtKsbm8Sc3nNgx7BjJPHuIzzQuLEy/GZf/anidQzrFbCeQzQq
 qpKzZO1MffTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="136454593"
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; 
   d="scan'208";a="136454593"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 00:04:24 -0700
IronPort-SDR: +mGfJ4fN8GdX+b3galXYZm21+cuocKgUviGrYgLujy61A368eUKMv9P3+Btyp5No5MHi7pc9LD
 8t+h/Pxhldig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,374,1592895600"; 
   d="scan'208";a="300952317"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by orsmga006.jf.intel.com with ESMTP; 31 Aug 2020 00:04:18 -0700
Subject: Re: [PATCH 5/6] perf record: Add 'snapshot' control command
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20200829105015.10800-1-adrian.hunter@intel.com>
 <20200829105015.10800-6-adrian.hunter@intel.com>
 <20200831062332.GW1509399@tassilo.jf.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <64a87689-8ce9-c54a-98fd-b6ad7fd3aa92@intel.com>
Date:   Mon, 31 Aug 2020 10:03:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831062332.GW1509399@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/20 9:23 am, Andi Kleen wrote:
> On Sat, Aug 29, 2020 at 01:50:14PM +0300, Adrian Hunter wrote:
>> Add 'snapshot' control command to create an AUX area tracing snapshot the
>> same as if sending SIGUSR2. The advantage of the FIFO is that access is
>> governed by access to the FIFO.
> 
> How about the --switch-output SIGUSR2 switch? Could that be handled too?

Presumably, but I have never used --switch-out because Intel PT does not yet
support it (it is on the list of things to do).  Perhaps someone more
familiar with it can add that :-)

> 
> Other than that it looks great. Thanks.
> 
> -Andi
> 

