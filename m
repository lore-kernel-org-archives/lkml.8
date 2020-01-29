Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FDFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 23:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF38A206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 23:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SdkOg+CG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgA2XNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 18:13:22 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34895 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgA2XNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 18:13:21 -0500
Received: by mail-io1-f67.google.com with SMTP id h8so1819137iob.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 15:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LCUbrUz7P+ZZOGgq2SEr224JKtlddICvuICcnGrb8wI=;
        b=SdkOg+CGhQWsyghj0M3VcH36oGpO89eNNXRye+lGikf5O5Is0N+RxBrpq/SFFroshF
         X865+RzEqL7tuwe6qQBrHRSo7IIb3mgnByPT5LO1mkE3R9BlviVxtp3u+QSA2QzOryf4
         gVPKzRsEO6gnwep19v1pcG56Mcttgie4MWpj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LCUbrUz7P+ZZOGgq2SEr224JKtlddICvuICcnGrb8wI=;
        b=lGCTphzgtuhbw0g05BIJ/bJaYPHZesJeUpT8iQEixFbkpRbBfP/SQmyrbvTvxVonQn
         SDwtjXksxz5cXD6fmH5dnZy6TKVqOkJ8RMiRYj9NfiivxzKS2usLdxArYrztwx7kwWu2
         wOSfLDlBtLj22b/+1TzSPEjbVrUZNk4liOGqIrNFB5/YFZGgPHdfNW+vxBXT423HUNA4
         tqfxtKiYDCpteSW2SRtlEsiRK+5yx+lnYe5oR3i0HbT6Hr5mstOpuKOEjEvHzjo6FWyJ
         P7tnA64MqjDpYIDGX8FtdZ3a5ZDo6NQTTCx4QD7tPaIwKawrF8GBxVu5afftSdvyYxPa
         seWw==
X-Gm-Message-State: APjAAAU34p03DAQg5iksqXrCS1NnACOZ02eyyqp3ej/UEljS9G7cfJn7
        lDF6Il5vR5A81LSlUGNNw0U/cWRvbn1QBNURFmL3fA==
X-Google-Smtp-Source: APXvYqxHMtiCwMc6jPRHRw63xfLorZNlXp+L+Bp/WE3y4H4JqVTTE0Uo9byH9oRz6OydL59iyNlWuRq15pvmR8iqCJY=
X-Received: by 2002:a5e:c907:: with SMTP id z7mr1648711iol.88.1580339600746;
 Wed, 29 Jan 2020 15:13:20 -0800 (PST)
MIME-Version: 1.0
References: <20200128221457.12467-1-linux@roeck-us.net> <CAD=FV=Wg2MZ56fsCk+TvRSSeZVz5eM4cwugK=HN6imm5wfGgiw@mail.gmail.com>
 <20200129000551.GA17256@roeck-us.net> <CA+8PC_f=qCUjihwbjd3vtGaNkG-=R1qm83oS7AmgtLTy6EgjyQ@mail.gmail.com>
 <20200129180428.GA99393@google.com>
In-Reply-To: <20200129180428.GA99393@google.com>
From:   Franky Lin <franky.lin@broadcom.com>
Date:   Wed, 29 Jan 2020 15:12:54 -0800
Message-ID: <CA+8PC_cr8D-tFT1QwS=DSNOW1X2sW3f__Aqts33bUseu9L7yfg@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: abort and release host after error
To:     Brian Norris <briannorris@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Doug Anderson <dianders@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 10:04 AM Brian Norris <briannorris@chromium.org> wrote:
>
> Hi Franky,
>
> [I'm very unfamiliar with this driver, but I had the same questions as
> Guenter, I think:]
>
> On Tue, Jan 28, 2020 at 04:57:59PM -0800, Franky Lin wrote:
> > On Tue, Jan 28, 2020 at 4:05 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > On Tue, Jan 28, 2020 at 03:14:45PM -0800, Doug Anderson wrote:
> > > > On Tue, Jan 28, 2020 at 2:15 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> > > > > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> > > > > @@ -1938,6 +1938,8 @@ static uint brcmf_sdio_readframes(struct brcmf_sdio *bus, uint maxframes)
> > > > >                         if (brcmf_sdio_hdparse(bus, bus->rxhdr, &rd_new,
> > > > >                                                BRCMF_SDIO_FT_NORMAL)) {
> > > > >                                 rd->len = 0;
> > > > > +                               brcmf_sdio_rxfail(bus, true, true);
> > > > > +                               sdio_release_host(bus->sdiodev->func1);
> > > >
> > > > I don't know much about this driver so I don't personally know if
> > > > "true, true" is the correct thing to pass to brcmf_sdio_rxfail(), but
> > > > it seems plausible.  Definitely the fix to call sdio_release_host() is
> > > > sane.
> > > >
> > > > Thus, unless someone knows for sure that brcmf_sdio_rxfail()'s
> > > > parameters should be different:
> > > >
> > > Actually, looking at brcmf_sdio_hdparse() and its other callers,
> > > I think it may not be needed at all - other callers don't do it, and
> > > there already are some calls to brcmf_sdio_rxfail() in that function.
> > > It would be nice though to get a confirmation before I submit v2.
> >
> > I think invoking rxfail with both abort and NACK set to true is the
> > right thing to do here so that the pipeline can be properly purged.
>
> Thanks for looking here. I'm not sure I totally understand your answer:
> brcmf_sdio_hdparse() already calls brcmf_sdio_rxfail() in several error
> cases. Is it really OK to call it twice in a row?

Yes. brcmf_sdio_rxglom does the same thing that calls
brcmf_sdio_rxfail again in error handling. For this instance I think
it's better using the same logic as the length mismatch block below (
calling brcmf_sdio_rxfail with true ture).

Thanks,
- Franky
