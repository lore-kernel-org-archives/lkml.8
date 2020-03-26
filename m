Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DA1C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852EE2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585235546;
	bh=39YFqBA/iJuWa5ADd6XMv4viTdNuFwmWvDAdaPeea1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j4fFcEEqHIDSdjA/Qjb86jKscfY0OSYVp6sknnaZTFYPBDCd7SGp6qoG+3ZwyhwLW
	 ZLK9bbbgDj6SV4wt5SNAdbnF7b22nef3ZjEBDRP2n0tHBjckDw39p2T/qnPprEjwyI
	 OxKffPyiINuGiqwtfJEtuj6V1xbusUG9TQkLGcHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgCZPMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:12:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgCZPMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 11:12:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1AEB206F8;
        Thu, 26 Mar 2020 15:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585235545;
        bh=39YFqBA/iJuWa5ADd6XMv4viTdNuFwmWvDAdaPeea1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kpk77p+Mx9sZ5lG2ymWwMZ8mWBk6Tse0ZNm35PUK0F3k06EVy5eT0XlSAtZwWA/MW
         n+twRkj9cUHWYQZtlPowlvfpsrocDxxWpw2C1ItmlmS2nteGefzKowWPcmrAkHCsu2
         a0k3Io5zp+eVogZ8aJd7eYWCEuIiDlWIjrmpi+u0=
Date:   Thu, 26 Mar 2020 16:12:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        guohanjun@huawei.com, Sudeep Holla <sudeep.holla@arm.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v4 06/16] iommu: Move iommu_fwspec to struct dev_iommu
Message-ID: <20200326151222.GA1530064@kroah.com>
References: <20200326150841.10083-1-joro@8bytes.org>
 <20200326150841.10083-7-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326150841.10083-7-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 04:08:31PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Move the iommu_fwspec pointer in struct device into struct dev_iommu.
> This is a step in the effort to reduce the iommu related pointers in
> struct device to one.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Tested-by: Will Deacon <will@kernel.org> # arm-smmu
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/iommu.c  |  3 +++
>  include/linux/device.h |  3 ---
>  include/linux/iommu.h  | 12 ++++++++----
>  3 files changed, 11 insertions(+), 7 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

