Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFAEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE0F42075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgHUNnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:43:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:47124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727843AbgHUNnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:43:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 342BFACB8;
        Fri, 21 Aug 2020 13:43:30 +0000 (UTC)
Date:   Fri, 21 Aug 2020 15:43:00 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [Regression] "iommu/amd: Relax locking in dma_ops path" makes
 tg3 ethernet transmit queue timeout
Message-ID: <20200821134300.GM3354@suse.de>
References: <4E9B03FB-9DA5-4831-B4CE-A0AA645D3F22@canonical.com>
 <20200518133209.GM8135@suse.de>
 <381D21C9-C913-4C33-A6F4-0440B5D11670@canonical.com>
 <8D375E06-A763-4B5E-9C6D-DA5EBC62530E@canonical.com>
 <CFC22DE4-E342-4F32-B758-6A690755C498@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CFC22DE4-E342-4F32-B758-6A690755C498@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai,

On Mon, Jun 29, 2020 at 08:33:22PM +0800, Kai-Heng Feng wrote:
> I am still seeing the issue on v5.8-rc3. The issue goes away as soon
> as "iommu=off" is added.

Can you probably help with debugging this issue? I've had no luck so far
getting my hands on a machine with tg3 hardware and an AMD IOMMU.

Regards,

	Joerg
