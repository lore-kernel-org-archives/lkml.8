Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED8FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4660520758
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589872804;
	bh=1jT1W/ydU3BqDCVDDCoHvLnrD4Q3FZCE3wKld24qVyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Euc2p1fbACEQF22z7mSDh61RYEJce1uNeXWzWl0itbUJ53hyAGlg4/QeAplQK50PL
	 MlqNsD7Ta1xbS+u+ixlzOiy4Gnd/bzu7aVc0oUQyzQ451NRNb+Pa6l8H/Yu9469zfG
	 GuoJu9EIIR776NlR8uzUVzBthh/Y5U+S1cI9gdpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgESHUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 03:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbgESHUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 03:20:03 -0400
Received: from localhost (unknown [122.182.207.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 078DF2070A;
        Tue, 19 May 2020 07:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589872802;
        bh=1jT1W/ydU3BqDCVDDCoHvLnrD4Q3FZCE3wKld24qVyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ezelM7YRbWjKGsyjoXVM4BMEeOFteFw61AqTzP6YRmQ8uAVepkgKUD9zMj+sPd8eC
         quTaErEsn9RcpPmrFRXzz4SK8W98ocgbGVj1x0QoraK7CNWX485vAA6ZBaPwnCrjLb
         PcI6ovYqwax9tAWHyUVga4J3dnNGF3DWMx4mNfbg=
Date:   Tue, 19 May 2020 12:49:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, slawomir.blauciak@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH v2 0/5] soundwire: bus_type: add sdw_master_device support
Message-ID: <20200519071958.GL374218@vkoul-mobl.Dlink>
References: <20200518174322.31561-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518174322.31561-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-05-20, 01:43, Bard Liao wrote:
> This series adds sdw master devices support.
> 
> changes in v2:
>  - Allocate sdw_master_device dynamically
>  - Use unique bus id as master id
>  - Keep checking parent devices
>  - Enable runtime_pm on Master device

I tested on RB3 board and it looks good to me, Applied all now.

Thanks for the good cleanup :)

-- 
~Vinod
