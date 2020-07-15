Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0365DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBEE5206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgGOXtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 19:49:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:48438 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgGOXtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 19:49:13 -0400
IronPort-SDR: 2jwL3ivzZvGgFO68nPF2+zhuWl5R2hAVeXPiJOwVZvB7cyuZNrwBMucFcsGE5S7l52wBRKenFl
 wapf/Xseah8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="137421039"
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; 
   d="scan'208";a="137421039"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 16:49:10 -0700
IronPort-SDR: lliRW6Jt4RDivPAl/jzU8Bcg77kM4yx0by48cApHiDIryCOiVKdRezdiqKtRsqZBIhAWWSxViM
 PYmOGNiogMDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; 
   d="scan'208";a="308432786"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jul 2020 16:49:09 -0700
Date:   Wed, 15 Jul 2020 16:49:09 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, bp@alien8.de, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, ravi.v.shankar@intel.com,
        mingo@redhat.com, babu.moger@amd.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 0/4] x86/resctrl: Enable user to view and select
 thread throttling mode
Message-ID: <20200715234909.GE64320@romley-ivt3.sc.intel.com>
References: <cover.1592841671.git.reinette.chatre@intel.com>
 <20200710173154.GA290028@otcwcpicx6.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710173154.GA290028@otcwcpicx6.sc.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 05:31:54PM +0000, Fenghua Yu wrote:
> Hi, Boris, Thomas and Ingo,
> 
> On Mon, Jun 22, 2020 at 09:43:27AM -0700, Reinette Chatre wrote:
> > V6 upstream submission available from:
> > https://lore.kernel.org/lkml/cover.1589922949.git.reinette.chatre@intel.com
> > 
> > Patches apply against v5.8-rc2
> > base-commit: 48778464bb7d346b47157d21ffde2af6b2d39110
> > 
> > Changes since V6:
> > - Rebase against v5.8-rc2
> > - Add Andy's Reviewed-by tag to patch 4
> 
> Do you have any comment on this series? Is it possible to push this series
> into 5.9?

We are going to release a simplified version of MBA thread throttling
series without min/max mode. The new version will replace this series.
Please comment on and apply the upcoming new version.

Thank you very much!

-Fenghua
