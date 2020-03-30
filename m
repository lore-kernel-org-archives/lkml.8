Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A969FC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889B42072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgC3Ozy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:55:54 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:44309 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgC3Ozy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:55:54 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 225DD20000C;
        Mon, 30 Mar 2020 14:55:48 +0000 (UTC)
Date:   Mon, 30 Mar 2020 16:55:47 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <gregkh@linuxfoundation.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wangle6@huawei.com>, <zhangweimin12@huawei.com>,
        <yebin10@huawei.com>, <houtao1@huawei.com>, <stable@kernel.org>
Subject: Re: [PATCH v3] mtd:fix cache_state to avoid writing to bad blocks
 repeatedly
Message-ID: <20200330165547.4e2acb9a@xps13>
In-Reply-To: <5bf71fe1-2dd1-f45a-5858-433f340b167e@huawei.com>
References: <1585575925-84017-1-git-send-email-nixiaoming@huawei.com>
        <20200330155222.20359293@xps13>
        <5bf71fe1-2dd1-f45a-5858-433f340b167e@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaoming,

Xiaoming Ni <nixiaoming@huawei.com> wrote on Mon, 30 Mar 2020 22:25:36
+0800:

> On 2020/3/30 21:52, Miquel Raynal wrote:
> > Hi Xiaoming,
> > 
> > Xiaoming Ni <nixiaoming@huawei.com> wrote on Mon, 30 Mar 2020 21:45:25
> > +0800:
> >   
> >> The function call process is as follows:
> >> 	mtd_blktrans_work()
> >> 	  while (1)
> >> 	    do_blktrans_request()
> >> 	      mtdblock_writesect()
> >> 	        do_cached_write()
> >> 	          write_cached_data() /*if cache_state is STATE_DIRTY*/
> >> 	            erase_write()
> >>
> >> write_cached_data() returns failure without modifying cache_state
> >> and cache_offset. So when do_cached_write() is called again,
> >> write_cached_data() will be called again to perform erase_write()
> >> on the same cache_offset.
> >>
> >> But if this cache_offset points to a bad block, erase_write() will
> >> always return -EIO. Writing to this mtdblk is equivalent to losing
> >> the current data, and repeatedly writing to the bad block.
> >>
> >> Repeatedly writing a bad block has no real benefits,
> >> but brings some negative effects:
> >> 1 Lost subsequent data
> >> 2 Loss of flash device life
> >> 3 erase_write() bad blocks are very time-consuming. For example:
> >> 	the function do_erase_oneblock() in chips/cfi_cmdset_0020.c or
> >> 	chips/cfi_cmdset_0002.c may take more than 20 seconds to return
> >>
> >> Therefore, when erase_write() returns -EIO in write_cached_data(),
> >> clear cache_state to avoid writing to bad blocks repeatedly.
> >>
> >> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> >> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >> Cc: stable@vger.kernel.org  
> > 
> > Still missing:
> > * Fixes: tag
> > * Wrong title prefix
> >   
> 
> Fixes: 	1da177e4c3f41524e88 "Linux-2.6.12-rc2"
> 
> Is it described like this?

The way to describe a commit is:

Fixes: 1da177e4c3f4 ("Linux-...")

But it is too old to be pointed, just drop both Fixes/Cc tags and just
fix the title please.

> 
> Do I need to go to
> https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git
> to trace back the older commit records?
> 
> Thanks
> Xiaoming Ni
> 
> 
> 
> 

Thanks,
Miquèl
