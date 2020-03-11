Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C71CC18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134452146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583919008;
	bh=2FUHCqW2t4fYOxAPSeOyaauGmNpMQoDtDDJi5ocXgU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0RMBv5GItqHdmi0lJY/0mvqUYTArmJlX29iOZm2IHKAVIrw11zCg100v5W4sPqtUY
	 EXWKmZPEeieF2OHUDaIWN5dVOA31WA+L0O7MxWBVLrHFCZ8v9KlGKAFdqqPkxj3vgi
	 eukvuWGjsV7LXHV+QGaacNGLByyJpU5JJ2REDVY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgCKJaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:30:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728349AbgCKJaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:30:07 -0400
Received: from localhost (unknown [106.201.105.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB7CE20828;
        Wed, 11 Mar 2020 09:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583919006;
        bh=2FUHCqW2t4fYOxAPSeOyaauGmNpMQoDtDDJi5ocXgU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S2gvekh43x5kX8cOIsE8hTMTtUNMSUEYAjd/5vEWZiw0IzTzEKz+h1zaKPU3znKo5
         DGLJC755JpM5vSrIszko6IYhHqQ8w4CKBUAcSTYMPpvbkqGZCfyKapivgGRG2Vaoim
         f1npNR9h9/yxdtE7FW923AhUYRDXBXi+YcK2Uc9o=
Date:   Wed, 11 Mar 2020 15:00:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: rectify the INTEL IADX DRIVER entry
Message-ID: <20200311093002.GN4885@vkoul-mobl>
References: <20200307205737.5829-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307205737.5829-1-lukas.bulwahn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-03-20, 21:57, Lukas Bulwahn wrote:
> Commit bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data
> accelerators") added the INTEL IADX DRIVER entry in MAINTAINERS, which
> mentions include/linux/idxd.h as file entry. However, this header file was
> not added in this commit, nor in any later one.
> 
> Hence, since then, ./scripts/get_maintainer.pl --self-test complains:
> 
>   warning: no file matches F: include/linux/idxd.h
> 
> Drop the file entry to the non-existing file in INTEL IADX DRIVER now.

Applied, thanks

-- 
~Vinod
