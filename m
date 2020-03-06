Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149CEC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC8E208CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583503453;
	bh=Nq9KmkAUq5F9r3sx/yxBgy6aw7mRvtKy8xoVi/1LUaU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=w+2sARb6wQDzuIBDoRTZhegRXf+bLBtjqMUZZ+FK+5PqpyBF/J1dby/O+V6KrUvXn
	 XHUNTo77LVzzEhB87MKfbsUHVlah/IaFDZ8/aTsFXVJFTgzQIUcreiSqoK72uCcLhl
	 qii0JmNsbIM75jmKUWyLxb+GgCY5meN4Ln8xCOEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgCFOEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:04:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgCFOEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:04:12 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9312F20866;
        Fri,  6 Mar 2020 14:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583503451;
        bh=Nq9KmkAUq5F9r3sx/yxBgy6aw7mRvtKy8xoVi/1LUaU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1VmdVldybeLhw8UkDSUvunsqGSnJj3olRcE2BPDvB6NY6YKLfpOZJ3HNCdILvE1OE
         552ncCbIyD6AoID2TsIZ/lrANy9t+Zcf7UxSG3gJHff3FhlaslGL+tHNTdr/yYGA6v
         qOFPJUC7HazIsfQ6YlNCnrz6L7+jkSTtHrZD3UZ0=
Date:   Fri, 6 Mar 2020 23:04:06 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-doc@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v5.1] Documentation: bootconfig: Update boot
 configuration documentation
Message-Id: <20200306230406.dd9c7358f00f47ff5760c899@kernel.org>
In-Reply-To: <58f4d6b3-ce3d-d1a5-aa0f-c31c1bbec091@web.de>
References: <ef820445-25c5-a312-57d4-25ff3b4d08cf@infradead.org>
        <158341540688.4236.11231142256496896074.stgit@devnote2>
        <f3c51b0a-2a55-6523-96e2-4f9ef0635d9f@web.de>
        <20200306105107.afba066a97db1eb12f290aff@kernel.org>
        <58f4d6b3-ce3d-d1a5-aa0f-c31c1bbec091@web.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Mar 2020 10:34:30 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> > If you think you have "any more" update candidates, feel free to make
> > an update "patch" and send to us.
> 
> I pointed a few change possibilities out already.

I can not respond to requests only for possibility.

> > That will be the next step.
> 
> I got the impression that we are in the process of constructing another patch together
> which will fix known wording weaknesses.

Would you mean the broken EBNF part? Yeah, maybe, but it is another story.
I decided to drop it this time.
You can refine it but please use better format instead of such incomplete one.

> By the way:
> I wonder about the shown version identifier.
> Will the patch numbering need also further considerations?

No.

> >> …
> >>> +++ b/Documentation/admin-guide/bootconfig.rst
> >> …
> >>> +If you think that kernel/init options become too long to write in boot-loader
> >>> +configuration file or you want to comment on each option, the boot
> >>> +configuration may be suitable. …
> >>
> >> Would you like to specify any settings in the boot configuration file
> >> because the provided storage capacity would be too limited by the kernel command line?
> >
> > Yes.
> 
> How will affected places be improved after such an agreement?

Would you please make a patch of new sentence?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
