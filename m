Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FAFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 406F22075A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406232AbgE1TPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:15:53 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:20716 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406126AbgE1TPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:15:51 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 28 May 2020 12:15:47 -0700
Received: from localhost (unknown [10.200.192.41])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 2E749404FD;
        Thu, 28 May 2020 12:15:51 -0700 (PDT)
Date:   Thu, 28 May 2020 12:15:50 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 2/3] objtool: Find relocation base section using
 sh_info
Message-ID: <20200528191550.GY9040@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1590597288.git.mhelsley@vmware.com>
 <d848189dac6c41193a6c55c3588b78114bbcb0f8.1590597288.git.mhelsley@vmware.com>
 <20200528140916.6crguzfpehf6lext@treble>
 <20200528160247.GW9040@rlwimi.vmware.com>
 <20200528170010.xe46x3tvz4npvovj@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200528170010.xe46x3tvz4npvovj@treble>
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:00:10PM -0500, Josh Poimboeuf wrote:
> On Thu, May 28, 2020 at 09:02:47AM -0700, Matt Helsley wrote:
> > On Thu, May 28, 2020 at 09:09:16AM -0500, Josh Poimboeuf wrote:
> > > On Wed, May 27, 2020 at 09:42:32AM -0700, Matt Helsley wrote:
> > > > Currently objtool uses a naming heuristic to find the "base"
> > > > section to apply the relocation(s) to. The standard defines
> > > > the SHF_INFO_LINK flag (SHF => in the section header flags)
> > > > which indicates when the section header's sh_info field can
> > > > be used to find the necessary section.
> > > > 
> > > > Warns when the heuristic is used as a fallback and changes
> > > > the name heuristic calculation to handle rela (explicit
> > > > addend) and now rel (implicit addend) relocations.
> > > 
> > > Does this fallback case actually happen?
> > 
> > Not that I could see. I was thinking about taking it out but
> > I haven't tried this set with clang or other toolchains. So
> > I was wondering if you think holding off before removing it
> > would be wise or if you'd rather just remove it.
> 
> I just realized somebody already submitted an almost identical patch:
> 
>   https://lkml.kernel.org/r/20200421182501.149101-1-samitolvanen@google.com
> 
> Which I'll be merging soon... so you can just drop this one.

OK, I'll drop this patch.

Cheers,
	-Matt
