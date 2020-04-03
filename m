Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F25C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90772073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SA0JPyC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404544AbgDCQZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:25:25 -0400
Received: from mout.gmx.net ([212.227.15.15]:33153 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403971AbgDCQZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585931109;
        bh=7FV3hj5CWeqQR3OUff6ZWxLHWef1NywoQKrDysZiVW0=;
        h=X-UI-Sender-Class:In-Reply-To:Date:Subject:From:To:Cc;
        b=SA0JPyC3SQWqDg9KXsY+j+dx6lv6QKSyj4y87aTTWWFPHvb1K4SYvFuZgbd/PqQC6
         nezfaJjNY/NUDfKp0fQrrF+lvg12m5vN6YYDA/A3opsXl+GT/FxalAQLKliSwr5+w+
         2V8twwq/bphZHBfkW3G7USvGmjk1tD/KP8mVsJYE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost ([82.19.195.159]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHXFr-1jXJI40dN3-00DXel; Fri, 03
 Apr 2020 18:25:09 +0200
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Originaldate: Fri Mar 27, 2020 at 4:29 PM
Originalfrom: "Alex Dewar" <alex.dewar@gmx.co.uk>
Original: =?utf-8?q?dma=5Fpool
 =5Fdestroy()_already_checks_for_NULL_arguments,_so_th?=
 =?utf-8?q?e_extra_check=0D=0Ais_unnecessary.=0D=0A=0D=0ASigned-off-by:_Al?=
 =?utf-8?q?ex_Dewar_<alex.dewar@gmx.co.uk>=0D=0A---=0D=0A_arch/arm/common/?=
 =?utf-8?q?dmabounce.c_|_6_++----=0D=0A_1_file_changed,_2_insertions(+),_4?=
 =?utf-8?q?_deletions(-)=0D=0A=0D=0Adiff_--git_a/arch/arm/common/dmabounce?=
 =?utf-8?q?.c_b/arch/arm/common/dmabounce.c=0D=0Aindex_f4b719bde763..a7c77?=
 =?utf-8?q?6cdc38f_100644=0D=0A---_a/arch/arm/common/dmabounce.c=0D=0A+++_?=
 =?utf-8?q?b/arch/arm/common/dmabounce.c=0D=0A@@_-560,10_+560,8_@@_void_dm?=
 =?utf-8?q?abounce=5Funregister=5Fdev(struct_device_*dev)=0D=0A_=09=09BUG(?=
 =?utf-8?q?);=0D=0A_=09}=0D=0A=0D=0A-=09if_(device=5Finfo->small.pool)=0D?=
 =?utf-8?q?=0A-=09=09dma=5Fpool=5Fdestroy(device=5Finfo->small.pool);=0D?=
 =?utf-8?q?=0A-=09if_(device=5Finfo->large.pool)=0D=0A-=09=09dma=5Fpool=5F?=
 =?utf-8?q?destroy(device=5Finfo->large.pool);=0D=0A+=09dma=5Fpool=5Fdestr?=
 =?utf-8?q?oy(device=5Finfo->small.pool);=0D=0A+=09dma=5Fpool=5Fdestroy(de?=
 =?utf-8?q?vice=5Finfo->large.pool);=0D=0A=0D=0A_#ifdef_STATS=0D=0A_=09if_?=
 =?utf-8?q?(device=5Finfo->attr=5Fres_=3D=3D_0)=0D=0A--=0D=0A2.26.0=0D=0A?=
 =?utf-8?q?=0D=0A?=
In-Reply-To: <20200327162914.24948-1-alex.dewar@gmx.co.uk>
Date:   Fri, 03 Apr 2020 17:25:06 +0100
Subject: Re: [PATCH] arm: dma-mapping: Remove unneeded NULL checks
From:   "Alex Dewar" <alex.dewar@gmx.co.uk>
To:     "Alex Dewar" <alex.dewar@gmx.co.uk>
Cc:     <alex.dewar@gmx.co.uk>, "Russell King" <linux@armlinux.org.uk>,
        "Enrico Weigelt" <info@metux.net>,
        "Allison Randal" <allison@lohutok.net>,
        "Kate Stewart" <kstewart@linuxfoundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Message-Id: <C1RPNOAB4OIV.1TTN7HLN0EYD@lenovo-laptop>
X-Provags-ID: V03:K1:tbuUIrGyiCaAhpS7s0piVJYeAudA2ncpvdZHVVYmXXlo/Pcr1oL
 M4j5SZWusZxkduIp11sIv2ZabbjdlxJq0z9q5oW1Xt2EeGSE4ibeGFUtEtT99+tgxqG0mlj
 8amfFZzt3BYvGSYMt1Z9PDye0u9ALZ6UOQ9rj3Ogxg5/KtUIwnhKfZdbEVaTOwP29fdpZSx
 XqZUlrBnLDgfHSZX4ZJxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dffSsgLKB4s=:cj39Kzeb2UxWUVBpVGpMi1
 Aunz0wGqa69jRXk/Wbq99xYM0E8dLwaikZ0Tn+V7GEJB5ql0344OUWKSoEEx2GaZg2DSOWUbf
 wey6maryh7IGNXUMpFeWBUEy7ln7MKqI2r7Tg0q++2YXbPcUe5DieqbJYW3cTcq4YGu8nJZqk
 DGXTid26l7RUV+wglgoCTMJJUxULhRsm5W2krZLdMChW1Igl8voZpyAsTficvqeMQJ2490hce
 H0j/2/vpM+wM50vGV9k8WFgTn5uREUGUwU/xNPM+HXyv6tcw1OHsU53yTfAZa1aBdtjqw7LCJ
 TGnVi8IEVc4BPwE6En4JBYPBL7KxRFr1qTa7rk1e+PacQI5iZXTOvdbEkGCejQSCCDDpHpYyf
 1s4ix/DFL0p87PiHjHsd4lywma00pshcw3QdZJDSWssHKd9jhmt/KatoK4GL4ZQnfLaxc+8ow
 HvK1nri7ibmNWrlIKMwNWwVzQr5mveJtGPyyhnCeKcyhu/42bM2GUTDtMPUN9Hd1SGwIHgWB9
 yv4J1BhpHKqYP6JxGPifpNlzjZo1EJ0iq1V5vOhR7O5P2+tTaQs5GJ1ZiBVyxMhqtXTG7uPEN
 dDQoh3w9ySHnjDqGGbpMnonaxlEuqreARBiGUJlesALh/qXeCjma/M3Yt/tcU5rpoOMYmdXdU
 w1wUM6NeSjDTzM6g63lRhs/sNzRcFJmAzca/QajJqpQSVM/B95fQDrAg414pY5t8WlpMPJXd3
 3AHaDZ8Cg3dJFz1S6e/QzgwzxIliKeHlMLIe5j5sCVAPf92d2UPtP+1zXwI+EkBFduYHp7nSA
 MLe0WHiQvj5NmQ6Z4OeAYZ/ceOuRWfRXJkg2jVz8fI+fEjI6BJHulhodplk0Oj5yOpTJe8Myj
 ST1R5tIxu0F31Gxla8QRHKHFJ4NH3uL2q3ebYh4utXIILoMfFSy7XmRsa7WMvq8dxUyh6bEXs
 WUmhXyTce6lZUQsg15w/URHyTHeYbL+cpvnKNzqthKKGqA/VnG9twV4YTdNz6RCNHZ2/CARfq
 rg/Dr+Bw+8Vux0xnezXfOI+mcemKndI13sDPe2qkZjsBV/+ZLou9r6XLoxwDArRQegridTUPZ
 fZr5zirZ4msljV4BugMnKAS5jZoeaVQAkN4Yh7UXBGTutVVMU0dDEnm/8Kt0Ih2oO9VccyTVY
 rhJZhnInEGQoC0d38kY/w2n9yV6Kbkl4Hrlmqgarttz6wIi6DTTJ++zy5e0t8uw7p3VJ8hEbx
 TDX6KBCMcUj6S7AG1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Mar 27, 2020 at 4:29 PM, Alex Dewar wrote:
> dma_pool_destroy() already checks for NULL arguments, so the extra check
> is unnecessary.
>
>=20
> Signed-off-by: Alex Dewar <alex.dewar@gmx.co.uk>

Gentle ping?
> ---
> arch/arm/common/dmabounce.c | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)
>
>=20
> diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
> index f4b719bde763..a7c776cdc38f 100644
> --- a/arch/arm/common/dmabounce.c
> +++ b/arch/arm/common/dmabounce.c
> @@ -560,10 +560,8 @@ void dmabounce_unregister_dev(struct device *dev)
> BUG();
> }
>
>=20
> - if (device_info->small.pool)
> - dma_pool_destroy(device_info->small.pool);
> - if (device_info->large.pool)
> - dma_pool_destroy(device_info->large.pool);
> + dma_pool_destroy(device_info->small.pool);
> + dma_pool_destroy(device_info->large.pool);
>
>=20
> #ifdef STATS
> if (device_info->attr_res =3D=3D 0)
> --
> 2.26.0
>
>=20
>
>=20
>
>=20

