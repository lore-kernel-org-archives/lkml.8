Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A6FC33CB7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 15:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187102071E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 15:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="deMtnl3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgA2PBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 10:01:21 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37189 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgA2PBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 10:01:20 -0500
Received: by mail-lj1-f194.google.com with SMTP id v17so18797813ljg.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 07:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sl0aMJ8sRZgoVukqPOv8d6RJ06Z/tyLk7TNt6vzRqMs=;
        b=deMtnl3RJ9qIDAe8ySKPee8iLeDGsHO/LLb/UtJOGe8IEMpDwzi/TmeYieAncJajhp
         CURjpnXLNwKxVGvj2LG9XnuPS09dUEs57GNdugFNrVrzpUg7zS08JnaprdOyZSyKqgFg
         Jd+V63T3aTQ33cz6ABCHZVk4SpUFSF0S4X52Ww6/2qecUPQAjPF7dK0nOU0h+5r2h61I
         cpr2sI5h99PQQhvwa45cE4wxwnu/u5c0QlCWN4fWCfkRP4tVdD0x5VIZ+M3iV/AP/Col
         7uboZf4VBw/H/xWrsE0GkpV2138IXeM/qvgC1WwslV98YcdPUxWTawI4ryegCKbm1WAX
         Zf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sl0aMJ8sRZgoVukqPOv8d6RJ06Z/tyLk7TNt6vzRqMs=;
        b=ZcXu8KmuTDR6vcxllAEoFjg1hOj2zaKokSJePk+CYVYpnZfQg1R3qpSRZTo4mqMDcD
         +Fj1vwAmKnu4QTvt7e5TyowEe/aepWkct01kI4QGXjaiuOY2rj26KSz5fgRMID2SIF/x
         CqNqMU3L6KzEdvm+S/cIbxAWV7Pftxftb3sTZKEDfqCjJf65bHjZfKFTpfghvto5C+yE
         fyeu27J9jG3LPNeKWlwTEiHaHDqti24LgdnfBI0/qRt2SFqklv2K+amubkqCjSjxojIB
         pBmJjNvGDEAkYGuR6D4R+wC8PKBwD40d/D5hVH5bnMc+jviyOoIeZexKsZ8YclSGFgyu
         Qbbw==
X-Gm-Message-State: APjAAAV2UgCBrqqoXiRMeNrrVwGfDFkRrV38O2EOWE6V8wOZUjVo3Q0r
        F1AZOUODdhgcgOn3VSiTTRgDIT6ZY2xpqXrAcJ1Eng==
X-Google-Smtp-Source: APXvYqzYBSzAXoljwWCWBwM7qrgJKjiYaZ1cu+RfrgsHxJUVkuN/rLf5IKtiKRfVRyG0+4dfYQ32YkYpyJX/PvVqLFQ=
X-Received: by 2002:a2e:8e84:: with SMTP id z4mr13884597ljk.207.1580310078530;
 Wed, 29 Jan 2020 07:01:18 -0800 (PST)
MIME-Version: 1.0
References: <CAN5uoS_YyPXiqZnNfM32cxeAsK+xuPX9QRK94-DJ6oMQFrZPXQ@mail.gmail.com>
 <CAN5uoS-9yUfAT4=a9ys4d_2wxh9nW_RgXd_-3T-zF2r-k-PtOw@mail.gmail.com> <AM0PR04MB448137850D19BADD11F75B18880B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB448137850D19BADD11F75B18880B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Wed, 29 Jan 2020 16:01:07 +0100
Message-ID: <CAN5uoS-cHxrFD-H245iHMU_zzk6wAL=YJvKFAY6rr2EMgd0L3w@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] mailbox: introduce ARM SMC based mailbox
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        etienne carriere <etienne.carriere@st.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peng,

On Mon, 27 Jan 2020 at 13:58, Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: [PATCH v11 2/2] mailbox: introduce ARM SMC based mailbox
> >
> > Hello Peng and all,
> >
> >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > This mailbox driver implements a mailbox which signals transmitted
> > > data via an ARM smc (secure monitor call) instruction. The mailbox
> > > receiver is implemented in firmware and can synchronously return data
> > > when it returns execution to the non-secure world again.
> > > An asynchronous receive path is not implemented.
> > > This allows the usage of a mailbox to trigger firmware actions on SoCs
> > > which either don't have a separate management processor or on which
> > > such a core is not available. A user of this mailbox could be the SCP
> > > interface.
> > >
> > > Modified from Andre Przywara's v2 patch
> > > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore
> > > .kernel.org%2Fpatchwork%2Fpatch%2F812999%2F&amp;data=02%7C01%7
> > Cpeng.fa
> > >
> > n%40nxp.com%7C735cc6cd00404082bf8c08d79f67b93a%7C686ea1d3bc2b4
> > c6fa92cd
> > >
> > 99c5c301635%7C0%7C0%7C637153140140878278&amp;sdata=m0lcAEIr0ZP
> > tyPHorSW
> > > NYgjfI5p0genJLlhqHMIHBg0%3D&amp;reserved=0
> > >
> > > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> > > Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >
> > I've successfully tested your change on my board. It is a stm32mp1 with TZ
> > secure hardening and I run an OP-TEE firmware (possibly a TF-A
> > sp_min) with a SCMI server for clock and reset. Upstream in progress.
> > The platform uses 2 instances of your SMC based mailbox device driver
> > (2 mailboxes). Works nice with your change.
> >
> > You can add my T-b tag: Tested-by: Etienne Carriere
> > <etienne.carriere@linaro.org>
>
> Thanks, but this patch has been dropped.
>
> Per Sudeep, we all use smc transport, not smc mailbox ,
> I'll post patch in a few days based on the transport split patch.

Ok, i am syncing.

> >
> > FYI, I'll (hopefully soon) post a change proposal in U-Boot ML for an equvalent
> > 'SMC based mailbox' driver and SCMI agent protocol/device drivers for clock
> > and reset controllers.
>
> Great to know you did scmi agent code in U-Boot. Do you have some public repo
> for access?

I've created a P-R on my github repo to share until I submit to u-boot:
 https://github.com/etienne-lms/u-boot/pull/3

I guess I will change my u-boot proposal and get a SMC SCMI transport
outside of the mailbox framework.

Regards,
Etienne


>
> Thanks,
> Peng.
>
> > I'm also working on getting this SCMI server upstream in TF-A and OP-TEE.
> > Your SMC based mailbox driver is a valuable notification scheme for our SCMI
> > services support in Arm TZ secure world.
> >
> > Regards,
> > Etienne
