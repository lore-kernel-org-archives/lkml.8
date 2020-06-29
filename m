Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B68C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADFB7206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="iFmORjkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391706AbgF2V7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:59:35 -0400
Received: from mout.web.de ([212.227.15.4]:50243 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731388AbgF2V7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593467956;
        bh=S8T29fkcYiXDkPn/9lQ+45R4Jkq71F8qlpyc/mIFxpc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iFmORjkYEdB5fFngA46+Axlm+dVx4vwUz1AE+KgsVUkoaCgOuzkx/13Zkt2c3et7J
         aP0zwnsQBYHgkAf0Sp4vXBTxODrqlPi0qoSTNe8KIdrIwEqpQWTVAflirXv0ukpsXM
         DGkJbtv9am/R3Jfak1b7FG6eDw7utcV/iYhT99cg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.123.16]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M73o5-1ivOy91X5Z-00wpRo; Mon, 29
 Jun 2020 10:15:24 +0200
Subject: Re: [PATCH 1/2] usb: mtu3: disable USB2 LPM
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Peter Chen <hzpeterchen@gmail.com>,
        linux-kernel@vger.kernel.org
References: <1593410434-19406-1-git-send-email-chunfeng.yun@mediatek.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <390dab28-2798-ee5a-ece3-bf7f2cd3f175@web.de>
Date:   Mon, 29 Jun 2020 10:15:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1593410434-19406-1-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t7V1F9kLqdX3GUIUap/U2aETmgPmRTpVr/MUNxvCH7AMYtaueRz
 L1/p/GHjsaoxRpo0i8waXAtAE3ppx7cfQf4rbsAxDFsoZS//+HziGbu4MhLzC0OGy1baAIC
 l/7ylzASryC5Le95u5bRV0XQFwkeG2JLit+p5clZLlv/xpX+c5t25vH1pntTFkIj0N/K8C9
 G5q1SOKR4AaUZaZK72L6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2dJx+0PPcfs=:VQP90HRNpTyDkMv/V50oA6
 YfgGhYHci9MQMC5Q+LVuQJFktQ5AT/IX4PGluW1BiHPUwuenVjWbqidC/9qQhq36WtgxJxttK
 GNamCePNWU15REYzx82pL+6lRXyOZRUbljCyYazQHTxbcv2/1Nb6t+0wOxVTx4qk4CBawswlS
 XqX3pmEG0K+rP4qQy+qKkPtN8EupqZAVDf8/O5GgY7wGdVuLQY0dai2ha/2JEGkyxFMTkO9ch
 PhYKNSDD4l8AqDJNTtRwvg77YS5asxqmILMTGrOUWSBV6ak2QecPSNba9xy5DGBv/PkApB+vb
 OHEz0z+ta/TG36p73fVwdZeUOJ2Kpjl1hlfunoq/Y5vmpD571Y3muLhwyp1p9JR+tz2sz1hcb
 0gXP0Fn2CNVuU5JcMH3ndYulbSQo4D34xbGnPTX7rCidgoMuqKmxvASdAStw6p7p8xNe4twP4
 a5i0OW7vI0r2o029QyxpBPxppzKfoJ11oFx8H7pSo5k2QqkJ1s9cwMsNyUJqHldC6CWq5H6ed
 PCRdyQlcZoUbfgzAX2lV50/Ljj+z4CUI1e4aHQHMJ35deF/LDN6KXApZmYveTiODeUAhWybmz
 jsYsIJPP/Lgjpv0tKw8nlZbdj4UbVF8DXHxxsJVjReSC6PtB+FTFR3u2r1cR/muFuXBv9FaxG
 fNNCFiewMze6f5vwVpYng7Tr+rYSi/Z9gA+XNNRBRlJfUYfPYGwIDuJpZXVeHTY9EPeb1s/Hl
 jd7U7B1dL30XplrfNekaGRA7JmxpPWjShuMiPv5NgD5tgo7+RdGlmU5enSdfj4em/+eff3aYW
 38MxeIvl2P7GIia+l7hJknAqo3Pifb08G87y49XOTBZXzx+JXvnt/Lec2oF3KZNMkjEi49Khk
 jUQWWfiaUf7anWw4Qrwe9jVg3RoDydNv32/qTRCXVRkAHO5IfVSRxPnUTRrbA155SlgwnozfM
 EBVDysx9P8Nh5JsFOafpuInFqiNxEGndE2k+eGH3QacsOPPQamQmuLaDUQQ1LLkNNWij9Ou3H
 i5HQ4kWay1SdULrwfZebGnOz/dFZL+KactgbtE/plgQL1shpaSRzR7Fs4Pw/7TMlpjLImuuTp
 o2SavfNLQKAagOL/u9bSSlOEbLxjtHwMYhcge7rssogOpt+/06WJ4bhfl789ZgI7WlN36vUbJ
 /S2uGx0e31a2Z4zrFxsOONijNUQ5kDWBqAlUs5Ft1gTdxwHJH3LkUSuBr755HOT4YNc0gTZR5
 AwH8JsiK/Ud0sflzKGtjgyusuKhFLZeI61PyB+Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> A SuperSpeed device shall include the USB 2.0 extension descriptor
=E2=80=A6

If you would insist to combine the presented update steps for this softwar=
e module,
a cover letter would be helpful together with following improvements.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D9ebcfadb0610322ac537dd7aa5=
d9cbc2b2894c68#n785

Regards,
Markus
