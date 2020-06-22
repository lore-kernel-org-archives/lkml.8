Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B690C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36DA720720
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592829101;
	bh=HKucR3qMyjkGIuv/CEcWoDelkdm9iYNzcU+Zrzv+ESM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tFLxdJBYOWPE5HocvZCLLre8CoybXMV7/GS+xxTIm9Dm8YTmGs5cnygmI24AvCxZ0
	 tXxnX6CAcAsN7L1ygoeIX0Fl2ejTIznbHDIO0Jp+Y0tx/KCrwPPrpt83wGJiZUXBGT
	 st/TBBlabNNOGbx85bh8BdPM3ATu4/wX897BKdBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgFVMbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:31:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbgFVMbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:31:39 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8167206BE;
        Mon, 22 Jun 2020 12:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592829099;
        bh=HKucR3qMyjkGIuv/CEcWoDelkdm9iYNzcU+Zrzv+ESM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cg7/4rIqO7T+pOhTZK0nEHsZnkTKN8Pzg7CR/klS/Xb9Jmz6dnbVhVYsV2E2iDE75
         R5JWrgv+QRmXHbRgBkgqrSYpgkQmYVKLnGZpCEFOYVRG9OKNEyhtXdYSe4oRGeojS9
         roaskBVIIb3HR4bCpAukPCXu83+M9Jc6+AmSMiWE=
Date:   Mon, 22 Jun 2020 08:31:37 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Wei Li <liwei391@huawei.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH AUTOSEL 5.7 130/388] ASoC: Fix wrong dependency of da7210
 and wm8983
Message-ID: <20200622123137.GG1931@sasha-vm>
References: <20200618010805.600873-1-sashal@kernel.org>
 <20200618010805.600873-130-sashal@kernel.org>
 <20200618110258.GD5789@sirena.org.uk>
 <20200621233453.GB1931@sasha-vm>
 <20200622101830.GA4560@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200622101830.GA4560@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 11:18:30AM +0100, Mark Brown wrote:
>On Sun, Jun 21, 2020 at 07:34:53PM -0400, Sasha Levin wrote:
>> On Thu, Jun 18, 2020 at 12:02:58PM +0100, Mark Brown wrote:
>
>> > This is purely about build testing, are you sure this is stable
>> > material?
>
>> Is this not something that can happen in practice?
>
>Not outside of build testing.

Okay, I'll drop it.

-- 
Thanks,
Sasha
