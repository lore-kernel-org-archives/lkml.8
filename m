Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C956C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 828982086A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgHFTrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:47:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgHFTrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:47:23 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 355F52086A;
        Thu,  6 Aug 2020 19:47:23 +0000 (UTC)
Date:   Thu, 6 Aug 2020 15:47:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sean Paul <sean@poorly.run>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tracing: Add trace_array_init_printk() to initialize
 instance trace_printk() buffers
Message-ID: <20200806154721.4b8712bc@oasis.local.home>
In-Reply-To: <CAMavQK+j8Gxj5n8XnzjprM5b4gL0Kopd5Nu0MNnJPt5_5KifWA@mail.gmail.com>
References: <20200806144618.4384a0f9@oasis.local.home>
        <CAMavQK+j8Gxj5n8XnzjprM5b4gL0Kopd5Nu0MNnJPt5_5KifWA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020 15:22:23 -0400
Sean Paul <sean@poorly.run> wrote:

> > Changes since v1:
> >   Added EXPORT_SYMBOL_GPL() to trace_array_init_printk() as it is
> >   required for another function that is exported.  
> 
> Could we also add this to trace.h?

That might be helpful, wouldn't it.

kernel test robot just suggested the same thing ;-)

-- Steve
