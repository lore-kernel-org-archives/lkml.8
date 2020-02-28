Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA71C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 23:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109D7246AE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 23:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582934226;
	bh=dkYKagcsSoeod0Wak+oWXNlsvhP3pNGkAlKGBk3qjZ0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=d+veDmGkDFyR4FM4RxqM8snTg9VT8UgqmfrkyFEmUoJvaBQQAUV0r//6KZQtqFVRh
	 lHz3BZTZUz7z/caP1VN4booVAHaTLIhA0/msyySyiMEmP0/mMT4O8WT4QEcWSbYGlZ
	 TZ/NMcD3FaGA9lKasqWyplcfez4rsetiAYlPjBh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgB1X5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:57:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgB1X5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 18:57:04 -0500
Received: from [10.92.140.22] (unknown [167.220.148.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EAB72469F;
        Fri, 28 Feb 2020 23:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582934223;
        bh=dkYKagcsSoeod0Wak+oWXNlsvhP3pNGkAlKGBk3qjZ0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bJjAMkQNm76eKzmefp3WXLalyyiyl5sFAB6+/yzr46y24Ix/eUnbkwaBynnjGF+gq
         kjSiyjgWJR+sGnkP7T1CRHuOQe8OkHCEkNRpR1NuoB2AcptNYQGFB/YisCljg4bXm6
         y0A/wn4ip8pFwfA7VcwuHR1e4bo/yA0foTExmJSE=
Subject: Re: About commit "io: change inX() to have their own IO barrier
 overrides"
To:     John Garry <john.garry@huawei.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     "xuwei (O)" <xuwei5@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com>
From:   Sinan Kaya <okaya@kernel.org>
Autocrypt: addr=okaya@kernel.org; keydata=
 mQENBFrnOrUBCADGOL0kF21B6ogpOkuYvz6bUjO7NU99PKhXx1MfK/AzK+SFgxJF7dMluoF6
 uT47bU7zb7HqACH6itTgSSiJeSoq86jYoq5s4JOyaj0/18Hf3/YBah7AOuwk6LtV3EftQIhw
 9vXqCnBwP/nID6PQ685zl3vH68yzF6FVNwbDagxUz/gMiQh7scHvVCjiqkJ+qu/36JgtTYYw
 8lGWRcto6gr0eTF8Wd8f81wspmUHGsFdN/xPsZPKMw6/on9oOj3AidcR3P9EdLY4qQyjvcNC
 V9cL9b5I/Ud9ghPwW4QkM7uhYqQDyh3SwgEFudc+/RsDuxjVlg9CFnGhS0nPXR89SaQZABEB
 AAG0HVNpbmFuIEtheWEgPG9rYXlhQGtlcm5lbC5vcmc+iQFOBBMBCAA4FiEEYdOlMSE+a7/c
 ckrQvGF4I+4LAFcFAlztcAoCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQvGF4I+4L
 AFfidAf/VKHInxep0Z96iYkIq42432HTZUrxNzG9IWk4HN7c3vTJKv2W+b9pgvBF1SmkyQSy
 8SJ3Zd98CO6FOHA1FigFyZahVsme+T0GsS3/OF1kjrtMktoREr8t0rK0yKpCTYVdlkHadxmR
 Qs5xLzW1RqKlrNigKHI2yhgpMwrpzS+67F1biT41227sqFzW9urEl/jqGJXaB6GV+SRKSHN+
 ubWXgE1NkmfAMeyJPKojNT7ReL6eh3BNB/Xh1vQJew+AE50EP7o36UXghoUktnx6cTkge0ZS
 qgxuhN33cCOU36pWQhPqVSlLTZQJVxuCmlaHbYWvye7bBOhmiuNKhOzb3FcgT7kBDQRa5zq1
 AQgAyRq/7JZKOyB8wRx6fHE0nb31P75kCnL3oE+smKW/sOcIQDV3C7mZKLf472MWB1xdr4Tm
 eXeL/wT0QHapLn5M5wWghC80YvjjdolHnlq9QlYVtvl1ocAC28y43tKJfklhHiwMNDJfdZbw
 9lQ2h+7nccFWASNUu9cqZOABLvJcgLnfdDpnSzOye09VVlKr3NHgRyRZa7me/oFJCxrJlKAl
 2hllRLt0yV08o7i14+qmvxI2EKLX9zJfJ2rGWLTVe3EJBnCsQPDzAUVYSnTtqELu2AGzvDiM
 gatRaosnzhvvEK+kCuXuCuZlRWP7pWSHqFFuYq596RRG5hNGLbmVFZrCxQARAQABiQEfBBgB
 CAAJBQJa5zq1AhsMAAoJELxheCPuCwBX2UYH/2kkMC4mImvoClrmcMsNGijcZHdDlz8NFfCI
 gSb3NHkarnA7uAg8KJuaHUwBMk3kBhv2BGPLcmAknzBIehbZ284W7u3DT9o1Y5g+LDyx8RIi
 e7pnMcC+bE2IJExCVf2p3PB1tDBBdLEYJoyFz/XpdDjZ8aVls/pIyrq+mqo5LuuhWfZzPPec
 9EiM2eXpJw+Rz+vKjSt1YIhg46YbdZrDM2FGrt9ve3YaM5H0lzJgq/JQPKFdbd5MB0X37Qc+
 2m/A9u9SFnOovA42DgXUyC2cSbIJdPWOK9PnzfXqF3sX9Aol2eLUmQuLpThJtq5EHu6FzJ7Y
 L+s0nPaNMKwv/Xhhm6Y=
Message-ID: <c1489f55-369d-2cff-ff36-b10fb5d3ee79@kernel.org>
Date:   Fri, 28 Feb 2020 18:57:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 2/28/2020 4:52 AM, John Garry wrote:
> About the commit in the $subject 87fe2d543f81, would there be any
> specific reason why the logic pio versions of these functions did not
> get the same treatment or should not? I'm talking about lib/logic_pio.c
> here - commit 031e3601869c ("lib: Add generic PIO mapping method")
> introduced this.
> 
> In fact, logic pio will override these for arm64 with the vanilla
> defconfig these days.

We only looked at inX()/inY() and readX()/writeX() API because the
semantics of these API are defined in the kernel documentation.
We looked at how to generalize this so that there is a uniform
behavior across different architectures.

Is logic PIO subject to ordering issues?
How is the behavior on different architectures?

As long as the expectations are set, I see no reason why it shouldn't
but, I'll let Arnd comment on it too.

Sinan
