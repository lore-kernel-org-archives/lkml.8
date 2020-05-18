Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F4EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE1DC20657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgERSdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:33:36 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:32870 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728490AbgERSdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:33:35 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 18 May 2020 11:33:34 -0700
Received: from localhost (unknown [10.200.192.41])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 1C66D40909;
        Mon, 18 May 2020 11:33:35 -0700 (PDT)
Date:   Mon, 18 May 2020 11:33:34 -0700
From:   Matt Helsley <mhelsley@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 1/5] objtool: Exit successfully when requesting help
Message-ID: <20200518183334.GN9040@rlwimi.vmware.com>
Mail-Followup-To: Matt Helsley <mhelsley@vmware.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1588888003.git.mhelsley@vmware.com>
 <10618c5e40b34a6af62c183feb5cd474c95e06fa.1588888003.git.mhelsley@vmware.com>
 <20200515195253.c5yzjyigxzhjflsd@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200515195253.c5yzjyigxzhjflsd@treble>
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 02:52:53PM -0500, Josh Poimboeuf wrote:
> On Mon, May 11, 2020 at 10:35:09AM -0700, Matt Helsley wrote:
> > When the user requests help it's not an error so do not exit with
> > a non-zero exit code. This is not especially useful for a user but
> > any script that might wish to check that objtool --help is at least
> > available can't rely on the exit code to crudely check that, for
> > example building an objtool executable succeeds.
> > 
> > Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> > ---
> >  tools/objtool/objtool.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
> > index 0b3528f05053..593ec85915a9 100644
> > --- a/tools/objtool/objtool.c
> > +++ b/tools/objtool/objtool.c
> > @@ -58,7 +58,10 @@ static void cmd_usage(void)
> >  
> >  	printf("\n");
> >  
> > -	exit(129);
> > +	if (!help)
> > +		exit(129);
> > +	else
> > +		exit(0);
> 
> Looks fine, though the 'else' isn't needed.

OK, removed the 'else'.

Cheers,
    -Matt Helsley
