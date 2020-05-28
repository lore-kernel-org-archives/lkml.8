Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021FFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB3C02053B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404787AbgE1QAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 12:00:03 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:39109 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404631AbgE1QAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 12:00:01 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 28 May 2020 08:59:57 -0700
Received: from localhost (unknown [10.200.192.41])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 3E7DD40600;
        Thu, 28 May 2020 09:00:01 -0700 (PDT)
Date:   Thu, 28 May 2020 09:00:00 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 1/3] objtool: Rename rela to reloc
Message-ID: <20200528160000.GV9040@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1590597288.git.mhelsley@vmware.com>
 <fcb4a18952604110296ade6f6e7331e165fe3382.1590597288.git.mhelsley@vmware.com>
 <20200528140444.lgphq6sicir2l7ws@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200528140444.lgphq6sicir2l7ws@treble>
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 09:04:44AM -0500, Josh Poimboeuf wrote:
> On Wed, May 27, 2020 at 09:42:31AM -0700, Matt Helsley wrote:
> > Before supporting additional relocation types rename the relevant
> > types and functions from "rela" to "reloc". This work can largely
> > be done with the following regex:
> > 
> > Notable exceptions include gelf_* library calls and
> > standard/expected section names which still use "rela" because
> > they encode the type of relocation expected. Also, keep "rela"
> > in the struct because it encodes a specify type of relocation
> 
> Missing regex?

I briefly looked into it and went with a manual process instead. I can
try and work backwards to reproduce the patch with a regex though.

> BTW it would be really nice if the regex were exact if possible, for
> stable backporting reasons.

Agreed. I'll see what I can come up with and put it and any necessary
details in the commit message for the next posting.

Cheers,
	-Matt Helsley
