Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C263C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83749206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732247AbgFISwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:52:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729371AbgFISwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:52:11 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3D6C2068D;
        Tue,  9 Jun 2020 18:52:08 +0000 (UTC)
Date:   Tue, 9 Jun 2020 14:52:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     Julien Thierry <jthierry@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH v4 02/32] objtool: Make recordmcount into mcount
 subcmd
Message-ID: <20200609145207.1d9dafa2@oasis.local.home>
In-Reply-To: <20200609183951.GE1284251@rlwimi.vmware.com>
References: <cover.1591125127.git.mhelsley@vmware.com>
        <0d44e0b1b8ebce4af8b90f73e351a003ef016005.1591125127.git.mhelsley@vmware.com>
        <fe3e0e4e-4f13-5193-c684-f995c8310e54@redhat.com>
        <20200609183951.GE1284251@rlwimi.vmware.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jun 2020 11:39:51 -0700
Matt Helsley <mhelsley@vmware.com> wrote:

> > > +ifeq ($(SRCARCH),sparc)
> > > +	SUBCMD_MCOUNT := y  
> > 
> > Is there some arch for which MCOUNT is not supported? If not you could just
> > have MCOUNT default to 'y' and avoid adding all those tests (or maybe reduce
> > the numbers and set to 'n' only for arches not supporting it).  
> 
> Yes, there are some which it does not support. For those architectures
> we keep recordmcount.pl around.
> 
> It occured to me that with your suggestion to use more CONFIG_ variables
> we could eliminate this pattern and replace it with these pseudo-patches:
> 
> +++ b/kernel/trace/Kconfig
> 
> +config OBJTOOL_SUBCMD_MCOUNT
> +	bool
> +	depends on HAVE_C_RECORDMCOUNT
> +	select OBJTOOL_SUBCMDS
> +	help
> +	  Record mcount call locations using objtool
> 
> and then change the Makefiles to use the CONFIG_ variables
> rather than have one ifeq block per arch:
> 
> +++ b/tools/objtool/Makefile
> 
> +SUBCMD_MCOUNT := $(CONFIG_OBJTOOL_SUBCMD_MCOUNT)

If you can make this work, this is definitely the way to go.

-- Steve

> 
> Does this seem like a good use of CONFIG_ variables or is it going too
> far?
> 
> I haven't changed to this pattern just yet -- I'm hoping you and Josh
> or Peter might weigh in with your preferences.

