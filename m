Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4DEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CD4920DD4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592967440;
	bh=ewh6p58MBLQ+gBYZH4UM+PqcqXmU3rYIoDXVYdQQtHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dtNYkb+K+A0EGwLMDV4B8dXoOo9SV2Q0qhqfbbbLZFcarabJRqC84wyVTPk9i9NKy
	 KsZjiDqlV2x1dNvoPYwBGz2jPxdGzj+jycFC2Mst3Fj85PoJz8HZlCPO2znoVzDCpb
	 nNwIcvk4C4Fz2Au8qtYqdZkIeW+Y0f2cTZFqKvKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388516AbgFXC5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 22:57:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387985AbgFXC5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 22:57:18 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 822C220874;
        Wed, 24 Jun 2020 02:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592967438;
        bh=ewh6p58MBLQ+gBYZH4UM+PqcqXmU3rYIoDXVYdQQtHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dIsWctIph+e7PUso+GGP/OZF0slRBaqcrwDuqs4IdtwvkDQf0ei15DA9RHYQA34di
         TlzuWgUk7OV5zgG3HQszMI/pB9MwpDomnMPmuoaloL8h+JaEMKyCJIBFGYgzVok3l0
         Ji0U4/GwfqaKlqGTZ/GKW+mUjBHeSq33QEjT7/GI=
Date:   Tue, 23 Jun 2020 19:57:15 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me, baolin.wang7@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] nvme: Add Arbitration Burst support
Message-ID: <20200624025715.GB1291930@dhcp-10-100-145-180.wdl.wdc.com>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
 <bf3f47ba50f72d0b775ca4bd098f183056d964ba.1592916850.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf3f47ba50f72d0b775ca4bd098f183056d964ba.1592916850.git.baolin.wang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 09:24:32PM +0800, Baolin Wang wrote:
> +void nvme_set_arbitration_burst(struct nvme_ctrl *ctrl)
> +{
> +	u32 result;
> +	int status;
> +
> +	if (!ctrl->rab)
> +		return;
> +
> +	/*
> +	 * The Arbitration Burst setting indicates the maximum number of
> +	 * commands that the controller may launch at one time from a
> +	 * particular Submission Queue. It is recommended that host software
> +	 * configure the Arbitration Burst setting as close to the recommended
> +	 * value by the controller as possible.
> +	 */
> +	status = nvme_set_features(ctrl, NVME_FEAT_ARBITRATION, ctrl->rab,

Since 'rab' is an 8-bit field, but the feature's AB value is only 3
bits, we should add a validity check.

> +}
> +EXPORT_SYMBOL_GPL(nvme_set_arbitration_burst);

I don't see any particular reason to export this function just for the
pci transport to use. Just make it a local static function an call it
from nvme_init_identify().
