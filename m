Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EA1C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 021F322BEF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595287026;
	bh=Q9szxRrPwCdNe0hZlylV+fReFObbkgbW4HzTvN549GY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JOLTxbG1+PBcNXeaCiNwG0fRN9A3UG1r1CfrzUeZgM01pFlBvkRMp2O0D2uzSmD3v
	 eR/gLoSOI0rd5QwY+x0fyk1W1LZxgJoaP+R2ArNeJlaT+FSrfzss1BPNV4G9jj+7/t
	 nM8w27j0tnB+Q4C6yXY9t/ew3VU4/cjtQprjdfSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgGTXRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 19:17:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbgGTXRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 19:17:04 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 763672065E;
        Mon, 20 Jul 2020 23:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595287024;
        bh=Q9szxRrPwCdNe0hZlylV+fReFObbkgbW4HzTvN549GY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oeiDJ4dqGgKNXkswJJXqxLf3XMqabNSt9swlgnWgDf+4gzGRHA46FKsSzzjGk7BYG
         MZQUiyzTZYVZDb6s4bzI0YHwRny9nxYI9la+SacZJaws/lJTaHdXjE5Q6u/Vimg4Wu
         3pNXo3teER48NQDE988vkw/RW1ldz4LLJwKWZTOo=
Date:   Mon, 20 Jul 2020 16:17:01 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v15 7/9] nvmet-passthru: Add passthru code to process
 commands
Message-ID: <20200720231701.GA682160@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200716203319.16022-1-logang@deltatee.com>
 <20200716203319.16022-8-logang@deltatee.com>
 <20200720141606.GF4627@lst.de>
 <e939dd43-9e7f-8ef0-162b-2a27f53e6e1a@grimberg.me>
 <5cc390cf-9b0b-b48b-7447-37934be51ee0@deltatee.com>
 <2dc39232-4042-1f93-3dcc-3266e70cf6f0@grimberg.me>
 <b8fc47a2-0b53-3316-775f-0e9a8eddfdc2@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8fc47a2-0b53-3316-775f-0e9a8eddfdc2@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 05:01:19PM -0600, Logan Gunthorpe wrote:
> On 2020-07-20 4:35 p.m., Sagi Grimberg wrote:
>
> > passthru commands are in essence REQ_OP_DRV_IN/REQ_OP_DRV_OUT, which
> > means that the driver shouldn't need the ns at all. So if you have a
> > dedicated request queue (mapped to the I/O tagset), you don't need the
> > ns->queue and we can lose the ns lookup altogether.

We still need a request_queue to dispatch the command. I guess you could
make a generic one for the controller that isn't tied to a namespace,
but we lose the fair shared tag allocation.
 
> Thanks, that helps clarify things a bit, but which xarray were you
> talking about

That was something that was replacing the list lookup:

  http://lists.infradead.org/pipermail/linux-nvme/2020-July/018242.html
