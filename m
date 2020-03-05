Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56035C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2514320870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 09:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="OmQvqiWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgCEJeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 04:34:24 -0500
Received: from mout.web.de ([212.227.17.11]:49817 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgCEJeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 04:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583400815;
        bh=7biBOxRckJ39aV+/ETWmeZBlWXIgMLraqVVwUKgXbuQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OmQvqiWADjN9maowEDZzC5FebyRX2qFmPQ7mzX1LuSEcACN3RvvkcxwlRWVdbAHBY
         6dd0Q7viMSER4+vjjROqBKN4KDf/QCZC/y5CaBwlfyzYKB346aX94tNKtaIAPfWaAI
         QRbcrRFyxcH0al45Oo+k+nbGBLr8Uyvjf9WB/hSo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.16.47]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M0hfO-1jV23d2kD0-00upCY; Thu, 05
 Mar 2020 10:33:35 +0100
Subject: Re: [v5] Documentation: bootconfig: Update boot configuration
 documentation
To:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <158339065180.26602.26457588086834858.stgit@devnote2>
 <158339066140.26602.7533299987467005089.stgit@devnote2>
 <ef820445-25c5-a312-57d4-25ff3b4d08cf@infradead.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3fb124a6-07d2-7a40-8981-07561aeb3c1e@web.de>
Date:   Thu, 5 Mar 2020 10:33:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ef820445-25c5-a312-57d4-25ff3b4d08cf@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:dDL9WEbWqXKKfr2w1raoJA0we/yi6MbjqqPA/LAxdkdXC2oW2OU
 dwj6TT6wdzaRybzN70AF4rcwQp0pG5ZNj9ACtjXod/CYyYIdLQTBqj/gDPxMYT12tDmDseO
 JLPHhyxjJ1gtj1xf7+MRAE12asoOOYsoU7cIsXvAPNbWlof9wHTHWmphEKlfQ4kwlc5xX9V
 4vI4oEArGn2lNxy8EEFUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kf526ytFE4k=:vQAbKrdSDXGY6Buhz+OGha
 0nJm4kj4kA4KjPqeK79o1bmQ0l/y8YfcChOaN+vz4IgYhfAt4zd3jhQnJ0TzWtldGVXcsbsk7
 5Zm5URGusBxQDjyoxUrTiMfR3+2etg7Y5assi2GumeQzQbrf12moFiJa1cyxe2vV84Zs/pewU
 Dch8Vp86JUhjnBsH4Qu4F0zys/Dx1Ope11tuWAbQrkg18K3AIo9a3ElKIZBFLkxtsdODgWsqi
 W5oojYe7gorPTYELw1PyhWjGBp9t8qZYtPxh3sFv1mh/cFvaJHHcw9u7b4hxemFtsip/lzPfb
 u4wfg+02LkxaMkRadJDB+uUMbn6KpEu9r2MKQ+7Ah8gbF1971eFaAKD8TOeq9IYYSSQzEH0Up
 d+vX+IIagQZtviMQqbqBsORkr6CPE1kyy/ymQCUBrZDEHs9JyP040IBOv0O9EX8oDOL3hwWoC
 VsGhFPAvfgW3lKP6ipWCRIEAeXUzwIvpi+3zaTIVEYaNkmkLiXCwBiB2BhnEJbHJ9I+mRZWaZ
 Wtjgk7MaT0RDoCFTD0OFX/1od6Tz6NyeXAiUaluFjiZ6Sgt+PAgAfAZNszjtDveZsQpQdYle7
 9+Xs6/l84imzbLI7U4kvUGOoVK+Uq+TVcH9EnTwFfjZ5ZjHRDngFGHvNu1eXwb6Q5XJVDUaDN
 s8sdnl7SMc8G1C6d1wAcJ3WCDfAUzVLaKcR/rIew/XmcitwoSra/PbYklAO8hcJZjqcPbvxFg
 5JF1JrH59V+d4xsplzyqGh0dEofDL+0N+vbyJWs1O/heAnHTy9hrqzR/CczpM4S87v/moSmbA
 nzFEqwnmJ68iRd6/aJbPIEMHon3mjpXvf3K/itCJU4/HpI8FMQAvSenR9U8IhYFBalXWmlb3o
 bYnaQhVinUML2FEqQU2unbFycCRLoRqJrKL1nRnnQnyU4H7vjONzHSNF4qiNbfX1CHsbd91l4
 ozRj4tlc8n51yMaS4tkGkQZf3/4w2r/1FyRwC8K68RjbUdOu7vE7TijDy6CsRWxlG1QylPblc
 LirMWrb5JPaKnW+J+WpwPtZvlGKdQZWse3kZr0hG4uUleVzk4jRqx2iNlVSKFIzPwZJMtp/Kj
 RXRekzSUEpBHgKL5DUMJYdDV3Y+bjU9f+4jl+CLKeE7KftEJ2w+PlF46EZLfpToY6gWDX9J70
 i7+z/MYCcpfbPhDW0ei/cUBVJ3gyb7f0iGK9yPUbXvcg/i1uJfPtOOok392MIrS6joalw/sGi
 enY9fm0h/TB2n24bT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

How does this feedback fit to known concerns around the discussed wordings?

Regards,
Markus
