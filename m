Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFE9C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E61C24692
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgCJLXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:23:35 -0400
Received: from 8bytes.org ([81.169.241.247]:50822 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgCJLXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:23:35 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A6D8F364; Tue, 10 Mar 2020 12:23:33 +0100 (CET)
Date:   Tue, 10 Mar 2020 12:23:32 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-remoteproc@vger.kernel.org, ohad@wizery.com,
        agross@kernel.org
Subject: Re: [PATCH 0/3] Request direct mapping for modem firmware subdevice
Message-ID: <20200310112332.GG3794@8bytes.org>
References: <20200309182255.20142-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309182255.20142-1-sibis@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 11:52:52PM +0530, Sibi Sankar wrote:
> The Q6 modem sub-system has direct access to DDR through memnoc and
> an indirect access routed through a SMMU which MSS CE (crypto engine
> sub-component of MSS) uses during out of reset sequence. Request direct
> mapping for the modem-firmware subdevice since smmu is not expected
> to provide access control/translation for these SIDs (sandboxing of the
> modem is achieved through XPUs engaged using SMC calls).

So the DMA accesses are initiated by the firmware and need to be direct
mapped? Which memory region do they access?

Regards,

	Joerg

