Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D270C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7363E206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E6HALyGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732170AbgCPQl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:41:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53270 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732149AbgCPQl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yIPai28MQMK5lRJnqJuabulZFAzep7tvbRM36Tir//s=; b=E6HALyGxPMtkxeZUe706w/QqAV
        qwZu7ZfFvCuZiOn6ySUTz4V8gJkyk9FUXE5ZVP9KPYkEAKXWUxzGY6D0RfXTz4K2zHPSMhniJk74i
        7aXZB/VWjhZ2DSwMd4vpcSjp7Ja9FWbxXtY4AcKvU9LlGW8eW93w6cS/YmxtKpa/jyAjAJSgDvqkV
        9f+VAv5sW/zeZoYGsTHPHSCg0+grlWXmSAmjyAL9G9jaF2gwIV+4T0uhVzMlNom0Qb86qXCrUpE8X
        jgyr+uaUIBiJaR/PPefYv8xp+Ham5MZsRNpUWFzSHVAcojcW6Wvn2gcwx3C0KU8HV87mP8ir5pX/5
        95W4OdKg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDsnQ-0000rD-Sx; Mon, 16 Mar 2020 16:40:56 +0000
Date:   Mon, 16 Mar 2020 09:40:56 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     hannes@cmpxchg.org, akpm@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] psi: move PF_MEMSTALL out of task->flags
Message-ID: <20200316164056.GY22433@bombadil.infradead.org>
References: <1584355585-10210-1-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584355585-10210-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 06:46:25AM -0400, Yafang Shao wrote:
> +++ b/include/linux/sched.h
> @@ -786,6 +786,10 @@ struct task_struct {
>  	/* to be used once the psi infrastructure lands upstream. */

That comment looks out of date ...

>  	unsigned			use_memdelay:1;
