Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0B6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 003A7207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597828184;
	bh=j/5MhL8jVpiVpD6E73OAda1qxDp3tLUlTDQmNNuyZxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L6lJUKVQmEHZhh7jLkOmUkpN8T3W7c30DMX873hPBkYA8aDnun3lIjrzshKMEo65p
	 L7EOkoUUTi+cY9YOpgOD+DDPbmk/1G/HGpxXwvrmoc05GdHKXsbEJ7cDk+12KRAZpk
	 V5z7eFhuKz3jQf0BYMz4E+s7lmwxpFxNucVaH/XY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHSJJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 05:09:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgHSJJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 05:09:41 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 775572072D;
        Wed, 19 Aug 2020 09:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597828181;
        bh=j/5MhL8jVpiVpD6E73OAda1qxDp3tLUlTDQmNNuyZxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qr3bIqxWNUFuD835NztlDSqyhRNZjX8yop+MS5q/Mh5ICGApW8A0B6Q9erWx4a9H1
         qWpAr8KiGOHRVsVmiXAqnJXVs9C9WAztha5hZC/URGey4xS5bOin3ABdDKNR9sP+6B
         KvqQRjSUgYjpyJWY6Z3aclZCEyeS3AJAdUGLNpE4=
Date:   Wed, 19 Aug 2020 14:39:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH] soundwire: bus: fix typo in comment on INTSTAT registers
Message-ID: <20200819090937.GF2639@vkoul-mobl>
References: <20200817220933.17492-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817220933.17492-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-08-20, 06:09, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> s/Instat/Intstat/

Applied, thanks

-- 
~Vinod
