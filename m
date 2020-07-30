Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A367DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BB4320829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgG3OB3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:01:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgG3OB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:01:29 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A1FA20838;
        Thu, 30 Jul 2020 14:01:28 +0000 (UTC)
Date:   Thu, 30 Jul 2020 10:01:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, chunyan.zhang@unisoc.com,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace : use kvmalloc instead of kmalloc
Message-ID: <20200730100126.410b3fb1@oasis.local.home>
In-Reply-To: <1596107052-25682-1-git-send-email-zhaoyang.huang@unisoc.com>
References: <1596107052-25682-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is also the second version of the patch. Please add a v2 to the
subject, otherwise it gets confusing to know which one to pull in.

 "[PATCH v2] ..."

-- Steve


On Thu, 30 Jul 2020 19:04:12 +0800
Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:

> High order memory stuff within trace could introduce OOM, use kvmalloc instead.
> 
> Please find the bellowing for the call stack we run across in an android system. The scenario happens when traced_probes is woken up to get a large quantity of trace even if free memory is even higher than watermark_low. 
> 
