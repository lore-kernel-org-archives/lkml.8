Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E39C76199
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 00:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5676D20726
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 00:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581898008;
	bh=gVWmyfqTnw1WJsietsaBjsko8jXoww3QXkt4qXMXUyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ia1Ncz8R3u21PB0mvWb8RKSvgMXo/7WgY++lVlhCUfiUQZrficPA30IzjzvKyNJvF
	 w5DvLSeCd9rKeI4PhiEfGnRzDJkOzZ8x1c2KebjSx3u7FchMxnOJ3WjwUSCVQ8EZyr
	 hOtvs+JscX3jwFM7ij49n4610mTWk4MFTjhE3qS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgBQAGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 19:06:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgBQAGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 19:06:32 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A47E9208C3;
        Mon, 17 Feb 2020 00:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581897991;
        bh=gVWmyfqTnw1WJsietsaBjsko8jXoww3QXkt4qXMXUyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BU6rH900fpic038GMNAWg32Tdbcib6vdKfVFjIIyWwrY/6/tu7JAlCfT7CQuTA6ld
         zyeAKH+AyOoMXo9XEidNtKxrtQ2SxMAEv0x+ZiHxLJPj5w5teB2pnXXqPeXViiyCsz
         VGbmHR7E1xWBchQJwtBr7mLGKKujabUJnfRCHDbM=
Date:   Sun, 16 Feb 2020 19:06:30 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Jean Delvare <jdelvare@suse.de>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.5 495/542] docs: i2c: writing-clients: properly
 name the stop condition
Message-ID: <20200217000630.GK1734@sasha-vm>
References: <20200214154854.6746-1-sashal@kernel.org>
 <20200214154854.6746-495-sashal@kernel.org>
 <20200215071402.027c9120@endymion>
 <dfb3d313-ad9e-8f53-a7f6-d3bfe655d493@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <dfb3d313-ad9e-8f53-a7f6-d3bfe655d493@lucaceresoli.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2020 at 10:49:39PM +0100, Luca Ceresoli wrote:
>Hi,
>
>On 15/02/20 07:14, Jean Delvare wrote:
>> On Fri, 14 Feb 2020 10:48:07 -0500, Sasha Levin wrote:
>>> From: Luca Ceresoli <luca@lucaceresoli.net>
>>>
>>> [ Upstream commit 4fcb445ec688a62da9c864ab05a4bd39b0307cdc ]
>>>
>>> In I2C there is no such thing as a "stop bit". Use the proper naming: "stop
>>> condition".
>>>
>>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>>> Reported-by: Jean Delvare <jdelvare@suse.de>
>>> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>>> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>>> ---
>>>  Documentation/i2c/writing-clients.rst | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/i2c/writing-clients.rst b/Documentation/i2c/writing-clients.rst
>>> index ced309b5e0cc8..3869efdf84cae 100644
>>> --- a/Documentation/i2c/writing-clients.rst
>>> +++ b/Documentation/i2c/writing-clients.rst
>>> @@ -357,9 +357,9 @@ read/written.
>>>
>>>  This sends a series of messages. Each message can be a read or write,
>>>  and they can be mixed in any way. The transactions are combined: no
>>> -stop bit is sent between transaction. The i2c_msg structure contains
>>> -for each message the client address, the number of bytes of the message
>>> -and the message data itself.
>>> +stop condition is issued between transaction. The i2c_msg structure
>>> +contains for each message the client address, the number of bytes of the
>>> +message and the message data itself.
>>>
>>>  You can read the file ``i2c-protocol`` for more information about the
>>>  actual I2C protocol.
>>
>> I wouldn't bother backporting this documentation patch to stable and
>> longterm trees. That's a minor vocabulary thing really, it does not
>> qualify.
>
>I also feel no need to have it in stable branches. Hovever it would not
>hurt, so whatever is fine for who's maintaining that branch will be fine
>for me as well.

No, you're right, this isn't stable material - I've missed it during
review and I'll drop it now. Thanks for pointing it out.

-- 
Thanks,
Sasha
