Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A30C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA6F2071B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgGPACP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 20:02:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgGPACO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 20:02:14 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23F9620714;
        Thu, 16 Jul 2020 00:02:14 +0000 (UTC)
Date:   Wed, 15 Jul 2020 20:02:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alistair Delva <adelva@google.com>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] bootconfig: Add value override operator
Message-ID: <20200715200212.0db61d5a@oasis.local.home>
In-Reply-To: <20200716073843.e7b1921aae962da9e5714fe0@kernel.org>
References: <159482882056.126704.15508672095852220119.stgit@devnote2>
        <20200715164504.3400efc5@oasis.local.home>
        <20200716073843.e7b1921aae962da9e5714fe0@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020 07:38:43 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:


> > So the end of the initrd would have:
> > 
> >  [data][size/checksum/magic][more-data][size/checksum/magic]
> > 
> > 
> > And the kernel could do the following:
> > 
> >  1. read the end of the initrd for bootconfig
> >  2. If found parse the bootconfig data.
> >  3. look at the content before the bootconfig
> >  4. if another bootconfig exists, goto 2.
> >   
> 
> Yeah, that is possible. But since the total size of the bootconfig
> is limited to 32KB (this means data + 1st footer + more-data),
> I would like to give a chance of sanity check to the bootloader.


That's a limit of the size field, right?

The bootloader (and all tools including the kernel) could check for
multiple instances, and that would even increase the size of what can
be added. As each section would be 32KB max size, but there's no limit
to how many you have. All tools, bootconfig, the bootloader, and the
kernel can perform the checksum.

-- Steve

