Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0DFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 596AD20829
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595920372;
	bh=HI8UhodQzU7U6XJLSAJ0DbuwsVXH6Kffdr14dc0qJ+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AozVyF/Qq65Ga163be9vgBHSibs1lF+WkMRkKUD1Cn4qPXkBvYN0yZSCRzh/mBtce
	 hNpg8oG6m4uGVVRdG9TRbKv6Ui8Wu5sl2dUOpQ6GQ+6FzHDz8XduhR4CW2LKxjdeD2
	 akHb0CUdv7TjBX9EnW3CcFS1BYY1dRooVjwq1L9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgG1HMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:12:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbgG1HMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 03:12:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEE72207E8;
        Tue, 28 Jul 2020 07:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595920370;
        bh=HI8UhodQzU7U6XJLSAJ0DbuwsVXH6Kffdr14dc0qJ+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a8yLXH5dgEAQiOhnhcln9br5ZqZ9OCgj9Vxp78cf3A5MKyCvvmLbWt2xJpqdjD9uE
         2+sBx0qjmLRLy0gF6aN+THTXPjUSroYC+sGts4/XAiWA0Pd5+YqHxrmONmWcY7G/p9
         8z8b2GCe5kqMIkr3GQewS78zQ6oncLjG6YV0ywKI=
Date:   Tue, 28 Jul 2020 09:12:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty/synclink: remove leftover bits of non-PCI card
 support
Message-ID: <20200728071244.GB348828@kroah.com>
References: <20200727130501.31005-1-hch@lst.de>
 <8a015ca4-e837-8fa5-684c-46fca8104ea5@kernel.org>
 <20200728062045.GA20992@lst.de>
 <e64a0045-02b5-777f-a60b-daa08dec04de@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e64a0045-02b5-777f-a60b-daa08dec04de@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 08:40:25AM +0200, Jiri Slaby wrote:
> On 28. 07. 20, 8:20, Christoph Hellwig wrote:
> > On Tue, Jul 28, 2020 at 08:05:36AM +0200, Jiri Slaby wrote:
> >> On 27. 07. 20, 15:05, Christoph Hellwig wrote:
> >>> Since commit 1355cba9c3ba ("tty/synclink: remove ISA support"), the
> >>> synlink driver only supports PCI card.  Remove any leftover dead code
> >>> to support other cards.
> >>
> >> So now you can remove also the defines and bus_type completely:
> >> $ git grep -E 'MGSL_BUS_TYPE_(E?ISA|PCI)'
> >> drivers/tty/synclink_gt.c:              info->bus_type = MGSL_BUS_TYPE_PCI;
> >> drivers/tty/synclinkmp.c:               info->bus_type = MGSL_BUS_TYPE_PCI;
> >> include/uapi/linux/synclink.h:#define MGSL_BUS_TYPE_ISA 1
> >> include/uapi/linux/synclink.h:#define MGSL_BUS_TYPE_EISA        2
> >> include/uapi/linux/synclink.h:#define MGSL_BUS_TYPE_PCI 5
> > 
> > This is in a uapi header, so I didn't dare to touch it.
> 
> Ah, sure. Then OK.
> 
> Just wondering, who would place this into a uapi header?

People didn't realize they were uapi headers a long time ago, when
everything was in the same directory/files :(

thanks,

greg k-h
