Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4F6C54E4A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2047206D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbgEHNA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:00:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgEHNA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:00:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9ECA2054F;
        Fri,  8 May 2020 13:00:54 +0000 (UTC)
Date:   Fri, 8 May 2020 09:00:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Shiyuan Hu" <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [v3] tools/bootconfig: fix resource leak in apply_xbc()
Message-ID: <20200508090053.430d28d7@gandalf.local.home>
In-Reply-To: <938cd0e9-d96b-766c-cfbc-4f0b73d97cd4@huawei.com>
References: <3569aa33-8963-966d-9247-ec79b3b3d56d@huawei.com>
        <5e2c3348-f346-e3f2-9c7c-5c4135f9b38c@web.de>
        <559edb00-a03b-747e-8ba7-1f16285deefb@huawei.com>
        <65057e82-8002-4ec4-b714-25ac8d05cb68@web.de>
        <938cd0e9-d96b-766c-cfbc-4f0b73d97cd4@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 May 2020 19:42:56 +0800
Yunfeng Ye <yeyunfeng@huawei.com> wrote:

> On 2020/5/8 19:30, Markus Elfring wrote:
> >> this change can fix the warning of tools.  
> > 
> > Would you like to point any specific source code analysis tools out
> > for this issue?
> > (Can a corresponding attribution become relevant for a clearer
> > change description?)
> >   
> The tools we used is not for open source. it point out some error description like
> "Memory leak: data" and "Resource leak: fd" in tools/bootconfig/main.c.
> 
> Can I only description:
>   "Memory and resource leak is found by a static code analysis tools" ? thanks.

Markus please stop! Your suggestions are just your preferences that are not
required for the kernel.

Yunfeng, your v2 was fine and has already landed in Linus's tree. Feel free
to ignore Markus's suggestions in the future.

See commit 8842604446d1f005abcbf8c63c12eabdb5695094

-- Steve
