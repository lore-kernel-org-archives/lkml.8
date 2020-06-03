Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4381BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C0212067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 19:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="HgrYxFWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgFCTaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 15:30:22 -0400
Received: from mout.web.de ([212.227.15.14]:34689 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgFCTaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 15:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591212611;
        bh=51Nqv/upDYdrjeVzruw2L3D2ZrE9E25j2glTzWyX+DI=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=HgrYxFWGJ20jnAN8cutKrm10ZcYhF5nGxlLYV8i2tBhHLRFgKMu/fBqOPiLxx/Rkj
         ZGPA9ygU+hjb4G+FsX9+p4MN8najOBCc7ggUQEP71AUVz7+hw9eTXSiJe5dl7VHzOp
         34pxdTpfo8/YEbKmaDKMzuOadKl8K/msYFszLvQs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.82.231]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mb8d1-1jQGKH3FwR-00Kckz; Wed, 03
 Jun 2020 21:30:10 +0200
Cc:     Alasdair Kergon <agk@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dm zoned: Fix memory leak of newly allocated zone on
 xa_insert failure
To:     Colin Ian King <colin.king@canonical.com>, dm-devel@redhat.com
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6ae5a0f1-68d3-a0f9-e7f0-5c9f008204a8@web.de>
Date:   Wed, 3 Jun 2020 21:30:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bn9dduKdWLaVz4HGfEeblTBOd5rRdpGCjDDRsgChYo+6jdtV7Ws
 YYUJEh6HyaoK2PncVm7mLiizeMlL7mnMwVNUyh7qsfXOv7HT8iKhBumZ2KATjMc8/STPR48
 Ac1cmTRW1WisC1YPrsly5scavA5N04EWDF6K92msIMGe1Rr3lsjgpf1OLCvRBJlbk7JDYgc
 xEIOjeLYfHs23Rk1X8l9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8rATjH4Yuhc=:eEEMQqjK5dkT0Lh3bI34Rz
 aEpJqI3YbptUONxcHgRjdRXSsdkXAerOnNEv/2CDiVnOZoeGDHEiKNRMAPL4cyEsuyZBLovBz
 VPwhf8IB0lJJon3ShXH0bRgp3QTJ/eNWWeuFCS9EQ4/kB9oY7SEGBFPrRl+pWQ1fdf2I4jbeU
 U2Q77yWCMdmPaU3rWtnKXS0y33JgzWS74j3ahV6JnMTQ69+2ex5sSZIQ/yg9DKqkmHaej+3kI
 jDUmi7FssjkaRW2KTsY43uYpyqlj7SuA/aTj9WY0QMbsF8lML5SXA61E/zoaG+C5cAf1iuQVl
 8TtDGBL9pKn/SvIECWy1qx3kt71AEjq/JKqZ315M4AoGWPIBRYaA7MT4Ioi303ilrc/mcIHIn
 Ee8LUfKq2I/d6xto4yejeP6du13B0jsCy7VRiGLV4fIbdS0ZmqSa31oaeUP1HPFqDLp9C2wd8
 PTJUSYHbOnUc5tjyEi0Qb1RJ6yJJ9jXlF3QvQwLGcxJKGp0t4jWmkUTP9JyT5PdK5ftxqWnkM
 a/ZEt1wk+miN3vbbrhXdoz4LiexMUP3HxjgKnPNcvVKyx+EyOkLZ626oqVJWvlv5CEJSwirY1
 Gm5XXFp3KiEQkP14Dxpiq1HpfiF7l8K8zBT8esQJ16FUpNVfoMSHnCW+pYJw6tpHFC2tUkVOJ
 EouHtAAqCTCXI+BLdUxOqplaMqjdXzH1VRGKmey4KEOuzQmFDV0+tDTqCkQlukHm+opd6D4HO
 ++p4Pd+8E6CmGxo2CqkJl5zxa2nfhBS3V60tXFpZNPknTLgzceK1Rv8KhNdZ46Ew1mM8LL8vR
 kXm1NWO6Dw1LLjqWIzUP2/1QvdUXVnXGqCvusrYKFiiPHPOoMbqNiBekgXyj4g2XpljVrLKCx
 O/SQ4ivIAolbmg9hrkcVEfo7byRcn60GKkcn1Qq628PC/n2F8PE/ksuD6bBxrNOQccCccpOX4
 y2YQURBHBbeAhjtHtS1gvAQdrlIfuTORT2jTSj4UZeE7dA274ULDqh4ahgoJr1cdCNK9anCiy
 8N9esFpYkmsHePBenS0tnlDJcwejEQONCcKBf+WzTLPzTY5AhqI4UvPSchvO3SeF/uT+LOqr3
 GN/avlPXWeQH30yZxUYRrLridX8v3D1/LY3Y26VcDzB/datjTsWYDpdKAq4D4Ded015Pkh+qS
 B5FjL32c0U5gii3xorB2n1KmipM6NO/6/ZZ3a0GSmB2D8hFO/mEodmkry+uSK/0hi12LwfCWr
 wTYZ0CUzZP2Mfa6ZU
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Currently if an xa_insert fails then there is a memory lead of the
> recently allocated zone object. =E2=80=A6

I hope that a typo will be avoided for the final change description.

Regards,
Markus
