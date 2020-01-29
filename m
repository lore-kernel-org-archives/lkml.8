Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6CCC33CB7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C203920716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uoHQrrL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgA2M4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:56:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55238 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgA2M4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:56:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SLgmNjaM2cFkmb1tZ6hEg2KCmNp2rU4V4QwYCqC2LIk=; b=uoHQrrL5EvNo0CZjPA/Azrhq8
        ylfDQUgwONKpZb5NNNOmfeh1FruhN4CV7DZQluMt1CH9bLo5RCf+eYK1YWqiwaHniAAINWJcnlxYN
        5szs4Okfx1mE31BHAmui2CoCPhcyKGY+IkYkEwENcoxDzXXEPWtwKaG1IOj/JcIynG5BrlqTmT6Eo
        fmXyWY1nN5DIgcJ/KvYAtYGxQLbUWFiotg6O+3J7eoA8tTPqnO88nZgI0K+zJaEVqvfCIW4zJKz2m
        dxZ+mwMVodHeKz+FqX1imyRDBthA5WPFjUB/n+C40/PDdirgJ6ddfQvpGx7BCGGlhOOXNwUsCU1rh
        iq+rldLJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwmtH-0005jA-0E; Wed, 29 Jan 2020 12:56:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7489F300DD5;
        Wed, 29 Jan 2020 13:54:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D141F2B77DA21; Wed, 29 Jan 2020 13:56:15 +0100 (CET)
Date:   Wed, 29 Jan 2020 13:56:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     sjpark@amazon.com
Cc:     akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>,
        sj38.park@gmail.com, acme@kernel.org, amit@kernel.org,
        brendan.d.gregg@gmail.com, corbet@lwn.net, dwmw@amazon.com,
        mgorman@suse.de, rostedt@goodmis.org, kirill@shutemov.name,
        brendanhiggins@google.com, colin.king@canonical.com,
        minchan@kernel.org, vdavydov.dev@gmail.com, vdavydov@parallels.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: Re: [PATCH v2 0/9] Introduce Data Access MONitor (DAMON)
Message-ID: <20200129125615.GQ14879@hirez.programming.kicks-ass.net>
References: <41BBD985-4B3D-4F87-B69D-D8CFE6EC0EBE@lca.pw>
 <20200128120033.27016-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128120033.27016-1-sjpark@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 01:00:33PM +0100, sjpark@amazon.com wrote:

> I worried whether it could be a bother to send the mail to everyone in the
> section, but seems it was an unnecessary worry.  Adding those to recipients.
> You can get the original thread of this patchset from
> https://lore.kernel.org/linux-mm/20200128085742.14566-1-sjpark@amazon.com/

I read first patch (the document) and still have no friggin clue.


