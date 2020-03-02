Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4702DC3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB02246B4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583141090;
	bh=sRxuK443/SmO92erZi2ineFAz+CJF5wRLU3TMFhkAdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iwDobx9RbC9o5AGrcknNIDMp9xYDmIi6o9hLKLu+JtN+P+y9fjYI4m6/AIiRLZQpz
	 /om57/dq6hwv5xbXDJhVQvRnEv2lxC9159FHR++afNuopfJtBTCIBOG+w21OMvKmSH
	 pmvsEH71LZgqRjKvnxJp/Yy3etsrBSsj6TWGAzkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgCBJYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:24:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgCBJYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:24:48 -0500
Received: from localhost (unknown [171.76.77.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 750B624695;
        Mon,  2 Mar 2020 09:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583141088;
        bh=sRxuK443/SmO92erZi2ineFAz+CJF5wRLU3TMFhkAdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TqHbqJVzGE3ypoqI0Dm2v+eJ5EdlyTfYQ9S11WElrwOIfwMPISzMpXBSLqTeTX9X/
         9d+Mwo/agmz+q7SuIDwXNM0cJHBqOJYrZLFt/EHUxfDW/SumFSc0Plhs2i+4wtq9Mk
         3MJmYWJ8nZwP3y39AelOyEMVtA+30omCU6Wgqfz8=
Date:   Mon, 2 Mar 2020 14:54:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [RESEND PATCH v4 0/2] dmaengine: Add UniPhier XDMAC driver
Message-ID: <20200302092444.GJ4148@vkoul-mobl>
References: <1582271550-3403-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582271550-3403-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-02-20, 16:52, Kunihiko Hayashi wrote:
> Add support for UniPhier external DMA controller (XDMAC), that is
> implemented in Pro4, Pro5, PXs2, LD11, LD20 and PXs3 SoCs.

Applied, thanks

-- 
~Vinod
