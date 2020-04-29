Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389E4C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FCA4206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="iCU++Bv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgD2Ke5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:34:57 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:40801 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726355AbgD2Ke4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:34:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588156496; h=In-Reply-To: Content-Type: MIME-Version:
 References: Reply-To: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=XB7BUC3ojRcHv6kGtFh287OR6Fh4f+iq/qyjT7C3JuI=; b=iCU++Bv+Fm9kHF8lUvT8DTEFvoU0HruoM+3/+9e1we4Bjb9Cw6nXeNuNdyq5zsbRqwrEyWbU
 b8xrHW5GY0ZKyyjD/LMk/y2j0s+wVN/Jyi3XuxYKIKaT14tyydmXF8q/OMZ8yWI3jB25UAna
 I6GpDJKVtQ3MILqLI9h/zjz/gF4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea9584a.7f04b35b6298-smtp-out-n04;
 Wed, 29 Apr 2020 10:34:50 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 77595C4478C; Wed, 29 Apr 2020 10:34:48 +0000 (UTC)
Received: from quicinc.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: svaddagi)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8502CC433D2;
        Wed, 29 Apr 2020 10:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8502CC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vatsa@codeaurora.org
Date:   Wed, 29 Apr 2020 16:04:40 +0530
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
Message-ID: <20200429103438.GF5097@quicinc.com>
Reply-To: Srivatsa Vaddagiri <vatsa@codeaurora.org>
References: <20200428174952.GA5097@quicinc.com>
 <20200428163448-mutt-send-email-mst@kernel.org>
 <275eba4b-dd35-aa95-b2e3-9c5cbf7c6d71@linux.intel.com>
 <20200429004531-mutt-send-email-mst@kernel.org>
 <b676430c-65b3-096e-ca48-ceebf10f4b28@linux.intel.com>
 <20200429023842-mutt-send-email-mst@kernel.org>
 <20200429094410.GD5097@quicinc.com>
 <20200429055125-mutt-send-email-mst@kernel.org>
 <20200429100953.GE5097@quicinc.com>
 <20200429061621-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200429061621-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael S. Tsirkin <mst@redhat.com> [2020-04-29 06:20:48]:

> On Wed, Apr 29, 2020 at 03:39:53PM +0530, Srivatsa Vaddagiri wrote:
> > That would still not work I think where swiotlb is used for pass-thr devices
> > (when private memory is fine) as well as virtio devices (when shared memory is
> > required).
> 
> So that is a separate question. When there are multiple untrusted
> devices, at the moment it looks like a single bounce buffer is used.
> 
> Which to me seems like a security problem, I think we should protect
> untrusted devices from each other.

I think as first step, let me see if we can make swiotlb driver accept a target
memory segment as its working area. That may suffice our needs I think.  A
subsequent step could be to make swiotlb driver recognize multiple pools.


-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
