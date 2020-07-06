Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF730C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AAEC206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="m4A+mnWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgGFPE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:04:56 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:21782 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729121AbgGFPEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594047895; x=1625583895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=Ew3vRT154Ol4/zuZVDkZ5exVL7GH9YuhqqiIWXQtCoM=;
  b=m4A+mnWdOIYDKQVZ9dyxzSLQ65n+6DP/82nni6RNfhRMnzrUqbj6AixJ
   PDpQCGnGabj7JZbCQh+lVuD/rjMpprsdAogmC/EXJ6xzLCbTX6/Prtrwm
   HK1sZvnBtO9l6xXVzeSs9GsxFieuqznPtSf9PIkmx5e0fYeHKDfGLAWH3
   g=;
IronPort-SDR: Fh7tXpOohuIneZlCZHUDMeg2WpZSZ7XGjV7lp2FS3RMGmJs/q95kYM6CTwm18nf46ZUR+z9n/2
 LKwYIbWBnPqA==
X-IronPort-AV: E=Sophos;i="5.75,320,1589241600"; 
   d="scan'208";a="40246313"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 06 Jul 2020 15:04:48 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id D8A00A257E;
        Mon,  6 Jul 2020 15:04:45 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 15:04:45 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.34) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Jul 2020 15:04:29 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.de>,
        <Jonathan.Cameron@Huawei.com>, <aarcange@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <benh@kernel.crashing.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <foersleo@amazon.de>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <david@redhat.com>, <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v17 11/15] tools/damon/wss: Implement '--thres' option
Date:   Mon, 6 Jul 2020 17:04:13 +0200
Message-ID: <20200706150413.16213-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706115322.29598-12-sjpark@amazon.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13D31UWC003.ant.amazon.com (10.43.162.34) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jul 2020 13:53:18 +0200 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> Currently, 'wss' treats every region as working set if accessed at least
> once.  Someone who want to know performance important working set only
> would want to ignore regions having low access frequency.  '--thres'
> option can be used to set the minimal access frequency of the regions to
> be classified as the workingset.
> 
> Using this, users can plot the reuse histogram.  For example:
> 
>     $ damo record $(pidof raytrace)
>     $ for t in {1..20}; do ./tools/damon/damo report wss --thres $t | \
>     		grep avr | awk -v reuse_time=$(( (21 - t) * 5 )) \
>     		'{print reuse_time " " $3}'; done
>     100 12838416
>     95 2222623
>     90 1585480
>     85 422890
>     80 67040
>     75 45218
>     70 13242
>     65 12896
>     60 12136
>     55 10872
>     50 9648
>     45 8136
>     40 7052
>     35 6304
>     30 5736
>     25 5404
>     20 5305
>     15 5187
>     10 5069
>     5 4873
> 
> Above command shows the reuse histogram of parsec3.raytrace.  Remind
> that the sampling interval and aggregation interval are 5ms and 100ms
> by default and this command used the default values.  So, the above
> output means that about 12MB of memory region was reused within 100 ms
> while only about 2MB of memory region was reused within 95 ms, then
> about 1.5MB within 90ms, and so on, in average.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  tools/damon/wss.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/damon/wss.py b/tools/damon/wss.py
> index b43065176cfd..d2a1b149e3ea 100644
> --- a/tools/damon/wss.py
> +++ b/tools/damon/wss.py
> @@ -17,6 +17,8 @@ def set_argparser(parser):
>      parser.add_argument('--range', '-r', type=int, nargs=3,
>              metavar=('<start>', '<stop>', '<step>'),
>              help='range of wss percentiles to print')
> +    parser.add_argument('--thres', '-t', type=int, metavar='<# accesses>',
> +            help='minimal number of accesses for treated as working set')
>      parser.add_argument('--sortby', '-s', choices=['time', 'size'],
>              help='the metric to be used for the sort of the working set sizes')
>      parser.add_argument('--plot', '-p', type=str, metavar='<file>',
> @@ -67,7 +69,7 @@ def main(args=None):
>              wss = 0
>              for p in snapshot:
>                  # Ignore regions not accessed
> -                if p[1] <= 0:
> +                if p[1] < args.thres:

Oops, I forgot giving default value for the option.  I will set it as 1 in the
next spin.


Thanks,
SeongJae Park

>                      continue
>                  wss += p[0]
>              wss_dist.append(wss)
> -- 
> 2.17.1
> 
> 
> 
