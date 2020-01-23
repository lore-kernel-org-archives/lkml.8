Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A519DC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BEB214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579789060;
	bh=aBxSUr/gjynePT84F3DyY+Db2ohisB0vJNv4FgKtc7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2vRoxrOWfUNKTQcrF+LVRg5O2sl6+K+BY6ctoSjLkHKQBj4RoR8Ay3Z5V9TUR0uu8
	 rx+DbHMbZg18UygOe/uKLsx9ioDp3Ew27bRflNQPy+/rog6so/2DqayCG3Wypsdncc
	 c/wFPQOrAgcrltAmwGlRUO5DpHa+AtwDDR3fquTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgAWORj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 09:17:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:52162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgAWORj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 09:17:39 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FDC320718;
        Thu, 23 Jan 2020 14:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579789058;
        bh=aBxSUr/gjynePT84F3DyY+Db2ohisB0vJNv4FgKtc7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w63LnevdSdZAkY4eBt+Wa2NXfG7LtIuPnDdxzREo7fPXI6REGhdaIQN5/SX4bzgII
         /j3MDnlDjlQhWWAJChsYrKoxruEBWmKdgD1tOikU5vlWe3mkmQyBPO83hdrmUkmGCY
         Z8CtCXqK/xF3EfSDl+iOy/oVMDLLyov1ls7KrLBQ=
Date:   Thu, 23 Jan 2020 09:17:37 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Iago Toral <itoral@igalia.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 5.4 003/205] drm/v3d: don't leak bin job if
 v3d_job_init fails.
Message-ID: <20200123141737.GC1706@sasha-vm>
References: <20200116164300.6705-1-sashal@kernel.org>
 <20200116164300.6705-3-sashal@kernel.org>
 <cb93a21557216d1b389390c556f421132aac88f0.camel@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cb93a21557216d1b389390c556f421132aac88f0.camel@igalia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 08:25:30AM +0100, Iago Toral wrote:
>Hi Sasha,
>
>
>please notice that there were two separate patches that addressed the
>same issue and applying both simultaneously leads to a double free
>(which is what I see is happening with this patch: see the second call
>to kfree(bin) right below the one added here). This issue was raised
>previously here:
>
>https://lists.freedesktop.org/archives/dri-devel/2019-October/241425.html

I'll drop this patch for now. Any idea why upstream didn't pick up the
fix yet? I see the problem still exists there.

-- 
Thanks,
Sasha
