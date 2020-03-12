Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CC0C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF41206CD
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584052360;
	bh=Lza2wvGcb07HstOGtM3uhmYGNmaJ9AzJsigH30FF04c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xEHe5GmsqbXJOHyR7/DySsJbkARmVYqdv2fdUiLjWv7El93NVbgSjkpa3FhJ8ELO+
	 RBfXDeQ7H/I4w035gg/VLV/i11XPqwZULxRp92Q/4FrS5IxfLMWLO9r0PdFq++7Y9h
	 caFZKWU2V0gqdUn04+5wtucS+/e5Wnd/Q59L6weg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgCLWcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:32:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgCLWcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 18:32:39 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CBE920637;
        Thu, 12 Mar 2020 22:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584052358;
        bh=Lza2wvGcb07HstOGtM3uhmYGNmaJ9AzJsigH30FF04c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2u1oozTCjgkspj5iC+6D6dBZcbBYV0TdViO75UI0pVKxRdVf6Yf6B4BTFuO9ld+3c
         FWyX5qGQKQEAa+V2jnHQ7SjZ+sx9hTOKyZ3zlops4671t8fqYEwGRPRLTbWhnm9JHW
         ARFpFWy5RudMAXMCwm65x/vy1QbG2Yolwf7LkPvo=
Date:   Thu, 12 Mar 2020 15:32:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP
 systems
Message-Id: <20200312153238.c8d25ea6994b54a2c4d5ae1f@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.21.2003121101030.158939@chino.kir.corp.google.com>
References: <993e7783-60e9-ba03-b512-c829b9e833fd@i-love.sakura.ne.jp>
        <alpine.DEB.2.21.2003111513180.195367@chino.kir.corp.google.com>
        <202003120012.02C0CEUB043533@www262.sakura.ne.jp>
        <alpine.DEB.2.21.2003121101030.158939@chino.kir.corp.google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Mar 2020 11:07:15 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:

> On Thu, 12 Mar 2020, Tetsuo Handa wrote:
> 
> > > On Thu, 12 Mar 2020, Tetsuo Handa wrote:
> > > > > If you have an alternate patch to try, we can test it.  But since this 
> > > > > cond_resched() is needed anyway, I'm not sure it will change the result.
> > > > 
> > > > schedule_timeout_killable(1) is an alternate patch to try; I don't think
> > > > that this cond_resched() is needed anyway.
> > > > 
> > > 
> > > You are suggesting schedule_timeout_killable(1) in shrink_node_memcgs()?
> > > 
> > 
> > Andrew Morton also mentioned whether cond_resched() in shrink_node_memcgs()
> > is enough. But like you mentioned,
> > 
> 
> It passes our testing because this is where the allocator is looping while 
> the victim is trying to exit if only it could be scheduled.

What happens if the allocator has SCHED_FIFO?
