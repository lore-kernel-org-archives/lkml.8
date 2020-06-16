Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B04C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E310B2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xums47GE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgFPOC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728908AbgFPOCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:02:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8B1C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 07:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qo9CnAT+aab0Ut3f7Yuy5n9QdYXS6e410dJb6BVWkRI=; b=Xums47GEWXlRQz7J1HKYxW9gMr
        JD0TMHDcMhQ8xkqodcrWJFLIQd5swU5qrm/olpW54z3c3jZXeCzb03CYU1OzCW/gPla8Dui8ZQxLd
        n3flGqm0V+23+DraWxkS6YK/kfUgiJ+BHszJqzJK/lSlL7JvVGprakhRvXTvUA31LaUcBExJR1lA6
        4gqKweGxBGnoey+ksrWp0GifwLUzSYDUTaddEMsOb9l2HvPjk6UubqlgBJc73xKbG694LiWav9uHY
        c/2Eq9hTzgS9T2eGm5ztDHu6jRtBrpOvFB6P52AHlZOw24SwWiw+bXPSGI0L7rBTq4d/CaktbIjRN
        UUMHW0kQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlCA4-0003JY-UF; Tue, 16 Jun 2020 14:02:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E110630018A;
        Tue, 16 Jun 2020 16:01:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CD7F22038E4EB; Tue, 16 Jun 2020 16:01:58 +0200 (CEST)
Date:   Tue, 16 Jun 2020 16:01:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Lichao Liu <liulichao@loongson.cn>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Don't active rt throtting when no running cfs
 task
Message-ID: <20200616140158.GY2531@hirez.programming.kicks-ass.net>
References: <20200616123729.153430-1-liulichao@loongson.cn>
 <20200616095027.1a2048d0@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616095027.1a2048d0@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 09:50:27AM -0400, Steven Rostedt wrote:
> On Tue, 16 Jun 2020 20:37:29 +0800
> Lichao Liu <liulichao@loongson.cn> wrote:
> 
> > Active rt throtting will dequeue rt_rq from rq at least 50ms,
> > When there is no running cfs task, do we still active it?
> > 
> 
> This is something I would like to have.
> 
> Peter, what's your thought on this?

I'd love to just delete all of this.. that said, I'm not sure this
change makes sense, because it doesn't deal sanely with the case where
the task will appear right after we did this.

The right thing to do is that fair deadline server thing.
