Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3578FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0615B207D4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589976063;
	bh=gXYFaHeuywZQoNmnvlqACdAzkXGUwSDZXZb5EP2pMiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cs9gJxITwbJxesFg3WG1Wk9tRw8gG5Po0I0i+OFTJtQEHIOAOB84Ss7P31KgwksL5
	 eUNXSsLbgOa/SM3U0k3IqWKhZrNs/C/X+Pq2PTM6K5AUmdSI4VRzOIvUn5SzNzrVBg
	 scYcaws+1ToEgoBi9nrit0MMBv+XUIPkEQq67htY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgETMBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgETMBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:01:00 -0400
Received: from localhost (unknown [122.178.227.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 679E8207C4;
        Wed, 20 May 2020 12:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589976060;
        bh=gXYFaHeuywZQoNmnvlqACdAzkXGUwSDZXZb5EP2pMiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VYO/p4wI8rY36t3/yE5oS/yS8har9AXeP1B/N186MwodO+UOTFKHUu9k3L0Gubu4T
         gz+SX/wQBDxBSD1jV63ZPWSI1+mS2QZEXPOaCogm+pfug19Blh3D/PpmlTvgRHt8Dt
         N46onprz2D/Zbo8xYIp92FOYceNT0R9vInv8KEmQ=
Date:   Wed, 20 May 2020 17:30:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, slawomir.blauciak@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 0/3] soundwire: add sysfs support
Message-ID: <20200520120056.GW374218@vkoul-mobl.Dlink>
References: <20200518203551.2053-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518203551.2053-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-05-20, 04:35, Bard Liao wrote:
> Add soundwire sysfs support.

Thanks for this, I have applied these and two patches for issues I found,
one was trailing line in drivers/soundwire/sysfs_slave.c and other was a
typo (3rd patch)

-- 
~Vinod
