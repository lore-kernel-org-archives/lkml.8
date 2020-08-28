Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBBFC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3877820872
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598629920;
	bh=YQ07odnS6NgebrciQwQis3LqHHVgGAFER6PkRV66vR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gWGl9bHhakF6yhGJu1hGHeTZiqnnU8jgoQmUIeeycHc+vXYUsI/fy2MNt0PQTb20/
	 CYllZHpXXcd/1aA0sFvIbEoqpS98l072Ulm6rXDMA3FJiNGziolrSVs3T5V4EvzQzG
	 fVJt/b2A27ZChwWtkC9eSQ/QHCTEvMAvnVt/cItw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgH1Pv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:51:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgH1Pv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:51:58 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 434F02075B;
        Fri, 28 Aug 2020 15:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598629917;
        bh=YQ07odnS6NgebrciQwQis3LqHHVgGAFER6PkRV66vR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XdcD+SDPBZoJ8xCKvlABgms53TZQHy5kuKzHcRX9uYdNgLYs9qFIUa8ybGbQoM3es
         us4ywUkGYV8Wnf3ZIgaICTfPyCgcrCVbNd14zNZIOF+W4kisiLEBCiURwvD7jWUS3x
         g/y143nD0WlWCDDlzt53e1eelwX5mhstgn59h2s0=
Date:   Fri, 28 Aug 2020 08:51:55 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme-pci: cancel nvme device request before disabling
Message-ID: <20200828155155.GA2826202@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200827150103.GA2613662@dhcp-10-100-145-180.wdl.wdc.com>
 <20200828141707.4124-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828141707.4124-1-ztong0001@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 10:17:08AM -0400, Tong Zhang wrote:
> This patch addresses an irq free warning and null pointer dereference
> error problem when nvme devices got timeout error during initialization.
> This problem happens when nvme_timeout() function is called while
> nvme_reset_work() is still in execution. This patch fixed the problem by
> setting flag of the problematic request to NVME_REQ_CANCELLED before
> calling nvme_dev_disable() to make sure __nvme_submit_sync_cmd() returns
> an error code and let nvme_submit_sync_cmd() fail gracefully.
> The following is console output.

Thanks, this looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>
