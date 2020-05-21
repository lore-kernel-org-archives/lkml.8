Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDD2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAA8920748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="WyRrdUVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgEUUji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:39:38 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:55440 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbgEUUjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1590093575; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tqs4AvNuoDMNDO2I27A5TOgvOdzT2DKGMDK0YpZqlAc=;
        b=WyRrdUVXj3rYXqc/O6lsvlXriCtU+H2xdG53omV1Mr5AgQiQpxq6KMlithFeoGGOm6Vc3I
        je0VDVoCMS/4gf370xlISMucr37kPmMPYqPU9drgcwUJeyyesEboP8AMaanf7Zle7VPJnv
        44qnzVuLuPyKOYqiAUjcz7wVl3SvWu8=
Date:   Thu, 21 May 2020 22:39:25 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] usb: musb: jz4740: Prevent lockup when CONFIG_SMP is set
To:     Bin Liu <b-liu@ti.com>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <P18PAQ.NMWTDBTHKARL1@crapouillou.net>
In-Reply-To: <20200521203422.GA25575@iaqt7>
References: <20200520150111.76658-1-paul@crapouillou.net>
        <20200521203422.GA25575@iaqt7>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bin,

The patch it fixes was introduced in 5.7-rc1, is it possible to queue=20
it for the next -rc? Otherwise I'll need to Cc it to linux-stable.

-Paul

Le jeu. 21 mai 2020 =E0 15:34, Bin Liu <b-liu@ti.com> a =E9crit :
> On Wed, May 20, 2020 at 05:01:11PM +0200, Paul Cercueil wrote:
>>  The function dma_controller_irq() locks up the exact same spinlock=20
>> we
>>  locked before calling it, which obviously resulted in a deadlock=20
>> when
>>  CONFIG_SMP was enabled. This flew under the radar as none of the=20
>> boards
>>  supported by this driver needs SMP.
>>=20
>>  Fixes: 57aadb46bd63 ("usb: musb: jz4740: Add support for DMA")
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>=20
> Queued for v5.8. Thanks.
> -Bin.


