Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C7DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F09BF20706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHYQpC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:45:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:24269 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgHYQo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:44:58 -0400
IronPort-SDR: +kU+jEL0JauKxlhOFwx6v941KB6DWFsVXNxXpk0lW0hqbnX92KvUj8Q5e/GjB5GERX2bai5Yib
 v1zXzqNLc7LQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="135700007"
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="135700007"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 09:44:43 -0700
IronPort-SDR: mOswLMnydWaBtvc3+C94OzV8rh9+ahLwbzVOpuHH0gxCXfz4ZU8KtwmsQ5MAJeChCo/0+Tc9pT
 j2dmn6jhxibQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,353,1592895600"; 
   d="scan'208";a="299153412"
Received: from fmsmsx603-2.cps.intel.com (HELO fmsmsx603.amr.corp.intel.com) ([10.18.84.213])
  by orsmga006.jf.intel.com with ESMTP; 25 Aug 2020 09:44:42 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 25 Aug 2020 09:44:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 SHSMSX605.ccr.corp.intel.com (10.109.6.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 26 Aug 2020 00:44:39 +0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Tue, 25 Aug 2020 09:44:37 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Tang, Feng" <feng.tang@intel.com>, Borislav Petkov <bp@suse.de>
CC:     "Chen, Rong A" <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "Mel Gorman" <mgorman@suse.com>
Subject: RE: [LKP] Re: [x86/mce] 1de08dccd3: will-it-scale.per_process_ops
 -14.1% regression
Thread-Topic: [LKP] Re: [x86/mce] 1de08dccd3: will-it-scale.per_process_ops
 -14.1% regression
Thread-Index: AQHWdTm7eFqn4vHQO0+vfjZnMLG+/6k+S8yAgADZR4CAAyQ1gIAFlB6AgAAFMQCAAAsTAIAA7Z2AgAA3A9A=
Date:   Tue, 25 Aug 2020 16:44:37 +0000
Message-ID: <b704f3c6298f46abbc59105ec0d52d14@intel.com>
References: <20200425114414.GU26573@shao2-debian>
 <20200425130136.GA28245@zn.tnic>
 <20200818082943.GA65567@shbuild999.sh.intel.com>
 <20200818200654.GA21494@agluck-desk2.amr.corp.intel.com>
 <20200819020437.GA2605@shbuild999.sh.intel.com>
 <20200821020259.GA90000@shbuild999.sh.intel.com>
 <20200824151425.GF4794@zn.tnic>
 <20200824153300.GA56944@shbuild999.sh.intel.com>
 <20200824161238.GI4794@zn.tnic>
 <20200825062305.GA83850@shbuild999.sh.intel.com>
In-Reply-To: <20200825062305.GA83850@shbuild999.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> These 2 variables are accessed in 2 hot call stacks (for this 288 CPU
> Xeon Phi platform):

This might be the key element of "weirdness" for this system. It
has 288 CPUs ... cache alignment problems are often not too bad
on "small" systems. The as you scale up to bigger machines you
suddenly hit some critical point and performance drops dramatically.

It's good that you are picking up tips on how to bisect these and diagnose
the underlying problem. Number of cores is going to keep increasing, so
we will keep finding new issues like this.

-Tony
