Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27255C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69D7206F8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="bmOCDRLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390446AbgDCILa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 04:11:30 -0400
Received: from mout.web.de ([212.227.17.12]:35511 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbgDCILa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 04:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585901466;
        bh=k6J2jEGKoisrXybcQoX9kDnWMjeMUacwmJqi0bycATI=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=bmOCDRLg2dxEYtzaE0yeKdKSFCiCBNWffMnsNwDWWcpDpxpp49lQjmWm6r6NmERTo
         ukO0C/GNQV1KBLyzFzbyhyItu4l/BNNVpJBc38Be2UhT4KD7BTndlpWDXez5DcnFdU
         /dqrZ5fL4J7qqBuIi7yEu35GhNZHZ2CphjeDZT7o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.25.116]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LZvUH-1iv4Q03MxZ-00ljvM; Fri, 03
 Apr 2020 10:11:05 +0200
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mfd: asic3: Delete redundant variable definition
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Tang Bin <tangbin@cmss.chinamobile.com>,
        Lee Jones <lee.jones@linaro.org>
Message-ID: <b2a0e5f6-1f07-a7bd-2f3c-c95119efe635@web.de>
Date:   Fri, 3 Apr 2020 10:11:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:Mtwl+Pl+WeuFWGJMDcCAs1lUj5kQL/N5XRsr6LymSl5ZML1qLsj
 sUk9jjWp9l95Q3Miq4OapRNQMyjuzc3/oWsTim682Y8ZTxJG7P2TRzdfS2y9p00ujR4Lrhp
 yz9NJ2UaoNIKgDhGMOQsQ9K/JN6omSJPRojqPRvWlRYFIbUKL/nM7KLE5oMcPVA4ecTiTY9
 UBmQ1gAyRqJA3Ho5fm8rQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CIEcgQUqkn8=:igVXpffXKsM6wKJeYaw3e7
 u0pospGCGdGDF+ZZL6mmYN1Uw9jIGKcNbpup5pXZYsWpDnpvCD9jyaloBsBMF85pzklFBzj8h
 wYmtP7/hqgVXe7WokZ24g0M37pq0HeeggdaxUOTRokphh1BKZ4C6X46Ys02IJQLJsghsEVuKF
 y/JDlO5gi2KUG2wh+ttrhXIkNR8iliFqvHIfvaI3XZBJ/hICfI8Ww68RYtsGNfywAoDmUnzre
 dK2Xj9LFpHfoXPQPRY5b0oE2eSxSEKqX0VATFO4S2092FMLQGW6XLuudwgJz0fjD3yeTh+Z27
 b+KQXdkWKq7m07BRtt52oQBqR/zEzvjUYWqfdt8O7GQL+hU9Ob1OfxPMHj/ePQXnz5fCkp14q
 SyRmThkYihOTyTh+Z0jRYIObcchBCZA4hLzsJDkBZ+qVxw626cZnCDDUsnMuyvbKVNUC1F89K
 eupwpo35y0bDpiinGfGkTcuU9WsJNDlzEEEGecvVsoMexQJQASE6xJEJw4H0tMcF60eQqqIoy
 IybbrC5xoXs/wNQs/x4kO310R1O/XCQyLuy+BkFW+l3DFrSlrs25k9GyBuxkc7o0/rHzYJkAF
 junCHF4pcYnYf1nlZMJKh5kJ0G3DYHGLpSUvte6LhZykAzZNd59BXopMIVG/8rSCognVkqQ4m
 Pcwo8op0K1lxIs8AMv5ewmAckHe1XNfq2RYLUAPjNPeo1rN8RlbY4K9cCs1iIBJioU8tOI5u8
 5r+sXFz74oA22SeuQpy6cPcYe8lYHcQFfDr4hvdWO6l5c7cY0SC9HTAKH2SC5Ue0RJLfite3j
 byV4z6e3yTFUmj14afZncjtf9SjE/4U35Im4HFu8Hu+NGy5FCdQ5s94Yt3+v/MfKcT4iMcWmP
 yNvJSzqkQ4J9SYZgCns4apuHsFUw4lo1vAUfpJSJbFGuiZvqCO0CMvD3cyHbF6Ma7YGez3/Mi
 P8z2BDLpplyiiFi/wCXeR0vFJ+CWD2CXvMl0BKmOE11n9gFs9Vdany53Im8hZoJRRdXsq5Wjw
 6mzFPhn47OzqDgJwcO17f5sg+5UJzSm0x6+mu17BsUEv/h60PN24gKTH218mGsTbVE9+MvX9t
 hTcQGPBoMSxx1or/eCOFI/du3uMxPoIbTeBz9KWUZZCzaHOOh8P3N+mpr+QwIbHAQ1ulYdhS8
 QjpQs9yVzerTSFWS3vjjCVN2SRlmqhRjKCINDY+P2Zg4OPwj7Kni8Aqc0iFK04RZU89eFN4Rw
 xY2xssix49xjECP8d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In this function, 'ret' is always assigned, even if 'pdata->leds'
> don't carry out,

I notice possibilities again to improve such a commit message.


> it has already been assigned a value in the above code, including '0',

The variable assignment will eventually be performed only in if branches.


> so it's redundant.

I suggest to reconsider this interpretation of the source code here.
Would you like to move the mentioned statement into an else branch
at the end?

Regards,
Markus
