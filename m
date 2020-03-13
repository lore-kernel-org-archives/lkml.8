Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8D0C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F002206E7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgCMKFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:05:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:2716 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgCMKFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:05:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 03:05:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,548,1574150400"; 
   d="scan'208";a="237172230"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga008.jf.intel.com with ESMTP; 13 Mar 2020 03:05:16 -0700
Subject: Re: [PATCH 3/3] perf intel-pt: Update intel-pt.txt file with new
 location of the documentation
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20200311122034.3697-1-adrian.hunter@intel.com>
 <20200311122034.3697-4-adrian.hunter@intel.com>
 <20200311140312.GE19277@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b42e3bad-c000-dfe3-3193-46ecd9b597f6@intel.com>
Date:   Fri, 13 Mar 2020 12:04:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311140312.GE19277@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/20 4:03 pm, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 11, 2020 at 02:20:34PM +0200, Adrian Hunter escreveu:
>> Make it easy for people looking in intel-pt.txt to find the new file.
> 
> Nice, consider making it possible to do:
> 
> $ man intel-pt
> 
> And it go to what now is:
> 
> $ man perf-intel-pt

Couldn't find a way to do that, but after a mandb update, apropos should work.

> 
> Applied the set,

Thank you!
