Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB9EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C02BC207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHSVyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:54:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:59297 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgHSVyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 17:54:23 -0400
IronPort-SDR: 89zGOGCfFoIBeMW0fB2xBq6ILkm7NyDcBYYDKYbdkoP/kb2XpIYSkQQiVPKpY4NJ19ObTlueo0
 4l+b47YJzB5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="152617032"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="152617032"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 14:54:23 -0700
IronPort-SDR: EPHC1e33LTT3gT4GgA80qhUot5SVvDl5NGvbT5WbDqviAf46e1Hb4EpvWlqK0JbMJ1z0LQuukP
 iueiYbdhLoCA==
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="327217882"
Received: from dfugate-mobl1.amr.corp.intel.com (HELO dwf-u18040) ([10.212.117.189])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 14:54:21 -0700
Message-ID: <d19605da52eb7aa3eb4132ad1781b5fbf636a8a0.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
From:   David Fugate <david.fugate@linux.intel.com>
Reply-To: david.fugate@linux.intel.com
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>
Cc:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        david.fugate@intel.com
Date:   Wed, 19 Aug 2020 15:54:20 -0600
In-Reply-To: <9fa64efe-8477-5d33-20ed-9619a9fe8d70@kernel.dk>
References: <20200818052936.10995-1-joshi.k@samsung.com>
         <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
         <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de>
         <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
         <9fa64efe-8477-5d33-20ed-9619a9fe8d70@kernel.dk>
Organization: Intel
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-19 at 13:25 -0600, Jens Axboe wrote:
> It's not required, the driver will function quite fine without it. If
> you
> want to use ZNS it's required. 

The NVMe spec does not require Zone Append for ZNS; a *vendor-neutral*
Linux driver should not either. 

> The Linux driver thankfully doesn't need
> any vendor to sign off on what it can or cannot do, or what features
> are acceptable.

The problem is the driver needs one *particular* vendor to sign off.
Existing driver behavior aligns with WDC drives instead of the spec,
giving WDC an unfair advantage. Couple this with NVMe maintainer(s?)
working for WDC, and there's a conflict of interest.

> It's *always* ok to reject contributions, if those contributions
> cause
> maintainability issues, unacceptable slowdowns, or whatever other
> issue
> that the maintainers of said driver don't want to deal with. Any
> contribution should be judged on merit, not based on political
> decisions
> or opinions.

Agreed, but this standard needs to be applied equally to everyone.
E.g., harmless contributions such as 
https://lore.kernel.org/linux-nvme/20200611054156.GB3518@lst.de/ get
rejected yet clear spec violations from maintainers are accepted? This
type of behavior encourages forking, vendor-specific drivers, etc.
which is somewhere I hope none of us want to go.


