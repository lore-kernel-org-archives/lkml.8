Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795EDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5765120776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgE2Pi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgE2Pi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:38:26 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1B7C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 08:38:26 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BEBD850C; Fri, 29 May 2020 17:38:23 +0200 (CEST)
Date:   Fri, 29 May 2020 17:38:22 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        jroedel@suse.de
Subject: Re: [PATCH 01/10] iommu/amd: Move AMD IOMMU driver to a subdirectory
Message-ID: <20200529153822.GH14598@8bytes.org>
References: <20200527115313.7426-1-joro@8bytes.org>
 <20200527115313.7426-2-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527115313.7426-2-joro@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 01:53:04PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The driver consists of five C files and three header files by now.
> Move them to their own subdirectory to not clutter to iommu top-level
> directory with them.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  MAINTAINERS                                          | 2 +-
>  drivers/iommu/Makefile                               | 6 +++---
>  drivers/iommu/{ => amd}/amd_iommu.h                  | 0
>  drivers/iommu/{ => amd}/amd_iommu_proto.h            | 0
>  drivers/iommu/{ => amd}/amd_iommu_types.h            | 0
>  drivers/iommu/{amd_iommu_debugfs.c => amd/debugfs.c} | 0
>  drivers/iommu/{amd_iommu_init.c => amd/init.c}       | 2 +-
>  drivers/iommu/{amd_iommu.c => amd/iommu.c}           | 2 +-
>  drivers/iommu/{amd_iommu_v2.c => amd/iommu_v2.c}     | 0
>  drivers/iommu/{amd_iommu_quirks.c => amd/quirks.c}   | 0
>  10 files changed, 6 insertions(+), 6 deletions(-)
>  rename drivers/iommu/{ => amd}/amd_iommu.h (100%)
>  rename drivers/iommu/{ => amd}/amd_iommu_proto.h (100%)
>  rename drivers/iommu/{ => amd}/amd_iommu_types.h (100%)
>  rename drivers/iommu/{amd_iommu_debugfs.c => amd/debugfs.c} (100%)
>  rename drivers/iommu/{amd_iommu_init.c => amd/init.c} (99%)
>  rename drivers/iommu/{amd_iommu.c => amd/iommu.c} (99%)
>  rename drivers/iommu/{amd_iommu_v2.c => amd/iommu_v2.c} (100%)
>  rename drivers/iommu/{amd_iommu_quirks.c => amd/quirks.c} (100%)

Okay, so there were a lot of conflicts creating my next branch after this
patch-set was applied, so I skipped this patch to make resolving them a
bit easier.

I will send out this patch again separatly together with a patch doing
the same for VT-d and merge it directly into the next branch I will send
to Linus.


	Joerg
