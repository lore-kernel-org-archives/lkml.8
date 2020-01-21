Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05219C33CAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 21:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF52E2465B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 21:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgAUVoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 16:44:30 -0500
Received: from gentwo.org ([3.19.106.255]:55880 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728799AbgAUVo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 16:44:29 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id C4A623F247; Tue, 21 Jan 2020 21:44:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id C22693EC49;
        Tue, 21 Jan 2020 21:44:28 +0000 (UTC)
Date:   Tue, 21 Jan 2020 21:44:28 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
cc:     Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Watson <davejwatson@fb.com>,
        Will Deacon <will.deacon@arm.com>, shuah <shuah@kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russell King <linux@arm.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>, Ben Maurer <bmaurer@fb.com>,
        linux-api <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC PATCH v1] pin_on_cpu: Introduce thread CPU pinning system
 call
In-Reply-To: <2049164886.596497.1579641536619.JavaMail.zimbra@efficios.com>
Message-ID: <alpine.DEB.2.21.2001212141590.1231@www.lameter.com>
References: <20200121160312.26545-1-mathieu.desnoyers@efficios.com> <CAG48ez2bQdoT9y7HkyU06DTazysUDdPdJe+gyV-NxgQA7JWQVQ@mail.gmail.com> <430172781.596271.1579636021412.JavaMail.zimbra@efficios.com> <CAG48ez2Z5CesMfandNK+S32Rrgp_QGQHqQ1Fpd5-YTsCWGfHeg@mail.gmail.com>
 <2049164886.596497.1579641536619.JavaMail.zimbra@efficios.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


These scenarios are all pretty complex and will be difficult to understand
for the user of these APIs.

I think the easiest solution (and most comprehensible) is for the user
space process that does per cpu operations to get some sort of signal. If
its not able to handle that then terminate it. The code makes a basic
assumption after all that the process is running on a specific cpu. If
this is no longer the case then its better to abort if the process cannot
handle moving to a different processor.


