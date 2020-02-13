Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E428C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3984B2465D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581613318;
	bh=U556d2PmtLaNN2i/zseRkAt5LAexOSH4RlsVoDHLoxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vctoa8PBalk16NhqyaD/4gpjl7rZwiXEgxaGiFoc1ljWJxtsdU8zT6ANEWt/Qu+kn
	 64+QwhZpR59dWqKHnKZllh4APo1bK3ceWEBLCOakXJ/0cOKOaFSuqomtDKtfC+LQbh
	 1EgUkVgR1J7PS97Ek0YwBB1dQHaAoxmWUCTyuhes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgBMRB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:01:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:53950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgBMRB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:01:57 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1301206DB;
        Thu, 13 Feb 2020 17:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581613316;
        bh=U556d2PmtLaNN2i/zseRkAt5LAexOSH4RlsVoDHLoxw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nhODriiCitKMS3HgY+skJsEXIvx7MDxW72+qU4ZeMrxi0op5f/2tl7iA4ilBWP6sa
         wMbYglHKJ7AuIiy9HN/f4jINaazmraLr/I7wjgqyeeBRYxMRITegJJ8ElDFZcxtX7A
         ywJ7/uyynvY8T5YWVQkIX/p0qkZKUWha/TE0st20=
Date:   Fri, 14 Feb 2020 02:01:51 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3] perf test: Fix test trace+probe_vfs_getname.sh
Message-Id: <20200214020151.c93187535a8ccd0fb146a301@kernel.org>
In-Reply-To: <20200213143048.GA22170@kernel.org>
References: <20200213122009.31810-1-tmricht@linux.ibm.com>
        <20200213143048.GA22170@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas and Arnaldo,

On Thu, 13 Feb 2020 11:30:48 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Thu, Feb 13, 2020 at 01:20:09PM +0100, Thomas Richter escreveu:
> > This test places a kprobe to function getname_flags() in the kernel
> > which has the following prototype:
> > 
> >   struct filename *
> >   getname_flags(const char __user *filename, int flags, int *empty)
> > 
> > Variable filename points to a filename located in user space memory.
> > Looking at
> > commit 88903c464321c ("tracing/probe: Add ustring type for user-space string")
> > the kprobe should indicate that user space memory is accessed.
> > 
> > The following patch specifies user space memory access first and if this
> > fails use type 'string' in case 'ustring' is not supported.
> 
> What are you fixing?
> 
> I haven't seen any example of this test failing, and right now testing
> it with:
> 
> [root@quaco ~]# uname -a
> Linux quaco 5.6.0-rc1+ #1 SMP Wed Feb 12 15:42:16 -03 2020 x86_64 x86_64 x86_64 GNU/Linux
> [root@quaco ~]#

This bug doesn't happen on x86 or other archs on which user-address space and
kernel address space is same. On some arch (ppc64 in this case?) user-address
space is partially or completely same as kernel address space. (Yes, they switch
the world when running into the kernel) In this case, we need to use different
data access functions for each spaces. That is why I introduced "ustring" type
for kprobe event.
As far as I can see, Thomas's patch is sane. Thomas, could you show us your
result on your test environment?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
