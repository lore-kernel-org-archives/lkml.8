Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A09CC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D002C20717
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583209653;
	bh=wec0exl0v7HgaU9UoBDCKH81fbyruX6Vo7KCx1wEh6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pIg/5TVMrUG1fw5nmTyj+9mK4RZZNewl/vV/reFP9w1IDWN5zbK9cVgKHbPPR3Znj
	 PGQMmkz6JY9WyWCl8Rzbxn6QPapiX4Vlv2XyidkE2oVPSnPD9fF5Oa7di+B1AITXsL
	 VaD0h9Yf+GkiAkhyTkK6e9lOgaHKDYrYat4490JM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgCCE1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 23:27:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:38442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbgCCE1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 23:27:32 -0500
Received: from localhost (unknown [122.167.124.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B15420716;
        Tue,  3 Mar 2020 04:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583209651;
        bh=wec0exl0v7HgaU9UoBDCKH81fbyruX6Vo7KCx1wEh6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=peJK4Xre0j6FhExptNv8lg6WNvc7bWEo9Malm3Zg6DMS4ZfOcPL7YdeKGZGwoSDnu
         kJucDS7ala/jY6W7cbmTjNLy+ANKTondJ4LwblKFSUJ1pu+Okfzhe04LDglidVoZTx
         VHZXQGsg1poqvFLh6pdjvbtO8gqmcExpBwo1VgpU=
Date:   Tue, 3 Mar 2020 09:57:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, geert@linux-m68k.org
Subject: Re: [PATCH v4 1/2] dmaengine: Add basic debugfs support
Message-ID: <20200303042725.GM4148@vkoul-mobl>
References: <20200228130747.22905-1-peter.ujfalusi@ti.com>
 <20200228130747.22905-2-peter.ujfalusi@ti.com>
 <20200302071146.GE4148@vkoul-mobl>
 <7b4f244d-0855-f979-414d-e2d3cb0f0c2f@ti.com>
 <be7d4df5-121b-0eec-b68c-fa3b5cffc8c9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be7d4df5-121b-0eec-b68c-fa3b5cffc8c9@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-03-20, 13:53, Peter Ujfalusi wrote:
> 
> 
> On 02/03/2020 12.28, Peter Ujfalusi wrote:
> > Hi Vinod,
> > 
> > On 02/03/2020 9.11, Vinod Koul wrote:
> >>> diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
> >>> index e8a320c9e57c..72cd7fe33638 100644
> >>> --- a/drivers/dma/dmaengine.h
> >>> +++ b/drivers/dma/dmaengine.h
> >>> @@ -182,4 +182,10 @@ dmaengine_desc_callback_valid(struct dmaengine_desc_callback *cb)
> >>>  struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
> >>>  struct dma_chan *dma_get_any_slave_channel(struct dma_device *device);
> >>>  
> >>> +#ifdef CONFIG_DEBUG_FS
> >>> +#include <linux/debugfs.h>
> >>> +
> >>> +struct dentry *dmaengine_get_debugfs_root(void);
> >>
> >> this needs to have an else defined with NULL return so that we dont
> >> force users to wrap the code under CONFIG_DEBUG_FS..
> > 
> > Drivers would anyways should have their debugfs related code wrapped
> > within ifdef. There is no point of having the code complied when it can
> > not be used (no debugfs support).
> > 
> > But I can add the  else case if we really want to:
> > 
> > #ifdef CONFIG_DEBUG_FS
> > #include <linux/debugfs.h>
> > 
> > struct dentry *dmaengine_get_debugfs_root(void);
> > 
> > #else
> > struct dentry;
> > static inline struct dentry *dmaengine_get_debugfs_root(void)
> > {
> > 	return NULL;
> > }
> > #endif /* CONFIG_DEBUG_FS */
> 
> It might be even better if the core creates directories for the dma
> controllers in dma_async_device_register() and removes the whole
> directory in dma_async_device_unregister()

hmmm, i think makes sense and dentry can be part of dma_device

> 
> Then drivers can get their per device root via:
> #ifdef CONFIG_DEBUG_FS
> static inline struct dentry *
> dmaengine_get_debugfs_root(struct dma_device *dma_dev) {
> 	return dma_dev->dbg_dev_root;
> }

right!

> #else
> struct dentry;
> static inline struct dentry *
> dmaengine_get_debugfs_root(struct dma_device *dma_dev)
> {
> 	return NULL;
> }
> #endif /* CONFIG_DEBUG_FS */

-- 
~Vinod
