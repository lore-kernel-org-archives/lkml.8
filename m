Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A92AC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2C852078C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgEGIfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 04:35:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:2947 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgEGIfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:35:37 -0400
IronPort-SDR: Z+lAl2FEz2jXd/QZul18QpnMAGNwHxDfbV8k9nSmx9Rd345ZW4i1DWJQNucXLOg3sNxKsYD3Cm
 KUuU37Xs4DCg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 01:35:37 -0700
IronPort-SDR: ZE1bQRvSz2AX4inPMw+9LKw12ZSOj6upC65GAttxe2kmGB58FkT0JRaki9Umo+v3TCw+OAEdVm
 pBh9AyRFFf8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,363,1583222400"; 
   d="scan'208";a="296458470"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 07 May 2020 01:35:37 -0700
Received: from [10.249.225.10] (abudanko-mobl.ccr.corp.intel.com [10.249.225.10])
        by linux.intel.com (Postfix) with ESMTP id 80A7A58048A;
        Thu,  7 May 2020 01:35:35 -0700 (PDT)
Subject: Re: [PATCH v2 07/11] perf docs: extend stat mode docs with info on
 --ctl-fd[-ack] options
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <d582cc3d-2302-c7e2-70d3-bc7ab6f628c3@linux.intel.com>
 <fb7c1fb9-2f6b-eb4b-d256-51253b29b4ac@linux.intel.com>
 <20200506202235.GG9893@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <10abe650-b73d-be76-23fb-9c341b459f5b@linux.intel.com>
Date:   Thu, 7 May 2020 11:35:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506202235.GG9893@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.05.2020 23:22, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 06, 2020 at 09:22:55PM +0300, Alexey Budankov escreveu:
>>
>> Extend perf-stat.txt file with --ctl-fd[-ack] options description.
>> Document possible usage model introduced by --ctl-fd[-ack] options
>> by providing example bash shell script.
> 
> Please update the docs in the same patch that introduces the options
> being documented.

Addressed in v3.

~Alexey

