Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF2EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D6B82067D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589805718;
	bh=7Gcl8CxLYUZqi40aBTR3CzPq6V4hTVndF7rtbs0NsKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PNvhoq8D/ZzQSNcq4lTXAZ5VnjXlMhlGOGGE05y/dggds1Nyqasq8GAH8XB5oRNP/
	 BIA6YrAwmSCTaKM3fxKSIrTutck/irEdLZric8gL7DA7QXV3G9hcuTL4JhZcFlp9Di
	 q4cVUieiknG6e01fiZ0VcmH2qNQ51p7FVMHYfq5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgERMl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 08:41:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbgERMl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:41:57 -0400
Received: from localhost (unknown [171.76.87.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F13F20674;
        Mon, 18 May 2020 12:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589805715;
        bh=7Gcl8CxLYUZqi40aBTR3CzPq6V4hTVndF7rtbs0NsKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c2vl74HVWltqdykYkY9wQ2gMCi6i7hMYErgYRr9fSziuAcw3XnEU6tWx+src0dtLw
         pQRwEBF6YG9WvSSs6ZxhWa91GDM1J/eIoVWBBuXBVU/lftiJBbmt7FvAOJK90fthsA
         b6HWai/3D3LRhaLr1OAE8z+NyYPnjVtOG0OPvR9k=
Date:   Mon, 18 May 2020 18:11:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, robh@kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        yixin.zhu@intel.com
Subject: Re: [RESEND PATCH v8 0/3] Add Intel ComboPhy driver
Message-ID: <20200518124145.GF374218@vkoul-mobl.Dlink>
References: <cover.1589530082.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1589530082.git.eswara.kota@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-05-20, 16:13, Dilip Kota wrote:
> This patch series adds Intel ComboPhy driver, respective yaml schemas
> 
> Changes on v8:
>   As per PHY Maintainer's request add description in comments for doing
>   register access through register map framework.
> 
> Changes on v7:
>   As per System control driver maintainer's inputs remove
>     fwnode_to_regmap() definition and use device_node_get_regmap()
>     
> Changes on v6:
>   Rebase patches on the latest maintainer's branch
>   https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git/?h=phy-for-5.7

Acked-By: Vinod Koul <vkoul@kernel.org>


-- 
~Vinod
