Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BB8C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1431820848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Eukd0FXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgCCJrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:47:02 -0500
Received: from mout.web.de ([212.227.15.14]:44765 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbgCCJrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:47:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583228777;
        bh=11R2jOqIYJXhaV4wSIF7OZ+gfm8nLgTYGCTOFRg7x3E=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Eukd0FXAh9pCubLsP+U0+/kieK+XaLa2kKGHFEZWu+ZeXkoPCpGesnzC02bu+J2PH
         CsHoA61zz7+q+Z9dENub6ZEHn23O8iV9RokqLCWOitjmg2wnMq5huyS1s0pechjFCM
         1Y6kJobHfgIm3Qlj1K1Bp+2W45RiDErgaMnojM2Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.62.7]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MPowc-1j48BX0Hv0-00504t; Tue, 03
 Mar 2020 10:46:17 +0100
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
 <12200e6e-2ef0-a0e4-9d92-35d7150342d2@web.de>
 <d79b5810-7445-9c91-cd0f-99c45195ba3b@infradead.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <465b904e-8861-66b5-387f-ba36eaae76e8@web.de>
Date:   Tue, 3 Mar 2020 10:46:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d79b5810-7445-9c91-cd0f-99c45195ba3b@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:Al/INPzcG61+YRU7HyLd/wf3u5GoZIHh8MODdkS8yCwqGfpnur/
 usw0aGMxtDB84NxAyTx7VG3CfiQHjRc1PYryHj1dkujgrCm0iYDeIN6EMfWH1EYYyMevcWR
 klKvA174CE/bNGqy+3N3FIiUBh2p9+YR7LlJgepBuQpEyRwfQ5SE1hLW7lD45M3NUCUvlO3
 CYkmavNDgyCeJRfNiYzkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rGIbdiPT7as=:dbKApni4DjLkQieIQukod+
 BfVWyYjTIg/ttUPNmtcxd4VCLRFjlNG+HpsoF6tT9GzgUrkqgyVP+czSDDBIFxJlKCYC6nTIX
 HHFuSk1+TMEyC8KNYy+o2TpakaiApLvjoKg9kM0YkANUlHAGGbLihZ2GHTYbC3e4Plb4DRydq
 FgacDdQIIb3Qll7/6wRmrRUCjxLrY13prdTXIWsXkunwDna9BhzQoIeq3Cu5SOsy+61tQm30g
 fX0Ob1ZBubiBVpK/LA9YGfgbmm7P4ws2qBoYL4mDbr7PQqDdT9+J+RtWajPK6UaABR5lnElch
 JvT/XDFG2daF7bspLGWMcyz0l8WyaTrH9jGcaC1wnkTUp+M9evA9sAM3EK0MpbxlfhhOVIeoM
 /ciTU/aG/wA5/unDCR7mckGUFhozKhH0fiS313efG2ZyT0ZS87YRP83QC950QE9w9YIyRmE0k
 sDMzsx5R1bVwIIzxNJZ9+3mE2UU0Jeeyf1+WWQ6hPtYgVf5XUezw2EpK7jQiNMwe4fWyZ4jEv
 Pa7W15STaYkUpt02XpozKcShGM2kHgYdPcuG/J65ykl8RchBXzpjfzjCCnakB3CzrD6+9V7zg
 us5ytw8A1oS3yP1QvV6OqK9bi+j9EU0ByVFhOJjanDVvygkYQGnI7u6vP3m0t1/g+iUYJFf6r
 02xgbdCSxac3U+C457eRLKHoAKSd7sVL9+22EeQMS+4Y7tmLcurQ+LJAKMPF0R6aNm8ujBxJj
 tOThb1FyjsEfoXwvRP9b+lGD/xmssVPGKeiqNwyXdHkMGajmpiVUnMS8DcPITzcw4J5ph5K/e
 3X4kX4ZiQwBGq+1TB//NYp8YKokXqO60VkicCk6hUitm8C5AlsmaHIMkXm1DWmTrs5dDQSzIO
 Y+Zcobgh7zypKOt6u0SkDCtI2bKlssTPJbptdeUxBN7MTX3xGujaU1RODcgtsU/hFh6NBPzZk
 7DhMQQ8MY06mrD510/y6Xwc+6XUArBxvgOfkAf+fwudTXKWd/XNAyT+udLNyDhf/a2OcvjF35
 djKFOfKJQlAT147iyXU29Gcys5k0njifqMBhoiIfJsGF3rcFDtzTotlSTm2zkN8zu+Ses6TlR
 FgsWciAhq07WbkQbRcmETYUrdNeSGWw/mjubEQYYEgLKag16TO9tUmObqI+pdkOTQW0xRArph
 qMvwnDV3JXcelTIpb4kvabqi7dyx4F86uYQbuFKCy0MDL1N6tRjlwPG4b02kSW+hKodm4fo4M
 gtHA107Ke4VDQ/DWi
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> There are a few other things that I would change,

Would you like to mention these details?


> but I don't think that they are showstoppers.

This view can be fine.

Regards,
Markus
