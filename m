Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984D0C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E776207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbgGWRk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:40:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:9789 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbgGWRk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:40:59 -0400
IronPort-SDR: NozlFLmUBW4UeE6AkHPqAsIRqGVEXoCJ/FNJA7yGeSQAyfwnh/2LTHsIgjd3Ie3HwqiExcjVKh
 zQ5XzgD+yLuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="235465905"
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="235465905"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 10:40:57 -0700
IronPort-SDR: RAfpaJHw8WJiVFP4kweZQQHB1+GYuCaviREqaujuZDXcnxNEXXRAmWn0YcH2MQ14U8leYoeucv
 ZZagawUd7HoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="432817650"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga004.jf.intel.com with ESMTP; 23 Jul 2020 10:40:57 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 11005301BF9; Thu, 23 Jul 2020 10:40:57 -0700 (PDT)
Date:   Thu, 23 Jul 2020 10:40:57 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     "Paul A. Clarke" <pc@us.ibm.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCHv3 00/19] perf metric: Add support to reuse metric
Message-ID: <20200723174057.GX1180481@tassilo.jf.intel.com>
References: <20200719181320.785305-1-jolsa@kernel.org>
 <20200721143702.GA15990@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
 <20200722181158.GF981884@krava>
 <20200723171404.GA15993@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723171404.GA15993@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> perf: util/evsel.c:1452: get_group_fd: Assertion `!(!leader->core.fd)' failed.                                                             
> Aborted (core dumped)
> ```

This usually happens when you run out of file descriptors

-Andi
