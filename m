Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9391BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 962642076E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596528708;
	bh=vDIdMthlwvK/lkIZaP62qRcbBqyYKHtAH/TIlf2+Eh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VZw+ELVIz1sH2b49K/s3g8ackEMDgd/H4gxb19R0nzICULp2LtRpNkDO5jOr6mPfW
	 /jf5hTarzw3W4uUt/cNk5ZPBwMwLcHCcRYWprI9CM8bigGVDZRrROXT0g0pfjFTCMW
	 2h0VCGsuk3t0s7JA9/JeuNhe7wCnUpPzyF/8fz3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgHDILr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 04:11:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgHDILq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 04:11:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B82442076C;
        Tue,  4 Aug 2020 08:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596528706;
        bh=vDIdMthlwvK/lkIZaP62qRcbBqyYKHtAH/TIlf2+Eh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QAOqMFQBXE6gbzCuR+sDBsl8IRxsLNFDP6Il/GaPzZT+gvA5oW0wVuRUqzDPvDuQp
         r8UCTIIT31gsbQEhsvEnC79nrk+7FRDKCi1hajUnkC27OS8olMycbG4OrilGdUOySY
         +6nCD/Zdd2WXZi+ckAUmdh7dfFuCKqKmk6zoyxbg=
Date:   Tue, 4 Aug 2020 10:11:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "hongxu.zhao" <hongxu.zhao@mediatek.com>
Cc:     "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        wsd_upstream@mediatek.com, Weiqi Fu <weiqi.fu@mediatek.com>,
        open list <linux-kernel@vger.kernel.org>,
        Cunliang Du <cunliang.du@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Zhen jiang <zhen.jiang@mediatek.com>
Subject: Re: [PATCH] staging: Add Mediatek High Frequency Manager Framework
Message-ID: <20200804081126.GA1765831@kroah.com>
References: <20200804075339.9820-1-hongxu.zhao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804075339.9820-1-hongxu.zhao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 03:52:49PM +0800, hongxu.zhao wrote:
> Add a new sensor framework into linux kernel which can support multi client request sensor data.
> There are the following features:
>     1.Ringbuffer between manager and client;
>     2.Kernel space user interface;
>     3.User space user interface with syscall;
>     4.Each client hang detect mechanism;
>     5.Polling timer management in framework no need driver concern;
>     6.Polling kthread work intergrated into a single kthread
>       worker to save system resources in framework no need driver concern;
>     7.Proc file system to show manager device and client details;
>     8.Compitable with android and widely used in many mediatek platform products;
> 
> Change-Id: I6361cdc2d51de50f66eede7df099c4575e7ec473

Did you not run checkpatch.pl on this?  :)

No need for change-id here.

But, most importantly, why is this in drivers/staging?  What keeps it
from being in the "real" part of the kernel?  I need a TODO file in the
directory of the driver listing what remains to be done and who is
responsible for doing this work and reviewing patches.

Can you resend this with that file added and the Change-id removed?

Also, why not just use the IIO interface, why are you creating
yet-another api for sensors?  We already have 2, making a third seems
like something that guarantees this will never be mergable to the
correct part of the kernel.

And finally, /proc/ is not for devices, that is what sysfs is for,
please use that.

thanks,

greg k-h
