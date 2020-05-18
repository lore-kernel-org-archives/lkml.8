Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B253C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 21:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDF292075F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 21:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgERVZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 17:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:44786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbgERVZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 17:25:32 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BDA1205CB;
        Mon, 18 May 2020 21:25:31 +0000 (UTC)
Date:   Mon, 18 May 2020 17:25:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] function_graph: apply tracing option 'irq-info'
Message-ID: <20200518172529.35ec248e@gandalf.local.home>
In-Reply-To: <20200516160953.155630-1-changbin.du@gmail.com>
References: <20200516160953.155630-1-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 May 2020 00:09:53 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> The tracing option 'irq-info' is only used by function tracer by far. This
> patch makes it also against function graph tracer. Then the two tracers
> have consistent behavior of this option.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---

Sorry, the function graph tracer is unique, and yes, you need to enable
latency_format.

Note, irq_info is meaning less with the function_graph tracer, as it
doesn't change the latency_format with or without it.

This patch basically just makes the latency_format default for the
function_graph tracer, and changes default settings for no real advantage.
It will cause regressions.

-- Steve
