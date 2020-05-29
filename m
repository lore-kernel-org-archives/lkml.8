Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61236C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 442F6206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgE2NIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 09:08:40 -0400
Received: from 8bytes.org ([81.169.241.247]:45362 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgE2NIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:08:40 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 14C65327; Fri, 29 May 2020 15:08:39 +0200 (CEST)
Date:   Fri, 29 May 2020 15:08:37 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        jroedel@suse.de
Subject: Re: [PATCH 00/10] iommu/amd: Updates and Cleanups
Message-ID: <20200529130837.GC14598@8bytes.org>
References: <20200527115313.7426-1-joro@8bytes.org>
 <855af88c-66b2-29c1-a184-40d52592e38e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <855af88c-66b2-29c1-a184-40d52592e38e@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 07:15:13PM +0700, Suravee Suthikulpanit wrote:
> Thank you for cleaning up.
> 
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Thanks for you review, Suravee. Patches are now applied.
