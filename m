Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A58C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C86342065E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbgGMQ3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 12:29:44 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2470 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730240AbgGMQ3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:29:42 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 6E89987888D39E689AE0;
        Mon, 13 Jul 2020 17:29:40 +0100 (IST)
Received: from [127.0.0.1] (10.47.2.10) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 13 Jul
 2020 17:29:39 +0100
Subject: Re: [PATCH 11/18] perf metric: Add referenced metrics to hash data
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
References: <20200712132634.138901-1-jolsa@kernel.org>
 <20200712132634.138901-12-jolsa@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c55188aa-d8ff-ea5c-c8ed-a6f36d20c652@huawei.com>
Date:   Mon, 13 Jul 2020 17:27:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200712132634.138901-12-jolsa@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.2.10]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2020 14:26, Jiri Olsa wrote:
>   
> +int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
> +{
> +	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
> +	char *old_key = NULL;
> +	char *name;
> +	int ret;
> +
> +	data_ptr = zalloc(sizeof(*data_ptr));
> +	if (!data_ptr)
> +		return -ENOMEM;
> +
> +	name = strdup(ref->metric_name);
> +	if (!name) {
> +		free(data_ptr);
> +		return -ENOMEM;
> +	}

JFYI, this was not compiling for me:

util/expr.c: In function ‘expr__add_ref’:
util/expr.c:84:13: error: implicit declaration of function ‘zalloc’; did 
you mean ‘valloc’? [-Werror=implicit-function-declaration]
  data_ptr = zalloc(sizeof(*data_ptr));
  ^~~~~~
  valloc
util/expr.c:84:13: error: nested extern declaration of ‘zalloc’ 
[-Werror=nested-externs]
util/expr.c:84:11: error: assignment to ‘struct expr_id_data *’ from 
‘int’ makes pointer from integer without a cast [-Werror=int-conversion]
  data_ptr = zalloc(sizeof(*data_ptr));
^
  LDutil/arm-spe-decoder/perf-in.o
cc1: all warnings being treated as errors

I think the zalloc.h include is missing.

Thanks,
john
