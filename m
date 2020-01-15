Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CC3C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 07:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2908E2187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 07:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dlink.ru header.i=@dlink.ru header.b="rUTU0sAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgAOHZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 02:25:02 -0500
Received: from mail.dlink.ru ([178.170.168.18]:43540 "EHLO fd.dlink.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgAOHZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 02:25:01 -0500
Received: by fd.dlink.ru (Postfix, from userid 5000)
        id AE5E11B2010A; Wed, 15 Jan 2020 10:24:58 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru AE5E11B2010A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlink.ru; s=mail;
        t=1579073098; bh=9BpX60oTC+OJffotL5YslGLjv5z+sH4Lz+acJSFb43Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=rUTU0sASFGg+onSvMq/HOSMe/x/A09rwA+xpRP8HIyFGoziDMjEEiRWopY8cHrf/j
         OPges88lZPP6KtMcrD0PvlaWYY1GxCgts/cynhy4+d2ET/4da0td/DCRfQrQAluqG1
         G1IvfgFx0fjLFQaeu06OUSlYbaZ0KdeWEteCYENQ=
Received: from mail.rzn.dlink.ru (mail.rzn.dlink.ru [178.170.168.13])
        by fd.dlink.ru (Postfix) with ESMTP id 381B21B2010A;
        Wed, 15 Jan 2020 10:24:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 381B21B2010A
Received: from mail.rzn.dlink.ru (localhost [127.0.0.1])
        by mail.rzn.dlink.ru (Postfix) with ESMTP id AC6BF1B20AE9;
        Wed, 15 Jan 2020 10:24:45 +0300 (MSK)
Received: from mail.rzn.dlink.ru (localhost [127.0.0.1])
        by mail.rzn.dlink.ru (Postfix) with ESMTPA;
        Wed, 15 Jan 2020 10:24:45 +0300 (MSK)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 15 Jan 2020 10:24:45 +0300
From:   Alexander Lobakin <alobakin@dlink.ru>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Edward Cree <ecree@solarflare.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Taehee Yoo <ap420073@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Matteo Croce <mcroce@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Paul Blakey <paulb@mellanox.com>,
        Yoshiki Komachi <komachi.yoshiki@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH RFC net-next 06/19] net: dsa: tag_gswip: fix typo in tag
 name
In-Reply-To: <0edda44f-7a75-e6c9-eec3-48259630bb3d@gmail.com>
References: <20191230143028.27313-1-alobakin@dlink.ru>
 <20191230143028.27313-7-alobakin@dlink.ru> <20191230172209.GE13569@lunn.ch>
 <0edda44f-7a75-e6c9-eec3-48259630bb3d@gmail.com>
User-Agent: Roundcube Webmail/1.4.0
Message-ID: <69c888adea30f35fe36da37d76ee604e@dlink.ru>
X-Sender: alobakin@dlink.ru
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Fainelli wrote 15.01.2020 00:57:
> On 12/30/19 9:22 AM, Andrew Lunn wrote:
>> On Mon, Dec 30, 2019 at 05:30:14PM +0300, Alexander Lobakin wrote:
>>> "gwsip" -> "gswip".
>>> 
>>> Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>
>> 
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> Likewise, this is a bug fix that should be extracted out of this GRO
> series and a Fixes: tag be put since this has an user-visible impact
> through /sys/class/net/*/dsa/tagging.

Sure, I'll pull some really important fixes (like this one and doubled
Tx stats in tag_qca) out of this series and submit them as separate
patches, maybe even in net-fixes tree?

> Thanks

Regards,
ᚷ ᛖ ᚢ ᚦ ᚠ ᚱ
