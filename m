Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAA1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EC4B20759
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgG1GUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:20:49 -0400
Received: from verein.lst.de ([213.95.11.211]:46784 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbgG1GUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:20:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0A1BD68B05; Tue, 28 Jul 2020 08:20:45 +0200 (CEST)
Date:   Tue, 28 Jul 2020 08:20:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty/synclink: remove leftover bits of non-PCI card
 support
Message-ID: <20200728062045.GA20992@lst.de>
References: <20200727130501.31005-1-hch@lst.de> <8a015ca4-e837-8fa5-684c-46fca8104ea5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a015ca4-e837-8fa5-684c-46fca8104ea5@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 08:05:36AM +0200, Jiri Slaby wrote:
> On 27. 07. 20, 15:05, Christoph Hellwig wrote:
> > Since commit 1355cba9c3ba ("tty/synclink: remove ISA support"), the
> > synlink driver only supports PCI card.  Remove any leftover dead code
> > to support other cards.
> 
> So now you can remove also the defines and bus_type completely:
> $ git grep -E 'MGSL_BUS_TYPE_(E?ISA|PCI)'
> drivers/tty/synclink_gt.c:              info->bus_type = MGSL_BUS_TYPE_PCI;
> drivers/tty/synclinkmp.c:               info->bus_type = MGSL_BUS_TYPE_PCI;
> include/uapi/linux/synclink.h:#define MGSL_BUS_TYPE_ISA 1
> include/uapi/linux/synclink.h:#define MGSL_BUS_TYPE_EISA        2
> include/uapi/linux/synclink.h:#define MGSL_BUS_TYPE_PCI 5

This is in a uapi header, so I didn't dare to touch it.

> 
> $ git grep -w bus_type drivers/tty/synclink*
> drivers/tty/synclink_gt.c:      unsigned int bus_type;
> drivers/tty/synclink_gt.c:              info->bus_type = MGSL_BUS_TYPE_PCI;
> drivers/tty/synclinkmp.c:       unsigned int bus_type;
> /* expansion bus type (ISA,EISA,PCI) */
> drivers/tty/synclinkmp.c:               info->bus_type = MGSL_BUS_TYPE_PCI;

Despite the similar names these are actually two drivers entirely
separate form the main synclink one.
