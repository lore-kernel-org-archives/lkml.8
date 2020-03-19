Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D780DC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB5120774
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="Qx4UOPeD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgCSUtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 16:49:49 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45988 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCSUtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 16:49:49 -0400
Received: by mail-ot1-f68.google.com with SMTP id e9so3850630otr.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 13:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kyf9ajsDR4vppAgtNsM21ihbXytHvjaLDq9vutqF0Ow=;
        b=Qx4UOPeDeAXY7YtTyphjv7NW1pUfalmORDqsPGqF3oMer7S9vHDnPTqDb/GbNTIabD
         YFY1UdwynVf2OPtuDZSrud7apoNYFrG2S5rPF2fgv+LXlr3NjGlIOsHoWlsIbDkLmIQA
         /sX4ZD1zud1H24z3wvGB7Syk4AqwlBXw+zKUYVvhpESNcP7VQG0IMH/1hKYd9WtLbgI+
         tkex+3lFg71V/Aai2J74wMGkJ5rC0nx+q0xoYdOs1G+xwQE7MbcF7bBicyLduY5OUcec
         moFPsa0TpyubUErOHpUgkQyXc9z4go+Qg7gG5qivHeGQ5fiHjxlfyvPaH4pB6CiAwhBf
         neTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kyf9ajsDR4vppAgtNsM21ihbXytHvjaLDq9vutqF0Ow=;
        b=tD0NVjdTbQIZKtRxWsVD/PLFwAQmntPlDJpk4MrdhrlEVwbQg6UTXummv3Xfb4k7pA
         GxOr9V3YnrMFS/khlDA2rLu8pEOHFJ/JcH02D5u3XeKh7P+LALgIaHuvClWXEpBvKuaX
         NG2jnyADVr3+hAH6ErDJZkroxGaLsvJ4xj0Jk7RGgev6fsLmbsmRHGbWjPqpO6yG9AQx
         B0zOeSxGzbl/oI0maOn0gRP9M/x4+shF5MYR+J6WJ05yeRTfcV8EZO3WFRTDlB3m+qu1
         NzZfZQpzwcYxpGrsyp6KuTMxEzJa5mKpiHmNMa90hZ0S5TkA5QBuOPwgQmA2+xUTHZeD
         +loA==
X-Gm-Message-State: ANhLgQ1bkCi/ltUhUliSqhmgpDdi5VOj0pLe1D7xhJ1YHAybO+/Of4fk
        jYdI7ntwEKylzAVNy8Bjg5gJ6uLRzIaCpC2ZW8DxYQ==
X-Google-Smtp-Source: ADFU+vuqkdgiVtQGhhHLai1JnzgDoVhjusIptb9AQOM1sFQLW+udrSlRkNFjBlfJV/724Z4ANjmbIaqm1SOWnNWOnaY=
X-Received: by 2002:a05:6830:1e38:: with SMTP id t24mr4047611otr.33.1584650988486;
 Thu, 19 Mar 2020 13:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191212071847.45561-1-alison.wang@nxp.com> <CAGgjyvHHzPWjRTqxYmGCmk3qa6=kOezHywVDFomgD6UNj-zwpQ@mail.gmail.com>
 <VI1PR04MB40627CDD5F0C17D8DCDCFFE2F4550@VI1PR04MB4062.eurprd04.prod.outlook.com>
 <VI1PR04MB4062C67906888DA8142C17E1F4550@VI1PR04MB4062.eurprd04.prod.outlook.com>
 <CAGgjyvGAjx1SV=K66AM24DxMTA_sAF2uhhDw5gXCFTGNZi8E7Q@mail.gmail.com>
 <VI1PR04MB40620DD55D5ED0FDC3E94C2BF4550@VI1PR04MB4062.eurprd04.prod.outlook.com>
 <20191212122318.GB4310@sirena.org.uk>
In-Reply-To: <20191212122318.GB4310@sirena.org.uk>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 19 Mar 2020 13:49:37 -0700
Message-ID: <CAJ+vNU0xZOb0R2VNkq6k3efdkgQUtO_-cEdNgZ643nt_G=vevQ@mail.gmail.com>
Subject: Re: [alsa-devel] [EXT] Re: [PATCH] ASoC: sgtl5000: Revert "ASoC:
 sgtl5000: Fix of unmute outputs on probe"
To:     Mark Brown <broonie@kernel.org>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     Alison Wang <alison.wang@nxp.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 4:24 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Dec 12, 2019 at 10:46:31AM +0000, Alison Wang wrote:
>
> > We tested this standard solution using gstreamer and standard ALSA
> > tools like aplay, arecord and all these tools unmute needed blocks
> > successfully.
>
> > [Alison Wang] I am using aplay. Do you mean I need to add some parameters for aplay or others to unmute the outputs?
>
> Use amixer.

Marc / Oleksandr,

I can't seem to find the original patch in my mailbox for 631bc8f:
('ASoC: sgtl5000: Fix of unmute outputs on probe') however I find it
breaks sgtl5000 audio output on the Gateworks boards which is still
broken on 5.6-rc6. Was there some follow-up patches that haven't made
it into mainline yet regarding this?

The response above indicates maybe there was an additional ALSA
control perhaps added as a resolution but I don't see any differences
there.

Best Regards,

Tim
