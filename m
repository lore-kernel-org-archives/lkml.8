Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA29C2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 01:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D288A206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 01:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6TUYI8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732105AbgEMBDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 21:03:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37837 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728131AbgEMBDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 21:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589331796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JQNnDWT5Bs7MtMyHapTaDwxpkFi8C8mU48tE9Jr7L7Q=;
        b=E6TUYI8+2PRIQW+/uZwJYEY9/5Vjjo68b/OP35eHB2mhWtNcxSPpIpGKjmAtDp/icHE+MZ
        MUy4oTllui4vIDpN4Pr4s2VVrko+jAOwd4o0dZ+Y84Z1eHKC4hJm46Y7QPdbOSzTejqrbx
        DFU2oTPXI9uVNCKKM8gbJJ2/GkEGEX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-5rNWuHwCOtSi3l-fRAog8w-1; Tue, 12 May 2020 21:03:12 -0400
X-MC-Unique: 5rNWuHwCOtSi3l-fRAog8w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E0DE8005B7;
        Wed, 13 May 2020 01:03:10 +0000 (UTC)
Received: from localhost (unknown [10.10.110.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 662B6648D7;
        Wed, 13 May 2020 01:03:07 +0000 (UTC)
Date:   Tue, 12 May 2020 18:03:06 -0700 (PDT)
Message-Id: <20200512.180306.1060369920104837686.davem@redhat.com>
To:     olteanv@gmail.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, vivien.didelot@gmail.com,
        kuba@kernel.org, eric.dumazet@gmail.com, jiri@mellanox.com,
        idosch@idosch.org, rmk+kernel@armlinux.org.uk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: sja1105: disable rxvlan offload for
 the DSA master
From:   David Miller <davem@redhat.com>
In-Reply-To: <20200512234921.25460-1-olteanv@gmail.com>
References: <20200512234921.25460-1-olteanv@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <olteanv@gmail.com>
Date: Wed, 13 May 2020 02:49:21 +0300

> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> On sja1105 operating in best_effort_vlan_filtering mode (when the TPID
> of the DSA tags is 0x8100), it can be seen that __netif_receive_skb_core
> calls __vlan_hwaccel_clear_tag right before passing the skb to the DSA
> packet_type handler.
> 
> This means that the tagger does not see the VLAN tag in the skb, nor in
> the skb meta data.
> 
> The patch that started zeroing the skb VLAN tag is:
> 
>   commit d4b812dea4a236f729526facf97df1a9d18e191c
>   Author: Eric Dumazet <edumazet@xxxxxxxxxx>
>   Date:   Thu Jul 18 07:19:26 2013 -0700
> 
>       vlan: mask vlan prio bits

Eric, please review.

