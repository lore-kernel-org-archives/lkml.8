Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABBBC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 22:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 440B921D7E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 22:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599691142;
	bh=yat5qEF1R5Wi8ynqYlJsDRaKkP24UNOVO0pWcjtQ5r4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iv88u6SIELIgoHT8MTD9VjiBkIzEwmqtqvazsn4BWjb5Aj0JjLn3qh4XzA5ACeW8/
	 AGUpiS/yu7wXax9GQWz3tTIq2vuzxWQIAeQsEgfvH8s4cOD1W/5/sIDkGSwkPRIRfI
	 KzaM2MKWOd9wi0h/c0TgYVRlIxnh9b/1Y0Q5r1T8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgIIWjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 18:39:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgIIWi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 18:38:59 -0400
Received: from localhost (lfbn-ncy-1-588-162.w81-51.abo.wanadoo.fr [81.51.203.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E8CA20C09;
        Wed,  9 Sep 2020 22:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599691138;
        bh=yat5qEF1R5Wi8ynqYlJsDRaKkP24UNOVO0pWcjtQ5r4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fOSS7FUOCNOtmolfkDcK2XSQIEP4VvLYrcUy1ovKzcVirOB3tnXzqWxykFDJ2K06/
         QKrAfqs7/Dy2feGXP3UHSZ9Q1ZP4xT38osGtyASaXYLOypXXL+wkmV4Tpp3P4a8xkr
         43HJgvX7QTLQ3HZVPbxT/qVbShKQfTl8frzLqcRA=
Date:   Thu, 10 Sep 2020 00:38:56 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Requirements to control kernel isolation/nohz_full at runtime
Message-ID: <20200909223856.GB20541@lenoir>
References: <20200901104640.GA13814@lenoir>
 <20200903182359.GA1016174@fuller.cnet>
 <20200903183015.GA1027417@fuller.cnet>
 <20200903183636.GB99697@lorien.usersys.redhat.com>
 <20200903185200.GA1029791@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903185200.GA1029791@fuller.cnet>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 03:52:00PM -0300, Marcelo Tosatti wrote:
> On Thu, Sep 03, 2020 at 02:36:36PM -0400, Phil Auld wrote:
> > exclusive cpusets is used now to control scheduler load balancing on
> > a group of cpus.  It seems to me that this is the same idea and is part
> > of the isolation concept.  Having a toggle for each subsystem/feature in
> > cpusets could provide the needed userspace api. 
> > 
> > Under the covers it might be implemented as twiddling various cpumasks.
> > 
> > We need to be shifting to managing load balancing with cpusets anyway.
> 
> OK, adding a new file per isolation feature:
> 
> 	- cpuset.isolation_nohz_full
> 	- cpuset.isolation_kthread
> 	- cpuset.isolation_time
> 
> With a bool value per file, is an option.

Exactly. I would merge kthread/timers/workqueue into
cpuset.isolation.unbound though. Unless anyone may need more
granularity there?
