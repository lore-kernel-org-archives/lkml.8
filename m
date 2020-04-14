Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98764C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7011720578
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rhDyyIar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388897AbgDNOEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:04:12 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:36484 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388386AbgDNOED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0bH6gdqHbfNmkN445ATqSeenRtPaKJB++FVbLu/FOwc=; b=rhDyyIarBEZrvhjwS93TXUgiHk
        Fp4a/KiL4JztUGGHIzTmMfpgtgbS2+VCboFITL4Z/vWhHwJiVjRDaeDItnFoJXykGrB0nIrH/DJBc
        36qCvqCiqPsQuvDy274fsFpgy/Ynwg9JV1yF048/6cv79gm8vb5tXvbzpxbW6zUL7vDc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jOMAP-002f5O-Tp; Tue, 14 Apr 2020 16:03:57 +0200
Date:   Tue, 14 Apr 2020 16:03:57 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        open list <linux-kernel@vger.kernel.org>, davem@davemloft.net,
        kuba@kernel.org
Subject: Re: [PATCH net 1/4] net: dsa: b53: Lookup VID in ARL searches when
 VLAN is enabled
Message-ID: <20200414140357.GJ436020@lunn.ch>
References: <20200414041630.5740-1-f.fainelli@gmail.com>
 <20200414041630.5740-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414041630.5740-2-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 09:16:27PM -0700, Florian Fainelli wrote:
> When VLAN is enabled, and an ARL search is issued, we also need to
> compare the full {MAC,VID} tuple before returning a successful search
> result.
> 
> Fixes: 1da6df85c6fb ("net: dsa: b53: Implement ARL add/del/dump operations")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
