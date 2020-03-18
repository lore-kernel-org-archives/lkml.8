Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC0FC5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A6520757
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="l7advMO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgCRPVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:21:18 -0400
Received: from ms11p00im-qufo17281801.me.com ([17.58.38.55]:48575 "EHLO
        ms11p00im-qufo17281801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726619AbgCRPVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1584544875; bh=yWf4/uOOJ3z75NIi29pM/3f+pnDGh2QRNthqEgRdhXo=;
        h=Date:From:To:Subject:Message-ID:Content-Type;
        b=l7advMO0a3wf8M7IFBA7BnnMEB5ENgHpMQlYefzcKsRcycp3hbgZ5KRpuL/2kfX+u
         O+NvupiCSOldm91V8DtnSqvH83E903Un5RoAZ/TBKnUgWXa1jwVN9BhIVRobRxnGVY
         xKzC2PelZ4p+IpJ6RLxbo/SE2EyQtYTX7JKKgD57iHYC8MjvM62jH2PwWhq0kwiVuP
         UeBZKeAWglo4fbgDuqZii7VjgWEjk2ABL+Bva+9bzDiBQOtXyy1+0tpiDwfuSVWNis
         Kv5ZPtg6dEMBZc3JwE8UZQa1rYCYKkd4AcRbdH3t4/tK7qj5ey7NBPmzCgvOa8a5c/
         3dzQBdeav25hw==
Received: from shwetrath.localdomain (unknown [66.199.8.131])
        by ms11p00im-qufo17281801.me.com (Postfix) with ESMTPSA id 3E6E11000EB;
        Wed, 18 Mar 2020 15:21:14 +0000 (UTC)
Date:   Wed, 18 Mar 2020 11:21:12 -0400
From:   Vijay Thakkar <vijaythakkar@me.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 2/3] perf vendor events amd: add Zen2 events
Message-ID: <20200318152112.GA231037@shwetrath.localdomain>
References: <20200316225238.150154-1-vijaythakkar@me.com>
 <20200316225238.150154-3-vijaythakkar@me.com>
 <20200318142057.GD11531@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318142057.GD11531@kernel.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-03-18_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2003180073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>   floating point:
>     fpu_pipe_assignment.total                         
>          [Total number of fp uOps]
>   
>   
>   Metric Groups:
>  

I just realized that I did not add back the counters for per pipe total
assignment as I said in the commit message. Patch 3/3 adds the total
uOp assignments per pipe for Zen1 based processors. Although the PPR for
Matisse does not list these counters, I can still sample them on my
Ryzen 3900X system and they seem to report correct numbers. For example,
here is the result of running:

$> perf stat -e r100,r200,r400,r800,rf00 ls

$> Performance counter stats for 'ls':

            5,047      r100:u
            5,236      r200:u
            31,300     r400:u
            2,040      r800:u
            43,623     fpu_pipe_assignment.total:u

Note that the per pipe total counters add up the overall total, which
makes me think I should submit a v6 of this patch adding the per pipe
totals for zen2 as well, especially since it is mentioned in the commit
message.

-Vijay
