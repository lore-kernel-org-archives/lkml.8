Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BDCC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22DBF2078D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgHXPmq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:42:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:4738 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgHXPj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:39:27 -0400
IronPort-SDR: Wn9zzGXdoQaIbuan1iLH5Ja1D550aM7G/T48IjjAK4ebNw7f+aKWRzsydQhk7mMFzRUMumPVEv
 zJoJddDux0Og==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="155911950"
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="155911950"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 08:38:59 -0700
IronPort-SDR: OXGKpCExxzOcDnP+9+nDPRBYDX0Rz4GWrLd/kIgqZv6PvbbvIW34Ae6s3iWxcqtqzN9OqskkrV
 xaBwVtfE/QSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="499513514"
Received: from fmsmsx601-2.cps.intel.com (HELO fmsmsx601.amr.corp.intel.com) ([10.18.84.211])
  by fmsmga005.fm.intel.com with ESMTP; 24 Aug 2020 08:38:59 -0700
Received: from shsmsx604.ccr.corp.intel.com (10.109.6.214) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 24 Aug 2020 08:38:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 SHSMSX604.ccr.corp.intel.com (10.109.6.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 24 Aug 2020 23:38:55 +0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Mon, 24 Aug 2020 08:38:53 -0700
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
Thread-Index: AQHWdTm7eFqn4vHQO0+vfjZnMLG+/6k+S8yAgADZR4CAAyQ1gIAFlB6AgAAFMQD//4tJoA==
Date:   Mon, 24 Aug 2020 15:38:53 +0000
Message-ID: <6e996ad05e434a6fb13f069ee72b876b@intel.com>
References: <20200425114414.GU26573@shao2-debian>
 <20200425130136.GA28245@zn.tnic>
 <20200818082943.GA65567@shbuild999.sh.intel.com>
 <20200818200654.GA21494@agluck-desk2.amr.corp.intel.com>
 <20200819020437.GA2605@shbuild999.sh.intel.com>
 <20200821020259.GA90000@shbuild999.sh.intel.com>
 <20200824151425.GF4794@zn.tnic>
 <20200824153300.GA56944@shbuild999.sh.intel.com>
In-Reply-To: <20200824153300.GA56944@shbuild999.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, that's what we suspected. And I just did another try to force the
> percpu mce structure aligned. And the regression seems to be gone (reduced
> from 14.1% to 2%), which further proved it.

I wonder whether it would be useful for bisection of performance issues
for you to change the global definition of DEFINE_PER_CPU() to make
all per CPU definitions aligned. Just like you switch compiler flags to make
all functions aligned.

-Tony
