Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A48C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 155A120658
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgGGNha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 09:37:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgGGNh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 09:37:29 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABF8420771;
        Tue,  7 Jul 2020 13:37:28 +0000 (UTC)
Date:   Tue, 7 Jul 2020 09:37:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        Andy Lutomirski <luto@amacapital.net>, Chris Mason <clm@fb.clm>
Subject: Re: [Tech-board-discuss] [Ksummit-discuss] [PATCH] CodingStyle:
 Inclusive Terminology
Message-ID: <20200707093727.22aa39e2@oasis.local.home>
In-Reply-To: <20200707064921.GA9411@linux.ibm.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CALCETrXewAK4_fpaJNDHJVDK9mUcjghA5HwYvZFQNYVfC9M+OQ@mail.gmail.com>
        <202007062234.A90F922DF@keescook>
        <20200707064921.GA9411@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jul 2020 09:49:21 +0300
Mike Rapoport <rppt@linux.ibm.com> wrote:

> > But that's all fine. The change is easy to do and is more descriptive
> > even if I can't find terms that don't collide with my internal grammar
> > checker. ;)  
> 
> How about yeslist and nolist? ;-)

I was thinking good-list / bad-list.

/me that has been doing a lot of git bisect lately...

-- Steve
