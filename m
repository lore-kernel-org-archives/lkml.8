Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED3AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75AC420656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgHURLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:11:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:52337 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgHURLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 13:11:06 -0400
IronPort-SDR: htkML8yGL21V2AYUjRalkwViV/dEW592mpf6yrtewWBjMnRY6L8F5myZk77uoivKXr6pYhdBVY
 kcpu0N6H5Uxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="156644348"
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="156644348"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 10:11:05 -0700
IronPort-SDR: I2mZkfr9xcMQIMP3kfbfldOKn4lii7Hzzr/Gi2BjSAbq3aMpijSBnuzGSdvAMmyB1ynYeQlPGP
 rA54NwF0FaEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="330096839"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga002.fm.intel.com with ESMTP; 21 Aug 2020 10:11:05 -0700
Date:   Fri, 21 Aug 2020 17:11:05 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Babu Moger <babu.moger@amd.com>, H Peter Anvin <hpa@zytor.com>,
        x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/resctrl: Enable user to view thread or core
 throttling mode
Message-ID: <20200821171105.GA362575@otcwcpicx6.sc.intel.com>
References: <1594921994-66192-1-git-send-email-fenghua.yu@intel.com>
 <1594921994-66192-3-git-send-email-fenghua.yu@intel.com>
 <20200821131306.GH12181@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821131306.GH12181@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 03:13:17PM +0200, Borislav Petkov wrote:
> On Thu, Jul 16, 2020 at 10:53:14AM -0700, Fenghua Yu wrote:
> >  struct rdt_membw {
> > +	enum membw_throttle_mode	arch_throttle_mode;
> 
> I guess "arch" is implicit so you can
> 
> s/arch_throttle_mode/throttle_mode/g
Ok. Will fix this.
> 
> ...
> 
> > +static struct rftype *rdtgroup_rftype_by_name(const char *name)
> 
> That function name needs a verb.

I will change it to rdtgroup_rftype_get_by_name().

Thank you very much for your review!

-Fenghua
> https://people.kernel.org/tglx/notes-about-netiquette
