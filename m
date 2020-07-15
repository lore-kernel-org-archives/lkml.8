Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45223C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B512065F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgGOUpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 16:45:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbgGOUpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:45:06 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF36C2065F;
        Wed, 15 Jul 2020 20:45:05 +0000 (UTC)
Date:   Wed, 15 Jul 2020 16:45:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alistair Delva <adelva@google.com>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] bootconfig: Add value override operator
Message-ID: <20200715164504.3400efc5@oasis.local.home>
In-Reply-To: <159482882056.126704.15508672095852220119.stgit@devnote2>
References: <159482882056.126704.15508672095852220119.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020 01:00:21 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> With this change, if the bootloader wants to change some value
> in the default bootconfig, it doesn't need to parse the existing
> bootconfig, but it can just append the new configs at the tail
> of the bootconfig and update the footer (size, checksum and magic
> word).

I wonder if we should support multiple bootconfigs instead of updating
the size/checksum/magic?

So the end of the initrd would have:

 [data][size/checksum/magic][more-data][size/checksum/magic]


And the kernel could do the following:

 1. read the end of the initrd for bootconfig
 2. If found parse the bootconfig data.
 3. look at the content before the bootconfig
 4. if another bootconfig exists, goto 2.

-- Steve
