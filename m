Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F66C33CB6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 07:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DB92253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 07:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579592553;
	bh=z0iKasSaDhTi7+F0plTQzE2JIf4RhD0ex4jeT4N6YTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kmbrM7g24D2ocmHptZtWYZmVfwlC6VUdmlGVBze8Xbi7Pm/rxDsFVBIKtpUWScPO4
	 tNSvWpNa0sI2nE2EBQ4SaaV1uSfE85Olx52J3yiakhlRM/yaYAQ7zxwASe9vMNjI4/
	 0ce3xqffZoODOBQureKIJTUXhLHg7N+FfTO5C5es=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgAUHmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 02:42:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgAUHmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 02:42:32 -0500
Received: from localhost (unknown [171.76.119.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5CCB2253D;
        Tue, 21 Jan 2020 07:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579592551;
        bh=z0iKasSaDhTi7+F0plTQzE2JIf4RhD0ex4jeT4N6YTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BCsn4lfrFfdVfMSBV8KxWz/q4g9hxiZqxPk2EjwV4MjJA+JQFB7wBb9QbKTqn3aN7
         RypFRDlJP8drL+XlYAZ/40cXcrg4yjFy1l+4yDWsLPzxfj84riT3rClwZRZqZhmcxj
         XWXZCNTkgtK3S4NGjBZx1HoynNLb2McnzDZEx9cQ=
Date:   Tue, 21 Jan 2020 13:12:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, grygorii.strashko@ti.com
Subject: Re: [PATCH] dmaengine: ti: k3-psil: Fix warnings with C=1 and W=1
Message-ID: <20200121074227.GC2841@vkoul-mobl>
References: <20200121070104.4393-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121070104.4393-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-01-20, 09:01, Peter Ujfalusi wrote:
> Fixes the following warnings:
> drivers/dma/ti/k3-psil-j721e.c:62:16: warning: symbol 'j721e_src_ep_map' was not declared. Should it be static?
> drivers/dma/ti/k3-psil-j721e.c:172:16: warning: symbol 'j721e_dst_ep_map' was not declared. Should it be static?
> drivers/dma/ti/k3-psil-j721e.c:216:20: warning: symbol 'j721e_ep_map' was not declared. Should it be static?
>   CC      drivers/dma/ti/k3-psil-j721e.o
> drivers/dma/ti/k3-psil-am654.c:52:16: warning: symbol 'am654_src_ep_map' was not declared. Should it be static?
> drivers/dma/ti/k3-psil-am654.c:127:16: warning: symbol 'am654_dst_ep_map' was not declared. Should it be static?
> drivers/dma/ti/k3-psil-am654.c:169:20: warning: symbol 'am654_ep_map' was not declared. Should it be static?

We dont use titles like this :(
A title should reflect the changes in the patch, I have updated this to
"dmaengine: ti: k3-psil: make symbols static"

and applied now

-- 
~Vinod
