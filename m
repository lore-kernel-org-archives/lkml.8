Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFF2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9B2F2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgERS3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:29:32 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:42213 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729345AbgERS32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:29:28 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 18 May 2020 11:29:26 -0700
Received: from localhost (unknown [10.200.192.41])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 42FFC40320;
        Mon, 18 May 2020 11:29:27 -0700 (PDT)
Date:   Mon, 18 May 2020 11:29:26 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 5/5] objtool: Report missing support for subcommands
Message-ID: <20200518182926.GM9040@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1588888003.git.mhelsley@vmware.com>
 <38a0c7a1ec8d98238379a322866c0432befc259b.1588888003.git.mhelsley@vmware.com>
 <20200515210448.jqseippuz52wx7ct@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200515210448.jqseippuz52wx7ct@treble>
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 04:04:48PM -0500, Josh Poimboeuf wrote:
> On Mon, May 11, 2020 at 10:35:13AM -0700, Matt Helsley wrote:
> > The check and orc-related subcommands for objtool are x86-specific.
> > To make this clear to anyone using the tool return a non-zero exit
> > code and indicate in the help and usage output which commands are
> > (and are not) available.
> > 
> > Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> 
> I think I'd rather the simplest approach of just having the weak
> functions print an error and return an error code.  At least for now I
> don't think we need to go through the trouble of advertising whether
> certain commands are available.  Technically they are available, they
> just always fail :-)

OK, that'll drop this patch from  the series.

> 
> And, people don't tend to use objtool directly anyway.
> 
> BTW, several of the patches didn't apply cleanly to tip/master, so
> you'll probably need to rebase for v2.  There've been a lot of objtool
> changes lately.  Peter's been busy...

Will do.

Cheers,
    -Matt Helsley
