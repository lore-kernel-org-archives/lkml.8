Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997DFC33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A95620CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgAaOZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 09:25:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:48714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728730AbgAaOZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 09:25:30 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3EA0215A4;
        Fri, 31 Jan 2020 14:25:28 +0000 (UTC)
Date:   Fri, 31 Jan 2020 09:25:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        syzbot <syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        ingrassia@epigenesys.com, LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] usb: core: urb: change a dev_WARN() to dev_err() for
 syzbot
Message-ID: <20200131092527.3f05a679@gandalf.local.home>
In-Reply-To: <CACT4Y+YmUBUzZQNrHZtCV-LDxvmgoJtaoPYYP9OgRpAa59qF-g@mail.gmail.com>
References: <00000000000095e1d8059d4675ac@google.com>
        <20200131090510.7112-1-hdanton@sina.com>
        <20200131101644.GE11068@kadam>
        <CACT4Y+YmUBUzZQNrHZtCV-LDxvmgoJtaoPYYP9OgRpAa59qF-g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2020 12:19:39 +0100
Dmitry Vyukov <dvyukov@google.com> wrote:

> +Eric, Steve, who got these WARNING-not-a-kernel-bug reports recently too

I've been trying to convert all WARN_ON() in my code to be only
triggered if something happens where I don't expect it to happen, and
there's either a bug in the code, or I missed something in the design
of the code. That is, if a WARN_ON() triggers, it means I need to have
a good look at the code to figure out why.

I like the idea of a NOTICE() that can be used for hardware bugs or bad
user input. Something to say, "the kernel code is fine, but we received
something we did not expect", which to me is different than a bug in
the kernel. Although, it could lead to finding a bug.

-- Steve
