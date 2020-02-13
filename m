Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3B7C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732BD217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgBMWJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:09:56 -0500
Received: from mga03.intel.com ([134.134.136.65]:60321 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgBMWJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 17:09:56 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 14:09:55 -0800
X-IronPort-AV: E=Sophos;i="5.70,438,1574150400"; 
   d="scan'208";a="313869160"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 14:09:55 -0800
Date:   Thu, 13 Feb 2020 14:09:53 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] x86/mce: Add new "handled" field to "struct mce"
Message-ID: <20200213220953.GA21107@agluck-desk2.amr.corp.intel.com>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200212204652.1489-4-tony.luck@intel.com>
 <20200213165617.GL31799@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213165617.GL31799@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 05:56:17PM +0100, Borislav Petkov wrote:
> On Wed, Feb 12, 2020 at 12:46:50PM -0800, Tony Luck wrote:
> > There can be many different subsystems register on the mce handler
> > chain. Add a new bitmask field and define values so that handlers
> > can indicate whether they took any action to log or otherwise
> > handle an error.
> > 
> > The default handler at the end of the chain can use this information
> > to decide whether to print to the console log.
> > 
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  arch/x86/include/uapi/asm/mce.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/x86/include/uapi/asm/mce.h b/arch/x86/include/uapi/asm/mce.h
> > index 955c2a2e1cf9..99ca07f7b078 100644
> > --- a/arch/x86/include/uapi/asm/mce.h
> > +++ b/arch/x86/include/uapi/asm/mce.h
> > @@ -35,8 +35,17 @@ struct mce {
> >  	__u64 ipid;		/* MCA_IPID MSR: only valid on SMCA systems */
> >  	__u64 ppin;		/* Protected Processor Inventory Number */
> >  	__u32 microcode;	/* Microcode revision */
> > +	__u32 handled;		/* Bitmap of logging/handling actions */
> >  };
> >  
> > +/* handled flag bits */
> > +#define	MCE_HANDLED_CEC		BIT(0)
> > +#define	MCE_HANDLED_UC		BIT(1)
> > +#define	MCE_HANDLED_EXTLOG	BIT(2)
> > +#define	MCE_HANDLED_NFIT	BIT(3)
> > +#define	MCE_HANDLED_EDAC	BIT(4)
> > +#define	MCE_HANDLED_MCELOG	BIT(5)
> > +
> >  #define MCE_GET_RECORD_LEN   _IOR('M', 1, int)
> >  #define MCE_GET_LOG_LEN      _IOR('M', 2, int)
> >  #define MCE_GETCLEAR_FLAGS   _IOR('M', 3, int)
> > -- 
> 
> Not sure if this should be exposed to user. I don't think it has any
> business poking its nose into how the MCE was handled. Or maybe it does
> but I cannot think of a good example ATM.
> 
> If not, this could be
> 
> 	...
> 	void *private;
> };
> 
> which userspace can't make any assumptions about. And we can put
> whatever we need in there...

I can see various ways to spin this:

1) It is useful to user mode. The mcelog(8) daemon (or other consumer
   of "struct mce") gets a record of where to look for logs from this
   record.  This could reduce the anxiety about logging the same item
   multiple times.  Its a bit weird though because each entity logging
   only sees who came before them, not who came after.
2) Not useful
	2a) Keep it in the structure, but clear it in copies shown to user
	2b) Make a *private to point to such things (but that really
	    complicates allocation of struct mce ... right now we just
	    have local copies on kernel stack)
	2c) Make a wrapper structure:
		struct kernel_mce {
			struct mce mce;
			u32 handled;
			... other hidden stuff ...
		};

-Tony
