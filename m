Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA35C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59DFF207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgFZNgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:36:37 -0400
Received: from verein.lst.de ([213.95.11.211]:51809 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgFZNgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:36:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0111168B02; Fri, 26 Jun 2020 15:36:33 +0200 (CEST)
Date:   Fri, 26 Jun 2020 15:36:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] proc: add a read_iter method to proc proc_ops
Message-ID: <20200626133633.GA12646@lst.de>
References: <20200626075836.1998185-1-hch@lst.de> <20200626075836.1998185-3-hch@lst.de> <20200626120624.GL4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626120624.GL4332@42.do-not-panic.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 12:06:24PM +0000, Luis Chamberlain wrote:
> On Fri, Jun 26, 2020 at 09:58:29AM +0200, Christoph Hellwig wrote:
> > diff --git a/fs/proc/inode.c b/fs/proc/inode.c
> > index 28d6105e908e4c..fa86619cebc2be 100644
> > --- a/fs/proc/inode.c
> > +++ b/fs/proc/inode.c
> > @@ -297,6 +297,29 @@ static loff_t proc_reg_llseek(struct file *file, loff_t offset, int whence)
> >  	return rv;
> >  }
> >  
> > +static ssize_t pde_read_iter(struct proc_dir_entry *pde, struct kiocb *iocb,
> > +		struct iov_iter *iter)
> > +{
> > +	if (!pde->proc_ops->proc_read_iter)
> > +		return -EINVAL;
> 
> When is this true?

Whenever a user sets up the method..
