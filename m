Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2224AC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AE220409
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583785968;
	bh=FFDaHAtD7iC6WyFyG4J8jvV5Jk9bE81FuTqbd/X/IcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=icEk8S4ZYDYtBtKUyA0L275vD6gLmFNHBZZSs16R3gwga/SJdRNKT3MCiaX+AY2ZJ
	 nnPorhwA85NJcriQqm7jbpAhpVBUMiF5X/z3yN2KSVaYuGoQtgDYOnWrbNGu6FioAx
	 jHnX0ylOwVmcnxI73cmUNiwwxSsFM0b//Vg7oX8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgCIUcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:32:47 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44945 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgCIUcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:32:46 -0400
Received: by mail-ot1-f65.google.com with SMTP id v22so10941166otq.11;
        Mon, 09 Mar 2020 13:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TPaozqX6hcrQl8MvSCKkCToz6ciR60p3BFFfuKRb91M=;
        b=Lc9NjB19XLFGie1+bIcXoy4um1zQ6ya551xRhPhEPQTa3cBL9WsSaE9c71lUQ1wfaa
         GcPnarDepkYKDmkO9U7Z6mghKOyA03ConXNtWSvaKVdTafDJV1jDGETSJWI00QjFwS6h
         VHrJTltqRJgUkUTKd5S+itpcE59M2pzfNQliRgQ79tyNZGal1S6zjfeAvyBhSMuDF6Lc
         LSq4yxkKrowmce0oULbu/M1eoq2541LKukqPUNq53KSD71g9sXM2lqD0CbwHPHH+nefK
         fPERR/xaIRQAW9Ech5+Kvg3Fnm4bcqsU7XQgKx1gfaO3FClTYH3HIzSEVcDbQR9LoFBS
         ry5w==
X-Gm-Message-State: ANhLgQ1tOjgo1AnBaHNtI28hxE7nGdJS5iiJCwMegkxMR/u/tCaMQIah
        4fguDC2AxsKTB2LOMEM3Nw==
X-Google-Smtp-Source: ADFU+vsR/WR3wizvIH1E4Drwx3TUV8dEzHnollfDTSSj6qrdLWlT3UkvH/z3CQ6DeACwVFzb8TLSTQ==
X-Received: by 2002:a9d:6654:: with SMTP id q20mr1223294otm.180.1583785964227;
        Mon, 09 Mar 2020 13:32:44 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m15sm15202144otl.20.2020.03.09.13.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 13:32:43 -0700 (PDT)
Received: (nullmailer pid 15518 invoked by uid 1000);
        Mon, 09 Mar 2020 20:32:42 -0000
Date:   Mon, 9 Mar 2020 15:32:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris.Paterson2@renesas.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [RESEND PATCH v7] dt-bindings: display: Add idk-2121wr binding
Message-ID: <20200309203242.GA14486@bogus>
References: <20200306152031.14212-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306152031.14212-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Mar 2020 15:20:31 +0000, Lad Prabhakar wrote:
> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> 
> Add binding for the idk-2121wr LVDS panel from Advantech.
> 
> Some panel-specific documentation can be found here:
> https://buy.advantech.eu/Displays/Embedded-LCD-Kits-High-Brightness/model-IDK-2121WR-K2FHA2E.htm
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Apologies for flooding in I missed to add the ML email-ids for the earlier
> version so resending it.
> 
> Hi All,
> 
> This patch is part of series [1] ("Add dual-LVDS panel support to EK874),
> all the patches have been accepted from it except this one. I have fixed
> Rob's comments in this version of the patch.
> 
> [1] https://patchwork.kernel.org/cover/11297589/
> 
> v6->7
>  * Added reference to lvds.yaml
>  * Changed maintainer to myself
>  * Switched to dual license
>  * Dropped required properties except for ports as rest are already listed
>    in lvds.panel
>  * Dropped Reviewed-by tag of Laurent, due to the changes made it might not
>    be valid.
> 
> v5->v6:
>  * No change
> 
> v4->v5:
> * No change
> 
> v3->v4:
> * Absorbed patch "dt-bindings: display: Add bindings for LVDS
>   bus-timings"
> * Big restructuring after Rob's and Laurent's comments
> 
> v2->v3:
> * New patch
> 
>  .../display/panel/advantech,idk-2121wr.yaml        | 120 +++++++++++++++++++++
>  1 file changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.example.dt.yaml: panel-lvds: 'port' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.example.dt.yaml: panel-lvds: 'port' is a required property

See https://patchwork.ozlabs.org/patch/1250384
Please check and re-submit.
