Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C7BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39EDA206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgHZJWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:22:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:36044 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbgHZJWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:22:30 -0400
IronPort-SDR: 5kqdthG520EFvOd0+cBX9F0BWPKX6ff3QNmF2jcG34YDM4AFaUc4CdgxCtJAfBpooaVKTE930E
 VdGmp5ZYuG5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="174308237"
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="174308237"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 02:22:29 -0700
IronPort-SDR: iGxGPqwz0Se3mmhRbGj07Qjo9Mx6Pbd65dfS1RpDmv0aUu8nqc+dPgNk07Sxgft5JnbII566nT
 2RmQxfDFRsaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="329159129"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 26 Aug 2020 02:22:27 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1kArZE-00BWYQ-Pt; Wed, 26 Aug 2020 12:18:04 +0300
Date:   Wed, 26 Aug 2020 12:18:04 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, thomas.langer@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        krzk@kernel.org
Subject: Re: [PATCH v1 0/9] extcon: extcon-ptn5150: Add the USB external
 connector support
Message-ID: <20200826091804.GF1891694@smile.fi.intel.com>
References: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200818084044.GD1891694@smile.fi.intel.com>
 <69e13a74-8b8d-cbc0-915d-ce289e7d4a70@linux.intel.com>
 <CAHp75VfwBnDgR6WR_On1nh+dX4meWrX1Q-CiUKqkV39=o2m5Hg@mail.gmail.com>
 <b9187c39-8d94-6b41-9e1c-b95161b17c1c@linux.intel.com>
 <20200825081935.GE189773@kuha.fi.intel.com>
 <bc66fcec-fa52-71a3-57d1-514a4d716605@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc66fcec-fa52-71a3-57d1-514a4d716605@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 10:51:37AM +0800, Ramuthevar, Vadivel MuruganX wrote:
> On 25/8/2020 4:19 pm, Heikki Krogerus wrote:
> > On Wed, Aug 19, 2020 at 04:45:38PM +0800, Ramuthevar, Vadivel MuruganX wrote:
> > > On 19/8/2020 3:55 pm, Andy Shevchenko wrote:
> > > > On Wed, Aug 19, 2020 at 8:38 AM Ramuthevar, Vadivel MuruganX
> > > > <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
> > > > > On 18/8/2020 4:40 pm, Andy Shevchenko wrote:
> > > > > > On Tue, Aug 18, 2020 at 02:57:18PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> > > > > > > USB external connector chip PTN5150 used on the Intel LGM SoC
> > > > > > > boards to detect the USB type and connection.
> > > > > > Internally I meant you can send cleanups, but couple of patches here are the
> > > > > > features and were still under discussion... But here we are.
> > > > > 
> > > > > you mean asking us to implement the Heikki suggested as below..
> > > > > 
> > > > > Heikki Krogerus: register the port and the partner attached to it with
> > > > > the USB Type-C connector class in the driver. Is my understaanding
> > > > > right? if not, please explain it. Thanks!
> > > > 
> > > > When you mention somebody, don't forget to Cc them (now done by me).
> > > Sure, Thank you
> > 
> > So the patches 1-5 are fine. The rest needs to be rewritten.
> Already Krzysztof submitted all the patches and got approved, so we started
> sending only one patch which support to Intel LGM SoC based boards, Thanks!

I'm not sure what you meant by above.

Krzysztof suggested you to squash all first patches into 1 (or two) and he
approves it. What you have to do is follow his advise and send v2 where it will
be one (or two) patch with his tag attached.

Krzysztof, is it correct what I'm saying?

-- 
With Best Regards,
Andy Shevchenko


