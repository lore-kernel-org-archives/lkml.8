Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF28C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40FCC2076E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597641472;
	bh=o0q7tl4rHZdWHTfZ5A5s/CaiQ+c8gJ5bAqhU391FTzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dG+60jTirFmiGbmwCBq24IOgnakyM2a9KJ1/KWn2UjZZCVsBsKLtrj8N5VbUGXmi+
	 jgcIEmaBgNuOJjyb/tBhXIScD6j4B691pnSwwAxFFrmhGNHou+m45ZiVWCmMexCMnD
	 pZwoB0YxixqyJHf4ZnlXVyU6oH5rDsugFFUimFPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgHQFRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 01:17:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgHQFRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 01:17:49 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E6FE20758;
        Mon, 17 Aug 2020 05:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597641469;
        bh=o0q7tl4rHZdWHTfZ5A5s/CaiQ+c8gJ5bAqhU391FTzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZsHY7d+AdypJIQ7Ur+MpxpY5r1F9QsmSzvtLevZxmOQkppVd/RkbC+vtD2/aqSa90
         zLw1wDI8eLrIqXGqAhsalSNupaVSXppTTARVBBm5hyRhhkAZgAHIE9u6RfM9mkJm8r
         x4hkuGwEYZxs07KF3vj7wrNXzrBt1IEuFpQF/9zI=
Date:   Mon, 17 Aug 2020 10:47:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     dan.j.williams@intel.com, anup.patel@broadcom.com,
        ray.jui@broadcom.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH V2] dmaengine: bcm-sba-raid: add missing put_device()
 call in sba_probe()
Message-ID: <20200817051745.GG2639@vkoul-mobl>
References: <20200729124904.2541801-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729124904.2541801-1-yukuai3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-07-20, 20:49, Yu Kuai wrote:
> if of_find_device_by_node() succeed, sba_probe() doesn't have a
> corresponding put_device(). Thus add a jump target to fix the
> exception handling for this function implementation.

Applied, thanks

-- 
~Vinod
