Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB911C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6BEE20767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595579520;
	bh=BAAMmdcl8MBCQ71JTfx1utpWjY3G2jmrQepewteeHXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QWoIHZE5wU1xK7ls8EekUJA1xgT+qj8DQ3fJb1rat4Axcj7/qUyAdGHLCz6hLQaJ1
	 H2W4UCweoRL2ghMlXEk3eHyA4MTbOH5N838tStxwkj7n/Hla4B/Op5M0jjyeUWeajb
	 Uu2f5jHlIPd8ncrUWa4zzFvZrJBSjKvAOc8XySTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGXIb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:31:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbgGXIb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:31:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FB372074A;
        Fri, 24 Jul 2020 08:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595579518;
        bh=BAAMmdcl8MBCQ71JTfx1utpWjY3G2jmrQepewteeHXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZGT38xYmi/QsrlypO30e8nsyAPaMYkv+GEQQ04BH2Uk/1ll43F3TkUBraFgKn7g5G
         kcJb5NWg8S1nJTu0bCmq0/QYSes0cybD0hkXHj30YVRkfpq33pt/5Wlawj3LQVF+Lb
         7a7wXC0fghwHfSPcymHguspk4kauAHuC27w6Reds=
Date:   Fri, 24 Jul 2020 10:32:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: master: enable pm runtime
Message-ID: <20200724083201.GB3977020@kroah.com>
References: <20200723134902.26290-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723134902.26290-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 09:49:02PM +0800, Bard Liao wrote:
> We should enable pm runtime.

Because why?

Please read the documentation about how to write good changelog
comments...

greg k-h
