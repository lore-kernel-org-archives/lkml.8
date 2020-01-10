Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8F6C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C752B2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AV133+fO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgAJN4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 08:56:18 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40456 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbgAJN4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 08:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XDFh81v50T65CqGR12jZtTBrz00AMNxO6f5LHG6APQY=; b=AV133+fOtlsjPiO6C9hIJ9hDD
        EUyWULs+/urgMHe3Wi3caTqSGZhPV2RHcdmrh2MXTplQlTtaZcLAFni3OGU7AiTZLFGOFP+yYUTkE
        t39L/UdAD0TGkxrt2xJHPHWhQCqjC0gflRaTpE66ttWZh/Cc2SePUemOLMCYWB/07+UNcT1jfuFhv
        kbR9U3EFdfgah0oTX4eeXISyusibuK98vKEZd8S/PWZHPXtOh/aRMkKNoWhBT51PJYQXjajFI972S
        0LVIyqbukpjq1zf5y1KOaKJO8VDQhsXCOYHbqvATltnld2yOsR4NILpu5zP8H2zvfdAlYo1AhKB+h
        ldkrLGFHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipulR-0003mo-Qz; Fri, 10 Jan 2020 13:55:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5C76130018B;
        Fri, 10 Jan 2020 14:54:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 530AF2B612603; Fri, 10 Jan 2020 14:55:47 +0100 (CET)
Date:   Fri, 10 Jan 2020 14:55:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Wang Long <w@laoqinren.net>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/psi: create /proc/pressure and
 /proc/pressure/{io|memory|cpu} only when psi enabled
Message-ID: <20200110135547.GN2844@hirez.programming.kicks-ass.net>
References: <1576672698-32504-1-git-send-email-w@laoqinren.net>
 <20200108135526.GH2844@hirez.programming.kicks-ass.net>
 <20200109153002.GA8547@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109153002.GA8547@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 10:30:02AM -0500, Johannes Weiner wrote:
> On Wed, Jan 08, 2020 at 02:55:26PM +0100, Peter Zijlstra wrote:
> > On Wed, Dec 18, 2019 at 08:38:18PM +0800, Wang Long wrote:
> > > when CONFIG_PSI_DEFAULT_DISABLED set to N or the command line set psi=0,
> > > I think we should not create /proc/pressure and
> > > /proc/pressure/{io|memory|cpu}.
> > > 
> > > In the future, user maybe determine whether the psi feature is enabled by
> > > checking the existence of the /proc/pressure dir or
> > > /proc/pressure/{io|memory|cpu} files.
> > 
> > Works for me; Johannes?
> 
> Seems reasonable, and the patch looks good to me.
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks!
