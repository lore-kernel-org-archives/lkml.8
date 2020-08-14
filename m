Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97AAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A862206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgHNIQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 04:16:52 -0400
Received: from verein.lst.de ([213.95.11.211]:48812 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbgHNIQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 04:16:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 135BB68CEE; Fri, 14 Aug 2020 10:16:48 +0200 (CEST)
Date:   Fri, 14 Aug 2020 10:16:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH] nvme-pci: cancel nvme device request before disabling
Message-ID: <20200814081647.GA10347@lst.de>
References: <20200814071431.201400-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814071431.201400-1-ztong0001@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 03:14:31AM -0400, Tong Zhang wrote:
>   This patch addresses an irq free warning and null pointer dereference
>   error problem when nvme devices got timeout error during initialization.
>   This problem happens when nvme_timeout() function is called while
>   nvme_reset_work() is still in execution. This patch fixed the problem by
>   setting flag of the problematic request to NVME_REQ_CANCELLED before
>   calling nvme_dev_disable() to make sure __nvme_submit_sync_cmd() returns
>   an error code and let nvme_submit_sync_cmd() fail gracefully.
>   The following is console output.

The commit log looks a little weird due to the extra indentation.

The patch itself looks good, though:

Reviewed-by: Christoph Hellwig <hch@lst.de>
