Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257F9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02D7C2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="J06awSLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391204AbgF2Vkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:40:43 -0400
Received: from mout.web.de ([212.227.15.14]:46537 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726966AbgF2Vkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593466833;
        bh=eFPVYKXOnSENohbuyonbWRq1F0OLlPtxo04hm41i4Jw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=J06awSLtc3S3FD0/WIxFXAZ6A8tsAOGPkFiKj4w4Dw7qgovMEvK43dPBjUiWb96Wc
         DFh1KZ5/Hz1cunIGi+2mYpBL1Qlivu/behZT1oLTyGdMNOmHmanWGpUo5yEbASrMsA
         nbaQmUUku0piBRnNX8gzOaqNgee+ICIe6eMgMaWg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.123.16]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LecN4-1j2jaR3AmE-00qRv5; Mon, 29
 Jun 2020 10:00:25 +0200
Subject: Re: [PATCH 2/2] usb: mtu3: fix NULL pointer dereference
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>
References: <1593410434-19406-1-git-send-email-chunfeng.yun@mediatek.com>
 <1593410434-19406-2-git-send-email-chunfeng.yun@mediatek.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <99fc1f6e-7907-6723-612a-8b68ffa871e5@web.de>
Date:   Mon, 29 Jun 2020 10:00:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1593410434-19406-2-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PizCbKGpJNTn7kZfWjisoo9mPDAoIPDPVWcuVGepIZSqN05lkgT
 Jo9ebRyje6ZSgX/opQn11xFpj9UUyG0ffXxbkiFiO4htPDOISmUkxRHsR/eloV4jq9+OqKd
 yN8ZmBwQMbdCf1xmBqYwpYe7p50esyW8f8KIEXM4VCevn6lM9v5BweWYI7L70ccGLYVMcQl
 X6zhk1uLo88yIGF1bG5Nw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zLtPOaNklz0=:JkMQymRAveoWdcYHTx/oN+
 uSljnuLc8FTYJXM6qdotS0v1/giq5xRC9gMsF1qpV5/6m7wiXlp7rLSm4PAWGU/4DfvGQH3sw
 klTYtvVrUHkIsDwmLHNyYqUE5LyMcQUt2rlVOI7lDaABPOErImsNuW+A6QwtN8LxKI0w2a2Zd
 AUNaFVTz5J8w/oGBIqiboMdxo8kUqG/WEhyMBI2vTNZQQUrEpkgGfi9v1er+elih0SCF12Uuz
 E3fUlEpgebkWG7Tv7dWnBCLUtumlAgKCFhZfmT+rfLe6v4l27eq1zl1Is2Y2VeYFg2J5cUW1V
 AuKYtjbVVb226G6eE009kFggXIgaY94RNcvhH33RpERDwxqfiwMntyA7gMQLuxdTtVR2vqBq3
 2GFTmOL1b3ZEidpi6mcAT4tNhMU38qZh74Tadb6nLl3eF0fGzVVWOQS3X1Ip257rvVKpOrf7/
 c/qvymXM9Sd7r7yoT6eLJ80R/9/K/LfHKCD2NaJz7SH46rBuZVXWuS9NMS1HBfHxk/vsX2HX/
 lA6cLhxq3ELqtYe2EAILJ5U82JccIthO3FUAQnaycVO2zSN6u99xdmbvWRjMGYHGDOD/I1xZs
 KuFJIQAvZbB1QRKyHqPszEEtj5o0ik2mNyf9j7IcfZCldvMb+MPPTvwi+GhLvDaMT17wu9UQD
 +l5vPvhD0VhvcPUYIVsKbx9NLDDbt4eF4HL9jPxIxhhN/WH8glbxoDtfiNhWyUE7yGOomFwzC
 gsw07LhRqieH0SFEpt71B7QK2ti/CCpcvCXPjdrTK/XZtqA0BPRsaOBgTM90w6mxMabW9zAoY
 WnCNIyfOlXqouVJOZDkyV3NdGXjqDVqQdTolFgtIgVPEYJXhjNvfn+SBDShkrz2LazW0MtMMx
 mdXm3YkQJIvmv4k6DDAiq/nySgBSvwYca5Tp8x9fPX0jo1hXXdD4m7e4yJyZy0rDsJT4AfwgT
 9fRWmhaIbJ/kFYl1FTX0HmMCeeZX2+3ABru2ivMYlIUbqe35ICwm4fORxOK9OK5ps0f4HJQae
 mOcqVm/mC4Qbs+cacNIyWDYDY99RMp+wQZB+e/J6SyYrOfAjeq3KBrVnRcbLq9NnqwzRpVS5A
 k3ONY/brcgKbD0hj153cpl+wZCbV4ULEhJvgJ84V6VFHI/4EDBAtqU5upBTo2/sgvcRvOl8Is
 jpRXnVjZH4R1F0HWPRrB37I6wB8HzpVaT3H80/xdJxjn5Z58eyzsIGvr+AhWMs4OwipJHrP12
 dm2aK4vlUyo6QPJqJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Some pointers are dereferenced before successful checks.

I suggest to reconsider and improve the change description.

* Would a null pointer dereference be possible only with the variables =E2=
=80=9Cmep=E2=80=9D
  and =E2=80=9Cmreq=E2=80=9D in the implementation of the function =E2=80=
=9Cmtu3_gadget_dequeue=E2=80=9D?

* How do you think about to adjust any more variable initialisations?

* Will it become helpful to add the tag =E2=80=9CFixes=E2=80=9D to the com=
mit message?

Regards,
Markus
