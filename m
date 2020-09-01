Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472B1C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2179320767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598978381;
	bh=dr8lHwwOag/AEGKr0f2JEzvp5F69En5NKrtfPtmoJsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ps9MtCITvfnbjZD2Tm4s28674dvp8JNqWuocfTPz3LDdrK4a7CkaBab8BE8N7ibiJ
	 xP2m8WgERduya5NTwhj2+XSeXthBdOsC8dkU4YcozXraBs7fVMztx0R++XqznLnCTS
	 W3VSaWBiFmvin2Qi6hbzQWL2ItdiRfrFyxp+1UJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbgIAQjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:39:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730335AbgIAQj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:39:29 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18E3120767;
        Tue,  1 Sep 2020 16:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598978369;
        bh=dr8lHwwOag/AEGKr0f2JEzvp5F69En5NKrtfPtmoJsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dv/qp1cvjo4u1Q6QF8ETb659T0g0+yajEQdEqw8WyWSdiVqK4NIr+lbll5oPtdPCR
         i0klifYzBqWT+ycUZ7i6+OQZL/05aPSXpEQmenRQrJiL7Gw41mVsH+2iqw3NhpsQ42
         oKZ51Cvyt5xpKsGv+DOutjEoRCNUsInwthq5Po1E=
Date:   Tue, 1 Sep 2020 09:39:27 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] nvme-pci: check req to prevent crash in
 nvme_handle_cqe()
Message-ID: <20200901163927.GC2831246@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200831105553.1621-1-tian.xianting@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831105553.1621-1-tian.xianting@h3c.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 06:55:53PM +0800, Xianting Tian wrote:
> As blk_mq_tag_to_rq() may return null, so it should be check whether it is
> null before using it to prevent a crash.

It may return NULL if the command id exceeds the number of tags. We
already have a check for a valid command id value, so something is not
adding up here if we're still getting NULL.

>  	req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), cqe->command_id);
> +	if (unlikely(!req)) {
> +		dev_warn(nvmeq->dev->ctrl.device,
> +			"req is null(tag:%d) on queue %d\n",
> +			cqe->command_id, le16_to_cpu(cqe->sq_id));
> +		return;
> +	}
