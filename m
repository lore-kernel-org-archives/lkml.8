Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE4DC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7DC20724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Fn2NQ+Dt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Fn2NQ+Dt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgCMPSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:18:33 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59024 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726420AbgCMPSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 11:18:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A98BA8EE111;
        Fri, 13 Mar 2020 08:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1584112712;
        bh=xNlQBaMJxw+xUPY3kKZXizEko19XrBGpMjrdn37j7V8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Fn2NQ+DtzV1RuwZsNXqqrERqDuz1PozzcgC3+Q+vnNGFYwO4TvTPtYtPMwkItYO9f
         Ks7vONNMJthP8OlcqQwGs7YMORZFS/dp2rupG6gXFluO7Ir8pJn+a7hqNwj+bZksUD
         VFDAbm7SbUIuS/Llq298v8rOtQwllQ1Mc1b2nJJ4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1OJPsJR58A3O; Fri, 13 Mar 2020 08:18:32 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EC94A8EE10C;
        Fri, 13 Mar 2020 08:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1584112712;
        bh=xNlQBaMJxw+xUPY3kKZXizEko19XrBGpMjrdn37j7V8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Fn2NQ+DtzV1RuwZsNXqqrERqDuz1PozzcgC3+Q+vnNGFYwO4TvTPtYtPMwkItYO9f
         Ks7vONNMJthP8OlcqQwGs7YMORZFS/dp2rupG6gXFluO7Ir8pJn+a7hqNwj+bZksUD
         VFDAbm7SbUIuS/Llq298v8rOtQwllQ1Mc1b2nJJ4=
Message-ID: <1584112710.3391.12.camel@HansenPartnership.com>
Subject: Re: [Ksummit-discuss] [Tech-board-discuss] Linux Foundation
 Technical Advisory Board Elections -- Change to charter
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jani Nikula <jani.nikula@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 13 Mar 2020 08:18:30 -0700
In-Reply-To: <874kusl50q.fsf@intel.com>
References: <6d6dd6fa-880f-01fe-6177-281572aed703@labbott.name>
         <20200312003436.GF1639@pendragon.ideasonboard.com>
         <MWHPR13MB0895E133EC528ECF50A22100FDFD0@MWHPR13MB0895.namprd13.prod.outlook.com>
         <20200313031947.GC225435@mit.edu> <87d09gljhj.fsf@intel.com>
         <20200313093548.GA2089143@kroah.com>
         <24c64c56-947b-4267-33b8-49a22f719c81@suse.cz>
         <20200313100755.GA2161605@kroah.com>
         <CAMuHMdVSxS1R2osYJh29aKGaqMw3NkTRgqgRWuhu4euygAAXVg@mail.gmail.com>
         <20200313103720.GA2215823@kroah.com>
         <CAMuHMdW6Br+x+_9xP+X4xr6FP_uNpZ6q6065RJH-9yFy_8fiZA@mail.gmail.com>
         <20200313081216.627c5bdf@gandalf.local.home> <874kusl50q.fsf@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-03-13 at 16:10 +0200, Jani Nikula wrote:
> On Fri, 13 Mar 2020, Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Fri, 13 Mar 2020 11:50:45 +0100
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > 
> > > > > > Given that before now, there has not be any way to vote for
> > > > > > the TAB remotely, it's less restrictive :)  
> > > > > 
> > > > > But people without kernel.org accounts could still vote in
> > > > > person before, right?  
> > > > 
> > > > Yes, and they still can today, this is expanding the pool, not
> > > > restricting it.  
> > > 
> > > Oh right, assumed we'll still have a conference in person, and
> > > unrestricted travel.
> > 
> > Correct. But if we don't change the voting requirements, and the
> > conference is canceled, or people are restricted from traveling,
> > then those people will not be able to vote with the current
> > charter.
> > 
> > We are trying to extend who can vote beyond those that the charter
> > allows.  We are not preventing those that can vote under the
> > current rules from voting.  IIUC, we are trying to create absentee
> > voting which we never had before. Thus, you can either vote the
> > current way by getting travel to wherever Kernel Summit is and
> > attending the conference, or we can extend the charter so that if
> > you can not come for whatever reason, you have an option to vote
> > remotely, if you satisfy the new requirements. Remember, not
> > attending means you do not satisfy the current requirements.
> > 
> > The TAB has bikeshed this a bit internally, and came up with the
> > conclusion that kernel.org accounts is a very good "first step". If
> > this proves to be a problem, we can look at something else. This is
> > why we are being a bit vague in the changes so that if something
> > better comes along we can switch to that. After some experience in
> > various methods (if we try various methods), we could always make
> > whatever method works best as an official method at a later time.
> > 
> > But for now, we need to come up with something that makes it hard
> > for ballot stuffing, and a kernel.org account (plus activity in the
> > kernel) appears to be the best solution we know of.
> 
> Thanks for writing this. I, for one, would welcome more open and
> proactive communication from the TAB.
> 
> Have you considered whether the eligibility for running and voting
> should be made the same? As it is, absolutely anyone can self-
> nominate and run.

When the TAB charter was written (in 2006), the original reason was to
prevent manipulation (real or imagined) by the committee who would then
become the arbiters of nominations and thus able to influence who might
run for the TAB.  There are a couple of reasons for the electorate
clause: when the TAB was formed, it was done by the kernel developers
unhappy at the way OSDL (precursor organization to the LF) was behaving
with regard to the kernel, who forced their way onto its board and
formed the TAB to gain input and control on behalf of kernel
developers, so the TAB was formed by kernel developer for kernel
developers and, since most other non-kernel open source groups had
their own foundation like entities, keeping it kernel only wasn't seen
as a problem.  The other reason was that OSDL was a bit unhappy to be
reformed in this way and we foresaw that one way to dilute the
reforming influence of the TAB would be to dilute kernel developer
representation since they were the main community interested in that
reform.  When the OSDL became the LF, some of the initial antagonism
and need for reform went away and the elections were opened to the co-
located conferences as a sign of improved trust.

James

