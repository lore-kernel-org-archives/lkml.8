Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5C2C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A938206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="gXxowvN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgDTIhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:37:48 -0400
Received: from mout.web.de ([212.227.17.12]:53473 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgDTIhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587371857;
        bh=5naHK4F7cdRn00Ul7FyKyYMV0OXYrmQ0MBn96tmiSOk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gXxowvN1v5Xg+vPocpT361uD6CMZN/QoW4n/aEBmJTCAqiAopHUhBDpsVv9MFqr8s
         +20tVHXP5fnxTnzrO4OrRkkHPM2jUkSkVoMWrwvlha8rT9cqaOEO/7IhyKhK5zPJmy
         aePiJp674SyzYHkpE7hZdDxksbaSiAK3jq1Xgam0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.153.203]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MYeuk-1jmwbL2pVq-00VRsX; Mon, 20
 Apr 2020 10:37:37 +0200
Subject: Re: mfd: asic3: Add error checking return in asic3_mfd_probe()
To:     Lee Jones <lee.jones@linaro.org>,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Cc:     linux-kernel@vger.kernel.org
References: <b9626e96-4bdb-e7e1-51e7-a99210de4c32@web.de>
 <20200420071339.GG3737@dell>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <aa5f9e64-042e-21a1-d252-9856207c7511@web.de>
Date:   Mon, 20 Apr 2020 10:37:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420071339.GG3737@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f3waiaGKoMD8WpTbXuLw6T10EiO9bLdqBC1bVemy7nSMUAhQSQt
 F1RAfL+D786Hv9to2X0Cpb2olnyjLB6oNWiTtqHvbMEJD6BzJbdKEqGXym9kcEANOIUdNZt
 XJjWZQMoKgoaRD0owsn7Y2T0QJC2UCWq9YpyCSUrryohOfV78qPtcje4PFiODiJNUjYqEBA
 za9YyIgTeaL3IU6MGW38A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rGVR9zZ+M0c=:uM+CV2yU5jUx+cXYOlhnqf
 tEwzMRbdC2FGl9/BtPW2BziXV7GjCwpUuQ9K7RQ9O+Q9yFLTwXEM+ChJzerVw9K/dNVgfT0eN
 R90gyGDDTM7L04z0B1RtJ+0SVXUTfQelE5ZQVpqPje/hlwO++LXiE252cJAvdy1TnJHb/Onri
 iVNAenczo7IY6BS0QGhW0qmulQA0ThrOgPoBXoeJWAHZmSfpKaG0E3KigKR/kKPQ1YZvwzZ1c
 z1i4wq5NXu4YRvg+79Dqdu6PK0HTWgT3Mbw8kVoXSHJL5QD+tGAA/St9hSDwFNPhP8BJURlog
 nYSYkrQoycTcXH4ywZelDGkZMOa8W2SrtHPVZRjIJ0Q43TAO48C3kEpGkvMG2a2XsnS4V08ho
 wQ9P5ugC2zL3nxktotpNapGumAmFaF+o0YqTwZeoqwTc5nSNO8jW9pCHeiHMcOKtMCGUSVNox
 RyM+SPc2QhQ/5nq9lBdSTqWj/X4ZCwx0XlIGFeDag5Y9lFWpVOOrS/VIy+3HiTQtU57uZv1Hu
 DmfkCzGljMrX6bM3lyhPnuTDe3s89H17pFD20TLZzh4yF+dssDw+jCU1EaFYReCB9Jo3hRqCv
 +hVIYrtW9CR5AsYgKC1wTVKfJ8Y0CyHkKc9Bn1IvHvd8VVOOSrEOekw0376fEZB3ZajTub2AI
 q06Ld+hWWBJhR2bLlAlFzpM+2RvPXj3ROPdLqgvBD1qGpLhzirLe6h+MHLo56JnixxLzhRc/p
 JT2jhimS/kFHkLfVOLvv7auXbSQItcsIkyBIPi4qnxxAQvR5/N0zJg0br+/RPuywhXrmYSb43
 /InhbhgGggXbgs2+9baCW8WnkT2gpuJ5hDKC6WIC79TjcQvxJJFJtjzulEyBPiQ4xs6eGJlzy
 4YCoPrChkNgKsczJZSRfrR5RTDMRdtKA+E7pTNLjxO5Fg3IuCKAJP223uLrLqJS0yHiQKtnUT
 lODzYzq7A5ZydjbNnPeq4cOyTeEWKXBRtabgaKtLwgrckbFwEJBBNw22VKytSKzoJyl/15Kdh
 lh8DLlC3sxTMCHhMPFaR1IIarh3q6b3s61/Np0xasPCtKUQo9R7V3wO9lv0IOjQJIublzn1tV
 mMKrgHtPVLIL7B0nBXlKxna++IaHvfsbXPFmu9+wHZsmnJd5m0ZUw67O/N17ncttzh0LGk+VF
 CwXPkKN1sKdAKFYLe4FRqTBXFqSmu7/dwLKGlg0mOFme6jy2vsJKWmyseM1XTlLS/dvHSrAil
 DTkqoS6DZLrwDITor
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> And remove the redundant 'ret =3D 0'.
>>
>> I propose to reconsider this interpretation of the source code here.
>> How do you think about to move the mentioned statement into an else bra=
nch
>> at the end?
>
> Could you please fix your mailer.

Would you like to help with increasing software development resources
according to corresponding open issues?

mailto:tangbin%40cmss.chinamobile.com?In-Reply-To=3D%3C20200419091923.5728=
-1-tangbin@cmss.chinamobile.com%3E&Cc=3Dlee.jones%40linaro.org%2Clinux-ker=
nel%40vger.kernel.org%2Czhangshengju%40cmss.chinamobile.com&Subject=3DRe%3=
A%20%5BPATCH%5D%20mfd%3A%20asic3%3A%20Add%20error%20checking%20return%20in=
%20asic3_mfd_probe%28%29


Can any more clarification help also around the previous update suggestion
=E2=80=9Cmfd: asic3: Delete redundant variable definition=E2=80=9D?
https://lore.kernel.org/lkml/20200403042020.17452-1-tangbin@cmss.chinamobi=
le.com/
https://lore.kernel.org/patchwork/patch/1219914/
https://lkml.org/lkml/2020/4/3/4

Regards,
Markus
