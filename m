Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBA9C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6568C20723
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590779647;
	bh=ddlofDIYR6Dl6040lB0eo6IJrVQZJ6cZJugQ0IZwV9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nozH/+zDNI0LAkmEnSo5W0fIavWPcNrrpt8ChbVFaQyOtomXk6FGAVNJfDyslWI4Q
	 GfBeIp3yI0bRYcD6xuE0VP3JaUdbbmbGY3OHhVUiYsBr16EH0cG1nDG2/NyVvwhb2+
	 CEbNiLScmH8FpZivpdSSGoLSAMujccFOk1wo78JQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgE2TOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:14:06 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46309 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbgE2TOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:14:06 -0400
Received: by mail-io1-f67.google.com with SMTP id j8so465681iog.13;
        Fri, 29 May 2020 12:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=patu6bOLsBycuGCIEsa9IJnB9XRHTZoUGaSCrN0jEK8=;
        b=m5F0iFup/WtRRAXbvrH3M6vg3u6qIR3fE+AQArBoddHWrsWkFtR0xn9/HXk76mT+tL
         hBYz14a8GdYxo8yvxidyIVN9DIN8SFKOFzZXNHqi+N5YhYmjNVUz86ecRMAZHRYx/wc+
         Eqna5+Fz/34aoie8CCjvQMXrAtRoOFrFWqEPpSnB0me+8og4M7yBQ8ZZW/dltP2ovw4k
         RlSbGf1XOC5a/Eb1/PF3pNR8b7zJ9nF4YJ92iVsZNNt+ELugOq1IDrwTlxEHCQ9hbvwI
         1ypjpl+zn9e3SxsGqI6fsMNXZynflDZb/em1775tg00SejodZJSPY6A5/VmbB6YHaPve
         BlzA==
X-Gm-Message-State: AOAM531l4+K4c8zrrrCLvMoUtitSUhmqRpXmWMLo9ZVfRu4CJUoL5Vgv
        i33GmTEBSItBSbXl7COyOmN7OY2XAA==
X-Google-Smtp-Source: ABdhPJzP8tAzNW8lGMh87KDtVvukZdpyVgGAXw8egTyzuJqRvIwXhIErM7CQrL7OxIcpOluDlRLCUA==
X-Received: by 2002:a02:c802:: with SMTP id p2mr8758691jao.111.1590779644584;
        Fri, 29 May 2020 12:14:04 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id j9sm5188179ilr.18.2020.05.29.12.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 12:14:03 -0700 (PDT)
Received: (nullmailer pid 2778355 invoked by uid 1000);
        Fri, 29 May 2020 19:14:02 -0000
Date:   Fri, 29 May 2020 13:14:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: timer: renesas,cmt: Document r8a7742
 CMT support
Message-ID: <20200529191402.GA2771130@bogus>
References: <1590614320-30160-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1590614320-30160-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdX+m7WixJiNJyrpHxjnp5vFHi3ULuT7QgPOA93NE1XiHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX+m7WixJiNJyrpHxjnp5vFHi3ULuT7QgPOA93NE1XiHQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 02:53:02PM +0200, Geert Uytterhoeven wrote:
> Hi Prabhakar,
> 
> On Wed, May 27, 2020 at 11:19 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Document SoC specific compatible strings for r8a7742. No driver change
> > is needed as the fallback strings will activate the right code.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Please note this DT binding is under yamlization, cfr.
> "[PATCH v2] dt-bindings: timer: renesas: cmt: Convert to json-schema"
> (20200505155127.4836-1-geert+renesas@glider.be).

Do I need to pick that one up? Doesn't look like it's been applied 
AFAICT.

Rob
