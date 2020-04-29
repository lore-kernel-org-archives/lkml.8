Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F94BC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C0132082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="tUZqRnj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgD2Jod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:44:33 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:52989 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726493AbgD2Joc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:44:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588153472; h=In-Reply-To: Content-Type: MIME-Version:
 References: Reply-To: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=xeoQ4Rw3CrXOQCQ/sgEZvG+//pNvDfL8fDquz8JatMw=; b=tUZqRnj+QYVZfUmaupkZ8i6/d2abRCmwPidZ/vQCW0UEF2iV11LFkPOkghTpCCtf3iw0ymQH
 jrROORpKyHxjrLKzkyvZs9HJAxTfTamKE1HBHolPwEcGcg+HGPJxQBj2BG1z+r6w+asU9WHP
 0NMdg2wqymfPvqaxRj1GmPDWWZQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea94c74.7ff0eebd0880-smtp-out-n03;
 Wed, 29 Apr 2020 09:44:20 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DA51AC4478C; Wed, 29 Apr 2020 09:44:18 +0000 (UTC)
Received: from quicinc.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: svaddagi)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E1190C433CB;
        Wed, 29 Apr 2020 09:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E1190C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vatsa@codeaurora.org
Date:   Wed, 29 Apr 2020 15:14:10 +0530
From:   Srivatsa Vaddagiri <vatsa@codeaurora.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, tsoni@codeaurora.org,
        virtio-dev@lists.oasis-open.org, konrad.wilk@oracle.com,
        jan.kiszka@siemens.com, jasowang@redhat.com,
        christoffer.dall@arm.com,
        virtualization@lists.linux-foundation.org, alex.bennee@linaro.org,
        iommu@lists.linux-foundation.org, stefano.stabellini@xilinx.com,
        will@kernel.org, linux-kernel@vger.kernel.org,
        pratikp@codeaurora.org
Subject: Re: [PATCH 5/5] virtio: Add bounce DMA ops
Message-ID: <20200429094410.GD5097@quicinc.com>
Reply-To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
 <1588073958-1793-6-git-send-email-vatsa@codeaurora.org>
 <20200428121232-mutt-send-email-mst@kernel.org>
 <20200428174952.GA5097@quicinc.com>
 <20200428163448-mutt-send-email-mst@kernel.org>
 <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
 <20200429004531-mutt-send-email-mst@kernel.org>
 <b676430c-65b3-096e-ca48-ceebf10f4b28@linux.intel.com>
 <20200429023842-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200429023842-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael S. Tsirkin <mst@redhat.com> [2020-04-29 02:50:41]:

> So it seems that with modern Linux, all one needs
> to do on x86 is mark the device as untrusted.
> It's already possible to do this with ACPI and with OF - would that be
> sufficient for achieving what this patchset is trying to do?

In my case, its not sufficient to just mark virtio device untrusted and thus
activate the use of swiotlb. All of the secondary VM memory, including those
allocate by swiotlb driver, is private to it. An additional piece of memory is
available to secondary VM which is shared between VMs and which is where I need
swiotlb driver to do its work.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
