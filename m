Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F463C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 12:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC85207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 12:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579176232;
	bh=KtX5tJKy5Hk3+x2VzUvP3+AgfvpKUSFz7vDwZZvkPO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NEcyeRKpxRLQ41jvHOV5FKPc2KhTx44cgot3mn0S24FQd4O44yO/luxXQaDMcnRcS
	 XavG0LzOzkgDwbumQrnO/EJvYIWqCDjor6RCzVLJNvC4rPbq7o3+YfuENJlUrQ8NSH
	 8ndpdOcYtSNyEJR1KcZdtx1sHW5xFSVAcjvxcoWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgAPMDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:03:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:48774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgAPMDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 07:03:50 -0500
Received: from localhost (unknown [223.226.122.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49FC920663;
        Thu, 16 Jan 2020 12:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579176230;
        bh=KtX5tJKy5Hk3+x2VzUvP3+AgfvpKUSFz7vDwZZvkPO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jKjXit/0EUNKfr25VxztK6cSK/DlonwNmDSBhZMLAbORjYVE/+GZ3eAQs2zAAvjcU
         Ch9tr6BUblYK4vlYJtdBjjVJw3fmV+RRQpruB/WUC69HKqCRJPnReedsfiSef+tx/S
         e3F/mCoBt68OtSTFrdJytuEGq1NHpTqOxOvncTtw=
Date:   Thu, 16 Jan 2020 17:33:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] soundwire: intel: report slave_ids for each
 link to SOF driver
Message-ID: <20200116120344.GO2818@vkoul-mobl>
References: <20200110220016.30887-1-pierre-louis.bossart@linux.intel.com>
 <a70c54c0-c691-d8eb-4f99-da1bb9306c2f@linux.intel.com>
 <20200114062605.GD2818@vkoul-mobl>
 <7a2e514c-edd1-fbeb-3ebb-df289c7436e2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a2e514c-edd1-fbeb-3ebb-df289c7436e2@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-01-20, 10:05, Pierre-Louis Bossart wrote:
> On 1/14/20 12:26 AM, Vinod Koul wrote:
> > On 10-01-20, 16:31, Pierre-Louis Bossart wrote:
> > > On 1/10/20 4:00 PM, Pierre-Louis Bossart wrote:
> > > > From: Bard Liao <yung-chuan.liao@linux.intel.com>
> > > > 
> > > > The existing link_mask flag is no longer sufficient to detect the
> > > > hardware and identify which topology file and a machine driver to load.
> > > > 
> > > > By reporting the slave_ids exposed in ACPI tables, the parent SOF
> > > > driver will be able to compare against a set of static configurations.
> > > > 
> > > > This patch only adds the interface change, the functionality is added
> > > > in future patches.
> > > 
> > > Vinod, this patch would need to be shared as an immutable tag for Mark, once
> > > this is done I can share the SOF parts that make use of the information (cf.
> > > https://github.com/thesofproject/linux/pull/1692 for reference)
> > > 
> > > Sorry we missed this in the earlier interface changes, we didn't think we
> > > would have so many hardware variations so quickly.
> > 
> > do you want the tag now..? I can provide... We are already in -rc6
> > and i will send PR to greg later this week...
> 
> yes please, I'd like to send the SOF patches this week as well.

Applied now and pushed tag 'sdw_interfaces_2_5.6' for this, thanks

-- 
~Vinod
