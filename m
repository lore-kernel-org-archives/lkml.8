Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05A2C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F01B2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgCMOKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:10:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:1279 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbgCMOKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:10:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 07:10:12 -0700
X-IronPort-AV: E=Sophos;i="5.70,548,1574150400"; 
   d="scan'208";a="237232618"
Received: from unknown (HELO localhost) ([10.252.52.87])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 07:10:09 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "ksummit-discuss\@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        "tech-board-discuss\@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] [Tech-board-discuss] Linux Foundation Technical Advisory Board Elections -- Change to charter
In-Reply-To: <20200313081216.627c5bdf@gandalf.local.home>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <6d6dd6fa-880f-01fe-6177-281572aed703@labbott.name> <20200312003436.GF1639@pendragon.ideasonboard.com> <MWHPR13MB0895E133EC528ECF50A22100FDFD0@MWHPR13MB0895.namprd13.prod.outlook.com> <20200313031947.GC225435@mit.edu> <87d09gljhj.fsf@intel.com> <20200313093548.GA2089143@kroah.com> <24c64c56-947b-4267-33b8-49a22f719c81@suse.cz> <20200313100755.GA2161605@kroah.com> <CAMuHMdVSxS1R2osYJh29aKGaqMw3NkTRgqgRWuhu4euygAAXVg@mail.gmail.com> <20200313103720.GA2215823@kroah.com> <CAMuHMdW6Br+x+_9xP+X4xr6FP_uNpZ6q6065RJH-9yFy_8fiZA@mail.gmail.com> <20200313081216.627c5bdf@gandalf.local.home>
Date:   Fri, 13 Mar 2020 16:10:29 +0200
Message-ID: <874kusl50q.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 13 Mar 2020 11:50:45 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
>> > > > Given that before now, there has not be any way to vote for the TAB
>> > > > remotely, it's less restrictive :)  
>> > >
>> > > But people without kernel.org accounts could still vote in person before,
>> > > right?  
>> >
>> > Yes, and they still can today, this is expanding the pool, not
>> > restricting it.  
>> 
>> Oh right, assumed we'll still have a conference in person, and unrestricted
>> travel.
>
> Correct. But if we don't change the voting requirements, and the conference
> is canceled, or people are restricted from traveling, then those people
> will not be able to vote with the current charter.
>
> We are trying to extend who can vote beyond those that the charter allows.
> We are not preventing those that can vote under the current rules from
> voting.  IIUC, we are trying to create absentee voting which we never had
> before. Thus, you can either vote the current way by getting travel to
> wherever Kernel Summit is and attending the conference, or we can extend
> the charter so that if you can not come for whatever reason, you have an
> option to vote remotely, if you satisfy the new requirements. Remember, not
> attending means you do not satisfy the current requirements.
>
> The TAB has bikeshed this a bit internally, and came up with the conclusion
> that kernel.org accounts is a very good "first step". If this proves to be
> a problem, we can look at something else. This is why we are being a bit
> vague in the changes so that if something better comes along we can switch
> to that. After some experience in various methods (if we try various
> methods), we could always make whatever method works best as an official
> method at a later time.
>
> But for now, we need to come up with something that makes it hard for
> ballot stuffing, and a kernel.org account (plus activity in the kernel)
> appears to be the best solution we know of.

Thanks for writing this. I, for one, would welcome more open and
proactive communication from the TAB.

Have you considered whether the eligibility for running and voting
should be made the same? As it is, absolutely anyone can self-nominate
and run.


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
