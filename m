Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF781C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FACC2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593526129;
	bh=Bir2/g52+uKiDFsLqGocRSdaGam+HlMfWXbv0m+pQTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ug2p6fSyUUr4fh/Zo8cKZuDk6ry6LnrhAFstdtDGamhvc4UXmGH40hcte6LgsajAs
	 M72suc/rCzMULuhES0dofBVowfW+oOq1HYiCAkzg3e7zoUTDrxcQXTZV8m4qzlxqnu
	 1dfekpUFMgyo9RW4cgOyr9aevL2CVsSVSpqt+pG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388350AbgF3OIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:08:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731084AbgF3OIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:08:48 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 564562072D;
        Tue, 30 Jun 2020 14:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593526127;
        bh=Bir2/g52+uKiDFsLqGocRSdaGam+HlMfWXbv0m+pQTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xPEECGY0ZlkfbVu8+/j9jkZcaX0C2kOSAHGXacxSdFt9J8gIYxRvW7wHdzyn/pE1X
         zVD5xi+yzQAdu6qncSpabQ6z+OnBQy1TYoy4WYvEula16bQGttes3jHQo1Mca0Ra2v
         VOO7tM+zk8gtePRfyFMNIQRgZN5HG+Mcr18CIYKk=
Date:   Tue, 30 Jun 2020 07:08:45 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Maximilian Heyne <mheyne@amazon.de>
Cc:     Christoph Hellwig <hch@lst.de>, Amit Shah <aams@amazon.de>,
        stable@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: validate cntlid's only for nvme >= 1.1.0
Message-ID: <20200630140845.GA1987534@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200630122923.70282-1-mheyne@amazon.de>
 <20200630133358.GA20602@lst.de>
 <20200630133609.GA20809@lst.de>
 <b3b621d9-b653-45c4-4164-f5a492cabd6a@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3b621d9-b653-45c4-4164-f5a492cabd6a@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 04:01:45PM +0200, Maximilian Heyne wrote:
> On 6/30/20 3:36 PM, Christoph Hellwig wrote:
> > And actually - 1.0 did not have the concept of a subsystem.  So having
> > a duplicate serial number for a 1.0 controller actually is a pretty
> > nasty bug.  Can you point me to this broken controller?  Do you think
> > the OEM could fix it up to report a proper version number and controller
> > ID?
> > 
> 
> I meant that the VF NVMe controllers will all land in the same subsystem from
> the kernel's point of view, because, as you said, there was no idea of different
> subsystems in the 1.0 spec.

Each controller should have landed in its own subsystem in this case
rather than the same subsystem.

> It's an older in-house controller. Seems to set the same serial number for all
> VF's. Should the firmware set unique serials for the VF's instead?

Yes, the driver shouldn't be finding duplicate serial numbers.
