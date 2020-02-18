Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476D1C34035
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 10:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2963920722
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 10:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgBRKey convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 05:34:54 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:45937 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgBRKey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 05:34:54 -0500
X-Originating-IP: 90.76.211.102
Received: from xps13 (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 2377840009;
        Tue, 18 Feb 2020 10:34:49 +0000 (UTC)
Date:   Tue, 18 Feb 2020 11:34:49 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 11/11] mtd: new support oops logger based on
 pstore/blk
Message-ID: <20200218113449.5ac44955@xps13>
In-Reply-To: <1581078355-19647-12-git-send-email-liaoweixiong@allwinnertech.com>
References: <1581078355-19647-1-git-send-email-liaoweixiong@allwinnertech.com>
        <1581078355-19647-12-git-send-email-liaoweixiong@allwinnertech.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi WeiXiong,

WeiXiong Liao <liaoweixiong@allwinnertech.com> wrote on Fri,  7 Feb
2020 20:25:55 +0800:

> It's the last one of a series of patches for adaptive to MTD device.
> 
> The mtdpstore is similar to mtdoops but more powerful. It bases on
> pstore/blk, aims to store panic and oops logs to a flash partition,
> where it can be read back as files after mounting pstore filesystem.
> 
> The pstore/blk and blkoops, a wrapper for pstore/blk, are designed for
> block device at the very beginning, but now, compatible to not only
> block device. After this series of patches, pstore/blk can also work
> for MTD device. To make it work, 'blkdev' on kconfig or module
> parameter of blkoops should be set as mtd device name or mtd number.
> See more about pstore/blk and blkoops on:
>     Documentation/admin-guide/pstore-block.rst
> 
> Why do we need mtdpstore?
> 1. repetitive jobs between pstore and mtdoops
>    Both of pstore and mtdoops do the same jobs that store panic/oops log.
>    They have much similar logic that register to kmsg dumper and store
>    log to several chunks one by one.
> 2. do what a driver should do
>    To me, a driver should provide methods instead of policies. What MTD
>    should do is to provide read/write/erase operations, geting rid of codes
>    about chunk management, kmsg dumper and configuration.
> 3. enhanced feature
>    Not only store log, but also show it as files.
>    Not only log, but also trigger time and trigger count.
>    Not only panic/oops log, but also log recorder for pmsg, console and
>    ftrace in the future.
> 
> Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Richard, your PoV on this is welcome.

I suppose this patch depends on the others to work correctly so maybe
we should wait the next release before applying it.

Thanks,
Miquèl
