Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD89C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C15A2173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583181743;
	bh=SRrZiuIqb+CFf0u17GxuqBXyOhyi1OsfKZAOzYuzi14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AFW1hr7BTzet91HLUfD5zlUcdEWP6IzknfybOtnKqfPlZnFD8d7xnscBPKVOTjYEw
	 36oCTxUSwjGMoEKJHniIzOF6JkerOMBiuon9/ReK+5H2zXV7y67lNZQ1vXY3e7b/em
	 eRAPZ75mR9z0JGyqWDa+DXox/gXisXZvrTAcQQzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgCBUmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 15:42:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgCBUmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 15:42:21 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8947621556;
        Mon,  2 Mar 2020 20:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583181741;
        bh=SRrZiuIqb+CFf0u17GxuqBXyOhyi1OsfKZAOzYuzi14=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mWTO7w9FivA0BR7CvjDLlRubz0CWTSKXmAUYb//naFgTZGJwEiE05X9U33ba5S4kG
         lcVyj/dx/lg37DV+aAow2yU2a2VXdqv+jNBSmfLrc6VnOUbcYK7hMCfSVq8vOgXHby
         8+lwQfZMsowXwhhcJCtTXgUg1OXs6vIpGHsIGO9c=
Date:   Mon, 2 Mar 2020 12:42:19 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     linux-kernel@vger.kernel.org, dave@stgolabs.net,
        longman@redhat.com, manfred@colorfullife.com, mingo@redhat.com,
        mm-commits@vger.kernel.org, neilb@suse.com, oberpar@linux.ibm.com,
        rostedt@goodmis.org, viro@zeniv.linux.org.uk, vvs@virtuozzo.com
Subject: Re: + seq_read-info-message-about-buggy-next-functions.patch added
 to -mm tree
Message-Id: <20200302124219.eaf3d18422b76ff2196d9ce8@linux-foundation.org>
In-Reply-To: <1583177508.7365.144.camel@lca.pw>
References: <20200226035621.4NlNn738T%akpm@linux-foundation.org>
        <1583173259.7365.142.camel@lca.pw>
        <1583177508.7365.144.camel@lca.pw>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Mar 2020 14:31:48 -0500 Qian Cai <cai@lca.pw> wrote:

> On Mon, 2020-03-02 at 13:20 -0500, Qian Cai wrote:
> > This patch spams the console like crazy while reading sysfs,
> > 
> > # dmesg | grep 'buggy seq_file' | wc -l
> > 4204
> > 
> > [ 9505.321981] LTP: starting read_all_proc (read_all -d /proc -q -r 10)
> > [ 9508.222934] buggy seq_file .next function xt_match_seq_next [x_tables] did
> > not updated position index
> > [ 9508.223319] buggy seq_file .next function xt_match_seq_next [x_tables] did
> > not updated position index
> > [ 9508.223654] buggy seq_file .next function xt_match_seq_next [x_tables] did
> > not updated position index
> > [ 9508.223994] buggy seq_file .next function xt_match_seq_next [x_tables] did
> > not updated position index
> > [ 9508.224337] buggy seq_file .next function xt_match_seq_next [x_tables] did
> > not updated position index
> > ...
> > 
> > 
> > > --- a/fs/seq_file.c~seq_read-info-message-about-buggy-next-functions
> > > +++ a/fs/seq_file.c
> > > @@ -256,9 +256,12 @@ Fill:
> > >  		loff_t pos = m->index;
> > >  
> > >  		p = m->op->next(m, p, &m->index);
> > > -		if (pos == m->index)
> > > -			/* Buggy ->next function */
> > > +		if (pos == m->index) {
> > > +			pr_info("buggy seq_file .next function %ps "
> > > +				"did not updated position index\n",
> > > +				m->op->next);
> 
> This?
> 
> s/pr_info/pr_info_ratelimited/
> 

Fair enough - I made that change.
