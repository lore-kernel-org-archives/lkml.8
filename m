Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986DDC352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 20:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C9C2072B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 20:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgBEUrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 15:47:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:15298 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgBEUrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 15:47:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 12:47:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,407,1574150400"; 
   d="scan'208";a="249832502"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga002.jf.intel.com with ESMTP; 05 Feb 2020 12:47:06 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 8C24E3003A2; Wed,  5 Feb 2020 12:47:06 -0800 (PST)
From:   Andi Kleen <ak@linux.intel.com>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Roman Sudarikov <roman.sudarikov@linux.intel.com>,
        0day robot <lkp@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexander Antonov <alexander.antonov@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [perf x86] b77491648e: will-it-scale.per_process_ops -2.1% regression
References: <20200205123110.GN12867@shao2-debian>
Date:   Wed, 05 Feb 2020 12:47:06 -0800
In-Reply-To: <20200205123110.GN12867@shao2-debian> (kernel test robot's
        message of "Wed, 5 Feb 2020 20:31:10 +0800")
Message-ID: <87tv44danp.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <rong.a.chen@intel.com> writes:

> Greeting,
>
> FYI, we noticed a -2.1% regression of will-it-scale.per_process_ops due to commit:
>
>
> commit: b77491648e6eb2f26b6edf5eaea859adc17f4dcc ("perf x86: Infrastructure for exposing an Uncore unit to PMON mapping")
> https://github.com/0day-ci/linux/commits/roman-sudarikov-linux-intel-com/perf-x86-Exposing-IO-stack-to-IO-PMON-mapping-through-sysfs/20200118-075508

Seems to be spurious bisect. I don't think that commit could change
anything performance related.

-Andi
