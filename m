Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4039FC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1045C2072A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgIBQLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:11:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:52905 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728393AbgIBQLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:11:23 -0400
IronPort-SDR: Nkv4QFO2wSh+RmfhOOyPnZMFUasuUocSOyr3wLBie0IH/uP2JrFWo5mk0FjDBkfFdrBYJFrzcT
 F28he9AYzS5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="145155091"
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; 
   d="scan'208";a="145155091"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 09:11:21 -0700
IronPort-SDR: dzq/eTDlVsR7B4yi7O/Ekb/ikEJN30Omp5QxCbDTyG1S8/Nh3R2rw+yhsu9OM9sTn50+n42ubu
 rpZNiETQ/MxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; 
   d="scan'208";a="331483741"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 02 Sep 2020 09:11:20 -0700
Received: from [10.249.227.213] (abudanko-mobl.ccr.corp.intel.com [10.249.227.213])
        by linux.intel.com (Postfix) with ESMTP id 239AE58041C;
        Wed,  2 Sep 2020 09:11:16 -0700 (PDT)
Subject: Re: [PATCH V2 2/6] perf tools: Handle read errors from ctl_fd
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20200901093758.32293-1-adrian.hunter@intel.com>
 <20200901093758.32293-3-adrian.hunter@intel.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <3172471f-7343-6efb-e549-ba7d95d7dfb3@linux.intel.com>
Date:   Wed, 2 Sep 2020 19:11:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901093758.32293-3-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.09.2020 12:37, Adrian Hunter wrote:
> Handle read errors from ctl_fd such as EINTR, EAGAIN and EWOULDBLOCK.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/evlist.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Acked-by: Alexei Budankov <alexey.budankov@linux.intel.com>

Regards,
Alexei
