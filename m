Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C062C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 01:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3542C2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 01:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B8O7J4rJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgFPBdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 21:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgFPBdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 21:33:42 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DC9C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 18:33:41 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c12so14279243qtq.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 18:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cDOEIQV5YQAeIdEMMGx3+/GevUyhzhDnAbEIVpCOnXI=;
        b=B8O7J4rJokQDXjU31zgPybo1cTW2Je/Kd6MMZp1L9D1ePsA7Yu4unjGsty4wjVY6y5
         6KOLOawoFG95cEFHEsatqraAC7BNZXmTMnc1cgE/6paJHcMrwiZUwPlyLqKnmoXZzH6E
         f8uVTRRbgDFf56GPhBFtDkrkqau8ltI7y0uho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDOEIQV5YQAeIdEMMGx3+/GevUyhzhDnAbEIVpCOnXI=;
        b=JaYNSUC1u5ZABeZCieSfKqJAcny3ri0u9VyJ9XNWj/7dPeSwHmaJ+48yORnbgYYqDC
         v9CZFbwupN83C7yOTotluG/DsueFGsOMhGUBtUS1dcKupln4DsBXCO8NZTEyQdicb0I7
         7hwcckXqsFjPTLFE1vedbLGLTzgZK0saRquh43WGBeOG8f5csZdyDA1mFNVaKl3BBNuA
         s1cwxw243InmUv0G37F4zo3LsPYyqYTZUPbS7X+pRucKdbhea5yvSkhIu23bHyjS5sgB
         YLwUudIoqiN4sb6I+fH3KDaMQ2M0m0RV4OAkOkfKHJ9wGMrXJqXA1ivbuHQRWUhsI6we
         ythg==
X-Gm-Message-State: AOAM533O+UZG6wBbg1B+mB/pxmb48Xr7FsKahnw0CHW1L32NgGpimMpT
        G5tSeRU4d6v4uGsI1eN3Gou/2jszZGTVWPkXHNrMcA==
X-Google-Smtp-Source: ABdhPJzfoS6eBeapghRz9PNlO0sf80T4JJIcwcg/RDgpsN2vhEmKNBk9sSWTfS/Osmsto+Bn7eoaf1doTxFmQlzCvjg=
X-Received: by 2002:aed:35af:: with SMTP id c44mr18911337qte.349.1592271221067;
 Mon, 15 Jun 2020 18:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200615190119.382589-1-drc@linux.vnet.ibm.com>
 <CACKFLimd0a=Y8WyvqCt4BD7SU_Cg1vQ=baKs6-uPv0dZuCm=mw@mail.gmail.com> <95bf20c6-a812-32ad-fd38-45cba7e10491@linux.vnet.ibm.com>
In-Reply-To: <95bf20c6-a812-32ad-fd38-45cba7e10491@linux.vnet.ibm.com>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Mon, 15 Jun 2020 18:33:29 -0700
Message-ID: <CACKFLi=-2jUO4UU2BKERqee1XMOgf7OrGerurAf53B-axJwotw@mail.gmail.com>
Subject: Re: [PATCH] tg3: driver sleeps indefinitely when EEH errors exceed eeh_max_freezes
To:     David Christensen <drc@linux.vnet.ibm.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 3:21 PM David Christensen
<drc@linux.vnet.ibm.com> wrote:
>
> On 6/15/20 1:45 PM, Michael Chan wrote:
> > On Mon, Jun 15, 2020 at 12:01 PM David Christensen
> > <drc@linux.vnet.ibm.com> wrote:
> >>
> >> The driver function tg3_io_error_detected() calls napi_disable twice,
> >> without an intervening napi_enable, when the number of EEH errors exceeds
> >> eeh_max_freezes, resulting in an indefinite sleep while holding rtnl_lock.
> >>
> >> The function is called once with the PCI state pci_channel_io_frozen and
> >> then called again with the state pci_channel_io_perm_failure when the
> >> number of EEH failures in an hour exceeds eeh_max_freezes.
> >>
> >> Protecting the calls to napi_enable/napi_disable with a new state
> >> variable prevents the long sleep.
> >
> > This works, but I think a simpler fix is to check tp->pcierr_recovery
> > in tg3_io_error_detected() and skip most of the tg3 calls (including
> > the one that disables NAPI) if the flag is true.
>
> This might be the smallest change that would work.  Does it make sense
> to the reader?
>
> diff --git a/drivers/net/ethernet/broadcom/tg3.c
> b/drivers/net/ethernet/broadcom/tg3.c
> index 7a3b22b35238..1f37c69d213d 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -18168,8 +18168,8 @@ static pci_ers_result_t
> tg3_io_error_detected(struct pci_dev *pdev,
>
>          rtnl_lock();
>
> -       /* We probably don't have netdev yet */
> -       if (!netdev || !netif_running(netdev))
> +       /* May be second call or maybe we don't have netdev yet */
> +       if (tp->pcierr_recovery || !netdev || !netif_running(netdev))

Dereferencing tp needs to be done after checking netdev.  If we don't
have netdev, tp won't be valid.

Other than that, I think the logic looks good and is quite clear.

Thanks.
