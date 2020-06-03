Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1FBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34B58206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgFCMwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:52:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:57844 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgFCMwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:52:24 -0400
IronPort-SDR: JYDnpKQVVbueGPepN+baeajkoW+M8f1BSnUf7wcE2t2vTVhGCNW5V2oDTIPY/1MedDY9usN1xW
 QQJ4XFp8wtLQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 05:52:22 -0700
IronPort-SDR: PPfeuenW2epTA8ap6pF0m4tYhM8mx8pY2bNB6qgxt8dZK2HiVN440akTqqVGQZk/Dxok/JU53w
 A5CoYIzjzNbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="304363930"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jun 2020 05:52:21 -0700
Received: from [10.249.225.188] (abudanko-mobl.ccr.corp.intel.com [10.249.225.188])
        by linux.intel.com (Postfix) with ESMTP id 9484358045A;
        Wed,  3 Jun 2020 05:52:19 -0700 (PDT)
Subject: Re: [PATCH v6 13/13] perf record: introduce --ctl-fd[-ack] options
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <f8e3a714-d9b1-4647-e1d2-9981cbaa83ec@linux.intel.com>
 <fdb10392-15d9-be66-12e7-b1f465737a0e@linux.intel.com>
 <b4315665-b5e7-ff56-d9a6-0e7870daf9c9@intel.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <31937c13-93fe-001c-de88-6a1986e0eb2e@linux.intel.com>
Date:   Wed, 3 Jun 2020 15:52:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <b4315665-b5e7-ff56-d9a6-0e7870daf9c9@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.06.2020 15:24, Adrian Hunter wrote:
> On 1/06/20 11:20 pm, Alexey Budankov wrote:
>>
>> Introduce --ctl-fd[-ack] options to pass open file descriptors numbers
>> from command line. Extend perf-record.txt file with --ctl-fd[-ack]
> 
> perf-record.txt change seems to be missing.

Good catch, thanks!
Will add it to v7.

~Alexey
