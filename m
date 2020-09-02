Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A31C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F19C2072A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgIBQMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:12:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:53087 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbgIBQMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:12:46 -0400
IronPort-SDR: x9lGR0DWSHNB9BG2vun+L522HWfQsr/yY+pFhR4SHuIkHpezshzgoy3CvG077fu7yiJxDl6mwQ
 EQSMnR19K4Iw==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="145155728"
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; 
   d="scan'208";a="145155728"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 09:12:45 -0700
IronPort-SDR: uJk2Q26O0qhF/+1loWfKT4Q5vkoQFUR2eii9kjk8dCIrr0zDie2Z7CPdnidW5Sqe/+ijLx1C1X
 TxX6MiwMYoRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; 
   d="scan'208";a="315164870"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 02 Sep 2020 09:12:45 -0700
Received: from [10.249.227.213] (abudanko-mobl.ccr.corp.intel.com [10.249.227.213])
        by linux.intel.com (Postfix) with ESMTP id 4CF7758041C;
        Wed,  2 Sep 2020 09:12:44 -0700 (PDT)
Subject: Re: [PATCH V2 3/6] perf tools: Use AsciiDoc formatting for --control
 option documentation
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20200901093758.32293-1-adrian.hunter@intel.com>
 <20200901093758.32293-4-adrian.hunter@intel.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <00c35eb4-ed31-d5b0-eec7-f72ddd642b66@linux.intel.com>
Date:   Wed, 2 Sep 2020 19:12:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901093758.32293-4-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.09.2020 12:37, Adrian Hunter wrote:
> The --control option does not display well in man pages unless AsciiDoc
> formatting is used.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/Documentation/perf-record.txt | 46 ++++++++++++------------
>  tools/perf/Documentation/perf-stat.txt   | 46 ++++++++++++------------
>  2 files changed, 46 insertions(+), 46 deletions(-)

Thanks Adrian for all the formating corrections.

Acked-by: Alexei Budankov <alexey.budankov@linux.intel.com>

Regards,
Alexei
