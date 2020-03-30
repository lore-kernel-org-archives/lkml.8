Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072C2C2D0ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21552072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvTFD7Ff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbgC3LwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 07:52:11 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36593 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbgC3LwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:52:11 -0400
Received: by mail-lf1-f67.google.com with SMTP id u15so4785336lfi.3;
        Mon, 30 Mar 2020 04:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oUxAOgz8NXHq1Pf5is4saO0kcIUnQRpCo7D1rQX9etA=;
        b=RvTFD7FfX+RF2ea4gaF0j0B2FI534aB0tSVvis0sLeVy4mJcjjSl4QzkrKQxQrs/Lc
         HnSvgz2uPVhL0YBxzkToXX0ETdvrkXkTatxWl5GYZ3Et+xaXK4x9aPAdTDpdFdBHu3LF
         PMXP9o1RYCtkWmFsczRDmvIF/BzwpyQjLk2sSc3ltABf097AdbHhRrcgijhcCicFh6aR
         T0JGsIhIFKx7DyT2mBRoaK6iaHLQKAK+gC/Vv15Z5kpoiAku3KSocHewLR2j8Fd3QtvF
         t0OOgv/I94yviCfCMx7/4Wv5e9qp/KbKw9qXFzvEADHzUn0Nfjrt2u4S0sjQoIEyB6Mz
         8r8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oUxAOgz8NXHq1Pf5is4saO0kcIUnQRpCo7D1rQX9etA=;
        b=PVPHLXf0Ts5u3t+l3SR2QlBzMXP6JanEmOjaFtO+vjUprhtLRAuN2cEswIobbS+rgs
         T1y0Un2LtE9VVhKs2LjDmzWdpQJztMnMP5Iwpw9FIJXpjhvsOlsFAi3Yar3w4lrIq+ED
         VwX0eDOuHvQzoxS370Plu5XPQ0ts86YEiCNXEHBznWojwn0+qwbc2cIlvfpLoaAkgJAE
         6YjySzsY5HsGgGRK8sGakeodpps6YFj89db2q/+sH0UUfCqQhaH+XYdSRW7o0IdxRNlN
         Go6qb7HKm1c0ioIVv1ZER+G+b0hCHS1IVogDGxdkyT3jK3O7NCDqdQKJq3NIK2al+ALx
         EB+w==
X-Gm-Message-State: AGi0PuY7B1vIYiegm5k+I5BDc9enDzxLMaUd6nnBfyFkGO/+aMYSMlR9
        xwnoPooQN4AYEXEqJkcWDi1+KSCgeWfCqE3gLd0=
X-Google-Smtp-Source: APiQypIs6reaMQbUKLAdY3KvxuAlR9R0M+IDM0rH838tBggLkO5g/vojQtpptaZ+TdidZCUDxI0stG9ysPseXJpdgfM=
X-Received: by 2002:a19:4cc3:: with SMTP id z186mr7582516lfa.69.1585569129458;
 Mon, 30 Mar 2020 04:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200330113542.181752-1-adrian.ratiu@collabora.com> <20200330113542.181752-6-adrian.ratiu@collabora.com>
In-Reply-To: <20200330113542.181752-6-adrian.ratiu@collabora.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 30 Mar 2020 08:52:00 -0300
Message-ID: <CAOMZO5CKr7hSUFtb9b05rpRtpp9mb9ZyeSVqqiDXvppHJEWu5w@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] dt-bindings: display: add i.MX6 MIPI DSI host
 controller doc
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sjoerd Simons <sjoerd.simons@collabora.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-rockchip@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>, kernel@collabora.com,
        linux-stm32@st-md-mailman.stormreply.com,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 8:35 AM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:

> +        panel@0 {
> +            compatible = "sharp,ls032b3sx01";
> +            reg = <0>;
> +            reset-gpios = <&gpio6 8 GPIO_ACTIVE_LOW>;
> +            ports {
> +                port@0 {

There is a unit address here without a corresponding reg property.
This gives warning with 'make dt_binding_check'
