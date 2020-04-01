Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA7FC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40128206EB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l8fvTKtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732114AbgDAJjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 05:39:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37280 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgDAJjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 05:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RksYf+q6dSBUyZMkDcFmWmu9Hr1Fry3FcTH7BUg8obI=; b=l8fvTKtCgOlxGfXClvJyCWI6p6
        aCkUuOvh+WWwyTaHw7Diz4G3KUbksL20hm4UMkQa6BBQTGdgf+JzYJ8ENK/r8Ck4onz3RYDfVeo8J
        OQLLaHrfKjgRRB/KjNrL7dj42aJVzjY6UdDQ4cosoI+m3x0P1vX6QCiRB6WblUaSwEYNv3qDPYlol
        HmZAfqFTTx3GUc07RIgv2SXmYKG1QKNWEYAu6Ez+R7jDkSXAnJC9ak28gAW9m1hSI6M2J2FGzt2vF
        pfSKlMZMpMTugUsr1lGeb30zntwmWyAJMQdaGoLcIq4yWtGZk+6MCKL3chcZ8K6DevXC/vrG7uqCV
        vZlcqvUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJZq0-0008PU-4k; Wed, 01 Apr 2020 09:39:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1D8B73025C3;
        Wed,  1 Apr 2020 11:39:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F3A6F29DB2524; Wed,  1 Apr 2020 11:39:04 +0200 (CEST)
Date:   Wed, 1 Apr 2020 11:39:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     liyueyi <liyueyi@live.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        liyueyi <liyueyi@xiaomi.com>
Subject: Re: [PATCH] kthread: set kthread state to TASK_IDLE.
Message-ID: <20200401093904.GX20713@hirez.programming.kicks-ass.net>
References: <DM6PR11MB3531D3B164357B2DC476102DDFC90@DM6PR11MB3531.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3531D3B164357B2DC476102DDFC90@DM6PR11MB3531.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 02:52:15PM +0800, liyueyi wrote:
> From: liyueyi <liyueyi@xiaomi.com>
> 
> Currently kthread() sleeps in TASK_UNINTERRUPTIBLE state waiting
> for the first wakeup, it may be detected by DETECT_HUNG_TASK if
> the first wakeup is coming later. Since kernel has introduced
> TASK_IDLE, change kthread state to TASK_IDLE.

How the heck can that ever happen anyway? Is this some virt
brain-damage?

And how is it not a real problem when it takes this long? 
