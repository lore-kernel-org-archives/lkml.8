Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AF9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9C252087D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="e3sJovM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgH0OCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:02:23 -0400
Received: from mout.gmx.net ([212.227.17.20]:50229 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgH0NmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598535710;
        bh=4quNDffXBr7xu+P8AYTF5B4Q4KC4iGb6IlNPmZ7OG44=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=e3sJovM3KqoNxeIq1/5pBzS+ip7jqoLwC9l9PlkeAZzaIDk5KZbPCIKsQ6rV2luSn
         uqWuwqbAyWcccWgkiwhmNF/tHGIGM11V+0ZhWnufh46+NPelcGb/ogBS63ui35TTXf
         0wzIiMwmUnHQetmDUnt70YSjg8+3NI0g6ji4yKcg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.146.7] ([217.61.146.7]) by web-mail.gmx.net
 (3c-app-gmx-bap26.server.lan [172.19.172.96]) (via HTTP); Thu, 27 Aug 2020
 15:41:50 +0200
MIME-Version: 1.0
Message-ID: <trinity-ddd51146-41eb-49ae-9456-4588450d31aa-1598535710011@3c-app-gmx-bap26>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        chunkuang Hu <chunkuang.hu@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org
Subject: Aw: Re:  [PATCH v5 3/7] drm/mediatek: disable tmds on mt2701
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 27 Aug 2020 15:41:50 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <81276d4c-8883-8bfd-d7d0-9b9ac025ed97@gmail.com>
References: <20200819081752.4805-1-linux@fw-web.de>
 <20200819081752.4805-4-linux@fw-web.de>
 <trinity-14a1b182-38ab-4f84-bb72-94d448b05fd5-1597994235320@3c-app-gmx-bs37>
 <81276d4c-8883-8bfd-d7d0-9b9ac025ed97@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:Qlp+wHkbak6pBZ5/7qykL04OknqT6U+WwH+B4u5tOtj3VmxF1XWSKrFYv2a1JnOA+i2Lc
 Hg2GwIs2jHrdNRuqRMAtCHBi/k4/RlQ99TTbKd3kElatLj3MdORZA1tUpyXWgo3l49SbXwC4yj/M
 LsWL+SJ4s2B+GEGWo+MoSBMhBUk04FIzI+8sYIdftad7aGEgMaAF9ze5jPqQLlRJbnQ6v66K2SKI
 ifet6FKzp2K62Ov2c3YltC4L6NbYXmQEMDhBvjZC7ybq//eKEAcT1eE6cw+WoWDwtZpst8hVn6oW
 UI=
X-UI-Out-Filterresults: notjunk:1;V03:K0:h5tkjHGfYDU=:lPmXLFE1B8AX3Zy3CbIsRD
 s3VayhK0/M/yARQry0GUjQ5SQ/cVYMkllZIE0P5rQMgq99bx4K4Frj56LvcjoWVW9Dq0lnl9V
 8tEP/JgYwaTRELytQ6wzIsL1iT9R8N0SrgvWKHxoeshp4XfROVxrFBMBywPqL6GN/dTQKSahO
 olxlvZ0BKTn4rEqfQyJbwlEcSbapgGw+c2dPYFy+H2jLCzYdK9yJHVUcANPLJpkUFH4sIjeIz
 WEESP+gE41YkuahFPE6LKdC1SOMvqgUYZvzUZVQnN4oSLbearFiLbMolaegP5D1mde4xlLIaz
 PRE8U3SxgvkzmPaoocV2OZh9LHWXUIihI/d54ZD+n80KekMosV2o1V4T/oSGwm50xfFUQXDaI
 64++WExLDIV8BPHmWAmwc0KwXdQa+GwMJ8Lb4lIPk3uh6ybmq/RyAXXTIXh1HI825htbnZ9BE
 0QvCEmZN993Rkwu4IxmDbrNW2ux6TN6zBTSohvveBWurA5jol5hISl6oj9RZnSZUNbzqYS29M
 PPcTZ7jZA7F4cy/rX+b+5jr6woxNeuyXPyz0vMj3JBSS+KZUho+pWx9DNs7mZvtPgspguIL+e
 GBhrExP6PHJPYN0w936PQ3XA7YTUEE2y4TOF9QCfu80Zc1aWHiAKUo6cn0nhwFKuiIcsA+sFn
 aWDahsL08vUtEYS6ALCRT6XHEN3lT1UtI2rMrV3+NTEvCQs2xcTKXAN7AoYkz4e3K4BI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

any opinions about the dts-changes?

maybe series except the tmds-Patch get merged...so i add it only to my own repo till we find a better way?
currently mainline does not support hdmi at all for the board. the tmds-patch is only a fix for specific resolutions which have a "flickering" without this Patch.

regards Frank
