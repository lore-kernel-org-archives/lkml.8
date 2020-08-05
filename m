Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D913AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3A0C22B40
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596613282;
	bh=drKtsLeF1osFV69PUj0aSkz5xDDMxcTAlYiBxYPMkUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KhvuM0GonhFYwMTTZFlb1GBoBBy9vlhNm9x157roCjrET24DZoM1EsPttUMQsthCx
	 zHo6T3EducSo/iAp0tHj6BiPxCNatxIeF+e5WXg9W6JBiYSG2QZqjjj8eRAaPN9J12
	 QgEJiI/mMwPAqFeHp+WvykTxsCLMcPj9k7ljYBow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgHEHlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:41:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgHEHlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 03:41:21 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36C842245C;
        Wed,  5 Aug 2020 07:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596613280;
        bh=drKtsLeF1osFV69PUj0aSkz5xDDMxcTAlYiBxYPMkUw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WPiDQ0ZD0IJnAC2KKPplaIlPsepL6Z4njQjaQbnQNCD08fm+5tUnyfXvvXfCO3Cdq
         6xXXhL4LMEIWMMRHJ7mqxRIUwSd4mnxM7NkABFj0lWKtfv0zZJMgzvdkkZboWKydlL
         qHIPx3NKMCA4CzOsgcg+IoPaCWzjG+/Ixv6/HUGk=
Date:   Wed, 5 Aug 2020 16:41:16 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bootconfig: Fix to find the initargs correctly
Message-Id: <20200805164116.2e396561081e61ef75c1ca51@kernel.org>
In-Reply-To: <20200804165929.3bfeb318@oasis.local.home>
References: <159650953285.270383.14822353843556363851.stgit@devnote2>
        <20200804165929.3bfeb318@oasis.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Tue, 4 Aug 2020 16:59:29 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  4 Aug 2020 11:52:13 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Since the parse_args() stops parsing at '--', bootconfig_params()
> > will never get the '--' as param and initargs_found never be true.
> > In the result, if we pass some init arguments via the bootconfig,
> > those are always appended to the kernel command line with '--'
> > even if the kernel command line already has '--'.
> > 
> > To fix this correctly, check the return value of parse_args()
> > and set initargs_found true if the return value is not an error
> > but a valid address.
> 
> Thanks Masami,
> 
> I'll start testing this now. I just finished testing everything else I
> had in my queue and pushed it to my for-next branch. Can you check to
> see if I missed anything there?

Yeah, it seems all acked patches are picked up.
I'll move onto the next series.

Thank you!

> 
> -- Steve
> 
> 
> > 
> > Fixes: f61872bb58a1 ("bootconfig: Use parse_args() to find bootconfig and '--'")
> > Cc: stable@vger.kernel.org
> > Reported-by: Arvind Sankar <nivedita@alum.mit.edu>
> > Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  Changes in v2:
> >   - Remvoe unneede !IS_ERR().
> > ---
> >  init/main.c |   14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/init/main.c b/init/main.c
> > index 0ead83e86b5a..883ded3638e5 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -387,8 +387,6 @@ static int __init bootconfig_params(char *param, char *val,
> >  {
> >  	if (strcmp(param, "bootconfig") == 0) {
> >  		bootconfig_found = true;
> > -	} else if (strcmp(param, "--") == 0) {
> > -		initargs_found = true;
> >  	}
> >  	return 0;
> >  }
> > @@ -399,19 +397,23 @@ static void __init setup_boot_config(const char *cmdline)
> >  	const char *msg;
> >  	int pos;
> >  	u32 size, csum;
> > -	char *data, *copy;
> > +	char *data, *copy, *err;
> >  	int ret;
> >  
> >  	/* Cut out the bootconfig data even if we have no bootconfig option */
> >  	data = get_boot_config_from_initrd(&size, &csum);
> >  
> >  	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
> > -	parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
> > -		   bootconfig_params);
> > +	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
> > +			 bootconfig_params);
> >  
> > -	if (!bootconfig_found)
> > +	if (IS_ERR(err) || !bootconfig_found)
> >  		return;
> >  
> > +	/* parse_args() stops at '--' and returns an address */
> > +	if (err)
> > +		initargs_found = true;
> > +
> >  	if (!data) {
> >  		pr_err("'bootconfig' found on command line, but no bootconfig found\n");
> >  		return;
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
