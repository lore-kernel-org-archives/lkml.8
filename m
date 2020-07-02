Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397B8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13CDC20781
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593653910;
	bh=n7G0ZoHURaVvKPF/v5+VF5jUWoLBPpS7aaMeUI0BxxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gkHjKFVGAFO7xcVqSaeHb+9Qd6KffQEzS1n7KDHIVgiiBgMgBH1Df+eE9xBOtrqSz
	 7KwjTXVbZS0vUBIj8rGZ2Elce3F39OeAMJJiy2pJctEDanrLT6DHywVhZvKMvO/Un9
	 my80AJ4/zRCUMlpadiMAa22rDbQihw2ebzgVj3xs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgGBBi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:38:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbgGBBi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:38:26 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81F8920781;
        Thu,  2 Jul 2020 01:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593653906;
        bh=n7G0ZoHURaVvKPF/v5+VF5jUWoLBPpS7aaMeUI0BxxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ODSQGqWciKtxVmLPw1z3yEnnWnq9TTYPm32DqG5N75qs0ciVOGI2hZ1y776vbImln
         fsjbipDnZLiMV6RyYcRvkG5etAxCjXxpjD3nDQxnBrjWXVXhwDzGdiTaNf3PhAyvXo
         oiaRuAQ8g79/4FFhxsGBi/qNHqqfZsZixtNeHyHQ=
Date:   Wed, 1 Jul 2020 21:38:24 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.7.y 0/5] exfat stable patches for 5.7.y
Message-ID: <20200702013824.GH2687961@sasha-vm>
References: <CGME20200701232535epcas1p3787fa9426c087372556cba2fdb7232ac@epcas1p3.samsung.com>
 <20200701232024.2083-1-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200701232024.2083-1-namjae.jeon@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namjae,

On Thu, Jul 02, 2020 at 08:20:19AM +0900, Namjae Jeon wrote:
>Could you please push exfat stable patches into 5.7.y kernel tree ?

I've queued them up, however it would be much easier if for commits that
don't require any modification to allow backporting you would just
provide the commit ids in Linus's tree rather than the patches
themselves.

I do see that you had to modify this one:

>Sungjong Seo (1):
>  exfat: flush dirty metadata in fsync

In which case, a header in the commit message indicating the upstream
commit id would be appriciated. Something like this:

[ Upstream commit 5267456e953fd8c5abd8e278b1cc6a9f9027ac0a ]

Thank you!

-- 
Thanks,
Sasha
