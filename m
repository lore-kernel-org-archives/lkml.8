Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCACAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7F332075E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oMyRKWuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgHYTa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgHYTaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 15:30:46 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31C9C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 12:30:45 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id v12so6859595lfo.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 12:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=91WGW73GFVXZx1UKeprndgfgbUo/dF8OQ0jSHfku+Fs=;
        b=oMyRKWufRNneJLathiUhhHb8GFwnpMOFPdZUhrb+Lp5nOIEH2I70wf70XzWPL2p86h
         tV6zGVWvQ5UqlBWAD/mIdJIH3c6cdzff4Zwg3yszC7MGUw0wSw6mKfhIBUoaoSPDVtdf
         62c56twYXvz6zL2YlbNYGyGie1UQatqVYornI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=91WGW73GFVXZx1UKeprndgfgbUo/dF8OQ0jSHfku+Fs=;
        b=SIG7QMSuKsnRiPHzYrXG+fjUtIMPN/Y/GVXbDbN1OAUZheymzCf56XGVxBWGEAL5cm
         /qXqbgddNC9fABUawLnSxmZAWBLgyi10Fkt0qDA0HbuP/V9GlSKjPIxmQtQ2rV+JLzjT
         3DJX5OJDP4Mhi7FUrX8yl5FDSgaubcqaOViQmIXYsi53L5wcV5uXAE/FEy6++5jp0KCh
         Juh5wFEMe/rabFjlVT1m9BdY5h7YqKfRbCcmpfKwuNlaVlwjmBewk2SuEqe83NalYwOt
         fPnhjyKTpbHdAy9coto2MC74yh1v975Kd0H9/i2v+Onzqrawfs1emRx+Wd0Lz7tr/pnT
         /YVA==
X-Gm-Message-State: AOAM533F/qGJGW5MXqFNjTFUECPn4GduDTMwmfmblKQGyBeSSP7O8YL2
        AOxY06wk/0A1OlIOAGdw+MkOgLHjZ7SFzw==
X-Google-Smtp-Source: ABdhPJzXDdnQ1n6ETBztB9zVXKYaN7h9kaS2CWkTU8y0M917/1BUMKZLxHMCB/33b+HDer7/2r44Ig==
X-Received: by 2002:a19:c20d:: with SMTP id l13mr4131367lfc.157.1598383842992;
        Tue, 25 Aug 2020 12:30:42 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id o24sm3009638ljg.69.2020.08.25.12.30.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 12:30:41 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id j15so7057773lfg.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 12:30:41 -0700 (PDT)
X-Received: by 2002:a19:8c3:: with SMTP id 186mr5686629lfi.61.1598383840878;
 Tue, 25 Aug 2020 12:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200825153829.38043-1-luzmaximilian@gmail.com>
In-Reply-To: <20200825153829.38043-1-luzmaximilian@gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 25 Aug 2020 12:30:28 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPoxdMb4b5d0Ayv=JFACHcq7EXub14pJtJfcCV2di95Rg@mail.gmail.com>
Message-ID: <CA+ASDXPoxdMb4b5d0Ayv=JFACHcq7EXub14pJtJfcCV2di95Rg@mail.gmail.com>
Subject: Re: [PATCH net] mwifiex: Increase AES key storage size to 256 bits
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Kaloyan Nikolov <konik98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 25, 2020 at 8:38 AM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>
> Following commit e18696786548 ("mwifiex: Prevent memory corruption
> handling keys") the mwifiex driver fails to authenticate with certain
> networks, specifically networks with 256 bit keys, and repeatedly asks
> for the password. The kernel log repeats the following lines (id and
> bssid redacted):
>
>     mwifiex_pcie 0000:01:00.0: info: trying to associate to '<id>' bssid <bssid>
>     mwifiex_pcie 0000:01:00.0: info: associated to bssid <bssid> successfully
>     mwifiex_pcie 0000:01:00.0: crypto keys added
>     mwifiex_pcie 0000:01:00.0: info: successfully disconnected from <bssid>: reason code 3
>
> Tracking down this problem lead to the overflow check introduced by the
> aforementioned commit into mwifiex_ret_802_11_key_material_v2(). This
> check fails on networks with 256 bit keys due to the current storage
> size for AES keys in struct mwifiex_aes_param being only 128 bit.
>
> To fix this issue, increase the storage size for AES keys to 256 bit.
>
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> Reported-by: Kaloyan Nikolov <konik98@gmail.com>
> Tested-by: Kaloyan Nikolov <konik98@gmail.com>

Thanks for this! I just happened to notice this breakage here, as we
just merged the relevant -stable updates. I think it would be wise to
get the Fixes tag Dan noted, when Kalle lands this.

Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>

Also, while technically the regressing commit (e18696786548 ("mwifiex:
Prevent memory corruption handling keys")) was fixing a potential
overflow, the encasing command structure (struct host_cmd_ds_command)
is a union of a ton of other command layouts, and likely had plenty of
padding at the end, which would at least explain why non-malicious
scenarios weren't problematic pre-commit-e18696786548. It's also not
clear to me how much the network can directly determine this length,
but I suppose that's beside the point now -- it's good to fix both of
these bugs.

Regards,
Brian
