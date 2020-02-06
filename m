Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86F9C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 03:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B099E20674
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 03:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgBFDHU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 22:07:20 -0500
Received: from mga11.intel.com ([192.55.52.93]:35007 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgBFDHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 22:07:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 19:07:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,408,1574150400"; 
   d="scan'208";a="235820044"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga006.jf.intel.com with ESMTP; 05 Feb 2020 19:07:19 -0800
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 5 Feb 2020 19:07:18 -0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.126]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.97]) with mapi id 14.03.0439.000;
 Thu, 6 Feb 2020 11:07:17 +0800
From:   "Li, Philip" <philip.li@intel.com>
To:     Andi Kleen <ak@linux.intel.com>,
        "Chen, Rong A" <rong.a.chen@intel.com>
CC:     Roman Sudarikov <roman.sudarikov@linux.intel.com>,
        lkp <lkp@intel.com>, Kan Liang <kan.liang@linux.intel.com>,
        "Antonov, Alexander" <alexander.antonov@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>
Subject: RE: [LKP] Re: [perf x86] b77491648e: will-it-scale.per_process_ops
 -2.1% regression
Thread-Topic: [LKP] Re: [perf x86] b77491648e: will-it-scale.per_process_ops
 -2.1% regression
Thread-Index: AQHV3GVxtV9AZpMZekqZJwJ+vcCDDqgNe3dw
Date:   Thu, 6 Feb 2020 03:07:15 +0000
Message-ID: <831EE4E5E37DCC428EB295A351E6624952397CEA@shsmsx102.ccr.corp.intel.com>
References: <20200205123110.GN12867@shao2-debian>
 <87tv44danp.fsf@linux.intel.com>
In-Reply-To: <87tv44danp.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [LKP] Re: [perf x86] b77491648e: will-it-scale.per_process_ops -2.1%
> regression
> 
> kernel test robot <rong.a.chen@intel.com> writes:
> 
> > Greeting,
> >
> > FYI, we noticed a -2.1% regression of will-it-scale.per_process_ops due to
> commit:
> >
> >
> > commit: b77491648e6eb2f26b6edf5eaea859adc17f4dcc ("perf x86: Infrastructure
> for exposing an Uncore unit to PMON mapping")
> > https://github.com/0day-ci/linux/commits/roman-sudarikov-linux-intel-com/perf-
> x86-Exposing-IO-stack-to-IO-PMON-mapping-through-sysfs/20200118-075508
> 
> Seems to be spurious bisect. I don't think that commit could change
> anything performance related.
Hi Andi, we will look into this as early as possible, we also receive another input from
Pater Z that he got false positive of will-it-scale.per_process_ops performance
regression. We will investigate them.

> 
> -Andi
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
