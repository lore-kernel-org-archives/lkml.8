Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C4BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D54E0207CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1UPOd2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbgEZLkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 07:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgEZLkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 07:40:01 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B433CC03E97E;
        Tue, 26 May 2020 04:40:00 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j198so4859579wmj.0;
        Tue, 26 May 2020 04:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XNz9J6b/OZ2/1Fmez/GnqprE7eisy/1+uGqJfTQOLC4=;
        b=I1UPOd2vABdAgPxVneTOoP6tzj7xsCGRvOyr48UXRni0gpsT73O9sUzt6bpt9joQ9c
         qLSUnyrLyk/vOjwAhPxEsbAagm5ZeyQu0b+SQv26I6y7nz3lUI37rAijnWn2OeEA9HBI
         CyucIRXauIONPkXv7CAJVAf7J6nx1z0aHePaD8Q0dh2PU7I9pOQrm1OGisaurBL5HDFk
         SE8VVwXSrWfaH9+yA8xNasTY2UtUxOLd61G6D0GO3OlYxrnAVRQuUfZS5B5QDl9uMcBt
         Ks+AvkW9VHguZwPrkcFVlheKfLq7OTeyshjqrzI/ZRIwkdSnZSkm6ABJglXylBR2NLHy
         wQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XNz9J6b/OZ2/1Fmez/GnqprE7eisy/1+uGqJfTQOLC4=;
        b=nrb2JPjjTkqcItiVpuvoGnfs7y5Kig0mTpGGSodcpPJs3mbE99Yjsi2FUi8MYj574P
         s2z6qedKJy+di3BPLv8U53xqF+sdV71+/ije+WV3cv49qjRjCt/ZMA4FsNaljQHq9kqE
         u0dZbdy0SV4Fg18zIbZ/l7YU5yQKAnLns1nIgqojoVoJnoMq5yrRvzK7e9QUuAUIIqQO
         7FPnbFtnCNWZIiyTvM+Rd0btmfQ0KEDagvOQCrsGw2Hr4OIXV1QpOnSt0aTZRAq4Igvo
         ugiiiZzsEyysj79myOURwW0LRpHLed1CBTxc1uJP+cb1m8RxXZRK2lqvsQs5vJoTkHtj
         QIKA==
X-Gm-Message-State: AOAM532sSEDIJAQ/yy9p+c3cHe4RkdRD1jmQjQAqIEOTrRcTGeQ0cB+h
        i36PjJ05ODG5A/U7HKr9YnuclUb5eMOQZjYE5kU=
X-Google-Smtp-Source: ABdhPJyrNBm0FnRwRbiS9MIhci3lGQnb9jCFVoa7fhtDCFX+azNqEJP4JBuYkUlsFFtwtUsrOcdqCXJvlgMf3wA7HqU=
X-Received: by 2002:a05:600c:2313:: with SMTP id 19mr1059849wmo.51.1590493199402;
 Tue, 26 May 2020 04:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200514155737.12160-1-martin.kepplinger@puri.sm>
In-Reply-To: <20200514155737.12160-1-martin.kepplinger@puri.sm>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 26 May 2020 14:39:48 +0300
Message-ID: <CAEnQRZCJ_+V1+bd4JsWBqJVNu6-ETckxsD0qvkr48in9mj0J8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: Add a device tree for the Librem5 phone
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Rob Herring <robh@kernel.org>, kernel@puri.sm,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, mchehab@kernel.org,
        Anson Huang <Anson.Huang@nxp.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 7:02 PM Martin Kepplinger
<martin.kepplinger@puri.sm> wrote:
>
> From: "Angus Ainslie (Purism)" <angus@akkea.ca>
>
> Add a devicetree description for the Librem 5 phone. The early batches
> that have been sold are supported as well as the mass-produced device
> available later this year, see https://puri.sm/products/librem-5/
>
> This boots to a working console with working WWAN modem, wifi usdhc,
> IMU sensor device, proximity sensor, haptic motor, gpio keys, GNSS and LE=
Ds.
>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> Signed-off-by: Guido G=C3=BCnther <agx@sigxcpu.org>

For audio related part:

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
