Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ED0C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C880020730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgD1VTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:19:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:45107 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgD1VTX (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:19:23 -0400
IronPort-SDR: ekVH395EVnQm27mw07g689x6lmqlcL2e3bk2L3l7/2/Efa5YwfQ+8faRKTUNO/spJnXeG5bMDX
 w4j/t6ghRF8g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 14:19:22 -0700
IronPort-SDR: bag5SpE7t8r86mNew+tfQwib1/3eh0Vj6dUD+4YqpzkfxlBlQKaFJ7gOdWS6sNKGasCi2QMv9r
 zFZn5zgfZ/Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; 
   d="scan'208";a="336756828"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga001.jf.intel.com with ESMTP; 28 Apr 2020 14:19:22 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 78168301A7A; Tue, 28 Apr 2020 14:19:22 -0700 (PDT)
Date:   Tue, 28 Apr 2020 14:19:22 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Fix uncore event mixed metric with workload
 error issue
Message-ID: <20200428211922.GA874567@tassilo.jf.intel.com>
References: <20200427144116.27330-1-yao.jin@linux.intel.com>
 <20200428105155.GG1476763@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428105155.GG1476763@krava>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I wonder this would break some expectations.. would it be
> more safe to detect duration event and bypass it from the
> decission? but maybe the case I'm worried about is not a
> problem at all.. Andi?

Don't see what it would break.

Yes maybe we need to special case duration_time more, but that would
be a much bigger patch.

-Andi
