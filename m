Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B7DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B775208A7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590693060;
	bh=McL+fVFL7VEwzes5MBT2HIhkPQz4yeJG/DEEGLug2z0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DgihuXLBDfeXHHdGXxgZ5O4QTaQtuWgII6AcXgauKXJvl1bS44FAXyVukp2M43trn
	 envi85wxX4UCyY7vhrBcajqWtyIugoIW3TOsOesWcOx5Dip1s0q5EfI3cRizvMnRUG
	 cf8uYK26rWu7YRI6ZXniebX4AFfnG/ihVRvXqLSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406172AbgE1TK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:10:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406096AbgE1TK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:10:58 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E9122075A;
        Thu, 28 May 2020 19:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590693057;
        bh=McL+fVFL7VEwzes5MBT2HIhkPQz4yeJG/DEEGLug2z0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hDypazUDM3h5eepOjW5JZ/+I4UObiA44nyq+DaXGct/jyfhNeJpNT+l5yOQERP/46
         mYHyrxau90uzB+7IPVW15Cp0ihC5nwvVDjuT7d2EEYdumOdTDvWf5t1KmA7EyUyghb
         y6SHBK1qeZcpcC1YbdAP+KiEqUBp0khzjby11rOw=
Date:   Thu, 28 May 2020 12:10:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] twist: allow converting pr_devel()/pr_debug() into
 snprintf()
Message-Id: <20200528121057.d47c47c67d5f7419f7557b84@linux-foundation.org>
In-Reply-To: <e0d6c04f-7601-51e7-c969-300e938dedc0@i-love.sakura.ne.jp>
References: <e3b30905-4497-29b4-4636-a313283dbc56@i-love.sakura.ne.jp>
        <20200528065603.3596-1-penguin-kernel@I-love.SAKURA.ne.jp>
        <20200528110646.GC11286@linux-b0ei>
        <e0d6c04f-7601-51e7-c969-300e938dedc0@i-love.sakura.ne.jp>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020 00:16:22 +0900 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:

> On 2020/05/28 20:06, Petr Mladek wrote:
> > Now, it requires lib/Kconfig.twist that is added by a patch in
> > Andrew's tree. One approach is to push this into linux-next
> > via Andrew's -mm tree.
> > 
> > Another possibility would be to remove lib/Kconfig.twist
> > changes from this patch and replace
> > CONFIG_TWIST_ALWAYS_EVALUATE_PRINTK_ARGUMENTS with
> > CONFIG_TWIST_FOR_SYZKALLER_TESTING.
> > Then I could push it into linux-next via printk/linux.git tree.
> 
> CONFIG_TWIST_FOR_SYZKALLER_TESTING is meant for linux-next only.
> But CONFIG_TWIST_KERNEL_BEHAVIOR is meant for Linus's tree.
> 
> That is, lib/Kconfig.twist will be there in printk/linux.git tree
> after 5.8-rc1. But maybe twist related patches should be gathered
> into one tree for easier management.

Yup.  I'll drop the twist patches from -mm.
