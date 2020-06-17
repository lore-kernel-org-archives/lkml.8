Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901D5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72FF621532
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgFQStE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:49:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:43887 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbgFQStD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 14:49:03 -0400
IronPort-SDR: AgB3EHHOqcmXJqAoiZkPc9x9DMxkIhrWGT1ADco5W4/mYDxJq1pUaHdx7oPpjwE+jH0g/9KkyM
 hLflplTRjtnw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 11:49:03 -0700
IronPort-SDR: rQlCPzqKvWW49g3x119dkXNz5t6mV47/X/As+esF/JyCfluuw/Q8Z7rWHLT9i+p8/7YK/++dYP
 ilF5fwgCCkvQ==
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="450353444"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 11:49:02 -0700
Date:   Wed, 17 Jun 2020 11:49:01 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Song, Youquan" <youquan.song@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mce: Add Skylake quirk for patrol scrub reported
 errors
Message-ID: <20200617184901.GA387@agluck-desk2.amr.corp.intel.com>
References: <20200615184056.26531-1-tony.luck@intel.com>
 <20200616192952.GO13515@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F670974@ORSMSX115.amr.corp.intel.com>
 <20200617074158.GB10118@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617074158.GB10118@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 09:41:58AM +0200, Borislav Petkov wrote:
> On Tue, Jun 16, 2020 at 10:33:08PM +0000, Luck, Tony wrote:
> > If the BIOS option is left in the default setting, uncorrectable errors found
> > by the patrol scrubber are reported with a machine check. Those MSCOD
> > and MCACOD signatures are the same ... but that's not important because
> > MCi_STATUS.UC==1. So Linux doesn't need to jump through hoops to
> > "upgrade" the severity.
> 
> No, this is not what I meant: I meant when you have the setting enabled
> to downgrade those errors, can they be detected as part of another MCE
> being raised...

Yes one of these downgraded error logs could be sitting in a bank
whe a different machine check fires. But the severity calculation will
ignore it as MCi_STATUS.EN==0

-Tony
