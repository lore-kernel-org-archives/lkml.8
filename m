Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC83C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 01:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1369D21741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 01:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgBGBZI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 20:25:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbgBGBZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 20:25:08 -0500
Received: from oasis.local.home (unknown [12.174.139.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11DA42082E;
        Fri,  7 Feb 2020 01:25:05 +0000 (UTC)
Date:   Thu, 6 Feb 2020 20:25:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Michal =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v8 0/2] sched/numa: introduce numa locality
Message-ID: <20200206202504.7175c4a8@oasis.local.home>
In-Reply-To: <3b2c5a07-4bc0-1feb-2daf-260e4d58c7b6@linux.alibaba.com>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
        <207ef46c-672c-27c8-2012-735bd692a6de@linux.alibaba.com>
        <040def80-9c38-4bcc-e4a8-8a0d10f131ed@linux.alibaba.com>
        <25cf7ef5-e37e-7578-eea7-29ad0b76c4ea@linux.alibaba.com>
        <443641e7-f968-0954-5ff6-3b7e7fed0e83@linux.alibaba.com>
        <d2c4cace-623a-9317-c957-807e3875aa4a@linux.alibaba.com>
        <a95a7e05-ad60-b9ee-ca39-f46c8e08887d@linux.alibaba.com>
        <b9249375-fe8c-034e-c3bd-cacfe4e89658@linux.alibaba.com>
        <3b2c5a07-4bc0-1feb-2daf-260e4d58c7b6@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Feb 2020 09:10:33 +0800
王贇 <yun.wang@linux.alibaba.com> wrote:

> Hi, Peter, Ingo
> 
> Could you give some comments please?

A little word of advice. When sending new versions of a patch. Don't
send them as a reply to the previous version. Some developers (and I
believe Peter is one of them), wont look for new patches in threads,
and this may never be seen by him.

New versions of patches (v8 in this case) need to start a new thread
and be at the top level. It's hard to manage patches when a thread
series in embedded in another thread series.

-- Steve
