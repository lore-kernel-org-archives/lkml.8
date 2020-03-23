Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FDBC54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD21A20732
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584943808;
	bh=p2fxI0BoeKeBhZDjBY9k99+ITPMG9PocWSW1DgnC9Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VlQ4Gu13R3l30ESEhkdCHuyz18BsV9zeh0po9kWMigSXmRaeikBx+FcC2eB88ELE4
	 SLTMeFXszHatw4hWudA/oORIhD8tWG1Jxhi7hhKwXSOt/p9g2Pdc8fgzZbbEIWWyak
	 +iC4440YNgwQRIp3HEX9Up/f2bM82BYwTrcSJkIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgCWGKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 02:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgCWGKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 02:10:07 -0400
Received: from localhost (unknown [171.76.96.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18CC1206C3;
        Mon, 23 Mar 2020 06:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584943806;
        bh=p2fxI0BoeKeBhZDjBY9k99+ITPMG9PocWSW1DgnC9Gk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IgzSf0d5fJc4y8kIIarGEJChH6ijxNpMhMOAzwZ6ZtJGUrY6mlV2rDVeEIEu2sYej
         9CGKJ3tx3VsXUcuaWIRC1fmykNVpqDFzFYpWRQlki8D/1dNus+0VCMg+CCn7O/PEfX
         qgB5HuNDZQIbMcKEGaSYMWmZETkIf13Utgqejluo=
Date:   Mon, 23 Mar 2020 11:40:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fix spelling mistake "exceds" -> "exceeds"
Message-ID: <20200323061002.GE72691@vkoul-mobl>
References: <20200316091653.110984-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316091653.110984-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-03-20, 09:16, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are a couple of spelling mistakes in dev_err error messages.
> Fix them.

Applied, thanks

-- 
~Vinod
