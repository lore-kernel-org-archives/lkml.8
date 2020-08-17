Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8659C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4BEF20578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597689803;
	bh=AyJyeBUIrLG0r7Q9Vo+RWqzElD6xhH3UK5WZ5y9uLyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z50xL4w6lDgiocpo+eA51PSooxrrwO3BHAgCveBLsehBelzobOK3i7I6+7TH//Nrm
	 DpgUkcUzvWcDLXraVFVloAo1Q9jRwHPsPtfG9zDscaMYfvwmMngK/TVa7RXnX36bDX
	 X3eChIrUOEZa3kZxr6iNpM4RIOF2jmu/0JJcyu+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391485AbgHQSnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:43:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388096AbgHQP5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:57:09 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C3C320825;
        Mon, 17 Aug 2020 15:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679820;
        bh=AyJyeBUIrLG0r7Q9Vo+RWqzElD6xhH3UK5WZ5y9uLyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C4tMPTONxbWjnDm8fnGLSy4ebkMPC5O4CJq4RTVft4DO2Kq1WKNzKCLZstZ7SjSBr
         6njgN4kXVE++dvsTW6NwqrNf7YSg4H36M6M0I8Fg3IBfFt3xqcXrxGZq3VeC7+gF2U
         tzb6b8QyDc3CMzj2cmF96YWyMm0xK+pjwvz5Gtxs=
Date:   Mon, 17 Aug 2020 08:56:58 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: v5.9-rc1 commit reliably breaks pci nvme detection
Message-ID: <20200817155658.GB1221871@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200817135011.GA2072@lx-t490>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817135011.GA2072@lx-t490>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 03:50:11PM +0200, Ahmed S. Darwish wrote:
> Hello,
> 
> Below v5.9-rc1 commit reliably breaks my boot on a Thinkpad e480
> laptop. PCI nvme detection fails, and the kernel becomes not able
> anymore to find the rootfs / parse "root=".
> 
> Bisecting v5.8=>v5.9-rc1 blames that commit. Reverting it *reliably*
> fixes the problem and makes me able to boot v5.9-rc1.

The fix is staged in the nvme tree here:

  http://git.infradead.org/nvme.git/commit/286155561ecd13b6c85a78eaf2880d3baea03b9e
