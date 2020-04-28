Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73644C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 421CC206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588115077;
	bh=bo21LaVDiN3p5qRExTfq+J7LOaI4TxtlxHpokeU5a/o=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=bHvhcRJUq+hqCnptl11doCD1Pbgnqy1ZPbG0Qn9EwE66M8hE8a+h5mQOKF9kEWinX
	 3dODhs7IE9cYhBfEoYkILzOZo1ibSox90ZGONojwgZm8YvJxKYjmu5hrIW5SLq90m9
	 hx0ECD/gba8NOQJG9s7XJ/9hPNk+CQhgfMnyyhnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgD1XEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 19:04:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgD1XEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 19:04:36 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E881120656;
        Tue, 28 Apr 2020 23:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588115075;
        bh=bo21LaVDiN3p5qRExTfq+J7LOaI4TxtlxHpokeU5a/o=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=yFtq8fVR/VOkhVWVlZwlZokdulMlFu18XJsQJY7pDxJcDZzrCvZYs0XLTYNZmxQFB
         TBC5AJbU1fcRxpBlV7gSsUZbbrInB3b/KP1iNNFQvhDadkU4ftnPdNkgd7QRwiGDNB
         fSoqdmY8NaFIDGsoCMkQHQ8Ab/XP58R2TcfoPOUo=
Date:   Tue, 28 Apr 2020 16:04:34 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     "Michael S. Tsirkin" <mst@redhat.com>
cc:     Srivatsa Vaddagiri <vatsa@codeaurora.org>, konrad.wilk@oracle.com,
        jasowang@redhat.com, jan.kiszka@siemens.com, will@kernel.org,
        stefano.stabellini@xilinx.com, iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org,
        pratikp@codeaurora.org, christoffer.dall@arm.com,
        alex.bennee@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
In-Reply-To: <20200428163448-mutt-send-email-mst@kernel.org>
Message-ID: <alpine.DEB.2.21.2004281556180.29217@sstabellini-ThinkPad-T480s>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org> <1588073958-1793-6-git-send-email-vatsa@codeaurora.org> <20200428121232-mutt-send-email-mst@kernel.org> <20200428174952.GA5097@quicinc.com> <20200428163448-mutt-send-email-mst@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020, Michael S. Tsirkin wrote:
> On Tue, Apr 28, 2020 at 11:19:52PM +0530, Srivatsa Vaddagiri wrote:
> > * Michael S. Tsirkin <mst@redhat.com> [2020-04-28 12:17:57]:
> > 
> > > Okay, but how is all this virtio specific?  For example, why not allow
> > > separate swiotlbs for any type of device?
> > > For example, this might make sense if a given device is from a
> > > different, less trusted vendor.
> > 
> > Is swiotlb commonly used for multiple devices that may be on different trust
> > boundaries (and not behind a hardware iommu)?

The trust boundary is not a good way of describing the scenario and I
think it leads to miscommunication.

A better way to describe the scenario would be that the device can only
DMA to/from a small reserved-memory region advertised on device tree.

Do we have other instances of devices that can only DMA to/from very
specific and non-configurable address ranges? If so, this series could
follow their example.


> Even a hardware iommu does not imply a 100% security from malicious
> hardware. First lots of people use iommu=pt for performance reasons.
> Second even without pt, unmaps are often batched, and sub-page buffers
> might be used for DMA, so we are not 100% protected at all times.
