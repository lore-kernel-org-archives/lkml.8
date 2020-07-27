Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F020FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA6B520786
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595882654;
	bh=t9ljCa86mAmXcEfUhWxtO7BrRHTALZYL65NXwXBbzps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sg+c1xt8A/owMbxZcUCCwYKPpU2P2TdHY5lwc7axXzIHf2N0afmENyfHuMQSTd/f+
	 srDj8IV4RD1XRz0ej8grn5lCD0ihq+wTpZOxL7V/OXNhEd9JJTcxT1NH1LZV/cuK8d
	 TnZGsNuDJ/9ocHo58cCDB6s6n0VPUvVX41e0Q1QA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgG0UoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:44:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbgG0UoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 16:44:13 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B3AC20759;
        Mon, 27 Jul 2020 20:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595882652;
        bh=t9ljCa86mAmXcEfUhWxtO7BrRHTALZYL65NXwXBbzps=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lva86vM0yR+ykzetM6P2yNWHIEIBUmbLKR+cYnkTCBElg/iIhC9AZDEfvpB5QRPEY
         Bs1WSopwxfn+NQvSt2u6dFkQwfLAHXx5wnXde4hNxXGa+oX6AniyLoSNM+kN9mGzo9
         TOyc/yiOesNznDiHJk2rD8Y8dVWI+x3e5zGpl9vE=
Date:   Mon, 27 Jul 2020 13:44:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        SeongJae Park <sj38.park@gmail.com>,
        Joe Perches <joe@perches.com>, <linux-kernel@vger.kernel.org>,
        <apw@canonical.com>, <colin.king@canonical.com>, <jslaby@suse.cz>,
        <pavel@ucw.cz>, SeongJae Park <sjpark@amazon.de>
Subject: Re: checkpatch: support deprecated terms checking
Message-Id: <20200727134411.73461df2fe73f8f96d93f75e@linux-foundation.org>
In-Reply-To: <20200727065441.27164-1-sjpark@amazon.com>
References: <20200726203328.GA8321@qmqm.qmqm.pl>
        <20200727065441.27164-1-sjpark@amazon.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020 08:54:41 +0200 SeongJae Park <sjpark@amazon.com> wrote:

> > > > Unfortunately, the inexperienced _do_ in fact run
> > > > checkpatch on files and submit inappropriate patches.

I don't think I really agree with the "new code only" guideline (where
did this come from, anyway?).  10 years from now any remaining pre-2020
terms will look exceedingly archaic and will get converted at some
point.

Wouldn't be longterm realistic to just bite the bullet now and add these
conversions to the various todo lists?
