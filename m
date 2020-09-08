Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B36C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 851E22166E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sslab.ics.keio.ac.jp header.i=@sslab.ics.keio.ac.jp header.b="I49U5h01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbgIHTm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730891AbgIHPwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:52:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BD0C061799
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 05:02:49 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x14so18777236wrl.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 05:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fHKZGBn8DYDZmUzkcQdtFyocASRnUskXF0G0c14zQIY=;
        b=I49U5h01ldadqbGBSJ+JPwaa/XpVL1RHekltbw+5yb9vJdeb7HlxO2SH/MxU+AXAwy
         mFX3smUOgYMCiRiMYtlhJgNbB0x45bfB59AcCGTmRd7oJw5HUypGbJ+wDCYeJroaA4or
         rnyPXVVdanOQ2bOVqv7iQHTy8xceM8lkCF844=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fHKZGBn8DYDZmUzkcQdtFyocASRnUskXF0G0c14zQIY=;
        b=qxEop9Mctu8BYFqt1QQ8KDo2XTvuts9Mq1gkIVEOOG9A8ansD84hTxgI55nO2Uh/zL
         rL2/Cyj1fofY/lL69+BCGHA2S4Bkal+am/oeKaDZa9doqZJG9M5wivfyc1hlZPenwc5H
         RcFJqs9iPZqbjLsetCz7MNJdkHkt+2zEj7kqLFsGGMpgn+rT8SzEoz6wlOoyCr8wwMsc
         Yb2NVN7AXew6HLmVOtS3Vs5C/Vw5+Cep6DrkDPtVURkmKTpeCKVPO54jZTe66EpD0B/V
         eSgpP77jo5d9vcTpZRKghR1wmk6xY67rye3pEMSOexYiMSPnMRBhvZhG7pysoul4BsVJ
         fFzw==
X-Gm-Message-State: AOAM530n+NfUTqU2ERGAlKrQ3C01QsdN+2/DlGeQEVl6U9G0AUCyHncL
        Vrl83XOSubtAC9xrgMCfa09jHh5cHf0HBXFcJ3i5lA==
X-Google-Smtp-Source: ABdhPJxLDgBM+s6ZLA0Xk5AyltkUhSxI4KJM4wlm9qfxvCvlS9XOiwZ2ahmKEQRp2PPZaiGtIw02aY3u8gSTeR+ZTXc=
X-Received: by 2002:adf:eecb:: with SMTP id a11mr26936125wrp.356.1599566568481;
 Tue, 08 Sep 2020 05:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <bad4e33a-af2f-b44f-63e5-56386c312a91@broadcom.com>
 <20200908001324.8215-1-keitasuzuki.park@sslab.ics.keio.ac.jp> <c13ee142-d69d-6d21-6373-acb56507c9ec@broadcom.com>
In-Reply-To: <c13ee142-d69d-6d21-6373-acb56507c9ec@broadcom.com>
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Date:   Tue, 8 Sep 2020 21:02:35 +0900
Message-ID: <CAEYrHjmG-R4RHn=59AGK8E0jKDXE5sbxQj49VpBvDMvBuBGiig@mail.gmail.com>
Subject: Re: [PATCH] brcmsmac: fix memory leak in wlc_phy_attach_lcnphy
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Takafumi Kubota <takafumi@sslab.ics.keio.ac.jp>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list@cypress.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your comment. I am relatively new to the Linux
kernel community, so I am more than happy to receive comments.
Please let me know if I'm violating any other rules.

> > Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
> > ---
> ... changelog here describing difference between previous patch and this
> version.

I will re-send the patch with the change log.

Thanks,
Keita

2020=E5=B9=B49=E6=9C=888=E6=97=A5(=E7=81=AB) 20:18 Arend Van Spriel <arend.=
vanspriel@broadcom.com>:
>
> On 9/8/2020 2:13 AM, Keita Suzuki wrote:
> > When wlc_phy_txpwr_srom_read_lcnphy fails in wlc_phy_attach_lcnphy,
> > the allocated pi->u.pi_lcnphy is leaked, since struct brcms_phy will be
> > freed in the caller function.
> >
> > Fix this by calling wlc_phy_detach_lcnphy in the error handler of
> > wlc_phy_txpwr_srom_read_lcnphy before returning.
>
> Thanks for resubmitting the patch addressing my comment. For clarity it
> is recommended to mark the subject with '[PATCH V2]' and add a ...
>
> > Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
> > ---
> ... changelog here describing difference between previous patch and this
> version.
>
> Regards,
> Arend
> ---
> >   .../net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c    | 4 +++=
-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
