Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D8CC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D3A20812
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590347010;
	bh=Mq59j8ehq3CwHIvV0e9bLb39zHdc2gtg/vFQ35A74Xc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=DPhsfQJQR9qX+6Bt8A89cP7kzcNGia4RckY6Yu9StuJ5cPYlYsJ67Mny5pPAduaA5
	 sycaIVP/4XDHaZARs5jejPNAh/KKzWdQNcJLBznOk1Ah+YBG413wltPg8cLN5op8TM
	 XQRRT0eWd5ToLALGnywghW7eRkuCYr7RvBlkkoyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388107AbgEXTD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 15:03:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388085AbgEXTD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 15:03:29 -0400
Received: from [192.168.0.50] (89-70-52-201.dynamic.chello.pl [89.70.52.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BF6E2076C;
        Sun, 24 May 2020 19:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590347008;
        bh=Mq59j8ehq3CwHIvV0e9bLb39zHdc2gtg/vFQ35A74Xc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TuUTZ9suN+FFAN3w+WA2Bkdzw0y7tuhWEIUHtcnflF7x0lao+v5s+KRhz07qfY6F9
         hRcbcOS/amhv1LcGlUX1ABdQHcG1aZH5PTuV4uVNvAA+j3dqhj4EJ0O65upC8TjvAM
         Mb+47d7mJ1+nVlnjEwNJGay6wrujIW/9m1Ah+q34=
Subject: Re: [PATCH V2] media: s3c-camif: fix missing disable in
 tegra_adma_probe().
To:     wu000273@umn.edu
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjlu@umn.edu
References: <20200524034616.31625-1-wu000273@umn.edu>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <9b1cdd76-1fbf-c66b-a8e1-929ce2aba791@kernel.org>
Date:   Sun, 24 May 2020 21:03:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200524034616.31625-1-wu000273@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/24/20 05:46, wu000273@umn.edu wrote:
> From: Qiushi Wu <wu000273@umn.edu>
> 
> "pm_runtime_enable()" was not handled by "pm_runtime_disable()"
> after a call of the function “pm_runtime_get_sync()” failed.
> Thus move the jump target “err_pm” before calling function
> "calling pm_runtime_disable()".
> 
> Fixes: babde1c243b2 ("[media] V4L: Add driver for S3C24XX/S3C64XX SoC series camera interface")
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>
> ---
> 
> V2: improving commit messages.

Thanks for the patch. It seems you have got typo in the subject line.
With tegra_adma_probe changed to s3c_camif_probe feel free to add:

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
