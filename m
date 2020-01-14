Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10F2C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 03:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF5321556
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 03:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbgANDeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 22:34:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728802AbgANDeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 22:34:09 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07FEB20CC7;
        Tue, 14 Jan 2020 03:34:07 +0000 (UTC)
Date:   Mon, 13 Jan 2020 22:34:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "chengjian (D)" <cj.chengjian@huawei.com>
Cc:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <bobo.shaobowang@huawei.com>, <mingo@redhat.com>,
        <tglx@linutronix.de>
Subject: Re: [PATCH] x86/ftrace: usr ftrace_write to simplify code
Message-ID: <20200113223406.5a8aeb29@rorschach.local.home>
In-Reply-To: <8ab66ffb-614b-063d-7362-2f01906aec51@huawei.com>
References: <20200113073347.22748-1-cj.chengjian@huawei.com>
        <8ab66ffb-614b-063d-7362-2f01906aec51@huawei.com>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 09:37:41 +0800
"chengjian (D)" <cj.chengjian@huawei.com> wrote:

> I am sorry.
> 
> usr => use in subject.
> 
> I will resend this patch.
> 

I already pulled the original patch into my queue, but I did fix the
typo (and also capitalized the first word to "Use").

It's currently running through my tests.

-- Steve
