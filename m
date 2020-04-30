Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511A5C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA8B2137B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588243317;
	bh=ZcTtHU52BJcfeJg1O8unpT4GgD3JTL20IZWKUTF8TKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dw4C0gDsEwvUqnxj8MOPQrRUoFl0azQVBVrolY/cdICBn5uxuwLrF8LKnj64ofo1n
	 H3Sv5DWN9hPGqvxQcdHopUxYUC3Iadx3GEcDzMWXLdKocKrCQQRNiuydR3dW+SWxtN
	 DCUPdVrU4njZWES7wGNEfGGejpgBZn6ODodubQUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgD3Kl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 06:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgD3Klz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 06:41:55 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9B2320838;
        Thu, 30 Apr 2020 10:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588243315;
        bh=ZcTtHU52BJcfeJg1O8unpT4GgD3JTL20IZWKUTF8TKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NoqNnmeKkPJyRneJ9nMRoBDO87ZWFjCkgG1ug60/9sKtzuDrOfUH6GYjuV09Epb5Z
         3mfxuTey9BjKXEuQX5GPlVcv4F4fS1W6Yt7XGl2CiupaHTqoL3BnztP8mNgZzFUZd2
         air1XKZM4E8l6ApPlZbshsahzH2kIyfc5OkPZmTc=
Date:   Thu, 30 Apr 2020 11:41:50 +0100
From:   Will Deacon <will@kernel.org>
To:     Srivatsa Vaddagiri <vatsa@codeaurora.org>
Cc:     konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com,
        jan.kiszka@siemens.com, stefano.stabellini@xilinx.com,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org,
        pratikp@codeaurora.org, christoffer.dall@arm.com,
        alex.bennee@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/1] virtio: Introduce MMIO ops
Message-ID: <20200430104149.GG19932@willie-the-truck>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <1588240976-10213-2-git-send-email-vatsa@codeaurora.org>
 <20200430101431.GD19932@willie-the-truck>
 <20200430103446.GH5097@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430103446.GH5097@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 04:04:46PM +0530, Srivatsa Vaddagiri wrote:
> * Will Deacon <will@kernel.org> [2020-04-30 11:14:32]:
> 
> > > +#ifdef CONFIG_VIRTIO_MMIO_OPS
> > >  
> > > +static struct virtio_mmio_ops *mmio_ops;
> > > +
> > > +#define virtio_readb(a)		mmio_ops->mmio_readl((a))
> > > +#define virtio_readw(a)		mmio_ops->mmio_readl((a))
> > > +#define virtio_readl(a)		mmio_ops->mmio_readl((a))
> > > +#define virtio_writeb(val, a)	mmio_ops->mmio_writeb((val), (a))
> > > +#define virtio_writew(val, a)	mmio_ops->mmio_writew((val), (a))
> > > +#define virtio_writel(val, a)	mmio_ops->mmio_writel((val), (a))
> > 
> > How exactly are these ops hooked up? I'm envisaging something like:
> > 
> > 	ops = spec_compliant_ops;
> > 	[...]
> > 	if (firmware_says_hypervisor_is_buggy())
> > 		ops = magic_qcom_ops;
> > 
> > am I wrong?
> 
> If CONFIG_VIRTIO_MMIO_OPS is defined, then I expect this to be unconditionally
> set to 'magic_qcom_ops' that uses hypervisor-supported interface for IO (for
> example: message_queue_send() and message_queue_recevie() hypercalls).

Hmm, but then how would such a kernel work as a guest under all the
spec-compliant hypervisors out there?

> > > +int register_virtio_mmio_ops(struct virtio_mmio_ops *ops)
> > > +{
> > > +	pr_info("Registered %s as mmio ops\n", ops->name);
> > > +	mmio_ops = ops;
> > 
> > Not looking good, and really defeats the point of standardising this stuff
> > imo.
> 
> Ok. I guess the other option is to standardize on a new virtio transport (like
> ivshmem2-virtio)?

I haven't looked at that, but I suppose it depends on what your hypervisor
folks are willing to accomodate.

Will
