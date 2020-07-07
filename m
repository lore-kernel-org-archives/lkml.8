Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D968C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0782F20771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgGGNlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 09:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgGGNlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 09:41:50 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AF6820658;
        Tue,  7 Jul 2020 13:41:49 +0000 (UTC)
Date:   Tue, 7 Jul 2020 09:41:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Harrosh, Boaz" <Boaz.Harrosh@netapp.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>, Chris Mason <clm@fb.clm>
Subject: Re: [Tech-board-discuss] [Ksummit-discuss] [PATCH] CodingStyle:
 Inclusive Terminology
Message-ID: <20200707094147.213e0a82@oasis.local.home>
In-Reply-To: <202007070137.3ADBEDC@keescook>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CALCETrXewAK4_fpaJNDHJVDK9mUcjghA5HwYvZFQNYVfC9M+OQ@mail.gmail.com>
        <202007062234.A90F922DF@keescook>
        <DM6PR06MB3836FBAD65096AF63ACD3DB3EE660@DM6PR06MB3836.namprd06.prod.outlook.com>
        <202007070137.3ADBEDC@keescook>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jul 2020 01:54:23 -0700
Kees Cook <keescook@chromium.org> wrote:

> "I will whitelist the syscall" -- sounds correct to me (same for
> "it is whitelisted" or "it is in whitelisting mode").
> 
> "I will allow-list the syscall" -- sounds wrong to me (same for
> "it is allow-listed" or "it is in allow-listing mode").

That's because we can't just make "allow-list" a drop in replacement
for "whitelist" as I too (native English speaker) find it awkward. But
then we don't need to make it a drop in replacement.

"I will whitelist the syscall" will become "I will add the syscall to
the allow-list", which sounds perfectly fine, and even better than
saying "I will add the syscall to the whitelist".

-- Steve
