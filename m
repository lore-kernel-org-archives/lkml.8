Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854F6C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57E792137B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588243166;
	bh=6+7qBBamWTT9w7zClGZROm5AeCOL7MN9qOqe5yevm90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UkfjEkAIeUlrzKblw0KVsRNVYYj62g6Zay6s/8cgqn36BxD2NFZ2B6mrXsqrx6NWQ
	 a/Qo2KEKLrS82Sr2Pe2ZGao4qmw3GhM2ggFdMAQ412EiInUFauV7+IljkodlvvvAe5
	 MfeTMdt+0Tl6tgxpECE3tLBMIaTRKN/QLRzLm8rw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgD3KjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 06:39:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgD3KjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 06:39:25 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3CF920838;
        Thu, 30 Apr 2020 10:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588243164;
        bh=6+7qBBamWTT9w7zClGZROm5AeCOL7MN9qOqe5yevm90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j4ZaDYWlFfnjJ0Kk6dtybxWMdijfCyiwyxZsPRioDIEIjW2Pq/Kffjmqjr3+J0Ejl
         JR4YgwOGru7gDKzTHRc+/mOOsVLTS5ejWCp0tS62mKzaXXuC93LMhd13Rxno4+GTvA
         qmCLkIDor0yLvS+hxfn7Nw42bPZSZSdBu25gx7Rk=
Date:   Thu, 30 Apr 2020 11:39:19 +0100
From:   Will Deacon <will@kernel.org>
To:     Srivatsa Vaddagiri <vatsa@codeaurora.org>
Cc:     konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com,
        jan.kiszka@siemens.com, stefano.stabellini@xilinx.com,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org,
        pratikp@codeaurora.org, christoffer.dall@arm.com,
        alex.bennee@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 0/1] virtio_mmio: hypervisor specific interfaces for
 MMIO
Message-ID: <20200430103919.GF19932@willie-the-truck>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <20200430100821.GC19932@willie-the-truck>
 <20200430102939.GG5097@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430102939.GG5097@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vatsa,

On Thu, Apr 30, 2020 at 03:59:39PM +0530, Srivatsa Vaddagiri wrote:
> * Will Deacon <will@kernel.org> [2020-04-30 11:08:22]:
> 
> > > This patch is meant to seek comments. If its considered to be in right
> > > direction, will work on making it more complete and send the next version!
> > 
> > What's stopping you from implementing the trapping support in the
> > hypervisor? Unlike the other patches you sent out, where the guest memory
> > is not accessible to the host, there doesn't seem to be any advantage to
> > not having trapping support, or am I missing something here?
> 
> 	I have had this discussion with hypervisor folks. They seem to be
> concerned about complexity of having a VM's fault be handled in another
> untrusted VM. They are not keen to add MMIO support.

Right, but I'm concerned about forking the implementation from the spec
and I'm not keen to add these hooks ;)

What does your hook actually do? I'm assuming an HVC? If so, then where the
fault is handled seems to be unrelated and whether the guest exit is due to
an HVC or a stage-2 fault should be immaterial. In other words, I don't
follow why the trapping mechanism necessitates the way in which the fault is
handled.

Will
