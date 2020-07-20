Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2368C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF90C20773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgGTWSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 18:18:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:3492 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgGTWSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 18:18:50 -0400
IronPort-SDR: ebw9RI41mCPOb4NNmXz+cqiMCn31Fk/Z9trepjQAG3Poe/pO/8wzjzw796d4fzmUtRat6wOUK1
 3dAN+Q1lq6uQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="168161686"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="168161686"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 15:18:49 -0700
IronPort-SDR: ykhVZjiUcT4kLe6TfxfcUJny0qg1qH7Gym601un/ZrBpmSjhuc8jxezX2aHB7Vc17wlJnn0rSz
 mlhAUDgKPaFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="319688457"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jul 2020 15:18:49 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 4E356301BF5; Mon, 20 Jul 2020 15:18:49 -0700 (PDT)
Date:   Mon, 20 Jul 2020 15:18:49 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] perf intel-pt: Use itrace error flags to suppress
 some errors
Message-ID: <20200720221849.GB1180481@tassilo.jf.intel.com>
References: <20200709173628.5613-1-adrian.hunter@intel.com>
 <20200709173628.5613-6-adrian.hunter@intel.com>
 <20200709175046.GA1126680@tassilo.jf.intel.com>
 <3271e2cf-490b-5391-19e0-e1b019bfba1f@intel.com>
 <3002ad3a-2ce1-3414-f511-f30370ec0488@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3002ad3a-2ce1-3414-f511-f30370ec0488@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What about prefixing each flag with - i.e.
> 
> e-o
> e-l
> e-o-l

I was thinking square brackets, but yes the shell collision is a fair point.
- should work too.

-andi
