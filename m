Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52973C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 05:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF9F20736
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 05:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583991430;
	bh=5Q38LdAf1p3YQXNjyyJQkIv6CfDiI7C7xbmfCU7hfY8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BdbK2sPpLn2x4AYSxKLB2LH9alBCMBbbU5/hdk7D/AiYHg7485UrQksOyIeGU3Ocd
	 heA0cEKqikIBcTs9UIobDsnM5NRpf4uR/Tuu2gh1E2xMjiYtNKUrcPSJveYT0lGcmj
	 KyeGlBtjqT6znC3Q9MyGECnVldDWc8dw6WbLcAR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387833AbgCLFhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 01:37:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387758AbgCLFhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 01:37:08 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB88F20736;
        Thu, 12 Mar 2020 05:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583991428;
        bh=5Q38LdAf1p3YQXNjyyJQkIv6CfDiI7C7xbmfCU7hfY8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PReOXJ+ZHmrWz4IbwksiW/OG0lbJWJy1sN0EqSgQDiO9uVY2WINfHJlMsPaqty0Qo
         ILiTPAgHc0GWcW7IlWU6pb4nMqotIc/Tybv2SET/fMYQba9t0qkov0FbhNOCuBCx+M
         29obK1XyA8M2q1u/vbF+jtY//M8i9RmGPjpCbox8=
Received: by mail-wm1-f43.google.com with SMTP id e26so4812699wme.5;
        Wed, 11 Mar 2020 22:37:07 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3e1s95nwQhDjByJL7wK5CppYMKnn62epfZ7DoUaL0ThZBYLqXH
        9VXvLJVX9kyzBm91rHsAPbsuM2dSE5KdRO9wir0=
X-Google-Smtp-Source: ADFU+vsZ1y4HC+7tZe1c2sRkkarw+06JoFyGMhDVnlrN2G68WyZu7GDqpl2qpg5ARTIgqnIM8w01GHQVsJGn7g8A9F4=
X-Received: by 2002:a1c:9816:: with SMTP id a22mr2916415wme.16.1583991426185;
 Wed, 11 Mar 2020 22:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200106084240.1076-1-wens@kernel.org> <20200106084240.1076-4-wens@kernel.org>
 <20200106085159.oirhyvxov6c4lzs6@gilmour.lan>
In-Reply-To: <20200106085159.oirhyvxov6c4lzs6@gilmour.lan>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Thu, 12 Mar 2020 13:36:54 +0800
X-Gmail-Original-Message-ID: <CAGb2v65ig=OjBbdZx3wRX_coV=BenZU34=f7CHEjuRYi6HpgnA@mail.gmail.com>
Message-ID: <CAGb2v65ig=OjBbdZx3wRX_coV=BenZU34=f7CHEjuRYi6HpgnA@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] dt-bindings: bus: sunxi: Add R40 MBUS compatible
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Jan 6, 2020 at 4:52 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> On Mon, Jan 06, 2020 at 04:42:36PM +0800, Chen-Yu Tsai wrote:
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > Allwinner R40 SoC also contains MBUS controller.
> >
> > Add compatible for it.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Acked-by: Maxime Ripard <mripard@kernel.org>

Looks like this didn't get picked up. But the device tree change using
the new compatible did make it into v5.6-rc1.

Could you pick this up as a fix for v5.6 so they make the same release?
Or I could pick it through our tree.

Regards
ChenYu
