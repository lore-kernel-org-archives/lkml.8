Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC1AC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFCA20749
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCMMMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:12:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbgCMMMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:12:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EA0820746;
        Fri, 13 Mar 2020 12:12:18 +0000 (UTC)
Date:   Fri, 13 Mar 2020 08:12:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg KH <greg@kroah.com>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Tech-board-discuss] [Ksummit-discuss] Linux Foundation
 Technical Advisory Board Elections -- Change to charter
Message-ID: <20200313081216.627c5bdf@gandalf.local.home>
In-Reply-To: <CAMuHMdW6Br+x+_9xP+X4xr6FP_uNpZ6q6065RJH-9yFy_8fiZA@mail.gmail.com>
References: <6d6dd6fa-880f-01fe-6177-281572aed703@labbott.name>
        <20200312003436.GF1639@pendragon.ideasonboard.com>
        <MWHPR13MB0895E133EC528ECF50A22100FDFD0@MWHPR13MB0895.namprd13.prod.outlook.com>
        <20200313031947.GC225435@mit.edu>
        <87d09gljhj.fsf@intel.com>
        <20200313093548.GA2089143@kroah.com>
        <24c64c56-947b-4267-33b8-49a22f719c81@suse.cz>
        <20200313100755.GA2161605@kroah.com>
        <CAMuHMdVSxS1R2osYJh29aKGaqMw3NkTRgqgRWuhu4euygAAXVg@mail.gmail.com>
        <20200313103720.GA2215823@kroah.com>
        <CAMuHMdW6Br+x+_9xP+X4xr6FP_uNpZ6q6065RJH-9yFy_8fiZA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020 11:50:45 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> > > > Given that before now, there has not be any way to vote for the TAB
> > > > remotely, it's less restrictive :)  
> > >
> > > But people without kernel.org accounts could still vote in person before,
> > > right?  
> >
> > Yes, and they still can today, this is expanding the pool, not
> > restricting it.  
> 
> Oh right, assumed we'll still have a conference in person, and unrestricted
> travel.

Correct. But if we don't change the voting requirements, and the conference
is canceled, or people are restricted from traveling, then those people
will not be able to vote with the current charter.

We are trying to extend who can vote beyond those that the charter allows.
We are not preventing those that can vote under the current rules from
voting.  IIUC, we are trying to create absentee voting which we never had
before. Thus, you can either vote the current way by getting travel to
wherever Kernel Summit is and attending the conference, or we can extend
the charter so that if you can not come for whatever reason, you have an
option to vote remotely, if you satisfy the new requirements. Remember, not
attending means you do not satisfy the current requirements.

The TAB has bikeshed this a bit internally, and came up with the conclusion
that kernel.org accounts is a very good "first step". If this proves to be
a problem, we can look at something else. This is why we are being a bit
vague in the changes so that if something better comes along we can switch
to that. After some experience in various methods (if we try various
methods), we could always make whatever method works best as an official
method at a later time.

But for now, we need to come up with something that makes it hard for
ballot stuffing, and a kernel.org account (plus activity in the kernel)
appears to be the best solution we know of.

-- Steve
