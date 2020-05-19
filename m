Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA894C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A17C520657
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgESVql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 17:46:41 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:31571 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726030AbgESVqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 17:46:38 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 19 May 2020 14:46:36 -0700
Received: from localhost (unknown [10.200.192.41])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id EAE73B284E;
        Tue, 19 May 2020 17:46:37 -0400 (EDT)
Date:   Tue, 19 May 2020 14:46:37 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/3] objtool: Enable compilation of objtool for all
 architectures
Message-ID: <20200519214637.GS9040@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1589913349.git.mhelsley@vmware.com>
 <96252a8eee50710f4fe115ca516f0e6058b9f66b.1589913349.git.mhelsley@vmware.com>
 <20200519211829.p2d454nz3h3mdxsa@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200519211829.p2d454nz3h3mdxsa@treble>
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 04:18:29PM -0500, Josh Poimboeuf wrote:
> On Tue, May 19, 2020 at 01:55:33PM -0700, Matt Helsley wrote:
> > +const char __attribute__ ((weak)) *objname;
> > +
> > +int missing_check(const char *_objname, bool orc)
> > +{
> > +	return 127;
> > +}
> > +
> > +int __attribute__ ((weak, alias("missing_check"))) check(const char *_objname, bool orc);
> > +
> > +int missing_orc_dump(const char *_objname)
> > +{
> > +	return 127;
> > +}
> > +
> > +int __attribute__ ((weak, alias("missing_orc_dump"))) orc_dump(const char *_objname);
> > +
> > +int __attribute__ ((weak)) create_orc(struct objtool_file *file)
> > +{
> > +	return 127;
> > +}
> > +
> > +int __attribute__ ((weak)) create_orc_sections(struct objtool_file *file)
> > +{
> > +	return 127;
> > +}
> 
> I think the aliased "missing_" functions are no longer needed, right?
> i.e. can we just have weak versions of check() and orc_dump()?

Oops, Yeah, we can remove those aliases. I can fix and resend this one if you
like. 

> Otherwise everything looks good to me.

Excellent. I'm thinking I'll get the relocs patches posted as an RFC next...

Cheers,
	-Matt
