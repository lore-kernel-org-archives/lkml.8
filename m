Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EA1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63A524658
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbgA0Pz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 10:55:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729203AbgA0Pzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 10:55:55 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C0292067C;
        Mon, 27 Jan 2020 15:55:54 +0000 (UTC)
Date:   Mon, 27 Jan 2020 10:55:53 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, borntraeger@de.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf test: Test case 66 broken on s390 (lib/traceevent
 issue)
Message-ID: <20200127105553.3cd92ef8@gandalf.local.home>
In-Reply-To: <659928a1-95b3-ed0d-7988-745d92b495d6@linux.ibm.com>
References: <20200124073941.39119-1-tmricht@linux.ibm.com>
        <20200124100742.4050c15e@gandalf.local.home>
        <20200125013153.46f05fc1f617fcd341e7060b@kernel.org>
        <20200124113610.662f4afb@gandalf.local.home>
        <659928a1-95b3-ed0d-7988-745d92b495d6@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2020 08:34:23 +0100
Thomas Richter <tmricht@linux.ibm.com> wrote:

> Steven and Masami,
> 
> thanks for the patch, it fixes this issue!

Thanks for letting me know. I'll add a:

  Tested-by: Thomas Richter <tmricht@linux.ibm.com>

to the commit.

> 
> PS: I should have sent this description earlier, would have saved a week of debugging
> on my side....

Heh, I do things like this ofter after triggering bugs in others
code, and will spend a few days debugging it, then finding out that
there's already a fix to the bug I find (or presenting the problem
gives a proper fix). I just calk it up as a learning experience ;-)

-- Steve
