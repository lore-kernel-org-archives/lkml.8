Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B93C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6A020730
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgAQKVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:21:55 -0500
Received: from 8bytes.org ([81.169.241.247]:60138 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgAQKVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:21:54 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 11BFA327; Fri, 17 Jan 2020 11:21:52 +0100 (CET)
Date:   Fri, 17 Jan 2020 11:21:51 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] iommu: Preallocate iommu group when probing
 devices
Message-ID: <20200117102151.GF15760@8bytes.org>
References: <20200101052648.14295-1-baolu.lu@linux.intel.com>
 <20200101052648.14295-4-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200101052648.14295-4-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2020 at 01:26:47PM +0800, Lu Baolu wrote:
> This splits iommu group allocation from adding devices. This makes
> it possible to determine the default domain type for each group as
> all devices belonging to the group have been determined.

I think its better to keep group allocation as it is and just defer
default domain allocation after each device is in its group. But take
care about the device hotplug path which might add new devices to groups
which already have a default domain, or add new groups that might need a
default domain too.

Regards,

	Joerg

