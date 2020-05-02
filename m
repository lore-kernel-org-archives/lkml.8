Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB74C47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D29D208C3
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgEBAgt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 20:36:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:10180 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbgEBAgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 20:36:49 -0400
IronPort-SDR: LyvviBwtccCuECDn9RiBJif07x0A+jnbpoAHNPm5CQevW62DPCW0ocEehyBB3UCUMB/+j+kXQK
 TK6ChT3CHXOA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 17:36:48 -0700
IronPort-SDR: UCDwa9xtBMPQP7l3w3ldOXffn+6aQQoL2ybbc1llYelWmorhUp2R9ZOqcVoAejc/vEK+4nHXFE
 7XKeD6tcz+DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,342,1583222400"; 
   d="scan'208";a="368582392"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga001.fm.intel.com with ESMTP; 01 May 2020 17:36:48 -0700
Received: from orsmsx151.amr.corp.intel.com ([169.254.7.25]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.249]) with mapi id 14.03.0439.000;
 Fri, 1 May 2020 17:36:48 -0700
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jakub Kicinski <kuba@kernel.org>,
        Andy Whitcroft <apw@canonical.com>
Subject: RE: [PATCH] checkpatch: add NL_SET_ERR_MSG to 80 column exceptions
Thread-Topic: [PATCH] checkpatch: add NL_SET_ERR_MSG to 80 column exceptions
Thread-Index: AQHWIA3lrxYd/voAoky496eGOdAMeKiUWXYA//+l34CAAGefgP//i+5w
Date:   Sat, 2 May 2020 00:36:48 +0000
Message-ID: <02874ECE860811409154E81DA85FBB58C0774F94@ORSMSX151.amr.corp.intel.com>
References: <20200501231131.2389319-1-jacob.e.keller@intel.com>
         <e1e12e3f6992c00c005ba2b3bcf671c033a1dccc.camel@perches.com>
         <5a1da586-0cc0-1900-477f-6fef61af7f95@intel.com>
 <1c86e75bb56693bc2343d30e5baba09c783b02a2.camel@perches.com>
In-Reply-To: <1c86e75bb56693bc2343d30e5baba09c783b02a2.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Joe Perches <joe@perches.com>
> Sent: Friday, May 01, 2020 5:30 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>; linux-kernel@vger.kernel.org
> Cc: Jakub Kicinski <kuba@kernel.org>; Andy Whitcroft <apw@canonical.com>
> Subject: Re: [PATCH] checkpatch: add NL_SET_ERR_MSG to 80 column
> exceptions
> 
> On Fri, 2020-05-01 at 17:19 -0700, Jacob Keller wrote:
> >
> > On 5/1/2020 4:42 PM, Joe Perches wrote:
> > > On Fri, 2020-05-01 at 16:11 -0700, Jacob Keller wrote:
> > > > NL_SET_ERR_MSG and NL_SET_ERR_MSG_MOD are used to report
> extended error
> > > > responses about failure of a netlink command. These strings often end up
> > > > going over the 80-column limit. Just like logging messages, it is
> > > > preferred to leave the message all on a single line.
> > > >
> > > > Add these to the exception list so that checkpatch.pl will no longer
> > > > complain about the long lines due to use of these macros.
> > > >
> > > > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > > > Cc: Jakub Kicinski <kuba@kernel.org>
> > > > Cc: Andy Whitcroft <apw@canonical.com>
> > > > Cc: Joe Perches <joe@perches.com>
> > > > ---
> > > >  scripts/checkpatch.pl | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > > index eac40f0abd56..5da3b06fbeaa 100755
> > > > --- a/scripts/checkpatch.pl
> > > > +++ b/scripts/checkpatch.pl
> > > > @@ -471,7 +471,8 @@ our $logFunctions = qr{(?x:
> > > >  	WARN(?:_RATELIMIT|_ONCE|)|
> > > >  	panic|
> > > >  	MODULE_[A-Z_]+|
> > > > -	seq_vprintf|seq_printf|seq_puts
> > > > +	seq_vprintf|seq_printf|seq_puts|
> > > > +	NL_SET_ERR_MSG(?:_MOD)?
> > > >  )};
> > > >
> > > >  our $allocFunctions = qr{(?x:
> > >
> > > <shrug>  OK I guess.
> > >
> > > What about GENL_SET_ERR_MSG ?
> > >
> >
> > This appears in far fewer locations, but it does seem reasonable to add
> > it to this list as well.
> >
> > > btw:
> > >
> > > There are some uses with what appear to be unnecessary newlines.
> > > Maybe these newlines should be removed.
> >
> > Yea, there's a number of places which seem to have put a newline break
> > after the extack pointer.
> >
> > A quick search shows that there are about 970 or so uses where we don't
> > put a newline, and around 220 where we do.
> >
> > I suppose I can make a series that cleans all of those up along with
> > this patch.
> 
> That's not what I meant.
> I don't care if there are multiple source lines used.
> In fact, I think it's mostly nicer with multiple lines.

Ah. Sure. I just noticed that one was more common than the other.

> 
> The ones I specified previously use:
> 
> 	NL_SET_ERR_MSG_MOD(extack, "message\n");
> 
> where all the others uses are:
> 
> 	NL_SET_ERR_MSG_MOD(extack, "message");
> 
> without the \n termination of the message.
> 

I see. Yea, I think the trailing newline isn't needed, but I'm not sure.

Thanks,
Jake

