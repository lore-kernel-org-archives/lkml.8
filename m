Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F84C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E3502078E
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599156120;
	bh=g/zK/ClT1m5soG/tnXSY+wGtMX3SLoeeyKDXpcFFi+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nwol6Ym07Qz6xI1D0jPipmJ6gawlHARBXBb8ZthwBD1S1+XkSaXWKM5WlTWSDafNL
	 mqCUAgbFldUFxHjUSgua1reWDgYsMdNA5zKFGCnPop7vzapH2wnDOLzG2rK6/BGip4
	 uJb4tUUavOQ0fzhtL7k4BpIkF1P24cauzKEc9i0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgICSB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:01:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbgICSB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:01:56 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE81520716;
        Thu,  3 Sep 2020 18:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599156115;
        bh=g/zK/ClT1m5soG/tnXSY+wGtMX3SLoeeyKDXpcFFi+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ELauOPuUtZVMDFEfwjDgxAIBXYDHvYmSzCpUf2Grzewy1io84bdEPRClmezPdJ+Tc
         8VayzXho4//0jrpJPwObQ/+LiUOL+aJux/rm7O/0TD93UAHCwrs3UM6Co7DGWhEmoN
         DPk1GRp2dVdFN8RC2KJ4Tgf4nV7LC/C5/2hmZnJk=
Date:   Thu, 3 Sep 2020 20:02:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Christoph Hellwig <hch@lst.de>, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /dev/zero: also implement ->read
Message-ID: <20200903180217.GA2038804@kroah.com>
References: <20200903155922.1111551-1-hch@lst.de>
 <1bc34841-f1a3-8a9b-cb48-10930ec55d71@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1bc34841-f1a3-8a9b-cb48-10930ec55d71@csgroup.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 07:51:07PM +0200, Christophe Leroy wrote:
> 
> 
> Le 03/09/2020 à 17:59, Christoph Hellwig a écrit :
> > Christophe reported a major speedup due to avoiding the iov_iter
> > overhead, so just add this trivial function.  Note that /dev/zero
> > already implements both an iter and non-iter writes so this just
> > makes it more symmetric.
> > 
> > Christophe Leroy <christophe.leroy@csgroup.eu>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >   drivers/char/mem.c | 22 ++++++++++++++++++++++
> >   1 file changed, 22 insertions(+)
> > 
> > diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> > index abd4ffdc8cdebc..1dc99ab158457a 100644
> > --- a/drivers/char/mem.c
> > +++ b/drivers/char/mem.c
> > @@ -726,6 +726,27 @@ static ssize_t read_iter_zero(struct kiocb *iocb, struct iov_iter *iter)
> >   	return written;
> >   }
> > +static ssize_t read_zero(struct file *file, char __user *buf,
> > +			 size_t count, loff_t *ppos)
> > +{
> > +	size_t cleared = 0;
> > +
> > +	while (count) {
> > +		size_t chunk = min_t(size_t, count, PAGE_SIZE);
> > +
> > +		if (clear_user(buf + cleared, chunk))
> > +			return cleared ? cleared : -EFAULT;
> > +		cleared += chunk;
> > +		count -= chunk;
> > +
> > +		if (signal_pending(current))
> > +			return cleared ? cleared : -ERESTARTSYS;
> > +		cond_resched();
> > +	}
> > +
> > +	return cleared;
> > +}
> > +
> >   static int mmap_zero(struct file *file, struct vm_area_struct *vma)
> >   {
> >   #ifndef CONFIG_MMU
> > @@ -921,6 +942,7 @@ static const struct file_operations zero_fops = {
> >   	.llseek		= zero_lseek,
> >   	.write		= write_zero,
> >   	.read_iter	= read_iter_zero,
> > +	.read		= read_zero,
> 
> Wondering if .read should be before .write, so that we get in order read,
> write, read_iter, write_iter.

It really does not matter :)

thanks,

greg k-h
