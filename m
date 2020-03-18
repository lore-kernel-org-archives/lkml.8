Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632AFC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D20A20752
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgCRO4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:56:12 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:52160 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgCRO4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:56:12 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id A8A1F3C0579;
        Wed, 18 Mar 2020 15:56:09 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9dQaXwgJ0t2n; Wed, 18 Mar 2020 15:56:04 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 3DD1D3C00C3;
        Wed, 18 Mar 2020 15:56:04 +0100 (CET)
Received: from lxhi-065.adit-jv.com (10.72.94.40) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 18 Mar
 2020 15:56:03 +0100
Date:   Wed, 18 Mar 2020 15:56:00 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [RFC PATCH 0/3] Fix quiet console in pre-panic scenarios
Message-ID: <20200318145600.GA20301@lxhi-065.adit-jv.com>
References: <20200315170903.17393-1-erosca@de.adit-jv.com>
 <20200316143517.651abbeb@gandalf.local.home>
 <20200316190948.7peesqnx6yhpzdpl@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200316190948.7peesqnx6yhpzdpl@linutronix.de>
X-Originating-IP: [10.72.94.40]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,
Cc: John Ogness

On Mon, Mar 16, 2020 at 08:09:48PM +0100, Sebastian Andrzej Siewior wrote:
> On 2020-03-16 14:35:17 [-0400], Steven Rostedt wrote:
> > I don't see any issues with this patch set. What do others think?
> > 
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > [ Note, I only acked, and did not give a deep review of it ]
> 
> What is the state of the other larger printk rework? If this does not
> solve any -stable related issues then it will be replaced?

Is this a question to John and his most recent series in
https://lore.kernel.org/lkml/20200128161948.8524-1-john.ogness@linutronix.de/
?

Is there any upstream agreement to already keep the current printk
mechanism away from any updates?

-- 
Best Regards
Eugeniu Rosca
