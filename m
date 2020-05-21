Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6B4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 983832072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590047728;
	bh=ztmjDJnB4DSWgslDZyMOEVi8COfs+ltn8Y9+Iuj2nII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dTgqsKZx3O4d1hs1b0h8hJvxWtpj4cikknThkzBIZem6nXIzeNK+q7Vd6JBcPonsb
	 HmFc1NONwpdEKmT33Zix8aK+LeRiycBLwXi1BYE5NxmLc5yvIrdxR8a4IQLHLwZnWE
	 hKvg4nlAJVex5PaxRk3Ki1DYS1ShrZk4w0gq3xpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgEUHz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 03:55:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgEUHz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 03:55:26 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D84652065F;
        Thu, 21 May 2020 07:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590047726;
        bh=ztmjDJnB4DSWgslDZyMOEVi8COfs+ltn8Y9+Iuj2nII=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ls/GEh7qp37HU5oV5n5PFupvaIEyg1WxgVqju8G1lW26hggWhNA/3jIe+UKfSJqKa
         ft0Ll+k8rkUL8TPv/udLvB6hxaoZPblI8yXrU9/9ykOOEFjKQ5LZp9ERzFF/HFKCZ4
         4dNg4eBPFVb4PLlDxy2lytoxC6N4f9efHEBeQZ4I=
Date:   Thu, 21 May 2020 16:55:21 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 0/3] tracing/kprobes: Fix event generation API etc.
Message-Id: <20200521165521.d55b76a1ca3b2a1e99b8174a@kernel.org>
In-Reply-To: <20200520104005.3c525969@gandalf.local.home>
References: <158779373972.6082.16695832932765258919.stgit@devnote2>
        <20200520232220.ec89497aab17d7e6507b9886@kernel.org>
        <20200520103346.53dcad9b@gandalf.local.home>
        <20200520104005.3c525969@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020 10:40:05 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 20 May 2020 10:33:46 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 20 May 2020 23:22:20 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > Hi Steve,
> > > 
> > > It seems this fixes are not picked up yet.
> > > Would you have any consideration?
> > >   
> > 
> > 
> > Ah, I missed your reply to my comment :-/
> > 
> > Yeah, I'll pull that in now and start testing it.
> > 
> > Thanks for the reminder.
> 
> No, it's already in mainline:
> 
> Merged: 192ffb7515839b1cc8457e0a8c1e09783de019d3
> 
> With commits:
> 
>  dcbd21c9fca5e954fd4e3d91884907eb6d47187e
>  da0f1f4167e3af69e1d8b32d6d65195ddd2bfb64
>  5b4dcd2d201a395ad4054067bfae4a07554fbd65

Oops, I must have checked another branch. Sorry.

Thank you!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
