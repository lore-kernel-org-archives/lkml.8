Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B8FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE92C20663
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580325964;
	bh=Yl825t3iEZ9buUUQpy6DFrNLD2QXVg3+Vh95zXjA0YU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=TInn7c5ytEbGi5pL7vlglw54K6gxKzj/amp9kkT20tT6zKU30eetgg73GFOwRrv93
	 XaCb6jP1N0iu3aqe1CO7jE+65ybrq+0lISYXocO7oKMcy6R69XRpMJc/yc62ukEVw8
	 dMXDo6CnyqrRQVyHvUtb67CpXdQq9tfw6yjGf5fQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgA2T0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:26:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:35222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgA2T0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:26:03 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B80120661;
        Wed, 29 Jan 2020 19:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580325963;
        bh=Yl825t3iEZ9buUUQpy6DFrNLD2QXVg3+Vh95zXjA0YU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jGfMBgUqiwXEsv1joHMa8MKSKFPtqcwjn8dKeRt42hRj347g6r/6iUVVtrCDGp8jm
         ueQnutfF7uiJ22pzV2wrZGkmv+6IsJQ3/qHtLb2LjoyR2OB2B6Z0EuRzXnIrmwgFo+
         29p9L+TisDEIg31p+KXsqiWEac31vlGQVfo7ewpk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C3B9A3521AEF; Wed, 29 Jan 2020 11:26:02 -0800 (PST)
Date:   Wed, 29 Jan 2020 11:26:02 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>, Qian Cai <cai@lca.pw>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH] locking/osq_lock: fix a data race in osq_wait_next
Message-ID: <20200129192602.GA2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200122165938.GA16974@willie-the-truck>
 <A5114711-B8DE-48DA-AFD0-62128AC08270@lca.pw>
 <20200122223851.GA45602@google.com>
 <A90E2B85-77CB-4743-AEC3-90D7836C4D47@lca.pw>
 <20200123093905.GU14914@hirez.programming.kicks-ass.net>
 <E722E6E0-26CB-440F-98D7-D182B57D1F43@lca.pw>
 <CANpmjNNo6yW-y-Af7JgvWi3t==+=02hE4-pFU4OiH8yvbT3Byg@mail.gmail.com>
 <20200128165655.GM14914@hirez.programming.kicks-ass.net>
 <20200129002253.GT2935@paulmck-ThinkPad-P72>
 <20200129184935.GU14879@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129184935.GU14879@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 07:49:35PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 28, 2020 at 04:22:53PM -0800, Paul E. McKenney wrote:
> > On Tue, Jan 28, 2020 at 05:56:55PM +0100, Peter Zijlstra wrote:
> > > On Tue, Jan 28, 2020 at 12:46:26PM +0100, Marco Elver wrote:
> > > 
> > > > > Marco, any thought on improving KCSAN for this to reduce the false
> > > > > positives?
> > > > 
> > > > Define 'false positive'.
> > > 
> > > I'll use it where the code as written is correct while the tool
> > > complains about it.
> > 
> > I could be wrong, but I would guess that Marco is looking for something
> > a little less subjective and a little more specific.  ;-)
> 
> How is that either? If any valid translation by a compile results in
> correct functionality, yet the tool complains, then surely we can speak
> of a objective fact.

Marco covered my concern in his point about the need to change the
compiler.

In any case, agreed, if a read does nothing but feed into the old/new
values for a CAS, the only thing a reasonable compiler (as opposed to
a just-barely-meets-the-standard demonic compiler) can do to you is to
decrease the CAS success rate.

							Thanx, Paul
