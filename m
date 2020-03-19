Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80990C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8B420732
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584602002;
	bh=nGwFrB1PzqeUqXfvl6pxCdc1NBj97fWXvdQEAtR0opc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EC/PE6sY0Y5otlkb8pF/vX+J+tbZNLmkzyzNHjzV4u1NcFzmRdwhn2rrgHbgOw/CC
	 MI6J/05sOpxRsF9QNz17u33bOPpGJGtzQf/O+dXGRUpeahSw3KVc6/WEsKY7hbKKwa
	 JWaZilsZGtOHOz/K6/PQ6WkqELORvZB4s6zrbiLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgCSHNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 03:13:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbgCSHNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 03:13:20 -0400
Received: from localhost (unknown [122.167.78.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F51B20724;
        Thu, 19 Mar 2020 07:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584602000;
        bh=nGwFrB1PzqeUqXfvl6pxCdc1NBj97fWXvdQEAtR0opc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZLC6xwLtb16a3HMBrddm/hJSPfqqaUjJmMgTpxMw7qVd9/tbhV2DxqBuE4qWTo/jV
         QVqs2eayqeu3/FwVGVENAKy+o7xP9WbAXbT3ovM/V23ymQq0p7VET8WYEA9vwy+MCZ
         MY5rQtsrWUGioLaprb+nBPY1G5uUXYVny3yZ95bY=
Date:   Thu, 19 Mar 2020 12:43:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>
Subject: Re: [PATCH v2 00/17] SoundWire: cadence: add clock stop and fix
 programming sequences
Message-ID: <20200319071313.GX4885@vkoul-mobl>
References: <20200317163329.25501-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317163329.25501-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-03-20, 11:33, Pierre-Louis Bossart wrote:
> To make progress with SoundWire support, this patchset provides the
> missing support for clock stop modes, and revisits all Cadence Master
> register settings. The current code is for some reason not aligned
> with internal documentation and hardware recommended flows,
> specifically for multi-link operation.

Applied, thanks

-- 
~Vinod
