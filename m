Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B0CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DE79206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388913AbgFIS42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:56:28 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:17545 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728189AbgFIS41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:56:27 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 9 Jun 2020 11:56:24 -0700
Received: from localhost (unknown [10.166.65.245])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 68E6F408D4;
        Tue,  9 Jun 2020 11:56:26 -0700 (PDT)
Date:   Tue, 9 Jun 2020 11:56:26 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Julien Thierry <jthierry@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH v4 02/32] objtool: Make recordmcount into mcount
 subcmd
Message-ID: <20200609185626.GF1284251@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <cover.1591125127.git.mhelsley@vmware.com>
 <0d44e0b1b8ebce4af8b90f73e351a003ef016005.1591125127.git.mhelsley@vmware.com>
 <fe3e0e4e-4f13-5193-c684-f995c8310e54@redhat.com>
 <20200609183951.GE1284251@rlwimi.vmware.com>
 <20200609145207.1d9dafa2@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200609145207.1d9dafa2@oasis.local.home>
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 02:52:07PM -0400, Steven Rostedt wrote:
> On Tue, 9 Jun 2020 11:39:51 -0700
> Matt Helsley <mhelsley@vmware.com> wrote:
> 
> > > > +ifeq ($(SRCARCH),sparc)
> > > > +	SUBCMD_MCOUNT := y  
> > > 
> > > Is there some arch for which MCOUNT is not supported? If not you could just
> > > have MCOUNT default to 'y' and avoid adding all those tests (or maybe reduce
> > > the numbers and set to 'n' only for arches not supporting it).  
> > 
> > Yes, there are some which it does not support. For those architectures
> > we keep recordmcount.pl around.
> > 
> > It occured to me that with your suggestion to use more CONFIG_ variables
> > we could eliminate this pattern and replace it with these pseudo-patches:
> > 
> > +++ b/kernel/trace/Kconfig
> > 
> > +config OBJTOOL_SUBCMD_MCOUNT
> > +	bool
> > +	depends on HAVE_C_RECORDMCOUNT
> > +	select OBJTOOL_SUBCMDS
> > +	help
> > +	  Record mcount call locations using objtool
> > 
> > and then change the Makefiles to use the CONFIG_ variables
> > rather than have one ifeq block per arch:
> > 
> > +++ b/tools/objtool/Makefile
> > 
> > +SUBCMD_MCOUNT := $(CONFIG_OBJTOOL_SUBCMD_MCOUNT)
> 
> If you can make this work, this is definitely the way to go.

I think I can so I'll give it a go!

Cheers,
	-Matt Helsley
