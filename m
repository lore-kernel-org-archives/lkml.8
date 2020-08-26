Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A48DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D85F720707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQw18JNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbgHZNuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbgHZNtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:49:36 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C212C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 06:49:35 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x77so8909lfa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 06:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XYm7Tduo8NWl5UNwRfQK8+cTzqgeaWnEyTZDJt6ZL0A=;
        b=cQw18JNOYdqf3sOurYRlourg5Md8zuitXIUOSC1+hAVeZIFeF7Y+VybvHHm/AsDTFh
         x1R5+XVIFzrI5xR2M2+xU86dR9yFVT1Rw+Gr+TtzOykldPfvxeoilXjnA6PGisH539I0
         DgtcYc1Dix0XcbBSo+sxcGJU2WLLHLrLJVnJTyoVzIUy5pUhG4Rk2T5RbgJywhruD56q
         bg9+5MO5PUvW2zxb/fUIvTKZt9uRLAkSQDhh0CBm0882P2knFBlD2eqi4B/cz47hbsJk
         dsz+t4E8spMvWm92CmYiLuxgckD9MVzt12YvP5PR8e88Is8XB/G272nfv35rPsD6FiSa
         aFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XYm7Tduo8NWl5UNwRfQK8+cTzqgeaWnEyTZDJt6ZL0A=;
        b=UftigrXWzNXusBXWPW6UufDxm2kLLNhE1DnVbKWQnlveQ86feky6zjaoJVMp6PdH4o
         SPLh5YNMGbXMwI1lS3Qorn8rvYcu0D889BsXzsl/430EF7kq7oBW7WqL74KfwsNd75zY
         UMhhlorquW6S7ZpeOw7CdXGePmpGMtOsVSPFGsZUgJOay4nLaHHnCv4RlemjY0ya/nti
         wUUJMdauTWSbJqlvdB6F9Y/nAG4no5BwFvuOTXQYcadSgi3nTSakcK7JG7IHpiW+Z0Bc
         BAmgLaySbe1Z6Cz/bXebNxULO5mgW6KGldRysg0jStqTVePwQDoU5yF5H5+PvR/DI0o+
         4xmQ==
X-Gm-Message-State: AOAM5301e2FcAXvdcp/x97UET6GegtU0bbOfXNoh0Z8u+RODODxzExT4
        KQLCdOzG3OZ2Gp9euGELJSVr/sjZawMRQbmTpZo=
X-Google-Smtp-Source: ABdhPJxVedw5wDUoff9RgpfDnP2MJ8QistoF1SlV7wu7KGXETn4R6i8GLZTyfubdJ9A4bPs35o56F2wDe8uwVYlwGPY=
X-Received: by 2002:a19:306:: with SMTP id 6mr7488144lfd.214.1598449772436;
 Wed, 26 Aug 2020 06:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200824091013.20640-1-matthias.schiffer@ew.tq-group.com>
 <20200824091013.20640-2-matthias.schiffer@ew.tq-group.com>
 <CAOMZO5DSX1pf3xxo=CGvgPmHcjMJoWFx74grVJBckSmjtF-RGg@mail.gmail.com>
 <4b7d57738ce8e2130c4740a0f3f973fbaf60a7cf.camel@ew.tq-group.com>
 <CAOMZO5DYrkEb_G+EYAGrc+qjSsbjRdeBUU3tJUfkU6tjgNm_7g@mail.gmail.com>
 <7a59492e46f34d213b83f7182c7db73954c5a9c7.camel@ew.tq-group.com>
 <CAOMZO5CP=wtJ5ZScyb0NrRMW0FR0FAGVKRFq9JpFcAoZppn_bA@mail.gmail.com>
 <53f5f17735fc2f0ca061a321969bbb131e55efff.camel@ew.tq-group.com>
 <CAOMZO5ADeXEHWiG7Xja1W1GnahV08ZEYSkNsrOzautn2mROCNA@mail.gmail.com>
 <aa0b7ad149a7bd4e681e4ebee12ffaaab2803832.camel@ew.tq-group.com>
 <CAOMZO5B_Jm8SX9N9V5oq+LAa0Yc4CmrEp2n=2t3XUyBCtnGVTA@mail.gmail.com> <d433e8a47d721a65903db68c38eb1c337c81e395.camel@ew.tq-group.com>
In-Reply-To: <d433e8a47d721a65903db68c38eb1c337c81e395.camel@ew.tq-group.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 26 Aug 2020 10:49:21 -0300
Message-ID: <CAOMZO5AfuPXfOmRSXAmyG-bdqGSzvTRm51NuTJ-B2PzKbLy9mw@mail.gmail.com>
Subject: Re: (EXT) Re: (EXT) Re: (EXT) Re: (EXT) Re: (EXT) Re: [PATCH 2/2]
 ARM: dts: imx6qdl: tqma6: minor fixes
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 10:13 AM Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:

> Using GPIOs for chipselect would require different pinmuxing. Also, why
> use GPIOs, when the SPI controller has this built in?

In the initial chips with the ECSPI controller there was a bug with
the native chipselect controller and we had to use GPIO.
