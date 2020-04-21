Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB36C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A5E206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgDUL0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 07:26:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55268 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgDUL0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 07:26:12 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jQr2U-0008Un-Ph; Tue, 21 Apr 2020 11:26:06 +0000
Date:   Tue, 21 Apr 2020 13:26:06 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        Christof Meerwald <cmeerw@cmeerw.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal: Avoid corrupting si_pid and si_uid in
 do_notify_parent
Message-ID: <20200421112606.ay4cck2dphguqazb@wittgenstein>
References: <20200419201336.GI22017@edge.cmeerw.net>
 <87sggyytnh.fsf@x220.int.ebiederm.org>
 <20200421083031.5wapruzncjkagvhf@wittgenstein>
 <20200421092846.GB6787@redhat.com>
 <20200421102104.6pt34jknxmtu5ygm@wittgenstein>
 <20200421111139.GC6787@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200421111139.GC6787@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 01:11:40PM +0200, Oleg Nesterov wrote:
> Sorry Christian, I don't understand...

In my original mail, it was really just a clarification question. I
said the patch is correct from looking at the codepaths. :) I was just
trying to see whether there was a potential corner-case we're missing
where "force" could be _validly_ true.

> 
> > because child subreapers can't come from outside the pid namespace. If
> > they could you could create a scenario where the signal is generated
> > from a sibling pid namespace in which case it would be correctly set to
> > true.
> 
> not sure I understand, but probably the answer is "yes"...

(This is really purely academic now since it isn't possible, but for
pure amusement assume that a child subreaper could cross namespace
boundaries (which they don't). A marks itself as a subreaper and creates
a new process B in a new pid namespace <pidnsB>, process B setnses into
<pidnsC> which is a sibling pid namespace, B clones a new proces in
<pidnsC> which is now a full member of <pidnsC>, B dies and C is
reparented to A, B exits and then you'd be getting a sigchld from a pid
in a pid namespace in which you have no pid nr.)
