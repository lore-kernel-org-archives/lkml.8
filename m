Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B93C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8D820674
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584026201;
	bh=SZEg4wWy8H11le7Oa0MVf7a4y384yEIniXmktsgnbyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nSc0r67gjU/jM3Cnc02B1J495g7ahh3S8C1+grAAVrKF3DzlQ8IEQsgFRTuVqIkXZ
	 iuzeN4/dGtiDFYwiLjieeT6cXVthbwt84G6BAmt+qnp93XimmHG/AFLduFgLKsws+7
	 QQWAkTHdPIW2VHmSrHnNMVJOLu1iA6Gq7Bti+QoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgCLPQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:16:40 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45923 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbgCLPQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 11:16:39 -0400
Received: by mail-oi1-f194.google.com with SMTP id v19so5797332oic.12;
        Thu, 12 Mar 2020 08:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2nVd6kVQeC4fmgj6PS1Xm+z10xV+uawDTTNUDTAtSz0=;
        b=LaOimdN6f4qP3pk5A0rIsuxhuMVxwo75aGCldNz4IWeYWfZmTAjYH4WlhxuURxMow/
         FodnrjSVvSYAlqHZsYIDJ9UdAR3dwjAu05ste3Nn1v+di05ySxjgmhTlhm8SVIvapCuw
         DpMzh5E8ZncB4PGJoEVpmDS7kXRksiNPayTYRR0kMu+fCxJNF70+fQaz7jLJMoECKqz9
         3Qjs8UHfjwl/tFVQN48atvZHPkn1QbloJQJhHd6s5DKVsz71YyBBmbjyjfrQfee8WGxp
         KczCYNqQ4RQ3cLfIxqCylIPJjlnkXOzGO+cInauxvVGTAqO5AVUpaZYGq/lcKz44c/8k
         0yyw==
X-Gm-Message-State: ANhLgQ2jJM3OHcxHA/YwDIacxgBZOkviQ70CpD4gd7WNqPZN8nhiHIJD
        8XL2zvLKqRCTDbbw9zexyQ==
X-Google-Smtp-Source: ADFU+vtpLTSI6Asr97Z+Fb8vk1osZZ4RtTebCFker8BuzujVU9OrD/qT5bTh+3jkwn/IuxGrg+rn8Q==
X-Received: by 2002:a05:6808:651:: with SMTP id z17mr2882892oih.160.1584026197598;
        Thu, 12 Mar 2020 08:16:37 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r20sm4604114oic.56.2020.03.12.08.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 08:16:36 -0700 (PDT)
Received: (nullmailer pid 6272 invoked by uid 1000);
        Thu, 12 Mar 2020 15:16:35 -0000
Date:   Thu, 12 Mar 2020 10:16:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v8] dt-bindings: display: Add idk-2121wr binding
Message-ID: <20200312151635.GA5799@bogus>
References: <1583869169-1006-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583869169-1006-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 19:39:29 +0000, Lad Prabhakar wrote:
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
> 
> Hi All,
> This patch is part of series [1] ("Add dual-LVDS panel support to EK874),
> all the patches have been accepted from it except this one. I have fixed
> Rob's comments in this version of the patch.
> 
> [1] https://patchwork.kernel.org/cover/11297589/
> 
> V7->8
>  * Dropped ref to lvds.yaml, since the panel a dual channel LVDS, as a
>    result the root port is called as ports instead of port and the child
>    node port@0 and port@1 are used for even and odd pixels, hence binding
>    has required property as ports instead of port.
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
>  .../display/panel/advantech,idk-2121wr.yaml        | 122 +++++++++++++++++++++
>  1 file changed, 122 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.example.dt.yaml: panel-lvds: 'port' is a required property

See https://patchwork.ozlabs.org/patch/1252386
Please check and re-submit.
