Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74333C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 05:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F6420791
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 05:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bhCGu83I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgH1FWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 01:22:13 -0400
Received: from mout.gmx.net ([212.227.15.18]:47533 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgH1FWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 01:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598592112;
        bh=WD3AJvfzF9oAQ+hbHrZsou5r5C78WR8jKTk/O/wDxkc=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=bhCGu83IIKmtmmNDUf2qiJ8fQ+syL2IrcoYwvcwZYbZNoiu7CzhFqkLrnr3WvF6qI
         RmKuT8w0Vi2ZTeqhHvQfMole1GlGC2xHpuuqZBn+VFJs0mktANxVDxjVpz1x+gKubS
         DZgWaey4t7a9ZbQt18hh3rUNEfykbUocbTPsDJic=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-s9 ([185.53.41.233]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwwdl-1kW4vD0uKZ-00yTBG; Fri, 28
 Aug 2020 07:21:52 +0200
Date:   Fri, 28 Aug 2020 07:21:46 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAAOTY_9R24-tcAMSfDhxLEXDFPAbMd5fYm8EwGODDMpULq-UZA@mail.gmail.com>
References: <20200819081752.4805-1-linux@fw-web.de> <20200819081752.4805-4-linux@fw-web.de> <trinity-14a1b182-38ab-4f84-bb72-94d448b05fd5-1597994235320@3c-app-gmx-bs37> <81276d4c-8883-8bfd-d7d0-9b9ac025ed97@gmail.com> <trinity-ddd51146-41eb-49ae-9456-4588450d31aa-1598535710011@3c-app-gmx-bap26> <e0edfd9f-5916-80ee-3bef-92d7050f97db@gmail.com> <CAAOTY_9R24-tcAMSfDhxLEXDFPAbMd5fYm8EwGODDMpULq-UZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Aw: Re: [PATCH v5 3/7] drm/mediatek: disable tmds on mt2701
Reply-to: frank-w@public-files.de
To:     linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     chunkuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Frank Wunderlich <linux@fw-web.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <B3A0E53D-ADC0-4D67-B9C2-70009DDD5D36@public-files.de>
X-Provags-ID: V03:K1:7PW5OPifrURLSHF7MjbrcWo5/B8RnBtD0szhETXVFhtYaU1kflx
 8RahuKcyckTIREd1Fujksg+Qo9pSqdK75DMSepPIN5mlJqSxvoSRfvem2ypHN5VizKwVrZw
 Z/6Of3tVfXrI1Nj4Ts4XF2VzbDbe9fIkdJWfnCCweJe0FLWrzWP1Pl4e8bCca9DBES1LOZl
 mp6yVVTPMo0VfSfa560xw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QBOEfSUFWXw=:RAuERleBgbJ+4wBWJIU4j5
 qcxsB6bPgpyUh3OQLvDAXj/+9fyNvY003SbBu64EJT2wl6Fe9hK3cpU0Rmg1rXnRbQbvY4EVz
 9u3+zEIIdouB8Sx6PGGlylWAkm/c5thKzxtG14yMQjkRToDqd9O1ziiLPcdzwtyUXDeXdEVX8
 F5U28qUIO7Fp6rBFIIZFyWdy6NVDHLGE5ac0GDc7ox33UCWyu7fj2HM1vIqsOIMfEWkZOxLpX
 yMkmqZut/9jpNOSZJq0IfJ1OGqFGXyv4y+QCqgO5uq63BFjUCi6f+zVlmGr6Ue4GciHr8z9au
 OrAwLLIRmJlvlyBlV2rBq1yOzGrdyJtCpHyS1bq9fqdDEnwiulNVNqUeziK5nRsDyjDtEdHqe
 tPcHkmfaocY0pp9Lo2X+1gfT1ZdwYHIeDJD9y1pNZyfrNymU8S//hhSa+PaKN9iRCK6ONNOin
 yASBTGWLG8j1f1HWRkfVTGeGyPB38ElZRxxVQ0ppu5HYcHSIpvm0wYO4z5Hc7QVP1UCXNg89W
 fMTShvEG9yvhps6WZGyHG52BpnXJ9O2SrmrCIy1+1uM8vymn3uD8ZxR5/lYGdrxLho4/dgTt3
 1070daybhPTjV0xwiWRfewsCnFUNC79IhyvvspBO+iBRRjFGGoN+eaOQ+0eILURRYwPIQPdhN
 wSp8FYPxSbUtVv3Vo3VvTSSn/y1Ba/Xr4sS3WPa3eYvJA3rdN83llebo19mEpYt2ZvT1yK3Us
 FtafbmGMF7ntFR/2/qxyDEQDGCkXbsYVpkzvwN0ykhbNjIP0C90Ol78b2rH125uRLK2sWfUjx
 JaH3mV3rYiA0YDO5RatiQnSuSO1y4qQiHOrXWzvwBr/6Hq+Uvxg/SxyVN5nxxhl2EuXeCVeOP
 hBptGE++PkS6hcv46bBuDOl1wDTkAbphH6BbJap9IxqjAOFqw+nYD3KHItf9kyHwhbNxR1NBd
 qT2EEWWtVATO8TRlvaU6qw2r3Ag6H8R+JhuJJXdKd5hkk4epnSxPdVDz9Tr4iOqx2x2Y9ZY9j
 OQe5xijS0g5Q9UQL86D78rmAUCXgRTeHJbuyNeP0UFrpJ62lBs/8sWU899JX62xyFJWMus/Wd
 aVz5hMKReYPr2aBZ27qB13nyRo5+JugLgBGIyoswYxQ2rVC5iNEW77poNbuGnn9bQCnIozChg
 1go5OIwy2mKBdYLtBWXjfMrajv76V9JvBznUsAbjTkZdH99aizmzz1Lsw5tkg+JlES65SCvXg
 +JxmknOM2vQzOj4Gxbe4zOjKCHcC+aDA/LuJJiw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch i have flickering/horizontal distortion (looks line ever=
y second line has different x position as one above approx=2E 5 px) on my 1=
280x1024 tft=2E

Fbcon is unreadable with this problem=2E

Hard to describe by words only :(

Am 28=2E August 2020 01:46:07 MESZ schrieb Chun-Kuang Hu <chunkuang=2Ehu@k=
ernel=2Eorg>:
>Hi, Frank:
>
>Matthias Brugger <matthias=2Ebgg@gmail=2Ecom> =E6=96=BC 2020=E5=B9=B48=E6=
=9C=8827=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8810:28=E5=AF=AB=E9=81=
=93=EF=BC=9A
>>
>>
>>
>> On 27/08/2020 15:41, Frank Wunderlich wrote:
>> > Hi Matthias,
>> >
>> > any opinions about the dts-changes?
>> >
>>
>> they look good to me=2E
>>
>> > maybe series except the tmds-Patch get merged=2E=2E=2Eso i add it onl=
y to
>my own repo till we find a better way?
>> > currently mainline does not support hdmi at all for the board=2E the
>tmds-patch is only a fix for specific resolutions which have a
>"flickering" without this Patch=2E
>> >
>>
>> Well let's see what CK's opinion=2E
>>
>
>Because no one has comment on this patch, I could apply this patch but
>I need you to add more experiment information so if someone meets
>another bug, he could fix his bug and consider your problem=2E
>
>Regards,
>Chun-Kuang=2E
>
>> Regards,
>> Matthias
>
>_______________________________________________
>Linux-mediatek mailing list
>Linux-mediatek@lists=2Einfradead=2Eorg
>http://lists=2Einfradead=2Eorg/mailman/listinfo/linux-mediatek

regards Frank
