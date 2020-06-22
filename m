Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5BDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CBDA20732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592825874;
	bh=lTqhDw3Cd5G+/fDtevGJJEA+nU1N8tNEJV1wtaYsQMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rQLU/YpaRzbrfnV5kc5qaeYLglmSBtnVl5yYmqZ6hnKbVJVONxBmiU1X6rWT9FPKA
	 mTXiRkAwdSKvdXevZZPCUetH+PAo3FbkhzSiXWp73UfQA+CgOFf+5pjWWEd/Ahf4yf
	 OfMODAuaI2VG13C519PYvJI4SNAt/abq68C7zVrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgFVLhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 07:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbgFVLhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:37:52 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33E9F2070E;
        Mon, 22 Jun 2020 11:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592825872;
        bh=lTqhDw3Cd5G+/fDtevGJJEA+nU1N8tNEJV1wtaYsQMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1GzAflToXP3J6cUJt2uRC77c4kvkEndBxv8QJDh5qmMjyEXG/2uyr8znnNdGwf2qp
         v5Mx1DM0+tuNJqnvgWaWRQQdcZ7Lud1tP9oywQeEOD6ONYr8GQGAf9SYLOSsg39+Np
         RSWtnc1MFfp56BzZEAr2hsODeX4/UUIT9xIJPeKM=
Date:   Mon, 22 Jun 2020 17:07:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, slawomir.blauciak@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: bus: clock_stop: don't deal with UNATTACHED
 Slave devices
Message-ID: <20200622113747.GI2324254@vkoul-mobl>
References: <20200531151806.25951-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531151806.25951-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-05-20, 23:18, Bard Liao wrote:
> We don't need to do anything for the slave if it is unattached during
> clock stop prepare and exit sequences.

Applied, thanks

-- 
~Vinod
