Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115B8C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A4D20720
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgBENYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 08:24:23 -0500
Received: from 8bytes.org ([81.169.241.247]:51190 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbgBENYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:24:22 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E3966371; Wed,  5 Feb 2020 14:24:20 +0100 (CET)
Date:   Wed, 5 Feb 2020 14:24:16 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Christoph Hellwig <hch@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge systems
Message-ID: <20200205132416.GA22063@8bytes.org>
References: <20191129142154.29658-1-kai.heng.feng@canonical.com>
 <20191202170011.GC30032@infradead.org>
 <974A8EB3-70B6-4A33-B36C-CFF69464493C@canonical.com>
 <20191217095341.GG8689@8bytes.org>
 <6DC0EAB3-89B5-4A16-9A38-D7AD954DDF1C@canonical.com>
 <CY4PR12MB13505BE6EFF95F7C48253120F7520@CY4PR12MB1350.namprd12.prod.outlook.com>
 <84CFD1EE-2DB7-451F-98E4-58C4B0046A81@canonical.com>
 <C4ADFDF0-8252-412A-8CFE-8E5ACE853B0A@canonical.com>
 <6B7AE45E-F1E0-4949-B3E6-B78658CD223F@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6B7AE45E-F1E0-4949-B3E6-B78658CD223F@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 06:10:11PM +0800, Kai-Heng Feng wrote:
> Since using identity mapping with ATS doesn't help,
> Is it possible to merge this patch as is?

Can you please re-send the patch to me after 5.6-rc1 is out?

Thanks,

	Joerg
