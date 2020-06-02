Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC20BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9034208B6
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze+ivp4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgFBN7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgFBN7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:59:11 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C89C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 06:59:10 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id q2so2088278vsr.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 06:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9owB6N5YoTr+QgRWYSW+w97CM/a02Li4ocdyLucMnlA=;
        b=Ze+ivp4cAFxyqk7NhiH/FgnYGbbWWGkjKQQY3TxEitCzQdk7p0Wu76o0FkjuBwXiVH
         2Dg5GkZntUYHmh7C7r68i/lLSdsF0OcuA1BfQ15WDPiUYtJHbjCzEhJEJ9F1fW4CSoBa
         khCoH7AF8Speu+33IkgkUZJNsl734DdLOmVBBUhwR0J5x8OL60XWZn6dVPDktK0uYZyY
         STfI+k0NDFh4ebSmg1x4NiORk3wVn8f8pbTx/cFFLCIJdycWBKOR9MKgZnroaxd6/GLI
         VygAjCvqQjJqWXgTeulGShbJMm30zj4FP81VlH6EQDYtPjzDPJbE9QL+kDGi985PaEAa
         KZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9owB6N5YoTr+QgRWYSW+w97CM/a02Li4ocdyLucMnlA=;
        b=rxH8a7+DazUqWM+3KLJfsj4Oy7Ffb0nUI5PJY2uvNP3mMRS4717uKEhIHAK6vz3plg
         aPH0tjTs6tk9adIfO44OvWaF4WOLB67kQPckmhpiOGTNAzrlMjksSBghjRs/4pNlr5UT
         i1qG9NOx7vAKEOAZRKnzQOUibRlFAiReSLOm1i+iumj64ugNY6qmsLulNl1PDJ//UB2T
         U0lQMLj/CQyqKb3rNBhi8iJ65vIhFZSOLG+IgXabEDJj1X3iuyRuqNo4bbzHb618BwOY
         TY0mIjmxRmaWTygP93dEHgsXqDpUvCFGX5ESZpX+2iQpsxLd5t1wqXCkkaWLfWF5inKu
         68Aw==
X-Gm-Message-State: AOAM530GH3auo0Tm0yDxEO517GPxSYpnN8HnYgipqrzgr/zJJuwIxtX4
        q1IbfyLF/RmpkCRQ9D4BrKV1xWmnydOMIFPOoac=
X-Google-Smtp-Source: ABdhPJwagcH+IMCLFpcz6CGUl5oYhyGNJls9L62J/M3CQCdOJiJr0Rvnef8YwBvKPwiyJDIDZDjyOZlJdWHq94p6Rm4=
X-Received: by 2002:a67:b149:: with SMTP id z9mr17006698vsl.85.1591106349968;
 Tue, 02 Jun 2020 06:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590982881.git.Sandor.yu@nxp.com> <d3d707cf37e7928a839071242c752779061cc094.1590982881.git.Sandor.yu@nxp.com>
In-Reply-To: <d3d707cf37e7928a839071242c752779061cc094.1590982881.git.Sandor.yu@nxp.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 2 Jun 2020 14:55:52 +0100
Message-ID: <CACvgo52NeUSQV5p8+4DkCjpkv12cs8fCkQqy4MFn8pVaorVaHg@mail.gmail.com>
Subject: Re: [PATCH 1/7] drm/rockchip: prepare common code for cdns and rk
 dpi/dp driver
To:     sandor.yu@nxp.com
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>, dkos@cadence.com,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-rockchip <linux-rockchip@lists.infradead.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Sandor Yu

On Mon, 1 Jun 2020 at 07:29, <sandor.yu@nxp.com> wrote:
>
> From: Sandor Yu <Sandor.yu@nxp.com>
>
> - Extracted common fields from cdn_dp_device to a new cdns_mhdp_device
>   structure which will be used by two separate drivers later on.
> - Moved some datatypes (audio_format, audio_info, vic_pxl_encoding_format,
>   video_info) from cdn-dp-core.c to cdn-dp-reg.h.
> - Changed prefixes from cdn_dp to cdns_mhdp
>     cdn -> cdns to match the other Cadence's drivers
>     dp -> mhdp to distinguish it from a "just a DP" as the IP underneath
>       this registers map can be a HDMI (which is internally different,
>       but the interface for commands, events is pretty much the same).
> - Modified cdn-dp-core.c to use the new driver structure and new function
>   names.
> - writel and readl are replaced by cdns_mhdp_bus_write and
>   cdns_mhdp_bus_read.
>
The high-level idea is great - split, refactor and reuse the existing drivers.

Although looking at the patches themselves - they seems to be doing
multiple things at once.
As indicated by the extensive list in the commit log.

I would suggest splitting those up a bit, roughly in line of the
itemisation as per the commit message.

Here is one hand wavy way to chunk this patch:
 1) use put_unalligned*
 2) 'use local variable dev' style of changes (as seem in cdn_dp_clk_enable)
 3) add writel/readl wrappers
 4) hookup struct cdns_mhdp_device, keep dp->mhdp detail internal.
The cdn-dp-reg.h function names/signatures will stay the same.
 5) finalize the helpers - use mhdp directly, rename

HTH
Emil

Examples:
4)
 static int cdn_dp_mailbox_read(struct cdn_dp_device *dp)
 {
+"  struct cdns_mhdp_device *mhdp = dp->mhdp;
   int val, ret;

-  ret = readx_poll_timeout(readl, dp->regs + MAILBOX_EMPTY_ADDR,
+  ret = readx_poll_timeout(readl, mhdp->regs_base + MAILBOX_EMPTY_ADDR,
...
   return fancy_readl(dp, MAILBOX0_RD_DATA) & 0xff;
 }

5)
-static int cdn_dp_mailbox_read(struct cdn_dp_device *dp)
+static int mhdp_mailbox_read(struct cdns_mhdp_device *mhdp)
 {
-  struct cdns_mhdp_device *mhdp = dp->mhdp;
   int val, ret;
...
-  return fancy_readl(dp, MAILBOX0_RD_DATA) & 0xff;
+  return cdns_mhdp_bus_read(mhdp, MAILBOX0_RD_DATA) & 0xff;
 }
