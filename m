Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4E4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2544F20739
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594206870;
	bh=HuTn2+p7wIhJTjMMiQ1v3hdP2M2atw3I9rw/YACMxDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R0mxOTyn9giZooDZQi7m/CpvpbjmFAW4k8p7roJCE5lS44Wf0nmF81ObqvC1QQsxu
	 rNpyF3E2HaE4xz1YWROYhV8neYq9Im5tkfyovWpbVbe/ibbxPD4xPxrz+rjm/r5+Q7
	 HXj8QzwcnxN+O0TqNKCp774qmSMoE8MgYLJFdatU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgGHLO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 07:14:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgGHLO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:14:28 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86E9220739;
        Wed,  8 Jul 2020 11:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594206868;
        bh=HuTn2+p7wIhJTjMMiQ1v3hdP2M2atw3I9rw/YACMxDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0wfsx9LQy82GvY+kxArYcegb6A8taFC77/zCYSD265KrweGPDC1hbb6VP9UkOwq17
         6Fd5qcb18RPRUAmwTL+DRgz6v4ocx8/E7UTYRQgB5kCej9jXiwke5iVQicuQ9dz8EG
         TgKY8XEEmLaTQ3Q2g2DhQXJK1xBig4BKXSycRFdM=
Date:   Wed, 8 Jul 2020 16:44:24 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] phy: core: fix code style in
 devm_of_phy_provider_unregister
Message-ID: <20200708111424.GE34333@vkoul-mobl>
References: <20200629145010.122675-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629145010.122675-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-06-20, 20:20, Vinod Koul wrote:
> Documentation/process/coding-style.rst says:
> "functions: they have the opening brace at the beginning of the next
> line"
> 
> devm_of_phy_provider_unregister() function has opening brace at same
> line, so fix it up.

Applied all these
-- 
~Vinod
