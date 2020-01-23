Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEE4C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DD42087E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L8NE79R9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgAWPHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 10:07:12 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40834 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgAWPHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 10:07:12 -0500
Received: by mail-lf1-f67.google.com with SMTP id c23so1652151lfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 07:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LO2b8uVYVBtkLDQSkWiZOiZeR9UaVRc6c7oLAxiq0hs=;
        b=L8NE79R9J3d4CO6b59XTiUIFYotqfCg7rEI6/iByzUEA3FODTd/T6JOtG8bUKnUoc6
         78/roEZXuyoIbVFDHsUiAr48VYDPT65EQBJoADV/TRCYFM+GsDEAl8jXJqvy93dy66Of
         yqwZ2YcadIjcEOjCnxXmFlX+4e97Tn88hLMiG49i4NKufYwLjwe9IcD6IoRu2so+ShEy
         Aqga92LMx7pO0sXUS5lkn2zDNOYjilWoxQRjLsWdenwGBUqr5Z+F2fYwnWlngIywgiEK
         QHr1OI+M7XuvC0jZ0rufP5WFZYbbOtwrNIch5Fh0Q3+TwyldE2Ops76pGUemkVFhyPeJ
         SRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LO2b8uVYVBtkLDQSkWiZOiZeR9UaVRc6c7oLAxiq0hs=;
        b=JvOX/nHxkgkaJzIY+BXcfvtVYWEy3zzPWc0E4PZb5v1WEabQ+RLjo/wkFP4npkyNUK
         4sO9BLw0ecX7thnNOF+pKxS32+FzMl7HK9AGdzkyu004HtOp1X9HuucuQAm54et8knDl
         Akzwb/OcH4dkPHWbAzpftK7bq75Qc9d4XRzZZrDGymqIVgbqd1doEruJvnNt84PmZzoa
         j4QVM5xOOjwhVSD6/qPYZb7rLnZonAkZl9/mXUXiZANGp5rxTquMLp6pyWhaIJqhAT/w
         F0GvNguli3srm9gmZZ4btsHV2Ko+d/gI8T28r2TcDPi0CaByLH0kfAN2ANNTo89IfN3k
         AaHg==
X-Gm-Message-State: APjAAAXrXqA+eg3ZzV+lFUWF9WcsQMTc1VqPbMs45TF2AN9dnzL8mXjt
        NeN5E/V8XB/zP+AbNeiQHeU9y5/5+hzrdriQOivm9Q==
X-Google-Smtp-Source: APXvYqySCUYd+U3ZvPuMwCzrM2ftGIrgnFPVoMuA9jR8gZ3PcpcdibtTAWSuOFjbM8o+bjA9sAjze4V6fKpgDMdCUSE=
X-Received: by 2002:a19:dc14:: with SMTP id t20mr4884795lfg.47.1579792029804;
 Thu, 23 Jan 2020 07:07:09 -0800 (PST)
MIME-Version: 1.0
References: <1576672860-14420-1-git-send-email-peng.fan@nxp.com> <AM0PR04MB448174E1DE647E9F2F65106988360@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB448174E1DE647E9F2F65106988360@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Jan 2020 16:06:58 +0100
Message-ID: <CACRpkdbi8KTEEEpv0fv3Hq_gyRqR0Kzeb799P6woq7+xwhdgUg@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: mvebu: armada-37xx: use use platform api
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 9:28 AM Peng Fan <peng.fan@nxp.com> wrote:

> Hi Linus,
>
> > Subject: [PATCH 1/2] pinctrl: mvebu: armada-37xx: use use platform api
>
> Would you pick this patch up?
>
> Per Uwe, this v1 patch use %pe is better that v2 use %d.

OK patch applied to my devel branch for v5.6.

Yours,
Linus Walleij
