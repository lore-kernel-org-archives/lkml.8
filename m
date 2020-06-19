Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9C6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7ACF2080C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbgFSK2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 06:28:52 -0400
Received: from a3.inai.de ([88.198.85.195]:37880 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732386AbgFSK2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 06:28:25 -0400
Received: by a3.inai.de (Postfix, from userid 25121)
        id 66EA058743C1C; Fri, 19 Jun 2020 12:28:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 63D8460D220A6;
        Fri, 19 Jun 2020 12:28:08 +0200 (CEST)
Date:   Fri, 19 Jun 2020 12:28:08 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Christoph Hellwig <hch@infradead.org>
cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arch@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] linux++, this: rename "struct notifier_block *this"
In-Reply-To: <20200619074631.GA1427@infradead.org>
Message-ID: <nycvar.YFH.7.77.849.2006191217280.9730@n3.vanv.qr>
References: <20200618210645.GB2212102@localhost.localdomain> <20200619074631.GA1427@infradead.org>
User-Agent: Alpine 2.22 (LSU 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 2020-06-19 09:46, Christoph Hellwig wrote:

>On Fri, Jun 19, 2020 at 12:06:45AM +0300, Alexey Dobriyan wrote:
>> Rename
>> 	struct notifier_block *this
>> to
>> 	struct notifier_block *nb
>> 
>> "nb" is arguably a better name for notifier block.
>
>But not enough better to cause tons of pointless churn.  Feel free
>to use better naming in new code you write or do significant changes
>to, but stop these pointless renames.

Well, judging from the mention of "linux++" in the subject, I figure 
this is the old discussion of someone trying to make Linux code, or 
parts thereof, work in a C++ environment. Since the patch does not just 
touch headers but .c files, I deduce that there seems to be a project 
trying to build Linux, or a subset thereof, as a C++ program for the fun 
of it. UML could come to mind.

Is it a hot potato? Definitely. But so was IPv6 NAT, and now we have it 
anyway.
