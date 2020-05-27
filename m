Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4940FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F3020888
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="TixyskSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbgE0IU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:20:57 -0400
Received: from mout.web.de ([212.227.15.14]:44033 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729292AbgE0IU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590567647;
        bh=AFatpR1sx84oKv3S12PP/JohWpkDNTirWJJdC8Lzq0U=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TixyskSH3IkrIcuHyRes66bjSmYnNHlfIfe/N5BMHYa9m/AOIBahMdTuYLoOD0zor
         EAp4lzTSPmySPLVeufcYigscrapVSwa7T986U8nPSyg7TXnrIqPmWPZ7hsHMrqVVj7
         VawQmzUql9lbeNjJiZmQbiqWXUEsu+CRu+Xo2itU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.185.253]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MLlCd-1jdaBg1Hut-000pll; Wed, 27
 May 2020 10:20:47 +0200
Subject: Re: [PATCH v5] workqueue: Remove unnecessary kfree() call in
 rcu_free_wq()
To:     Zhang Qiang <qiang.zhang@windriver.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200527075715.36849-1-qiang.zhang@windriver.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <284c7851-4e89-a00f-a2e6-aa8e2e1f3fce@web.de>
Date:   Wed, 27 May 2020 10:20:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527075715.36849-1-qiang.zhang@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FGMCA5xIudUe5ot11E4zFtmjuJ4omrO9LmnZwtOm86vKm6O7UZk
 mGtL38QusxQx8g7VgOJMpVukqSc+Pj0e/oWQrpV04vzdo6G94dXFEeCeXe3ZvTW9xDQiYGd
 yQtTNpz0XpDmMVRKKDfTRW3L5EJGOXbSK0tQaW6qp/g9aNL2AE3ffhR90dlTO0S85XCDTYk
 NzJVHCGCwbLD5cMCoiS0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NzOXb4H4EMo=:EVR+jXrGnvtTKRqEeFzpS6
 NK6lqLNPInzLbpici7GLx5U2O9tSCgFc/rMU1P0btTTWdhajv7Iy03tQ2Mq9r5kPqelzspL9z
 1e1Y8s+TTztK9egTvWL5e/Tu5WGsQDVibsyusic9+v10W6z9jUzYhhl2ME+7bVbTaHh+qcptG
 KOLzItnBuXk+1wZJoy0FsewEGoj/C/9PEnK/1+ikqnBfOdhv5LtRaDYKeYn6kpK/ciTUsx9QO
 qL4Bq01leOZ2wr7PJf3JehNDHEEJZhs3lxM5E34CCTcCFZwOHa3X3TFKF+l+yTj1AVbhtzHY9
 isBR58YrcX4qKEK1GStyivC8isz2CDNDdXNDU8PlluZSXhQpNZ3Ie0a2Wswyk5ZRFS6w1EE1w
 cReljCFcUS3egLSTiljtpy9kcYoSo+w7SQpKL975NkdrLQrQ3khNuaR87HW2rhwg8SyBeTgjL
 wTkNQa6mDoJFIoKUGEluoJoyummmCtSgpsp1G/pKd+0AvniCpR97W5de81ZI5KedRkiwfl3aF
 0yQkoZtc4P+hhSMGRnhn4Y2LNlyDFQ2VcOrJxr2NgbTWZxfvMZwEARGfbzg9h8gqIvo6ualg3
 U1DDVwMGzzGrlXDOTIxghiWNjQMSUPTUrH0hICEzPHcaz+/hlXTvQN2MGPGmb1oeKBs4mAKHs
 HudQY9OCWyIVypvCEUm8qi1PVb60xA31EbcdqZRQg9bw/chgdxgwHjOHgiVsKkxN81xzfeePy
 coTQmYhNv9NTDEosePDaLTPCL7oJO2YtHvq17mZXfnHhbOtAfqZsIDxVbjekyRDXenUjRXdeq
 UK9u0IVmjt5lMOkhVqH2OQOkl4zjj2g4mOvkeLOtCMpHroYjQfWyD+MhG9Z1GROA//XuHFJaZ
 w4SXjSgJjEKwu0+NE2KJlOV/lR1OVZBoSMhxhDMVz4PV3lVEdsxIHaCjBXI/kmHeW5O+5OmRX
 EsNkHYDTd4jSSaFDgZNvX/RLtzrUiZLPArcH4wYn7fyFLpVpi8l9rrVX2aADHzFnNBw8K4RwA
 8xNw+iRfr4a5kNnm/DdXQoH3YzH0VwXbchAjCBMUc3PSbgHiGc6aITDqnmYn9goFi0/Nd7BhR
 qXhLPFIkRE6B0oGUpocilVI0+BpVFPUn0lTlwv0Pk64x1N9y2FYa900MU90tU0mqJQAH9vEoz
 D2CEsn/rjsNUuyzRtGuuFp8KPkqzHRhdbtYb4GGGRac7RaCv45wQemBTIUrpExLICDutOR0AC
 TagQm5pY8D57cAsP6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thus delete this function call which became unnecessary with the referen=
ced
> software update.
=E2=80=A6
> Suggested-by: Markus Elfring <Markus.Elfring@web.de>

Would the tag =E2=80=9CCo-developed-by=E2=80=9D be more appropriate accord=
ing to the patch review
to achieve a more pleasing commit message?


>  v1->v2->v3->v4->v5:
>  Modify weakly submitted information.

Now I wonder about your wording choice =E2=80=9Cweakly=E2=80=9D.

Regards,
Markus
