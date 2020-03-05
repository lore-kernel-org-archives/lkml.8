Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F581C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E559A21D56
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583434435;
	bh=vBbNg6fZxdddRM7UYfGLolWtdb/qaErKZin8V84yJyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TtEuYF+7SCwVLia9aJwU5L2mxKkwZlWaalAAK5i5JEU0gz6oTxLwbZ1Q+m/dWIZsw
	 FS89AzQ4356DbbWQUhzaO+trXNomZTuuFPqZECx2g/6pGmJag2oxmxKLdfCcBzs8vm
	 xaFuwPX/IkpzRcMzMTfU4x1wzj8SyRSVbSEyyxSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgCESxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:53:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:47960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgCESxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:53:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE9EB20716;
        Thu,  5 Mar 2020 18:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583434431;
        bh=vBbNg6fZxdddRM7UYfGLolWtdb/qaErKZin8V84yJyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YZXkramL97DoVXcckOT6XLBbVnCMIzzBx5T2RoqGUoIsmjDsj6E4rxFMR1NjC4+jM
         ww+yIci/U/TudWgN2Mj3Ihnxb77bakGAgMQQyD+SpRcvSEkyT1mmWdGCqt7Ak3kBDY
         xzlalDo68G37QAralnT0Y7LDm+m36TEWTkCU3SPc=
Date:   Thu, 5 Mar 2020 19:53:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        Theodore Ts'o <tytso@mit.edu>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCHv2] printk: queue wake_up_klogd irq_work only if per-CPU
 areas are ready
Message-ID: <20200305185348.GB2141048@kroah.com>
References: <20200303113002.63089-1-sergey.senozhatsky@gmail.com>
 <20200304152159.2p7d7dnztf433i24@pathway.suse.cz>
 <20200305013014.GA174444@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305013014.GA174444@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 10:30:14AM +0900, Sergey Senozhatsky wrote:
> On (20/03/04 16:21), Petr Mladek wrote:
> [..]
> > > Fix printk_deferred() and do not queue per-CPU irq_work
> > > before per-CPU areas are initialized.
> > >
> > > [0] https://lore.kernel.org/lkml/aa0732c6-5c4e-8a8b-a1c1-75ebe3dca05b@camlintechnologies.com/
> > >
> > > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > > Reported-by: Lech Perczak <l.perczak@camlintechnologies.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Theodore Ts'o <tytso@mit.edu>
> > > Cc: John Ogness <john.ogness@linutronix.de>
> >
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Thanks!
> 
> > Now, the question is whether to hurry this fix into 5.6 or if
> > it could wait for 5.7.
> >
> > I think that it could wait because 5.6 is not affected by
> > the particular printk_deferred(). This patch fixes a long-term
> > generic problem. But I am open for other opinions.
> 
> Good question. My 5 cents, I would _probably_ push it now. Not
> because it fixes any known issues on 5.6, but because we have
> a number of LTS kernel (4.19, 4.14, 4.9, 4.4, 3.16) that can be
> affected should 1b710b1b10eff9d4 be backported to those kernels.

It was backported there, and now has been reverted.  So no big rush from
what I can tell.

thanks,

greg k-h
