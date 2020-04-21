Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77FFC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9034E206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgDUUGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:06:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:1677 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgDUUGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 16:06:32 -0400
IronPort-SDR: L4nZDE7pqRowTFaaI2BK0srPc+H5edwjFPNz4189iHpuc/w50FvUpDANIGc/t5OASve1kRkOVF
 jGaW8a9Z4tQg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 13:06:31 -0700
IronPort-SDR: RO23W0D2pXrfBWwzMV3NBUTnrL4YYUAL8T/lx+vgIyA22DauPPQtjCZGEMJ/0QjHOyTxzLsgnR
 OGJheq79i4KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; 
   d="scan'208";a="247267230"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga008.fm.intel.com with ESMTP; 21 Apr 2020 13:06:31 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 09B9E3019B6; Tue, 21 Apr 2020 13:06:31 -0700 (PDT)
Date:   Tue, 21 Apr 2020 13:06:30 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 3/3] perf stat: Add --metrics-file option
Message-ID: <20200421200630.GG608746@tassilo.jf.intel.com>
References: <20200421181337.988681-1-jolsa@kernel.org>
 <20200421181337.988681-4-jolsa@kernel.org>
 <20200421183615.GD608746@tassilo.jf.intel.com>
 <20200421185252.GA962614@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421185252.GA962614@krava>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Also there are some asserts that can be triggered by expressions. I think
> > you should fix those too and convert them to errors.
> 
> do you have some details on this? examples of those failures?

At a minimum 

/* Caller must make sure id is allocated */
void expr__add_id(struct parse_ctx *ctx, const char *name, double val)
{
        int idx;
        assert(ctx->num_ids < MAX_PARSE_ID);


-Andi
