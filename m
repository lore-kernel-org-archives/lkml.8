Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30ADC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBF72166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Q5z+7a5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgCDOqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:46:42 -0500
Received: from mout.web.de ([212.227.17.12]:39947 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbgCDOqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 09:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583333155;
        bh=xAUjkZMNEOqn9QzZ6yJY18Y9cdiyleYEzRzzT1vt4vY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Q5z+7a5orRBV/M1jMwz79QR18z6BENEHrtGrrZIvH97qOInoeEQAOAo1JaJ/Y7gWe
         quHTLfaYSbK7rNmtw0ceiFVPilalOmsO8ZCJ3oLeHT2ZmstRpcBONhBWVg2/Wnrnv4
         e9A5tfaAht/9fkoN1RRhOgAvIYU9H+e0JPpG3oDU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.53.147]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LtWo4-1jYhAF07W8-010y3V; Wed, 04
 Mar 2020 15:45:55 +0100
Subject: Re: [v4] Documentation: bootconfig: Update boot configuration
 documentation
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <158322634266.31847.8245359938993378502.stgit@devnote2>
 <158322635301.31847.15011454479023637649.stgit@devnote2>
 <ad1e9855-4c64-53bd-7da5-f7cdafe78571@infradead.org>
 <20200304203722.8e8699c2a3e0a979aae091b1@kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3a3a5f1a-3654-d96d-3b4a-dd649a366c65@web.de>
Date:   Wed, 4 Mar 2020 15:45:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304203722.8e8699c2a3e0a979aae091b1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5nKMEK3wVVfbImt4swlrePjgGoZjrYcXVt3rA+nTudbxA/HC3d1
 pldol/s0I3c0o/gM2+3e4lp7ynOI3juDUIMDxhARaMRvhrdgdG6MZI/Ta/+tZZIaocTvePW
 t1+PRJTVGpWsf0phuV8V7chq2e7NCl/d6S/+qi9x6uNyfFv2xyamViRJ9uJa4rhraNJG8LN
 JkRRlLqPZEHwClagNZyBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pSDlToBWnFQ=:d/pRe8hZlszIYUq9hSQqUR
 oU/hXaqAadbmr5BropZjUMlG0Ys0yzE0+SWzOMmVGTCzalkJOyu/gRYodufLlyyPkp0/xnowO
 fgjpHCqutOCpit2q2OfCC7i9FLDQURh7kHeWUbZalbl4bw3UvL6C1VFI3wnAqKTV5TXIbpPK3
 jo6OfK7i1ofZUhQ+XOw2G5xiwDhJ8BtfdQFMahWkAus+d6nxS7AuEwwbX/HUJIrd4FnU+5omT
 gmOzKVaTyGSE24GzDdr6/qMSE0tGIkcCjray+IrxZAeoJJaV2yhwi2Jxmo1yS7bFFbqxBRDVE
 CvA05cISw6UDzyeJp6pls+B4lrjxAclJrGmHTZaxeNvimEwAIiYsOIvOOkGa0S1/kgWGSfwHW
 r14++wFgc9wBMfQgQU0RAyUFozUvFH33ibq9LXyt0frtgOTmCAa5ffKW256tOcAMVmvf+es2k
 Ehk8HRtREitcJaefrKr7ct8WH8dJ2a3NvTBe66u68VrhDiwslurfhiw1xeRlYDlGAHzAyoJDF
 19BQEUuAx9lG+cwQOpmMi1Dc7RfIA/dWkth2lPzk3jb56eMnWgIqgI5Y4iV4hoki3BFalr6Kt
 iOEMVDhJxA1YbVZm3XYUCcGbMr9uqRHki4YvxktvAJHaV/8TGGuTG0wluTmwqBgcgaoHv3Er2
 M7jF1cEBOipLU4/7vijh/lDIGMaVlPmogBjQJLGn7TTJZatH9TURFzdHsFlVKDW3ZyrzOiNAy
 ICOXPdqsHPtVcA0MJ/pzxxLO0wBB8hu5Iqp9VqZazKGLfm6RGcxrE6Rl0ikphPzvR/PKFPwNJ
 7EXra8/FAl9fP4LERrTGDoPMfZqZIqY/KrYYBKKiK9NoDH5XPmIq20CVcGX5LX9ndeRto74hL
 S+paZ3yQMZJWCoUfrhYlrc3c4s+YRyiR+1tAlv8b4O/GVsZ5++KKjvY126SnHCqGQQf3VigsQ
 9W4XEfolj6tZxcEgFE/eMXBoUS3IPqCHTIuSRDvbYsF4HykyjUdUAJ2qfDh4kdCzWXnvItVug
 OFDIjZmcEImbHEJih4FtAYMf1P1V5kXuwGR8nvskNVp/1Yt786NLc2v51LDu1LSJZnAmgyQRk
 OieQgq6gj6vMS6+NoCpYyVmV9jtthNNgKvmx2Z2moTwixubrMDUqdq5xZMJsDXKfqpOjMLgJd
 w9u8zXhejfN3pgTU6PW4jBXtvD7w2rqkP4/NEhCtj1jdhGfHZgeAqItHofQiTLl7Nc1i2KHQ0
 NtGmYHPEUcJ28KikV
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What about the following?
>
> User can group identical parent keys together and use braces to list chi=
ld keys
> under them.

Another wording alternative:

The user can group settings together. Curly brackets enclose a configurati=
on then
according to a parent context.

Regards,
Markus
