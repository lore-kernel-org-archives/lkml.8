Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A41C55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4384A21569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587626087;
	bh=AeF70vTjq/9y5KRWZypXBHzN95lvMOJwni/xdASXw1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eLWracZJCmitbc6pjE9Ofiq5jkNLz0iPgKQ0XZQcb7XvDWnlJ+j9jw7rDJtre4+P+
	 tlWBoP0LWQCnkSoZiVaInEOgxxHdg1y1lMVdeLqNze5q+p5WfkZzstGpT30/fqP378
	 MF9IybMQsjCxClTDkari8Eb2crjBgujKTxX+c61E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgDWHOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:14:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgDWHOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:14:46 -0400
Received: from localhost (unknown [49.207.59.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4148020736;
        Thu, 23 Apr 2020 07:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587626086;
        bh=AeF70vTjq/9y5KRWZypXBHzN95lvMOJwni/xdASXw1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VLV1o6iIp8T62yj/19RiPP+bcpnSrswM5jx2Smm6g2siM7SFA/GdYHzQfiXi1HwH9
         I9kr4ke9O9tn5Dy4E0sSg3BD0iOJmRONvLfbug/57hohaIf8XSG5W7lVvr5etpDPS6
         04PLESsXM34ce6UvOoxE5z/DYOhlc+Z/YjWq7T1E=
Date:   Thu, 23 Apr 2020 12:44:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] dmaengine: mmp_tdma: Reset channel error on release
Message-ID: <20200423071442.GZ72691@vkoul-mobl>
References: <20200419164912.670973-1-lkundrak@v3.sk>
 <20200419164912.670973-5-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419164912.670973-5-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-04-20, 18:49, Lubomir Rintel wrote:
> When a channel configuration fails, the status of the channel is set to
> DEV_ERROR so that an attempt to submit it fails. However, this status
> sticks until the heat end of the universe, making it impossible to
> recover from the error.
> 
> Let's reset it when the channel is released so that further use of the
> channel with correct configuration is not impacted.

Applied to fixes, thanks
-- 
~Vinod
