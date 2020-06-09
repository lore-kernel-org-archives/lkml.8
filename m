Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CC7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4054F2078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cILibC/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732830AbgFIAPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:15:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33908 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732210AbgFIAOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 20:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591661683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HD882eS9OH3S3VV1WViNWe8Js+sPqHEy08aEq1E9ORs=;
        b=cILibC/tR+Zug++FyqFvwBFTMnfQGI/ABuXrtLSDeRWMZkE2M4660uLi2VIgRQAO9JIhAB
        wzGtPS1vX+xvU/WGUUpRaXkjilZ5ResLkpb2NFPUrb1udEiaC2sEZvVBPKNG95dvTCNO0E
        DKWuBzx5ce7PJwAlajKVr85sl2crhg8=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-o0XpGo98MleYTTQawf2d5A-1; Mon, 08 Jun 2020 20:14:39 -0400
X-MC-Unique: o0XpGo98MleYTTQawf2d5A-1
Received: by mail-io1-f69.google.com with SMTP id p8so11945230ios.19
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 17:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HD882eS9OH3S3VV1WViNWe8Js+sPqHEy08aEq1E9ORs=;
        b=mYXxZRE4uey5JrrccxGyKr6ff5YBIW5Z/4peEen53FBEtwjaldKh5l43CEsaXFfUkL
         rrK8//JEHoLWyxkFv6PXvc9BU9jeXTGzG/LPdeXH/O9q6klKvUDTbbHprkm6aX7KZdFf
         jHvEK0/YmWTjWhUe1TXluM+8aeZHA9M9bYEjZDxo2kwDQvFifRPX3eqBq6y03mhVOo2M
         hf0l+/C++T68jWoEC6PCG9OlDazNy9mJbTPL2XGOAenbvZFddmmqPzbMInyjbcB7/c5Y
         pgXLWJ+afa5bejj8/2SLk4GLxAvhc9N2Sq1SWTpw3OpUMEke76gYNpVaFo1xQreLRBKs
         TADA==
X-Gm-Message-State: AOAM530CMDiJBVfTzKzo9j1OjVwkDCabGZeNSSsdihAUUYd5CDeDPN/I
        p6qOUtYC8bx5puSJgAD9mj8J/Q4ioy2b+F273ERMCCP+GsN0zcx9hKYvYsgYw91g1AG8lY7Ph5V
        F8V8sJ7VK+dCblUjyBOI/hZDHfEd9CCURYD69xAxa
X-Received: by 2002:a92:4899:: with SMTP id j25mr25560332ilg.168.1591661679101;
        Mon, 08 Jun 2020 17:14:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzELESE+K/wYsirvszqaNXPPRRvDprGl6QEl149kIe4qX3GOTtJp+ATld3JvWRLCQNPe8wmFXSgJgJDrnUrPSE=
X-Received: by 2002:a92:4899:: with SMTP id j25mr25560307ilg.168.1591661678726;
 Mon, 08 Jun 2020 17:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200608210058.37352-1-jarod@redhat.com> <20200608210058.37352-4-jarod@redhat.com>
 <20717.1591660112@famine>
In-Reply-To: <20717.1591660112@famine>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Mon, 8 Jun 2020 20:14:28 -0400
Message-ID: <CAKfmpSfkgC20w3Bp1PCfNJaADU7Hhkk5u9+2cMH+6--b_9cn4Q@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] bonding: support hardware encryption offload
 to slaves
