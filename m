Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1768DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E518A206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594806782;
	bh=Zktt8IwpQMvAvcmw2Xuw7LZZo1eXS6/bq5wvTKh+plQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eTuzyZmkK+3BZTNel6l+RjNfxsjwYGeAOf75q0++wtjIkp9dG/2+N8XNYlrSMWII3
	 FH2U0SRuqbAGb4kdOWNxtF7D6NWqrTuBDIFIWAWn1clVpV4xYSQ0FMw6hj05GGkiM7
	 mAn74X+Hr6ZHe1vkR5S78PxNBfUjXRZ2x6rYpCg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbgGOJxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:53:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730583AbgGOJxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:53:01 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 118E72064B;
        Wed, 15 Jul 2020 09:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594806781;
        bh=Zktt8IwpQMvAvcmw2Xuw7LZZo1eXS6/bq5wvTKh+plQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WOlqo0z5UOzgF3o9oDU21nPM8kRjRB1xb2oldRbhwhYLOuZvoVIrpNDudvHohuSDh
         WQOFNZH2q4voB3GUUFcDJfgieuaTFdEtR1qQexb1nzxzCaL7glyDHQ4e55bIO4UGnv
         Y6mpBpO+7d+OpaNQz06jeZC5rvshxLg+mCr12VXE=
Date:   Wed, 15 Jul 2020 15:22:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, slawomir.blauciak@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 0/2] soundwire: sdw.h: fix PRBS/Static_1 swapped
Message-ID: <20200715095256.GG34333@vkoul-mobl>
References: <20200714213744.24674-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714213744.24674-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-07-20, 05:37, Bard Liao wrote:
> Fix PRBS/Static_1 swapped definitions and indentation in sdw.h

Applied both, thanks
-- 
~Vinod
