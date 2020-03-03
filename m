Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE02FC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E152146E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="oFr7Llwf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbgCCGyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 01:54:14 -0500
Received: from mout.web.de ([212.227.15.4]:41071 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbgCCGyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 01:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583218369;
        bh=Tw6WiExerKH3MYiejQXgfAi8Kj6gQGvgXqA0l7ZIMQY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=oFr7LlwfL6Moph+Knido1xTrSjOI+lmXQvJUR9ZDzbi7XibS13kp1X3wftTv4U3DL
         axHrL8MKKSL32lX5tjXiH0Vilv7aid+HoaegqAOKns3WM4FYiHU3mue6XI1X1aoVMV
         /Ii0xhlbCvYqubhK8sa2xszCQarjVHgFiSWXfkOw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.62.7]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MAdX1-1jFqvK2RNz-00Bvgl; Tue, 03
 Mar 2020 07:52:49 +0100
Subject: Re: [v3] Documentation: bootconfig: Update boot configuration
 documentation
To:     Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
References: <158313621831.3082.9886161529613724376.stgit@devnote2>
 <158313622831.3082.8237132211731864948.stgit@devnote2>
 <8c032093-c652-5e33-36ad-732f73beabab@infradead.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <12200e6e-2ef0-a0e4-9d92-35d7150342d2@web.de>
Date:   Tue, 3 Mar 2020 07:52:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8c032093-c652-5e33-36ad-732f73beabab@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:Ri05URW0Gf7ouLqfc7nIJOjM23BryCaIGtcbrWNx4VnmoH5MvUY
 y7Tc8/Roll1Rv5yCuoiEsgXf5xoN4hg3guGQHMQv5vox0vUR7nsd7JVHKA9IO4zT2ZUjzzF
 CSnLDr6YH0LdOz+e7IdKnNy7ztZJzAQfbeh+m6kxSAGgNCSC7ypT+3YmV2vWEXyFg/Zk4lr
 9xM8E0thhSztHU9BHH9Pw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VQ3eeP0xYvo=:Vs4HSsGJqhz59b/40aAE6w
 2r9O0jR+ZGb211ABVUshbRfTq7B86pPbSozFqlffTXsvl807d6wd6aennxucPij4SfbIqxiY0
 NjOfwH7361LfEukgLSHmvntfipYMhYxFCvSrLC+ClNxCPxTd75UNJ+sL2qcXcdjhdA3h84434
 A+mm4WKhWMDm8kuRmzOryOF7SPvps2UOQqFYd51OHzb3RQ40sM6IMzF6OOo8w2mO4Mae+BZN7
 GOKN3OIuRp/pKNteNP9+vftLKIoTAEYnRilSA/Ex2Yh9x0YyhTAxISFpUKo0p9cEpJ5Ov9f/O
 mxxxOx5s1lELiSzF+C0dowrxM2SjlFEM4Cl2uVNhDqLghOHEyAn7qVhk8WJVeXXY8u8tQDvKp
 1INsk2GQhe35jA6pXb0LgkFNdWCz1GbvfwIWoE9JX2gWtsHz45LLzByic2+LlLa0hozMM0XIB
 S7tIsMQ1S2ogtNjuk0NDz6S0B2RAhjLuicJcdDOgb47MtlRVubC8v7FqYQUTEayR0AN6vP/mX
 kmDBEyMhZNdF4e5qjnYly3tnc0MrWqH+HDIONVUpsQa7uTiW1lUneVt03ZGMKjDbxSabnRzjR
 OMdEudNjxBuZgBWccmvCmEL13QJ0+veUx6M+Kb1qM8xgCS8oafcFpgvLeRpgOihxOvoT42I8W
 8JT4crlDzzCDTQ0PmllCcS3bbM/R8HcAsEieTvzqTpvKNWyGqieqgekOPdQdK/N5ypnkFRUeO
 eIqev6ii5eN/P6fHZ1te9GVYHiU2GPh0Bb7pavrRJz5asKtfJLSd4OIqRtd9pgxs0BB1+sD0x
 XWJsFobvATt5f2rlWUFMkSj0Ara6Ac0xBPR9gqZJoUwe2bZlxmMNR66ncFm8yEAs52uTAfODa
 PUA56jt0lcmqbzOycc5N3FMeyQ19gNN9hq8duzeiCoSOzg9PMpw3E8/w/duwDPH+Gq+zB9Ui/
 iwp8BE1YqIxHfkHQtv5WxAytiLQAKwPLuhs3Cap8KPl9ICwpt0H+0yYUOVBC/lAWr02KqBr2j
 yC5+yH4syVvMXGh4Se5zeeYYyXPA3WTNt68XpA5P1EDnhYNLzToX6wSG9GHchrJlJJv/8VRuv
 4ENJClDmTWQhozcUlgcmv8umKNmnR3oh7/L3hfllu1bPI5WQ1XlPMv4VYCpEtKVdxc5TByYv4
 Ymyk63Ri9/uHIS1bcJ562CnXB9zMrkwyd5zXuiSVoiH9gIe5rTF2c03dzKjpO33+n3BDtG6XQ
 /xhMC2hbg6ZWlO9HP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> All of the other changes look good to me.

I suggest to take another closer look.
Would you like to help with the clarification of any remaining
software documentation concerns?

Regards,
Markus
