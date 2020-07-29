Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A44EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D72482075D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgG2U73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgG2U73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:59:29 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26215C061794;
        Wed, 29 Jul 2020 13:59:29 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0tAV-005Crq-G9; Wed, 29 Jul 2020 20:59:19 +0000
Date:   Wed, 29 Jul 2020 21:59:19 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 15/23] seq_file: switch over direct seq_read method calls
 to seq_read_iter
Message-ID: <20200729205919.GB1236929@ZenIV.linux.org.uk>
References: <20200707174801.4162712-1-hch@lst.de>
 <20200707174801.4162712-16-hch@lst.de>
 <87eep9rgqu.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eep9rgqu.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 11:09:13PM +0200, Thomas Gleixner wrote:
> 
> Needs some thought and maybe some cocci help from Julia, but that's way
> better than this brute force sed thing which results in malformed crap
> like this:
> 
> static const struct file_operations debug_stats_fops = {
> 	.open		= debug_stats_open,
> 	.read_iter		= seq_read_iter,
> 	.llseek		= seq_lseek,
> 	.release	= single_release,
> };
> 
> and proliferates the copy and paste voodoo programming.

Better copy and paste than templates, IMO; at least the former is
greppable; fucking DEFINE_..._ATRIBUTE is *NOT*, especially due
to the use of ##.