To:     Jay Vosburgh <jay.vosburgh@canonical.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Netdev <netdev@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 7:48 PM Jay Vosburgh <jay.vosburgh@canonical.com> wrote:
>
> Jarod Wilson <jarod@redhat.com> wrote:
>
> >Currently, this support is limited to active-backup mode, as I'm not sure
> >about the feasilibity of mapping an xfrm_state's offload handle to
> >multiple hardware devices simultaneously, and we rely on being able to
> >pass some hints to both the xfrm and NIC driver about whether or not
> >they're operating on a slave device.
> >
> >I've tested this atop an Intel x520 device (ixgbe) using libreswan in
> >transport mode, succesfully achieving ~4.3Gbps throughput with netperf
> >(more or less identical to throughput on a bare NIC in this system),
> >as well as successful failover and recovery mid-netperf.
> >
> >v2: rebase on latest net-next and wrap with #ifdef CONFIG_XFRM_OFFLOAD
> >v3: add new CONFIG_BOND_XFRM_OFFLOAD option and fix shutdown path
> >
> >CC: Jay Vosburgh <j.vosburgh@gmail.com>
> >CC: Veaceslav Falico <vfalico@gmail.com>
> >CC: Andy Gospodarek <andy@greyhouse.net>
> >CC: "David S. Miller" <davem@davemloft.net>
> >CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> >CC: Jakub Kicinski <kuba@kernel.org>
> >CC: Steffen Klassert <steffen.klassert@secunet.com>
> >CC: Herbert Xu <herbert@gondor.apana.org.au>
> >CC: netdev@vger.kernel.org
> >CC: intel-wired-lan@lists.osuosl.org
> >Signed-off-by: Jarod Wilson <jarod@redhat.com>
> >
> >Signed-off-by: Jarod Wilson <jarod@redhat.com>
> >---
> > drivers/net/Kconfig             |  11 ++++
> > drivers/net/bonding/bond_main.c | 111 +++++++++++++++++++++++++++++++-
> > include/net/bonding.h           |   3 +
> > 3 files changed, 122 insertions(+), 3 deletions(-)
> >
> >diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> >index c7d310ef1c83..938c4dd9bfb9 100644
> >--- a/drivers/net/Kconfig
> >+++ b/drivers/net/Kconfig
> >@@ -56,6 +56,17 @@ config BONDING
> >         To compile this driver as a module, choose M here: the module
> >         will be called bonding.
> >
> >+config BONDING_XFRM_OFFLOAD
> >+      bool "Bonding driver IPSec XFRM cryptography-offload pass-through support"
> >+      depends on BONDING
> >+      depends on XFRM_OFFLOAD
> >+      default y
> >+      select XFRM_ALGO
> >+      ---help---
> >+        Enable support for IPSec offload pass-through in the bonding driver.
> >+        Currently limited to active-backup mode only, and requires slave
> >+        devices that support hardware crypto offload.
> >+
>
>         Why is this a separate Kconfig option?  Is it reasonable to
> expect users to enable XFRM_OFFLOAD but not BONDING_XFRM_OFFLOAD?

I'd originally just wrapped it with XFRM_OFFLOAD, but in an
overabundance of caution, thought maybe gating it behind its own flag
was better. I didn't get any feedback on the initial posting, so I've
been sort of winging it. :)

> >diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> >index a25c65d4af71..01b80cef492a 100644
> >--- a/drivers/net/bonding/bond_main.c
> >+++ b/drivers/net/bonding/bond_main.c
...
> >@@ -4560,6 +4663,8 @@ void bond_setup(struct net_device *bond_dev)
> >                               NETIF_F_HW_VLAN_CTAG_FILTER;
> >
> >       bond_dev->hw_features |= NETIF_F_GSO_ENCAP_ALL | NETIF_F_GSO_UDP_L4;
> >+      if ((BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP))
> >+              bond_dev->hw_features |= BOND_ENC_FEATURES;
>
>         Why is adding the ESP features to hw_features (here, and added
> to BOND_ENC_FEATURES, above) not behind CONFIG_BONDING_XFRM_OFFLOAD?
>
>         If adding these features makes sense regardless of the
> XFRM_OFFLOAD configuration, then shouldn't this change to feature
> handling be a separate patch?  The feature handling is complex, and is
> worth its own patch so it stands out in the log.

No, that would be an oversight by me. The build bot yelled at me on v1
about builds with XFRM_OFFLOAD not enabled, and I neglected to wrap
that bit too.

I'll do that in the next revision. I'm also fine with dropping the
extra kconfig and just using XFRM_OFFLOAD for all of it, if that's
sufficient.

-- 
Jarod Wilson
jarod@redhat.com

