Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE281C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C483F207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uM0P162V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgE1Inz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 04:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgE1Inx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:43:53 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0445C05BD1E;
        Thu, 28 May 2020 01:43:51 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a2so31135273ejb.10;
        Thu, 28 May 2020 01:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PtBZpwuldR+k4cdnKzw6Vd49Klpt/z28rh2z7h84a+4=;
        b=uM0P162VPGLvSJtPFiUc6pd7hKj5ZaNd24yJBxvQm2aQVFNvjMo8YRuKNwgndu9AeM
         K7U4KFvzL6JMLhluXDFd0kqTF338Peqp+2gj4V0pFqYYmTXbrqroPSkutGz2DKf59qdG
         Wqhp8IlvYX7L+sQLRsFOIS/g9M8wpH9BNN3DaL+kJw8Pk6l8+GXpcYzQf9LocKAYM3gj
         INAEhmfhwMMEACU+6l2rfptCaNfOTcrYsHFUJF7RI+ZOWjVv8Qc7TKTvctAP8D98YhSm
         d6ns+UPbU1C6scLS/dREHD5ekaONVack1tR46IULAvKZcMmLgQECIY4VGZrqBK+6F8UE
         6abw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PtBZpwuldR+k4cdnKzw6Vd49Klpt/z28rh2z7h84a+4=;
        b=uhW/JJ1vjeMVGquwIbZtTl0Gv8L7QXH068lyww2wS6D9YyM89kF3mf8oIrDFgxq8JU
         /soaUiAg5IGx8Z/ib4ZzItsXFdZwcpff2zNcFfJDIbVEiFznxVf/uN2QJeiW4DSWZkeD
         I7gfjbjc0VWNtJrKOYY823sYp+kZoeFpx/Yl1Aw4b1YdC5+fazElfTWvR3UWgZgnrpaG
         0scdcnD9h6PyM2Cm74j9yuNNzgiKzUhPJNFawLxcIqI9xRHfWaLlN2+NPX2z/m+rE/3I
         WoL/qmG3+LM73i0fHQgaDiPG9aJGUZWb6DKB7kxFaUn0APCNHNLA7Qx5IidqAUWY9OK3
         y85Q==
X-Gm-Message-State: AOAM530DN3xP79RL4Q8hx50E2QE5LtFCFVOmt3T3OjIUeedlPwKchzGN
        N6AFwihrZyHW2/rfjHEw0kL8UAxMZyaahQglO+4=
X-Google-Smtp-Source: ABdhPJzaEtx1o1zuA9p5VXIM4nIave3Ck+4OQ/jrMTG+JJHNevru8KE7qZ/M44WqpvxWIlyKh0cDq7J5KzlCFRddunM=
X-Received: by 2002:a17:906:2e50:: with SMTP id r16mr1930902eji.305.1590655430447;
 Thu, 28 May 2020 01:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200528063847.27704-1-michael@walle.cc> <0130cb1878a47efc23f23cf239d0380f@walle.cc>
In-Reply-To: <0130cb1878a47efc23f23cf239d0380f@walle.cc>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Thu, 28 May 2020 11:43:39 +0300
Message-ID: <CA+h21hruQkYEYatnOSSc6r2EPR+SY-NbcKCRF6sX2oNLy84itg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/3] net: enetc: remove bootloader dependency
To:     Michael Walle <michael@walle.cc>
Cc:     netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 at 11:18, Michael Walle <michael@walle.cc> wrote:
>
> Am 2020-05-28 08:38, schrieb Michael Walle:
> > These patches were picked from the following series:
> > https://lore.kernel.org/netdev/1567779344-30965-1-git-send-email-claudiu.manoil@nxp.com/
> > They have never been resent. I've picked them up, addressed Andrews
> > comments, fixed some more bugs and asked Claudiu if I can keep their
> > SOB
> > tags; he agreed. I've tested this on our board which happens to have a
> > bootloader which doesn't do the enetc setup in all cases. Though, only
> > SGMII mode was tested.
> >
> > changes since v2:
> >  - removed SOBs from "net: enetc: Initialize SerDes for SGMII and
> > USXGMII
> >    protocols" because almost everything has changed.
> >  - get a phy_device for the internal PCS PHY so we can use the phy_
> >    functions instead of raw mdiobus writes
>
> mhh after reading,
> https://lore.kernel.org/netdev/CA+h21hoq2qkmxDFEb2QgLfrbC0PYRBHsca=0cDcGOr3txy9hsg@mail.gmail.com/
> this seems to be the wrong way of doing it.
>
> -michael

FWIW, some time after the merge window closes, I plan to convert the
felix and seville drivers to mdio_device. It wouldn't be such a big
deal to also convert enetc to phylink then, and also do this
phy_device -> mdio_device for it too.

Thanks,
-Vladimir
