Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DA6C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141172084D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgAOVHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:07:07 -0500
Received: from mga17.intel.com ([192.55.52.151]:12802 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728903AbgAOVHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:07:06 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 13:07:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; 
   d="scan'208";a="254938941"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2020 13:07:07 -0800
Date:   Wed, 15 Jan 2020 13:17:49 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Moger, Babu" <Babu.Moger@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v9 00/13] selftests/resctrl: Add resctrl selftest
Message-ID: <20200115211749.GA51626@romley-ivt3.sc.intel.com>
References: <1576535207-2417-1-git-send-email-fenghua.yu@intel.com>
 <7aacc3e8-4072-c6b9-5d0f-f687a40ad315@amd.com>
 <CY4PR12MB1574ACDEE30CDCD8113CECA795390@CY4PR12MB1574.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR12MB1574ACDEE30CDCD8113CECA795390@CY4PR12MB1574.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 04:06:32PM +0000, Moger, Babu wrote:
> [AMD Official Use Only - Internal Distribution Only]
> 
> Hi Fenghua,
> 
> > -----Original Message-----
> > From: Moger, Babu <babu.moger@amd.com>
> > Sent: Tuesday, December 17, 2019 12:24 PM
> > To: Fenghua Yu <fenghua.yu@intel.com>; Thomas Gleixner
> > <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>; Borislav Petkov
> > <bp@alien8.de>; H Peter Anvin <hpa@zytor.com>; Tony Luck
> > <tony.luck@intel.com>; Reinette Chatre <reinette.chatre@intel.com>;
> > James Morse <james.morse@arm.com>; Ravi V Shankar
> > <ravi.v.shankar@intel.com>; Sai Praneeth Prakhya
> > <sai.praneeth.prakhya@intel.com>
> > Cc: linux-kernel <linux-kernel@vger.kernel.org>; x86 <x86@kernel.org>
> > Subject: Re: [PATCH v9 00/13] selftests/resctrl: Add resctrl selftest
> > 
> > Fenghua,
> > Thanks for the patches. I did a quick test. I am seeing some failures with
> > this series. I need to debug to figure out what is going on. Hopefully I
> > will be able to spend sometime this week or next week. I will be out for
> > few days this week and also next week. Here is the failure..
> 
> The problem has been root caused and fixed with this following patch.
> https://lore.kernel.org/lkml/20200108193455.29834-1-kim.phillips@amd.com/
> After this patch everything works as expected. Patches look good to me. Thanks.

Hi, Babu,

Thank you very much for finding and fixing the issue!

Glad to know this resctrl selftest tool actually finds one issue although
it's not really a resctrl issue.

Hi, Boris, Thomas, Ingo, et al,

Any comment on this patch set?

Thanks.

-Fenghua
