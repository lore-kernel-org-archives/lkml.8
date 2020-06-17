Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AC6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BBE72070A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="R6qNHWtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgFQVst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:48:49 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:33616 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgFQVst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:48:49 -0400
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jun 2020 17:48:48 EDT
Date:   Wed, 17 Jun 2020 21:38:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1592429930; bh=BHRlybEla9RSsqJCF1ZBfvNg6UHwGh4px8zN0yh041Y=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=R6qNHWtP0rxd8v7/aRGEPRJvP4R8ESGedaF+i3uFy2jPt8eiRBw92z6JyEGMzgGPZ
         qH2M+gtPZGuDSm+LZs44XjkaF1/muj3+r8yYkDMcHhnD3GFWgzDed/ifFPgRYzDn0s
         D7GZYev0c/TWWUneeOtrfIGJepec04eaHjlowIvOtxikryLjtMEOGAzx5d9V+LrjjA
         In1bqJCgrXLBAb6lfnbqyJOY7u0YKOS8PHkMGLvVQ7j9Y5GgxFDPJ2tRjH/cFaZJtl
         pYh+mofJ9e2rN0GqJsdp4dn+WnhFDEjHruogaPlqN9sGcEjmmILJKqoJhAs95obRaO
         a39S5301L53Qg==
To:     Michal Kubecek <mkubecek@suse.cz>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Aya Levin <ayal@mellanox.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Willem de Bruijn <willemb@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [PATCH resend net] net: ethtool: add missing NETIF_F_GSO_FRAGLIST feature string
Message-ID: <5u_BsHq6Jk0q09sGWsVKfvv0NRa5kBHjxdOr9VpNknRnxHpbRO_80JSHl_AWS-C_wBS7B15KetRleLaluF8tOysTNYyLVRUG4BRFQZxnhXw=@pm.me>
In-Reply-To: <20200617211844.kupsyijuurjpb5kd@lion.mk-sys.cz>
References: <9oPfKdiVuoDf251VBJXgNs-Hv-HWPnIJk52x-SQc1frfg8QSf9z3rCL-CBSafkp9SO0CjNzU8QvUv9Abe4SvoUpejeob9OImDPbflzRC-0Y=@pm.me> <20200617211844.kupsyijuurjpb5kd@lion.mk-sys.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Thursday, 18 June 2020, 0:18, Michal Kubecek <mkubecek@suse.cz> wrote:

> On Wed, Jun 17, 2020 at 08:42:47PM +0000, Alexander Lobakin wrote:
>
> > Commit 3b33583265ed ("net: Add fraglist GRO/GSO feature flags") missed
> > an entry for NETIF_F_GSO_FRAGLIST in netdev_features_strings array. As
> > a result, fraglist GSO feature is not shown in 'ethtool -k' output and
> > can't be toggled on/off.
> > The fix is trivial.
> >
> > Fixes: 3b33583265ed ("net: Add fraglist GRO/GSO feature flags")
> > Signed-off-by: Alexander Lobakin alobakin@pm.me
> >
> > -----------------------------------------------------------------------=
-----------------------------------------
> >
> > net/ethtool/common.c | 1 +
> > 1 file changed, 1 insertion(+)
> > diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> > index 423e640e3876..47f63526818e 100644
> > --- a/net/ethtool/common.c
> > +++ b/net/ethtool/common.c
> > @@ -43,6 +43,7 @@ const char netdev_features_strings[NETDEV_FEATURE_COU=
NT][ETH_GSTRING_LEN] =3D {
> > [NETIF_F_GSO_SCTP_BIT] =3D "tx-sctp-segmentation",
> > [NETIF_F_GSO_ESP_BIT] =3D "tx-esp-segmentation",
> > [NETIF_F_GSO_UDP_L4_BIT] =3D "tx-udp-segmentation",
> >
> > -   [NETIF_F_GSO_FRAGLIST_BIT] =3D "tx-gso-list",
> >     [NETIF_F_FCOE_CRC_BIT] =3D "tx-checksum-fcoe-crc",
> >     [NETIF_F_SCTP_CRC_BIT] =3D "tx-checksum-sctp",
> >
>
> Reviewed-by: Michal Kubecekmkubecek@suse.cz

Thanks!

> AFAICS the name for NETIF_F_GSO_TUNNEL_REMCSUM_BIT is also missing but
> IMHO it will be better to fix that by a separate patch with its own
> Fixes tag.

Oh, nice catch! I'll make a separate for this one.
I also wanted to add any sort of static_assert() / BUILD_BUG_ON() to
prevent such misses, but don't see any easy pattern to check for now,
as netdev_features_strings[] is always NETDEV_FEATURE_COUNT-sized.

> Michal
