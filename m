Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309F8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1393B206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgF2VeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:34:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:13469 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728630AbgF2Vd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:33:57 -0400
IronPort-SDR: W4F/L96Wg6shjp4F5mUwljVkF0dflLaPEeXoEROxvUO1Qnv5eCHg1/dHkZxYTXnMG2m4fOYoG9
 yq9bh+wOTOOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="207599721"
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="207599721"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 14:33:55 -0700
IronPort-SDR: +eiATfBA9bo4hucX3V0Y+/dJ1kiHgE21TReelGbH2BmoL+HHo566d99Q+X53f2SfpaqLtk32vm
 xUxRiyZKWw5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="277215572"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga003.jf.intel.com with ESMTP; 29 Jun 2020 14:33:54 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 959A7301BA3; Mon, 29 Jun 2020 14:33:54 -0700 (PDT)
Date:   Mon, 29 Jun 2020 14:33:54 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [RFC 00/10] perf tools: Add support to reuse metric
Message-ID: <20200629213354.GH818054@tassilo.jf.intel.com>
References: <20200626194720.2915044-1-jolsa@kernel.org>
 <b1fd3b2d-9312-bbb1-7803-426dbb737866@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1fd3b2d-9312-bbb1-7803-426dbb737866@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm guessing that those metric JSONs are human generated, so would be
> suitable; unlike the regular JSONs, which are automated.

The x86 metrics are auto generated too.

That's why you see the repetition.

-Andi
