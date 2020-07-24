Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B704C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB76A2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595619314;
	bh=OyWnGKGYTbGw+IY4gpJNqzKFV+CQ5aSvZCLKgmsvSw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TZASSdF2dYiZ0jz7B3UJhop/yAL/ET9X0zMpvsNQpC+RdVA/qeyuVK6cQr0wjXAmF
	 6E7jWAe0mmtwZpHwohu/RPKjOscZ6hU9pBMsU81vpHdApnvS4xM7PZdiWdTnWytgyw
	 2yQ6+7JmHo0w93APci2lo8RtQ5YPvFOEMF8/lMdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGXTfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 15:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgGXTfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:35:12 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D3EE206D8;
        Fri, 24 Jul 2020 19:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595619312;
        bh=OyWnGKGYTbGw+IY4gpJNqzKFV+CQ5aSvZCLKgmsvSw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NFdEZU6IOueyntu8q4uunWpKhG/WXNlg+x2jV/pxv6WEM7UJcXJtfBsxQ6E2L7gz/
         go0xqISCK/aUR+Nj1Zn0UpxkXA5C9aILzzIO9UVNmK1zvXTKKATScDgPPkcYVq09w8
         YYuHLCAF/9PlnTYbuJ02Myf6CID30DiQgroi96zI=
Date:   Fri, 24 Jul 2020 12:35:09 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v16 0/9] nvmet: add target passthru commands support
Message-ID: <20200724193509.GB2857771@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200724172520.16318-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724172520.16318-1-logang@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 11:25:11AM -0600, Logan Gunthorpe wrote:
> This is v16 of the passthru patchset which make a bunch of cleanup as
> suggested by Christoph.

Thank, looks great. Just the comment on 6/9, which probably isn't super
important anyway.

Reviewed-by: Keith Busch <kbusch@kernel.org>
