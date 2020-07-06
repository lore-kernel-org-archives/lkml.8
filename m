Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CACDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43EEE20724
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="SbBy9VqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgGFHnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 03:43:50 -0400
Received: from mout.web.de ([212.227.17.11]:44815 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbgGFHnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 03:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1594021417;
        bh=Wb8Q4StqUqY9E3ubjH8+vLUNmLWdPXf4VOlWVaeJpXY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SbBy9VqE+WXqjt10ZnAPMCmmPkUgVQqaz+UNpYefG1CC650YTERBHLNDf5tRYhkf/
         YJQ2Ppn7C0pO8PhBOJc+trBZWULZTov2g1SXZvtINVPHKSWXajze3PIxfmaTK3i/QY
         UBMI4Ujh8mNVrazpqLqf7W7ztjivkif0o+vdk/NI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.113.119]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZSBQ-1kNdmQ3Qfu-00WWMu; Mon, 06
 Jul 2020 09:43:36 +0200
Subject: Re: [PATCH v5 00/14] irqchip: Fix potential resource leaks
To:     Marc Zyngier <maz@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1593998365-25910-1-git-send-email-yangtiezhu@loongson.cn>
 <ab1cd9280c7892a0230945ef5ff0880c@kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <097e0670-6725-0733-0cf2-3d3c897c4dee@web.de>
Date:   Mon, 6 Jul 2020 09:43:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ab1cd9280c7892a0230945ef5ff0880c@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:utiFaU44pqh6Tv1V05a1lHs0OmIclr75lAnmKwoDubQ3bmqkEIL
 Z06BNorJzvQ8S00tN5paGuNRbf+Bki4+ZDmMLB5MgWoRMrEoC+inK7xauB19xd6V33sB86I
 h8/1H3h0FWF4IftbMuTDsw5e6ELG0/fo7S8qQAIaDLMVe+l+weqnJLIDTJyMw7pce0cqXmk
 iASJrln0Y+wSjWNB+UAvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WmwBejuREvY=:mCk4hRd63LULj0GYVNZkvN
 V4rjBwUMc07fYdvvsfGZjK8YEgefRx+nnIOz1kROh/GBeiRGsO+I3RJ1ZKtRRAWEOI89N6zbz
 II+xxhxA/qR+nSV1gOXzuv8cdRLWPYP2kL47/4VEsJSH/ubiLVa22D7ObkzT6AoCnlhl/8pZB
 kYriRRNY2mbtg0J0QPVwi9YCx21Av46PPUuHyctdQUqNIGxscK5K3Z13A8nm9f+yq5VVwBKqo
 uGnvl8u3+boR4KSMbRN2T05P3J+iToDs2iZ5PmtNMIrTTC2wVmLZI4aoN4/ORS4ULQwcLYFYs
 CgUPVI7ZPbLKyLCbIrtg2Uv51mKqg8VLOgArpYoZpW3PvLV4DkLd+s8IjRaXhSDG7wvUpS+AE
 Xn9TzIT8s3y1tnP5OtHyiBygPEsUR9nJV8H59mrxK97vAXuhckM04m/gXHYKIDQHJwTHPjafU
 wvL+L0Hu12ct9S0kP/TtPFBDYs/kAZc2yIXyG/+1sz1bq3qlvDkiAXazhCkieb2KzuaZuKm+Y
 vlN0dN44Qnrx2qkLrHqKWJcLFq/11sciA3i97eN2wwi2suL/i29HZUTzeqR066xQB2YE2Ztn4
 WJQfJLK5DGceb8TFj4GwVM0voputv2grOSTmZ2SBvy1WN758UieydvODOmiCLuujUSBtgoKyD
 0teamgAdrAK5HXZK0vq6uGuAZ1Xz4DBjQoJTt9BiXZ0NEMrOa8YooDIUfRiQ+rcFZzSHdSVCc
 dawByp1zLlLqDyhJ/lpr0XtW1qwEvmV4coLt1TOVYK1MnhJFlWCMHpx5bbggDKEBu4iZYOGS+
 QBqySmlU2uj38F1YR1SJxoBFzc3cU43mEzsyqCN3xUtenx2mnsHXymVKZw5jyt854Al1n7oI/
 LjH2Ge9yMSfW26b1EhKKHDOMwVc5MiTmzidmr0t8fvO3vcI4WRykMOrfZTPCVBWLC1rntls7h
 vQTg9wdiYd1e6X2fG6pgBdySGr62DIRXYAffbb3P8sM4hMFXeBRL47+V7aUok1yuQOGYizMMY
 EAy7LQiQF+YVNQBSwPhcXHfqIhnoK69vRAHZSa7qiymFahj0elUHjpm253eUsgrOrmN0maCfw
 Q0tFLa8lQf+/GLKDCsmv+UmTWLA4gsqzhFTrKZaQxVA8201BZniIhbLaaOCMTisj7ysTFw9Ff
 ynOERaj1BbgQEbgECXf5xLMfjobHpKhcJs6ZO/7vGtcFxMbdi2imOseujV6d36fuuofPlMNDu
 OS0iG6WokMqWUCSp9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> v5:
>> =C2=A0 - Modify the commit messages and do some code cleanups
>
> Please stop replying to Markus Elfring, and give people who actually
> care a chance to review this code.

You got the usual chances for the desired patch review.


>                                    Elfring will keep asking you to make
> absolutely pointless changes until you are blue in the face

Can the circumstances evolve in ways under which you would admit
the relevance of (my) suggestions for possible software improvements?

Regards,
Markus
