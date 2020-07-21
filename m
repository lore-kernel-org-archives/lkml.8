Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED02C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B0332080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595327808;
	bh=KTkwwdcQ+kMR1Ovh51In5yyyZWyyGKxeo6iRpogCmQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jk9J9WMljyUziFkSgEA8UYX4iU80FIBQPFi/KOx1hjglyyuEyLENX1uU3u58Up2fR
	 t0t1WlmRWeLB8EVBMG8cP5THXvGPUgEDllaco3oaPiA/pcruDCPI15ZD94a17sTjCS
	 NtzqNrH8A17CZ7YlhiLLlw+s33oV2JZxnNCRDArE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgGUKgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:36:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgGUKgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:36:46 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5094D20714;
        Tue, 21 Jul 2020 10:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595327806;
        bh=KTkwwdcQ+kMR1Ovh51In5yyyZWyyGKxeo6iRpogCmQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XqLQAZJevKLtqk4QwiVs+jObnNMM+rNdITS4Fb6H+7sZaY9bsJ4X7U2c5z8Tpy1el
         l6x3F7zZHdVu1DlE8bQy1cL6Mjy0d0xfg1Zdn/rrXHLb1PvDiYMiBylorUSsf2Ti6T
         3EWgWBLNn8rxRzfffCg6kOimm214sxltDb7LikFg=
Date:   Tue, 21 Jul 2020 16:06:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, slawomir.blauciak@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH v2 0/9] soundwire: intel: revisit SHIM programming
Message-ID: <20200721103642.GL12965@vkoul-mobl>
References: <20200716150947.22119-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716150947.22119-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-07-20, 23:09, Bard Liao wrote:
> This series does some cleanup, revisits SHIM programming sequences,
> and merges Soundwire interrupt handlers/threads.

Applied, thanks

-- 
~Vinod
