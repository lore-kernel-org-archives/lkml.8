Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81092C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A7DE20771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgGWQD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:03:29 -0400
Received: from verein.lst.de ([213.95.11.211]:60762 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgGWQD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:03:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 071B168AFE; Thu, 23 Jul 2020 18:03:25 +0200 (CEST)
Date:   Thu, 23 Jul 2020 18:03:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        kyounghwan sohn <kyounghwan.sohn@sk.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme/pci: Add new quirk for SK hynix PC400 NLB
 off-by-one bug
Message-ID: <20200723160325.GA17996@lst.de>
References: <20200417083641.28205-1-kai.heng.feng@canonical.com> <20200723155731.22313-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723155731.22313-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 11:57:31PM +0800, Kai-Heng Feng wrote:
> After commit 6e02318eaea5 ("nvme: add support for the Write Zeroes
> command"), SK hynix PC400 becomes very slow with the following error
> message:
> [  224.567695] blk_update_request: operation not supported error, dev nvme1n1, sector 499384320 op 0x9:(WRITE_ZEROES) flags 0x1000000 phys_seg 0 prio class 0]
> 
> SK Hynix PC400 has a buggy firmware that treats NLB as max value instead
> of a range, so the NLB passed isn't a valid value to the firmware.
> 
> According to SK hynix there are three commands are affected:
> - Write Zeroes
> - Compare
> - Write Uncorrectable
> 
> Write Uncorrectable isn't implemented yet, so add a new quirk to
> workaround the former two commands.

compare isn't implemented either in the kernel, and we certainly
aren't going to do these quirks for passthrough.  So I think we really
want a "write zeroes is buggy" quirk and just disable issuing that
command from the driver.

> 
> BugLink: https://bugs.launchpad.net/bugs/1872383
> Cc: kyounghwan sohn <kyounghwan.sohn@sk.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
> - SK hynix found the root cause so change the approach accordingly.
> - lspci is wrong, the device is PC400 instead of SC300.

I don't remember seing a v1..
