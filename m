Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D20AC3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 04:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066E32072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 04:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iylATBPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgCEEhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 23:37:54 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42160 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgCEEhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 23:37:54 -0500
Received: by mail-lj1-f194.google.com with SMTP id q19so4513525ljp.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 20:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t2NH86lH1DI/On0AefQ9vdB8vQNR37Hyb66yqqiKK9w=;
        b=iylATBPgLeRW8zT14gwN4uEbnKpONggVIenAcFarCgI87I7oWndJpa55z2OS7w94lN
         GZAXFFiZGGdlT/IiFD7Wb1JdAWlL0UUC6fqZbjfZbYFnUAHhKiAq33GBRvT5WMEhAtRF
         yWRf3IOYI/FImd9zdLUH9PIO0cWM4Ix/PApY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t2NH86lH1DI/On0AefQ9vdB8vQNR37Hyb66yqqiKK9w=;
        b=E8E3xoucWhEOiASw+l02FEZy6fQkDEuWug3YNyPflijRjo2fvTJYM0n65JosFfPu2Q
         48PMjEGsSs/2yLQaBpiv8qThkD7XRJQgIq7fYVq8MqXlZYJj0FnE1hj5/L+yWbsqWVTC
         MTnMJU6AfKGDpzQjiQAkHMgILK119In93T56dGhgqDftwHICnTYtfIFX/uKMn1s5lwXl
         mktPnTCMRqXhIhFTN2E73L//BJxHelrGR1thTshX/HcFvv4YI8rlas7f5Bm1L8FQM5hr
         LkxzSGQSkQT74qtgwEMrLdrl1Rnl3NjgLoqbVvceolwr+1eTFb8Z+h/I13IRFothNPJF
         0Kdg==
X-Gm-Message-State: ANhLgQ0nZ830eEz+hzO4PPWvhOutA02c9tutUNdpYyp4fZvCe71Sa6Cq
        JbGqKiLTP1mALSJUitwbnRMiqcZRTK4=
X-Google-Smtp-Source: ADFU+vsvHV4DQlrX7E0KHTfJq2u72SA9Ih9HihsjpoDIt7NxlZMzgJOwHBKZuv6SkcS7LkCWZniBng==
X-Received: by 2002:a2e:b24a:: with SMTP id n10mr4075482ljm.174.1583383070672;
        Wed, 04 Mar 2020 20:37:50 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id m24sm18138400ljb.81.2020.03.04.20.37.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 20:37:49 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id b13so3403551lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 20:37:49 -0800 (PST)
X-Received: by 2002:a19:4cc4:: with SMTP id z187mr4069381lfa.49.1583383068980;
 Wed, 04 Mar 2020 20:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20200227000511.256055-1-briannorris@chromium.org> <DB7PR04MB524240B38FF6603D89D694538FE20@DB7PR04MB5242.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB524240B38FF6603D89D694538FE20@DB7PR04MB5242.eurprd04.prod.outlook.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 4 Mar 2020 20:37:36 -0800
X-Gmail-Original-Message-ID: <CA+ASDXNvjJLzH+_0g1OUNckmRoLyNJVwiAg9=OPwd7LGk-E2Cg@mail.gmail.com>
Message-ID: <CA+ASDXNvjJLzH+_0g1OUNckmRoLyNJVwiAg9=OPwd7LGk-E2Cg@mail.gmail.com>
Subject: Re: [EXT] [PATCH] mwifiex: set needed_headroom, not hard_header_len
To:     Ganapathi Bhat <ganapathi.bhat@nxp.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Arend Van Spriel <arend@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ganapathi,

On Wed, Mar 4, 2020 at 8:00 PM Ganapathi Bhat <ganapathi.bhat@nxp.com> wrote:
> > hard_header_len provides limitations for things like AF_PACKET, such that
> > we don't allow transmitting packets smaller than this.
>
> OK; However, are we not supposed to mention hard_header_len also?

No, my understanding is that we do not need to bother with
hard_header_len ourselves -- ether_setup() establishes the appropriate
L2 header parameters. I think that's covered a little better below.

> > This is the essentially the same bug (and fix) that brcmfmac had, fixed in
> > commit cb39288fd6bb ("brcmfmac: use ndev->needed_headroom to reserve
> > additional header space").
>
> OK; I read this commit:
>
> "... According to definition of LL_RESERVED_SPACE() and hard_header_len, we should use hard_header_len to reserve for L2 header, like ethernet header(ETH_HLEN) in our case and use needed_headroom for the additional headroom needed by hardware..."

Yeah, that's probably a little more verbose and accurate description,
which is partly why I referred to that commit :)

> So, does it mean, hard_header_len is already considered by upper layer?

Right, it's set by ether_setup().

Brian
