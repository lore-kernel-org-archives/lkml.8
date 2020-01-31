Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2456C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC37214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgAaQOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 11:14:34 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39336 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbgAaQOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 11:14:33 -0500
Received: by mail-yw1-f67.google.com with SMTP id h126so5200686ywc.6;
        Fri, 31 Jan 2020 08:14:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ckkf5M0bZXgaGqlYIu11/GGEFF4eIcF87GnyR7xW+c0=;
        b=cGd43aZbv57vw61B3V6vfMWOQ0mNvESafKj+z9r7ImDRvuY+DkltNfTrvnjkLA1o2r
         +f5bNiGPda0ubBk/7Yho7UHSGR7fhGeEpaOQI+1jxiPDJyPxGvHptunYoHs+whILJ7EE
         wA2WsWLwEHbUxkjvgkOSa4IzTyQVDPH4hM8+2U4x50UXmfoIDnT0Oa1LlqZVcahZrlBK
         8hEgn18X5Gs2klsJDzj9eN4HaO5rkKkxUyAjPjKtN+oDIkxajVHHqDlC4iGduLLL9W+b
         r3RhohFpcrG0IIvefKmYgKDwZtmejP+8Pmw816I29jze++DsRdmJD+ok5cX3//IQ0XEI
         H8Cg==
X-Gm-Message-State: APjAAAWWK6gslHKNke1ocqoOIs1MvQgSNVQg/odkQsBvq0Q5GDOiedFs
        dDLXHP+Du5GPwYB7sRw/G2m3etZQugfy5QkLDbM=
X-Google-Smtp-Source: APXvYqzHv7OSupQXVjxZlorlsa6kLoBz0HtstylMdgrlwaBD07wmACPCSgavnPQHHtRYuqpT3DEKP9R6/j1ceut6v1g=
X-Received: by 2002:a25:c784:: with SMTP id w126mr9036069ybe.14.1580487272811;
 Fri, 31 Jan 2020 08:14:32 -0800 (PST)
MIME-Version: 1.0
References: <1580466455-27288-1-git-send-email-harini.katakam@xilinx.com>
 <1580466455-27288-3-git-send-email-harini.katakam@xilinx.com> <29c67f4f-9dd9-3786-689f-c0b6eeb40f49@microchip.com>
In-Reply-To: <29c67f4f-9dd9-3786-689f-c0b6eeb40f49@microchip.com>
From:   Harini Katakam <harinik@xilinx.com>
Date:   Fri, 31 Jan 2020 21:44:20 +0530
Message-ID: <CAFcVEC+sg++cQuB-tEzC4DDgYwd1nTHyA=R7CGkrjCOCAbkroQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] net: macb: Limit maximum GEM TX length in TSO
To:     Claudiu Beznea <Claudiu.Beznea@microchip.com>
Cc:     Harini Katakam <harini.katakam@xilinx.com>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Fri, Jan 31, 2020 at 8:27 PM <Claudiu.Beznea@microchip.com> wrote:
>
>
>
> On 31.01.2020 12:27, Harini Katakam wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > GEM_MAX_TX_LEN currently resolves to 0x3FF8 for any IP version supporting
> > TSO with full 14bits of length field in payload descriptor. But an IP
> > errata causes false amba_error (bit 6 of ISR) when length in payload
> > descriptors is specified above 16387. The error occurs because the DMA
> > falsely concludes that there is not enough space in SRAM for incoming
> > payload. These errors were observed continuously under stress of large
> > packets using iperf on a version where SRAM was 16K for each queue. This
> > errata will be documented shortly and affects all versions since TSO
> > functionality was added. Hence limit the max length to 0x3FC0 (rounded).
> >
> > Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
> > ---
<snip>
> > -               bp->max_tx_length = GEM_MAX_TX_LEN;
> > +               bp->max_tx_length = min(GEM_MAX_TX_LEN, GEM_MAX_TX_LEN_ERRATA);
>
> Isn't this always resolved to GEM_MAX_TX_LEN_ERRATA?

Sorry, yes it does. I accidentally concluded that this was
version specific. Will just default to 0x3fc0 in v2.
Thanks for the review.

Regards,
Harini
