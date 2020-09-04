Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B67C28E83
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2138206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgIDKGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:06:02 -0400
Received: from 8bytes.org ([81.169.241.247]:41090 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgIDKF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:05:59 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id DE4873D5; Fri,  4 Sep 2020 12:05:57 +0200 (CEST)
Date:   Fri, 4 Sep 2020 12:05:56 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     "jroedel@suse.de" <jroedel@suse.de>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] iommu/amd: Fix IOMMUv2 devices when SME is active
Message-ID: <20200904100556.GU6714@8bytes.org>
References: <20200824105415.21000-1-joro@8bytes.org>
 <MN2PR12MB4488D6B7BBF98845DF796E0BF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
 <34db343f-cd23-09af-3bc5-29b9d385f85d@amd.com>
 <MN2PR12MB4488BF7DDE700378F7B2776CF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200828134639.GW3354@suse.de>
 <60067932-dbf4-d67b-cf11-4dd2b016ed63@amd.com>
 <MN2PR12MB448849D3AD019749DB64A146F7520@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200828152943.GY3354@suse.de>
 <MN2PR12MB4488BE2F12F85BDBC91E2C0CF7520@MN2PR12MB4488.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR12MB4488BE2F12F85BDBC91E2C0CF7520@MN2PR12MB4488.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 03:47:07PM +0000, Deucher, Alexander wrote:
> Ah, right,  So CZ and ST are not an issue.  Raven is paired with Zen based CPUs.

Okay, so for the Raven case, can you add code to the amdgpu driver which
makes it fail to initialize on Raven when SME is active? There is a
global checking function for that, so that shouldn't be hard to do.

Regards,

	Joerg
