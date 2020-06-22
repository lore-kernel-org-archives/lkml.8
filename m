Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731A1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 528F62071A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592829082;
	bh=vUsQ4/bIHVn4jBo65OALfNI338jW6zMlkCy7dd1UtUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dJLKNPo7TH5An+LpjGbyLjAJ/If3rO21hdap5HReS9YlUZUPqenEGUMsNFRxUo/a5
	 Y3Lc2mVv7db5v7y41cA1rsrKDR9yF5JoB3PlJMOcxd7tVoRU1c3E3l+0i6VqamCQZ8
	 uUTb6ZDZ5fq5+pgnAonhg03zX1tlDZbfi01JKnEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgFVMbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:31:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbgFVMbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:31:20 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CA1B206BE;
        Mon, 22 Jun 2020 12:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592829079;
        bh=vUsQ4/bIHVn4jBo65OALfNI338jW6zMlkCy7dd1UtUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kQhewzvsjTq3cvPrzmIBgb5SttjfYpYAIvQ5Sk32Q6C8nxucZEc7myegU6NDew1Ql
         Om4NchBLWbGKl0T0gUerAdMSFOJno0IDf+H3x+a1YRaJx5M8asWcogxHQ6vTkHl6nl
         7gS0eiC95+Xni+DDX+Xb7uWSTTR/yN282ozy9BK4=
Date:   Mon, 22 Jun 2020 08:31:18 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.7 004/388] ASoC: tegra: tegra_wm8903: Support
 nvidia, headset property
Message-ID: <20200622123118.GF1931@sasha-vm>
References: <20200618010805.600873-1-sashal@kernel.org>
 <20200618010805.600873-4-sashal@kernel.org>
 <20200618110023.GB5789@sirena.org.uk>
 <20200618143046.GT1931@sasha-vm>
 <20200618143930.GI5789@sirena.org.uk>
 <20200621233352.GA1931@sasha-vm>
 <20200622112321.GB4560@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200622112321.GB4560@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 12:23:21PM +0100, Mark Brown wrote:
>On Sun, Jun 21, 2020 at 07:33:52PM -0400, Sasha Levin wrote:
>> On Thu, Jun 18, 2020 at 03:39:30PM +0100, Mark Brown wrote:
>> > On Thu, Jun 18, 2020 at 10:30:46AM -0400, Sasha Levin wrote:
>> > > On Thu, Jun 18, 2020 at 12:00:23PM +0100, Mark Brown wrote:
>
>> > > > This is a new feature not a bugfix.
>
>> > > I saw this patch more as a hardware quirk.
>
>> > Pretty much any DT property is a hardware quirk :(
>
>> Which is why we're taking most of them :)
>
>That's concerning - please don't do this.  It's not what stable is
>expected to be and there's no guarantee that you're getting all the
>changes required to actually make things work.

How come? This is one of the things stable rules explicitly call for:
"New device IDs and quirks are also accepted".

If we're missing anything, the solution is to make sure we stop missing
it rather than not take anything to begin with :)

-- 
Thanks,
Sasha
