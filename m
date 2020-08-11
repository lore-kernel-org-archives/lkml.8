Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E25C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9368E2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Y2LCGsOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgHKUhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgHKUhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:37:18 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05FEC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:37:17 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id v6so143074ota.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cyAdGLpsSHEg2WGh7JZfkmwsxkBgafP7iF5apU/n2CY=;
        b=Y2LCGsOpN0RldBzIMy48v+04TzKnyHcLpJToEgT+4rGAxSGdVtYwypLiVftvRHBOPE
         i+OlqvcAfb1XVHq8fZEdcZYKKnf1oG+gB8R7wAcAjI+0kT7MKjYvsw9Gaf99EnI06ogT
         HfPwLCmgC5PbrPp+Kf4RZvBDb5lF0nJLsiCyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cyAdGLpsSHEg2WGh7JZfkmwsxkBgafP7iF5apU/n2CY=;
        b=EcfxHCIqidi0drUsp+dlfaqIkaGihMiMsg/oWlr02mhEDgtwdJ/OPdpFRsq5yzAjRc
         3P4D17sj7dV+w8bnI9QcqM5TMwW9MRvBBwy8GtrdtRaE770Ormb02MobaHrf4wo4TLZT
         +DFlEFAifJ7JRnIkAQnSfVDVSGEfPMz0jBEdXcFLmqDTpJ12P7oQ1fJRNj5gHfU8hGNy
         5LkifhdYnJBYbiZ1BlT3y7e9k83tmZZEUlPq8Ds7lh9xmMBjyv7uJtVScT4QBm7GrI+w
         vxs1JIH+7rZ25ZzdsHfweRwDswvDt/iXRYsdZu4JvQGNtSSBilqzeyqHrbSKG0EUKPjk
         nFHQ==
X-Gm-Message-State: AOAM531Pe0JlAN7y5Jf4RrGA75F5508L/JyrldNOrwx3iNYeZehnGXtE
        dSEzml6hG/ZYaAGBkZFckNAEsDXq+25iED77IbnnRA==
X-Google-Smtp-Source: ABdhPJxcgyXaX2x4hKWYec2RgVCtOonhZp1fq6FNvEKDqlAjlAYywhMckS+x9KVczzXwmCrjQz4q/gqy6pfHxpswrYY=
X-Received: by 2002:a05:6830:1e71:: with SMTP id m17mr6955382otr.188.1597178235447;
 Tue, 11 Aug 2020 13:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <1597106777-30913-1-git-send-email-venkateshwar.rao.gannavarapu@xilinx.com>
In-Reply-To: <1597106777-30913-1-git-send-email-venkateshwar.rao.gannavarapu@xilinx.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 11 Aug 2020 22:37:04 +0200
Message-ID: <CAKMK7uGcbaABtUuzWpOi8TA=ERSHBP6hwiX-YnQSXVHKWQo+mA@mail.gmail.com>
Subject: Re: [RFC PATCH V2 0/2] Add Xilinx DSI TX driver
To:     Venkateshwar Rao Gannavarapu 
        <venkateshwar.rao.gannavarapu@xilinx.com>
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sandipk@xilinx.com, vgannava@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 2:46 AM Venkateshwar Rao Gannavarapu
<venkateshwar.rao.gannavarapu@xilinx.com> wrote:
>
> Xilinx DSI-TX subsytem consists of DSI controller core, AXI crossbar
> and D-PHY as sub blocks. DSI TX subsystem driver supports multiple lanes
> upto 4, RGB color formats, video mode and command modes.
>
> DSI-TX driver is implemented as an encoder driver, as it going to be
> the final node in display pipeline. Xilinx doesn't support any converter
> logic to make this as bridge driver. Xilinx doesn't have such
> use cases where end node can't be an encoder like DSI-TX. And Xilinx
> encoder drivers represents a subsystem where individual blocks can't be
> used with external components / encoders.

So there's indeed a bit of an argument about when it should just be
stitched together as components, and when it is better a bridge. But
bridges also come with plenty of convenience glue, and we're talking
about fpga so the point pretty much is to rewire this all eventually.
Maybe not by you folks, but people are r/e-ing these things so who
knows.

The other thing is you do have a bridge attached already, or should
have: The drm_panel. And you do get the entire drm-connector
instantiation rather wrong, at least the ->dpms hook is breaking
atomic real bad. The ->detect implementation is also quite the
adventure. So panel bridge is definitely required here.

Finally this also would avoid component.c usage in xlnx - not that
there's something wrong with that per se, but it always means driver
specific logic and interactions, so harder to maintain for people not
involved in the code base on a daily basis. Also I'm not sure how this
works, the component integration glue in the main driver seems to be
missing. And the upstream drm/xlnx doesn't seem to have it either.

So all together I do think drm_bridge sounds like the right thing to do her=
e.
-Daniel

>
> Venkateshwar Rao Gannavarapu (2):
>   dt-bindings: display: xlnx: dsi: This add a DT binding for Xilinx DSI
>     TX     subsystem.
>   drm: xlnx: dsi: driver for Xilinx DSI TX subsystem
>
>  .../devicetree/bindings/display/xlnx/xlnx,dsi.yaml | 147 +++++
>  drivers/gpu/drm/xlnx/Kconfig                       |  11 +
>  drivers/gpu/drm/xlnx/Makefile                      |   2 +
>  drivers/gpu/drm/xlnx/xlnx_dsi.c                    | 701 +++++++++++++++=
++++++
>  4 files changed, 861 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/xlnx/xlnx,d=
si.yaml
>  create mode 100644 drivers/gpu/drm/xlnx/xlnx_dsi.c
>
> --
> 1.8.3.1
>
> This email and any attachments are intended for the sole use of the named=
 recipient(s) and contain(s) confidential information that may be proprieta=
ry, privileged or copyrighted under applicable law. If you are not the inte=
nded recipient, do not read, copy, or forward this email message or any att=
achments. Delete this email message and any attachments immediately.



--
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
