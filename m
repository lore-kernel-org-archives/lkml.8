Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820F1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6867A206A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgFCPbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgFCPbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:31:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C6FB205CB;
        Wed,  3 Jun 2020 15:30:59 +0000 (UTC)
Date:   Wed, 3 Jun 2020 11:30:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: linux-next: build failure after merge of the ftrace tree
Message-ID: <20200603113058.11895c24@gandalf.local.home>
In-Reply-To: <af08615d0ce87b7c920a0ac6a5389834a0504cb7.camel@kernel.org>
References: <20200603174253.60deace5@canb.auug.org.au>
        <20200603112223.3adc3451@gandalf.local.home>
        <af08615d0ce87b7c920a0ac6a5389834a0504cb7.camel@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Jun 2020 10:24:36 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> > It appears to be the ascii art that is causing the issue. I have no
> > idea
> > how to fix it. If someone has a patch they would like to submit, I
> > will
> > take it before I push it off to Linus.
> > 
> > -- Steve  
> 
> I just sent you/posted a patch to fix this.  Should be in your inbox
> already.

Thanks Tom!

Stephen,

Can you test if this fixes the issue for you? If so, I'll add it push it to
my for-next branch.

-- Steve
