Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E33C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 19:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD85207BB
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 19:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BUiYN4/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbgE3TBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 15:01:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:33533 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728998AbgE3TBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 15:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590865267;
        bh=auponKtemrWXzsEAaRmc1ImqHLxQ5fOLo/J1jMQd4Cs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BUiYN4/b/uTJqtSDRQJUFRajDuzCVXbbMOPv+PLGNpEPOD7OaoPQ/kUl/somYHWMx
         7bcoNXUhtlSUWtG1awcyiW74pOWK1DuV9qDv48NhtqV4XOjLbKJQ+5nZH+JZRSz8ap
         SMF9auMl1XCj+pW/VQRFUwmlk9RA29cz5T/jrxX4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.23] ([77.0.170.188]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUGe1-1jW4Ho0Qzr-00RKEy; Sat, 30
 May 2020 21:01:07 +0200
Subject: Re: fatal: unable to access
 'https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/': SSL
 certificate problem: certificate has expired
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
References: <7d5a91f3-e5bd-8410-487d-5cbcd23b174b@gmx.de>
 <8a425b75-cfc7-17b4-3991-63945a855715@gmx.de>
 <20200530161612.3rz42y5yyulitsdl@chatter.i7.local>
 <CAMwyc-TfqyLZtamqN5ELr-hceySwWZ4TPMYJLtDRPHSuGKmbMQ@mail.gmail.com>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Autocrypt: addr=toralf.foerster@gmx.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <43477804-0087-3945-384c-0ef01e9a27eb@gmx.de>
Date:   Sat, 30 May 2020 21:01:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAMwyc-TfqyLZtamqN5ELr-hceySwWZ4TPMYJLtDRPHSuGKmbMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a4e7j8NWmu2jf5d+0Jo3YxYbg6htMYdcVuVQ1F8B7nlJBVvvjqq
 OQJmsQNDokLORyaLHRrfjxHGkbh9rJ0wpH+fHa7oIKw4dD1Zx5nW7D0aoPfi/+NTBKZv10k
 Yz6BQHskMs1WJqSOVMo1XsEYJW/aJzlwFVnnDhSkN8ZLBGPGis+KdvwygFvn93rUrguFDU6
 eo7vNuXCni9deHZk8PK+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wl0uVsT+3R0=:hmCG/u0MWF5I0HVAUrhhs4
 0eynL4zaTVOjMZ8tqe1XLSFrF98zfkndSD8kemyg6MxfmAg7JuRZuwPr2dR88KgT4gc2/uffG
 5SNIcC9ShN0O4Dh1MOfdxmnQ9zYmzAvgiQYOaLndYMXGu9Uiy884OtVmcfZ4/BnXQmpSfVqE+
 k7G6/hcr3OE7Xn0pIRv0H7sSbZr70VeTDy6QFd3aMERrNL1fRAOYaFSQG6CV7p1hfqhnGQZh2
 mKP/EqHxgNanhh7ZpEEd0TQVWy7EIS2mLXJPHpAs1jnUX4AEfnVcNDeeMJMbo/wgI01KLfiRz
 /OhWIdba9kVd3cX72lv8fayOT8zxGEAln/jp0EkpidDRAPGnu8IdzznipUpy68UBuzwFpOpR+
 SLy8q9mGRqrt1coCE5mdzWp20/vrHgq+PNdNBdmbms7hDZcgFxKKvm6Oe8JIWNBkHmaQ0OVTC
 xNAmOYpV+wYlFNFeCYPYnmS/0mpYqWxYKAhW4B0WxzG0HPsYrdeV86LSf4g5biXvammm02X4b
 xLBHhs+rEDkjN0XLSDWrRRjoHZBLQfPC/LcKcLG7vqhYJkHF1vcPjmpVOoLE82EFNyeD7Lxdq
 yHrYJ48J5dmp+/Gaw1ba7NI5HEQ1k+w3Nu0sY7ncPs90BGibHmFp+3nlidrzJcTZNdqcbsP5e
 2jppMzmLU9tVMtyY4DcrEE7XmhdBudXfLcsv4DE675m0q5UB3vYpm7Pd2NcU6ujfBXZE2RNJi
 ngnVK+Rj0snosaKZmaurvlqLdCDtffyFqZ/O3OmHbfqfVkmORyPSqEj1dQKNmYQAAteLJFbh2
 vuuEIoNZXV69MRchALlau8Rgg+yhWpMOtqLiD57mqIsUm5m9AHx+gTSxMMwVTJcywZWXLm5C3
 aBv5nnBomqVcp/okTUY8VYB7YCl7a2dBVO9RAJW04uCOYjH9GCgx9kRQkihWeNl4zVDkhhnho
 pLK0Gqr5kSMA/UX4iLVh6doM5qnRsJ36zhL4AYoP7K6h9Rw44/tOuCRFei1PAjPv9UGc05wf5
 UqInol4Cm2BE5MxwBHqYzcQdTdjsrLI7QC1WYnCe4+gdcAFGYYmBJGoD92jZRyaUIllk4p7wi
 3e2JN7hnAg5oCTJSlNrcb3irs+nTFCF4XC/UMI1ZpTdB7nhzxStYfAaH2iT4FIqVwWoizY9WB
 qKwl82wg+F2idHzoBtGqLejbUJj0+VbQBBhAcFyaHwyCYak6V4u8AoQPGgsj6jXH2TIkuuUru
 RSYCqw0pdlHrdOy3x
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/20 7:10 PM, Konstantin Ryabitsev wrote:
> (and the fact that you were seeing it in the first
> place suggests that you should update your openssl library, see
> https://calnetweb.berkeley.edu/calnet-technologists/incommon-sectigo-cer=
tificate-service/addtrust-external-root-expiration-may-2020).
>
> -K
FWIW I do use dev-libs/libressl-3.0.2

=2D-
Toralf
