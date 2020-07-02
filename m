Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82F3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AE4F2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgGBFPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 01:15:18 -0400
Received: from verein.lst.de ([213.95.11.211]:42629 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgGBFPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 01:15:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 63EDC68B02; Thu,  2 Jul 2020 07:15:13 +0200 (CEST)
Date:   Thu, 2 Jul 2020 07:15:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 19/23] sysctl: Call sysctl_head_finish on error
Message-ID: <20200702051512.GA30361@lst.de>
References: <20200701200951.3603160-1-hch@lst.de> <20200701200951.3603160-20-hch@lst.de> <20200702003240.GW25523@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702003240.GW25523@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 01:32:40AM +0100, Matthew Wilcox wrote:
> On Wed, Jul 01, 2020 at 10:09:47PM +0200, Christoph Hellwig wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > This error path returned directly instead of calling sysctl_head_finish().
> > 
> > Fixes: ef9d965bc8b6 ("sysctl: reject gigantic reads/write to sysctl files")
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> I think this one needs to go to Linus before 5.8, not get stuck in the
> middle of a large patch series.

I've only kept it here because it didn't show up in Linus tree yet.
If you send it and it gets picked up I can trivially drop it.
