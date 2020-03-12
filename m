Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB59C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572AC20663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584019086;
	bh=9LvTzccs20EfwHRZkugVuiWmgd25bpPrRl6L8w4/Oz4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Q64gMhx1qHIwnr8V1UoD8Z3u8kmw9uWTquWaogWaLx+NiaxBm686IRJPjyFPBO8tV
	 XoJu5uc06A5YoT+8r/LS2cXjoGpuCjHIi85GM+vuqmFlLxiRC8bwQ70uEO1d4W7C0y
	 lxLPQzF7EK3wv7dzviBX5zhN8dw6t8c6Lj3LBaQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCLNSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:18:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgCLNSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:18:04 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54126206BE;
        Thu, 12 Mar 2020 13:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584019084;
        bh=9LvTzccs20EfwHRZkugVuiWmgd25bpPrRl6L8w4/Oz4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zY0iaiEuq+94HEJNC+M3uNNqqWvIuL8LmuYCbrWbvB2ja1QjHiApBUHK6+3t2w3V3
         r2wjvYgMkprtz2WwMP/UCxCpanZ2I1A9xlCbVCUQS7wjr8zptKjLXjrHXhOmEI72K1
         j4fWFVMRwBFcA8StaO/AmvEoxFfHjdqyIJEyK6pk=
Received: by mail-qt1-f181.google.com with SMTP id l20so4264585qtp.4;
        Thu, 12 Mar 2020 06:18:04 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1IIqIqrXNDrojz5rre0C9sMJkVFTo0Gk7WhKrQSa2LbHaGpx30
        HjOL0ESJdSPVaiEoUiHvrm5C/MYaT3IwCEAuVw==
X-Google-Smtp-Source: ADFU+vuLXMJHQEOc9yZQJjg2VBWDBilY6CR5xhZf9pkeq5kaczXg78bABk9trxq/40GZUQEb4VvUo1jtlgxUuKyHUpc=
X-Received: by 2002:ac8:59:: with SMTP id i25mr7306219qtg.110.1584019083428;
 Thu, 12 Mar 2020 06:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200311210001.5102-1-robh@kernel.org> <20200311214028.GA21800@ravnborg.org>
In-Reply-To: <20200311214028.GA21800@ravnborg.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 12 Mar 2020 08:17:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK8n-YTsROL+XhjJVtFJzV-aGPxhLOxs1axHq5+TvE-Lg@mail.gmail.com>
Message-ID: <CAL_JsqK8n-YTsROL+XhjJVtFJzV-aGPxhLOxs1axHq5+TvE-Lg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: Fix dtc unit-address warnings in examples
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 4:40 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> On Wed, Mar 11, 2020 at 04:00:01PM -0500, Rob Herring wrote:
> > Extra dtc warnings (roughly what W=1 enables) are now enabled by default
> > when building the binding examples. These were fixed treewide in
> > 5.6-rc5, but some new display bindings have been added with new
> > warnings:
> >
> > Documentation/devicetree/bindings/display/panel/raydium,rm68200.example.dts:17.7-27.11: Warning (unit_address_vs_reg): /example-0/dsi@0: node has a unit name, but no reg property
> > Documentation/devicetree/bindings/display/panel/panel-simple-dsi.example.dts:17.19-31.11: Warning (unit_address_vs_reg): /example-0/mdss_dsi@fd922800: node has a unit name, but no reg property
> > Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.example.dts:17.7-26.11: Warning (unit_address_vs_reg): /example-0/dsi@0: node has a unit name, but no reg property
> > Documentation/devicetree/bindings/display/ti/ti,am65x-dss.example.dts:21.27-49.11: Warning (unit_address_format): /example-0/dss@04a00000: unit name should not have leading 0s
> > Documentation/devicetree/bindings/display/ti/ti,j721e-dss.example.dts:21.27-72.11: Warning (unit_address_format): /example-0/dss@04a00000: unit name should not have leading 0s
> > Documentation/devicetree/bindings/display/ti/ti,k2g-dss.example.dts:20.27-42.11: Warning (unit_address_format): /example-0/dss@02540000: unit name should not have leading 0s
> >
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Jyri Sarha <jsarha@ti.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>
> And I can drop my patch that only fixed the panel/ parts - good.

It seems I missed some panels. Perhaps ones that are in drm-misc, but
not in linux-next yet? Keep yours and I'll respin with just the TI
part.

Rob
