Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A59C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72AA12076A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgD0RYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:24:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:20457 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgD0RYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:24:09 -0400
IronPort-SDR: KI+QSblsX4clCLDdctlfk6DDuBox++UdzurSoYnZku3EjXUNoWsLyQA1/iylYwVlSk/kVmA5ai
 JLYemdJFKGJw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 10:24:09 -0700
IronPort-SDR: t4+pw8a0fxZyPc1F3AXiaSD2C1lYZ9vgoM9lrl0bsUyiLHWf89FKzZOpBJiuDk9FkrbNPa/XTO
 ZUAL6LBPshgw==
X-IronPort-AV: E=Sophos;i="5.73,324,1583222400"; 
   d="scan'208";a="458457221"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 10:24:09 -0700
Date:   Mon, 27 Apr 2020 10:24:08 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Robert Richter <rrichter@marvell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/10] EDAC/ghes: Remove local variable rdr_mask in
 ghes_edac_dmidecode()
Message-ID: <20200427172408.GA13177@agluck-desk2.amr.corp.intel.com>
References: <20200422115814.22205-1-rrichter@marvell.com>
 <20200422115814.22205-7-rrichter@marvell.com>
 <20200427070802.GA11036@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427070802.GA11036@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 09:08:02AM +0200, Borislav Petkov wrote:
> >  			if (entry->type_detail & BIT(6))
> >  				dimm->mtype = MEM_RMBS;
> > -			else if ((entry->type_detail & rdr_mask) == rdr_mask)
> > +			else if ((entry->type_detail & BIT(7)) &&
> > +				 (entry->type_detail & BIT(13)))
> 
> Well, "checks some bits" doesn't make it more telling than checking a
> descriptive name like "rdr_mask" but ok, since we're assigning MEM_RDR
> here, it is still clear what the check does.
> 
> Btw, please write it like this:
> 
> 			else if (entry->type_detail & (BIT(7) | BIT(13)))

That isn't the same. The previous version checked that BOTH bits
7 and 13 were set. Your version checks for either bit.

Looks like the original with the local variable was checking for both
bits set.

-Tony
