Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC694C4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835612467F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJAIwt3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgBZMqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 07:46:15 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33728 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgBZMqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 07:46:14 -0500
Received: by mail-lj1-f195.google.com with SMTP id y6so2978023lji.0;
        Wed, 26 Feb 2020 04:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qgJPSpfwkB4wpHwVPaSt8tJmm/cC07E5aTtE/ZGtNew=;
        b=hJAIwt3XqcA6vdQYlW5DN1YmEqE1lXwSUL3D9lMIL4oTQ7g/Q+sMxozuu5BCwAIyXC
         fhi9rbfJsXmquyo1vwBRXfm2gwf/M0mMzhFe9uO/CFpITOf4artAjfPx4sbGj4W8hleM
         MJ48U6K3xxgtdkGcRBgifFExebZTmpC4sEy+2rWNtahDhyvJWx2JR8ckHSASBcef/fdi
         yvlAoM6IgumqA7T1upMmzuC5zMxU/5VCAfVYp0MCElHeH5VHFbBh1ogjysPJtu8WqhRK
         OOfuAwOnM7TWmV2/O6u/dLAw6LWaGj487oyJyQ/JJM8kRHSeqPQCVVO/qo8qgUtmr8Ga
         2jNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qgJPSpfwkB4wpHwVPaSt8tJmm/cC07E5aTtE/ZGtNew=;
        b=Oszo+MRO9mI9hAm6oa02gQ8lgjElR7otptitAh5mjEYUunlXpYuX5C9UmyoEQpUdei
         Afg8FTP8NEBA4+VPNqvK5d32Zq/DbjeRDa6g9xevzqEBqri11aMOwi6jsucLFoEzk3OW
         GdXSSHyr5iz4CRiDMaghjHgDovJVtdJQvFJYVkz+5B18pql1cNm15CZocMnXXLkdsOX4
         miQwVCrcTWZ+tclp/KepX3LZOpjOr2IB7/H9rTPNE3Zc9Xx5dQIjQAXNf0F4SogTVhZN
         6fVkOvYHCQ2Rac4MY6fCuQFM5ONL3UwHuG2QZkLdI+JMFlFN+vIJ3mVR2LvKeRiapxgX
         h4fw==
X-Gm-Message-State: APjAAAX+DL7o7ENslAP7yc/uMfOfTtAhKltbzmMWpQIS20SEH824I5Os
        QOfEcoCPFke71LQNUvc3zV8PqAm/ZDvwzMPytaSxLA==
X-Google-Smtp-Source: APXvYqzaHbc9A2c9xE2edfnUWxJTjRVKLCIJGvlkTyklIyTN06zsZhz4ISWpDA1VVtf7NNjiq/hDCBcwaUp3aSzRtyE=
X-Received: by 2002:a2e:2e11:: with SMTP id u17mr2865444lju.117.1582721172264;
 Wed, 26 Feb 2020 04:46:12 -0800 (PST)
MIME-Version: 1.0
References: <20200224062917.4895-1-martin.kepplinger@puri.sm> <20200224062917.4895-5-martin.kepplinger@puri.sm>
In-Reply-To: <20200224062917.4895-5-martin.kepplinger@puri.sm>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 26 Feb 2020 09:46:01 -0300
Message-ID: <CAOMZO5DV9JY=7Vg3RL_T4W_8yb1DnLThmS_LWM45uWAAgeXwQA@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] arm64: dts: librem5-devkit: add a vbus supply to usb0
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, kernel@puri.sm,
        Yongcai Huang <Anson.Huang@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Mon, Feb 24, 2020 at 3:31 AM Martin Kepplinger
<martin.kepplinger@puri.sm> wrote:
>
> From: "Angus Ainslie (Purism)" <angus@akkea.ca>
>
> Without a VBUS supply the dwc3 driver won't go into otg mode.

Since this is a bug fix, it would be better to put it as the first
patch of the series, with a Fixes tag and Cc stable, so that it could
be backported to stable trees.

Please rearrange the series and put all bug fixes first with Fixes tag
and Cc stable.

Thanks
