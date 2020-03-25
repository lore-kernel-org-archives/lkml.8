Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62926C18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDCE20663
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="UQwj5mzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgCYJES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:04:18 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:51117 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgCYJES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:04:18 -0400
Date:   Wed, 25 Mar 2020 09:04:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1585127056;
        bh=Guy2vOhTyBfZhuCrDbubTIeu//kaLb6ip8d00QcbKFc=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=UQwj5mzFaHihXW13WpxBcrPWmbIGaA8H7Qj+3IufGWtq8INdISQG6sVlJn+S4In/9
         PNcaW1d2j3KDPhCsoCgbgouJj2J1wgZimNSJCD73RXSstTyFiXvNANX31Fd+bqxpU2
         zh9IMKKqAuoKSdZ9hI2GOhyoKL+jj1bU9/CxHvGE=
To:     Neil Armstrong <narmstrong@baylibre.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "mjourdan@baylibre.com" <mjourdan@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v4 7/8] drm/fourcc: amlogic: Add modifier definitions for the Scatter layout
Message-ID: <JgBZ7eZYMgXRNu_-E4ItS1bud9mEe15xptZEX_XhsM_h8_iIZTOmPokEVxPJYwX0wP0pmb5p-ymubyyZP3kVbcfuDNdmM0__L8wBR5IykfE=@emersion.fr>
In-Reply-To: <20200325085025.30631-8-narmstrong@baylibre.com>
References: <20200325085025.30631-1-narmstrong@baylibre.com>
 <20200325085025.30631-8-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 25, 2020 9:50 AM, Neil Armstrong <narmstrong@baylibre.c=
om> wrote:

> Amlogic uses a proprietary lossless image compression protocol and format
> for their hardware video codec accelerators, either video decoders or
> video input encoders.
>
> This introduces the Scatter Memory layout, means the header contains IOMM=
U
> references to the compressed frames content to optimize memory access
> and layout.
>
> In this mode, only the header memory address is needed, thus the content
> memory organization is tied to the current producer execution and cannot
> be saved/dumped neither transferrable between Amlogic SoCs supporting thi=
s
> modifier.

I don't think this is suitable for modifiers. User-space relies on
being able to copy a buffer from one machine to another over the
network. It would be pretty annoying for user-space to have a blacklist
of modifiers that don't work this way.

Example of such user-space:
https://gitlab.freedesktop.org/mstoeckl/waypipe/
