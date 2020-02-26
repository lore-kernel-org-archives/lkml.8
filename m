Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36321C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A3024650
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582695249;
	bh=fps7Q7NeX2nh5WEWBJmBKMJvcbpoOQ72FLyxQGxfMHc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=dwYif/M8jvrVkHiX0gQbcwy8b8OWeUbOs6ZNo4ugradE3AqK9pLsXdZDnKU42zy2r
	 qdBeBS620MfHquJxn/EJ9hzs0+1vrgz13EpcrKHAZ9EtITTrCgnZ+SMa0EPkp+UV7R
	 CefRowoFW+CNwHXeI0dwlpZ0v1vycT72tuvJtoZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgBZFeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 00:34:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:35572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgBZFeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:34:07 -0500
Received: from [192.168.0.217] (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C444C21927;
        Wed, 26 Feb 2020 05:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582695247;
        bh=fps7Q7NeX2nh5WEWBJmBKMJvcbpoOQ72FLyxQGxfMHc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=n0g4yJ8a3s9BKFsvVLD50nv6/J85MJCRMtXlo2zkS4iFMzVqjb9rMbQ4MVw0HVGz8
         7nJNe0uuqTDXxtk0fEzW7GAAA6f5zZjmgjeyFlS9vna03slKP2cYLAmQVMVBwz4+c1
         2IirYHQFj0I8clFSXP9HU4U2EMDSODn6gjplMjqU=
Subject: Re: [patch 08/10] x86/entry/32: Remove the 0/-1 distinction from
 exception entries
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200225213636.689276920@linutronix.de>
 <20200225220216.933457250@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <6dd020cd-e20a-be12-aba7-bfa9e1a94795@kernel.org>
Date:   Tue, 25 Feb 2020 21:34:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225220216.933457250@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 1:36 PM, Thomas Gleixner wrote:
> Nothing cares about the -1 "mark as interrupt" in the errorcode anymore. Just
> use 0 for all excpetions which do not have an errorcode consistently.
> 

I sincerely wish this were the case.  But look at collect_syscall() in
lib/syscall.c.

It would be really quite nice to address this for real in some
low-overhead way.  My suggestion would be to borrow a trick from 32-bit:
split regs->cs into ->cs and ->__csh, and stick CS_FROM_SYSCALL into
__csh for syscalls.  This will only add any overhead at all to the int80
case.  Then we could adjust syscall_get_nr() to look for CS_FROM_SYSCALL.

What do you think?  An alternative would be to use the stack walking
machinery in collect_syscall(), since the mere existence of that
function is abomination and we may not care about performance.

--Andy
