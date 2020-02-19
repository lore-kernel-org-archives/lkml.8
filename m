Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E47C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67046207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgBSKJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 05:09:16 -0500
Received: from 8bytes.org ([81.169.241.247]:54842 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgBSKJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:09:15 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A44F5346; Wed, 19 Feb 2020 11:09:14 +0100 (CET)
Date:   Wed, 19 Feb 2020 11:09:13 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iommu/amd: Disable IOMMU on Stoney Ridge systems
Message-ID: <20200219100913.GA1961@8bytes.org>
References: <20200210075115.14838-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210075115.14838-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 03:51:15PM +0800, Kai-Heng Feng wrote:
> Serious screen flickering when Stoney Ridge outputs to a 4K monitor.
> 
> Use identity-mapping and PCI ATS doesn't help this issue.
> 
> According to Alex Deucher, IOMMU isn't enabled on Windows, so let's do
> the same here to avoid screen flickering on 4K monitor.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Bug: https://gitlab.freedesktop.org/drm/amd/issues/961
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied, thanks.

