Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B778C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4576D20836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgBXQ4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:56:15 -0500
Received: from smtprelay0042.hostedemail.com ([216.40.44.42]:44148 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727644AbgBXQ4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:56:14 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 620EC18224D7C;
        Mon, 24 Feb 2020 16:56:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ray51_362d824f82409
X-Filterd-Recvd-Size: 2679
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Feb 2020 16:56:12 +0000 (UTC)
Message-ID: <9f0d39d5972553b86123873294fc9f9566130036.camel@perches.com>
Subject: Re: [PATCH v4] staging: qlge: emit debug and dump at same level
From:   Joe Perches <joe@perches.com>
To:     Kaaira Gupta <kgupta@es.iitr.ac.in>,
        Manish Chopra <manishc@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Feb 2020 08:54:43 -0800
In-Reply-To: <20200224164721.GA7214@kaaira-HP-Pavilion-Notebook>
References: <20200224082448.GA6826@kaaira-HP-Pavilion-Notebook>
         <84410699e6acbffca960aa2944e9f5869478b178.camel@perches.com>
         <20200224164721.GA7214@kaaira-HP-Pavilion-Notebook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-24 at 22:17 +0530, Kaaira Gupta wrote:
> On Mon, Feb 24, 2020 at 05:38:09AM -0800, Joe Perches wrote:
> > On Mon, 2020-02-24 at 13:54 +0530, Kaaira Gupta wrote:
> > > Simplify code in ql_mpi_core_to_log() by calling print_hex_dump()
> > > instead of existing functions so that the debug and dump are
> > > emitted at the same KERN_<LEVEL>
> > []
> > > diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
> > []
> > > @@ -1324,27 +1324,10 @@ void ql_mpi_core_to_log(struct work_struct *work)
> > >  {
> > >  	struct ql_adapter *qdev =
> > >  		container_of(work, struct ql_adapter, mpi_core_to_log.work);
> > > -	u32 *tmp, count;
> > > -	int i;
> > >  
> > > -	count = sizeof(struct ql_mpi_coredump) / sizeof(u32);
> > > -	tmp = (u32 *)qdev->mpi_coredump;
> > > -	netif_printk(qdev, drv, KERN_DEBUG, qdev->ndev,
> > > -		     "Core is dumping to log file!\n");
> > 
> > There is no real need to delete this line.
> > 
> > And if you really want to, it'd be better to mention
> > the removal in the commit message description.
> > 
> > As is for this change, there is no "debug" and "dump"
> > as the commit message description shows, just "dump".
> 
> This patch has already been added to the tree,

What tree is that?
It's not in -next as of right now.

>  if I amend the commit now
> using git rebase, won't it affect the upstream as the SHA-1 of the
> commit and it's children will change?

You are sending patches not pull requests.

If it's really in an actual tree that people
care about, send another patch putting the
netif_printk back.


