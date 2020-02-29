Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E352C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 03:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6233D246A2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 03:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582948004;
	bh=8/1smc8j49MqGwnYGm26WRCBSJWhdGq3Kci/+iykrSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bNnkx069IfxjTSzpDDYFjKD/h2gir1VCcG8P8P5/v1ds6sRM2aM8YwAj8QItGcOe6
	 MkPKO4KG3d0Bcob2H6jtywbRkZ87uhk6ijj9pQi32XYonNpOU4RzAuWITFxFSHaWRD
	 VSr/S/z1zQySkUMERrJm6oRpDCMWweBg2Nfx887I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgB2Dqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 22:46:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:34490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbgB2Dqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 22:46:33 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9291B246A2;
        Sat, 29 Feb 2020 03:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582947992;
        bh=8/1smc8j49MqGwnYGm26WRCBSJWhdGq3Kci/+iykrSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fxl3/WvriTf1bPawKq/fakfqWDP7xNiZ9q2n81QEpCC2VqfIXzfzZBzMYIevtKdar
         l8dE+NaRFs76WuF4/klGRkJpGjwjRj1RCOO2duaOnAf3uw/S+Pb7HUhcGSNafPQ8CB
         ZdYL8o9L2kUmpwTaKgIQjUVxfkKISrLyinPt8MgI=
Date:   Fri, 28 Feb 2020 22:46:31 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 4.14 111/237] tty: synclinkmp: Adjust indentation in
 several functions
Message-ID: <20200229034631.GH21491@sasha-vm>
References: <20200227132255.285644406@linuxfoundation.org>
 <20200227132305.054909944@linuxfoundation.org>
 <11c17de7c525997ddddab995223828bdec8e8e93.camel@perches.com>
 <20200228071239.GC2895159@kroah.com>
 <a81f6072c8adfc5343fbc249f355c9ea5ced698e.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a81f6072c8adfc5343fbc249f355c9ea5ced698e.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 10:06:45AM -0800, Joe Perches wrote:
>On Fri, 2020-02-28 at 08:12 +0100, Greg Kroah-Hartman wrote:
>> On Thu, Feb 27, 2020 at 07:55:49PM -0800, Joe Perches wrote:
>> > On Thu, 2020-02-27 at 14:35 +0100, Greg Kroah-Hartman wrote:
>> > > From: Nathan Chancellor <natechancellor@gmail.com>
>> >
>> > I believe these sorts of whitespace only changes should
>> > not be applied to a stable branch unless it's useful for
>> > porting other actual defect fixes.
>>
>> I want to get clang build warnings down to the same level that gcc build
>> warnings are, so that they become useful in detecting new issues.  That
>> is why I add these types of patches to the stable trees.
>
>New issues should be found in the current kernel.

Right, but we're talking about issues with backporting patches. We catch
a lot of issues where a patch applied to an older version, but is
missing stuff or is outright incorrect by having the compiler warn us
about it.

We're not trying to debug upstream, but rather to catch broken backports
that compile but are broken.

>Backporting whitespace changes is value-free.

The value here is to make other errors obvious.

-- 
Thanks,
Sasha
