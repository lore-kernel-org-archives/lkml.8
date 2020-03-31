Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A13C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 12:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28D1208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 12:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585658261;
	bh=IaryMowmAx4OQ//gy52Bp04tanIU0UkHswH1YoJsT8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BOyqe5N3pZT/QJHwmibfyWJiJEiVWQqIHyduDgwid7zZgoeDJ6JR3cPvAO3W9VWW/
	 s469ulACtdGxzkTDYlB2auajihfnl+jjSniDFzDt+7cJt5gKsJp63y0SN9GGfhDsDs
	 EEu3uq97rQI6QpUM7za8t4t/0QIv1yXBYEs4/zq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbgCaMhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 08:37:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730436AbgCaMhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 08:37:39 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6359A2072E;
        Tue, 31 Mar 2020 12:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585658259;
        bh=IaryMowmAx4OQ//gy52Bp04tanIU0UkHswH1YoJsT8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SaKeVZBvfVFoEHqJLbz1ikyoWwc6oN2EtK2dgUPhBs6A7eMaJkcCkeBD7yR+BoTB+
         fN9koCz2ZA7p2MxmDkCWzVoCO/sBcqKe+CKQ6JmvllaeOK/niJZL+dwRlPk/dWe6cW
         7bUzAdVBKCwc7tuOdTp0doCxc05rTxTRMi7cl4qE=
Date:   Tue, 31 Mar 2020 13:37:34 +0100
From:   Will Deacon <will@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 09/21] list: Remove unnecessary WRITE_ONCE() from
 hlist_bl_add_before()
Message-ID: <20200331123733.GB30061@willie-the-truck>
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-10-will@kernel.org>
 <20200330233020.GF19865@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330233020.GF19865@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 04:30:20PM -0700, Paul E. McKenney wrote:
> On Tue, Mar 24, 2020 at 03:36:31PM +0000, Will Deacon wrote:
> > There is no need to use WRITE_ONCE() when inserting into a non-RCU
> > protected list.
> > 
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Will Deacon <will@kernel.org>
> 
> OK, I will bite...  Why "unsigned long" instead of "uintptr_t"?

I just did that for consistency with the rest of the file, e.g.
hlist_bl_first(), hlist_bl_set_first(), hlist_bl_empty() and
__hlist_bl_del() all cast to 'unsigned long', yet only
hlist_bl_add_before() was using 'uintptr_t'

> Not that it matters in the context of the Linux kernel, so:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Thanks, Paul!

Will
