Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051FDC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C52F52070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588114437;
	bh=ywVtSYZTVnlMl6doGY8VJNhfjwkHTSTfeN9miNjuHLc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=t1xntNC6ATNh873ihjZbVyrPYU69dGil78w3Uqv/VywJ2s34hd19FefFh3mSw2vIL
	 Zt4+I35dlh0ZTtfYxKWLKdVVyX6n5R7A6wpMDktzXaUwH9zya1r4f66GkfSL11ghdx
	 YDGfqSru1UB1oXDIO5XRlwMAfUC3PUqnhnxGuWeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgD1Wx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbgD1Wx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 18:53:56 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACB2E206D9;
        Tue, 28 Apr 2020 22:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588114436;
        bh=ywVtSYZTVnlMl6doGY8VJNhfjwkHTSTfeN9miNjuHLc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=K8ywBOYNFWIro+8tTcJPkzDdktI4MKmTQFI2jKuDDCZxz/UPDSdJCkEwANhDBlV4Z
         +AD2jXT3SglB96bLRp2T+E2dhPpvIycmfgpopwde4gOSyMWOMgY/EG/59z2V1xC782
         pzdsNh2DvdLoOlNaBrJ/mPX3Dl7yMXVfFt5esrDw=
Date:   Tue, 28 Apr 2020 15:53:55 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Srivatsa Vaddagiri <vatsa@codeaurora.org>
cc:     konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com,
        jan.kiszka@siemens.com, will@kernel.org,
        stefano.stabellini@xilinx.com, iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org,
        pratikp@codeaurora.org, christoffer.dall@arm.com,
        alex.bennee@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
In-Reply-To: <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
Message-ID: <alpine.DEB.2.21.2004281542010.29217@sstabellini-ThinkPad-T480s>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org> <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020, Srivatsa Vaddagiri wrote:
> For better security, its desirable that a guest VM's memory is
> not accessible to any entity that executes outside the context of
> guest VM. In case of virtio, backend drivers execute outside the
> context of guest VM and in general will need access to complete
> guest VM memory.  One option to restrict the access provided to
> backend driver is to make use of a bounce buffer. The bounce
> buffer is accessible to both backend and frontend drivers. All IO
> buffers that are in private space of guest VM are bounced to be
> accessible to backend.

[...]

> +static int __init virtio_bounce_setup(struct reserved_mem *rmem)
> +{
> +	unsigned long node = rmem->fdt_node;
> +
> +	if (!of_get_flat_dt_prop(node, "no-map", NULL))
> +		return -EINVAL;
> +
> +	return virtio_register_bounce_buffer(rmem->base, rmem->size);
> +}
> +
> +RESERVEDMEM_OF_DECLARE(virtio, "virtio_bounce_pool", virtio_bounce_setup);

Is this special reserved-memory region documented somewhere?
