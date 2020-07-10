Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B5AC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D012077D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgGJNII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:08:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbgGJNIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:08:07 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18E7D20748;
        Fri, 10 Jul 2020 13:08:07 +0000 (UTC)
Date:   Fri, 10 Jul 2020 09:08:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] tracing: toplevel d_entry already initialized
Message-ID: <20200710090805.2ee0b97f@oasis.local.home>
In-Reply-To: <20200710011119.GB51939@L-31X9LVDL-1304.local>
References: <20200703020612.12930-1-richard.weiyang@linux.alibaba.com>
        <20200703020612.12930-5-richard.weiyang@linux.alibaba.com>
        <20200709181359.42b4e61e@oasis.local.home>
        <20200710011119.GB51939@L-31X9LVDL-1304.local>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 09:11:19 +0800
Wei Yang <richard.weiyang@linux.alibaba.com> wrote:

> Yep, if you think there is no need.
> 
> Do you want me to send v2 based on you comments?

I already applied patch 2 and 3. Please send a v2 with the 4-5 folded,
and you can also include a patch to remove the dentry of
tracing_init_dentry() return.

-- Steve
