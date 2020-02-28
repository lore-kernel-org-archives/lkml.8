Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC72C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51997246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582875174;
	bh=EJ819KBDu+k2dtkanbIAzQ59SFqTDwp5/gb56PSzO98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W++B1PMxsotz+RGGdTzZv+JLQp9OtgwDm6/whxhU37NKFSm+dw0OhefblzhjZQTYB
	 nJxlFQpgGU9u8RHQnytiYHPPkis8Vrh92Z1QwPJMmJ1fc11sgOcvg5AIklQ1eJo7zR
	 a7v3Rc36XHOOzOTBN12H4s5lGwCUo5Qw/jJetSE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgB1Hcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 02:32:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:44212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbgB1Hcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 02:32:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBD2F246A3;
        Fri, 28 Feb 2020 07:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582875172;
        bh=EJ819KBDu+k2dtkanbIAzQ59SFqTDwp5/gb56PSzO98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vpTK8H3PC+31WeXDZVDRv8EttvbleH1wcaGreWT5CjMg/9T8LYoDi2yjS9+Y33zO3
         jP3oHki6L93gMJK5J7kq4hjRyP3g8M7dqqQioVkMPt9t0c7j6sKa/Y84dDSCQe8ppJ
         7RsNJrhT1l1gaQr4bAC/HspSQtyYu2FkdDZdTxBc=
Date:   Fri, 28 Feb 2020 08:32:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>
Subject: Re: [PATCH 0/8] soundwire: remove platform devices, add SOF
 interfaces
Message-ID: <20200228073249.GB2898712@kroah.com>
References: <20200227223206.5020-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227223206.5020-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 04:31:58PM -0600, Pierre-Louis Bossart wrote:
> The first two patches were already reviewed by Greg KH in an earlier
> RFC. Since I only cleaned-up the error handling flow and removed an
> unnecessary wrapper, I took the liberty of adding Greg's Reviewed-by
> tag for these two patches.

That is fine, they still look sane to me :)
