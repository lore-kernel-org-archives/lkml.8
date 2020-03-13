Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D2DC4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C3D2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NM5zON52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgCMOGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:06:05 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44826 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgCMOGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:06:05 -0400
Received: by mail-qk1-f193.google.com with SMTP id f198so12586261qke.11;
        Fri, 13 Mar 2020 07:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2IzTJc24RHaXF9i2kbRLsxcZuVRdHtsyvDmIVlxiGNo=;
        b=NM5zON52Wh8BIQSs2uzORLOpRw6SUMGdKwCQc7pUHrZhGAQV4ZjiqcGQuUjY/BSBpC
         hgr5K8R6XGMUCSyOypfdL3IftV4CYLVFtwpeGYfXgMdjPf+yyUf9BaUV9f6H3SD7524a
         pnGCVlTSjgRRt/sOfV1s/7v9PvbXktkpCHI8h9mbGDW+5vkwOsjKLfBo9P6CXFj/N48R
         Le2dkY6lkuvZBNVL99GasTj401db7IXSIeOrqghAaCbQ6AXeVbuN/x/PTqgiFee7wHRH
         oU7jBUIexMk8vsnSVWUepn8f1oivN3UlbpB9EOt1iB4beJadgtW9bFig84RPecNpsFtf
         vNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2IzTJc24RHaXF9i2kbRLsxcZuVRdHtsyvDmIVlxiGNo=;
        b=Q3BeIrW2kT/X4P1F93LpgsJ103T3vGu92te7zcbh2yLrKxY+8VMLV/wvRFT0RzmIM/
         VvqxmP0sn/kZm9+hdkyFB/qcyQ3O/f10+DBI+VQWXKGuhcEJqOD34ID3K1SK3g8/ZtfO
         KuT0imSIocDweY8WeLG2UU5WAxoN17JhgisSf7QmriEInFF880ozjf5CsZnd1LUCj1Q1
         4dQwoO/L6h2aq6rKlhICYXqXby5lr02ZaLPjZMVRvOjx4WkCtyXq2jvI6lvI2aJGB8Pq
         +joW21pxpI7Lf3HN2kM7Uq2RjXs19vAKiml4V7b5n4XPhZ7+krz2wQJe/yPrEFideViv
         Xycg==
X-Gm-Message-State: ANhLgQ1KK6gee5YFRmxFPimEztX1YUFaR43MV6jctYjz12t/BoB5kV9U
        kji0/Nj0gonnuPkS6W6eptL3A9yVOdwkGbB7y1g=
X-Google-Smtp-Source: ADFU+vuv+r4wqNl1VwI7XiXSjNuc9tLsqXE4ohOyQ9xBFClhhrqH1z4BBOItF7Ig1YP6o+czYM3VUPvAOD7NOnpg8+Q=
X-Received: by 2002:a25:5b8a:: with SMTP id p132mr18283294ybb.11.1584108363091;
 Fri, 13 Mar 2020 07:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <1564306219-17439-1-git-send-email-bmeng.cn@gmail.com> <20190816215425.GA2726@bogus>
In-Reply-To: <20190816215425.GA2726@bogus>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Fri, 13 Mar 2020 22:05:52 +0800
Message-ID: <CAEUhbmU-SdjjsmPmc7JHQLVjfs7CcXxSf9mZ01h7w=nv7HiP4w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller: msi: Correct
 msi-controller@c's reg
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Sat, Aug 17, 2019 at 5:54 AM Rob Herring <robh@kernel.org> wrote:
>
> On Sun, 28 Jul 2019 02:30:18 -0700, Bin Meng wrote:
> > The base address of msi-controller@c should be set to c.
> >
> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> > ---
> >
> >  Documentation/devicetree/bindings/interrupt-controller/msi.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
> Applied, thanks.

This seems not be applied anywhere. Could you please check? Thanks!

Regards,
Bin
