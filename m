Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41DBC2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817FB206E9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391003AbgDCOEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:04:41 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:12606 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726087AbgDCOEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:04:40 -0400
X-IronPort-AV: E=Sophos;i="5.72,339,1580770800"; 
   d="scan'208";a="443711742"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 16:04:38 +0200
Date:   Fri, 3 Apr 2020 16:04:38 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     sergei.shtylyov@cogentembedded.com, horms+renesas@verge.net.au,
        tho.vu.wh@rvc.renesas.com, uli+renesas@fpond.eu
cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, joe@perches.com
Subject: question about drivers/net/ethernet/renesas/ravb_main.c
Message-ID: <alpine.DEB.2.21.2004031559240.2694@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In the function ravb_hwtstamp_get in ravb_main.c, the following code looks
suspicious:

        if (priv->tstamp_rx_ctrl & RAVB_RXTSTAMP_TYPE_V2_L2_EVENT)
                config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
        else if (priv->tstamp_rx_ctrl & RAVB_RXTSTAMP_TYPE_ALL)
                config.rx_filter = HWTSTAMP_FILTER_ALL;
        else
                config.rx_filter = HWTSTAMP_FILTER_NONE;

According to drivers/net/ethernet/renesas/ravb.h,
RAVB_RXTSTAMP_TYPE_V2_L2_EVENT is 0x00000002 and RAVB_RXTSTAMP_TYPE_ALL is
0x00000006.  Therefore, if the test on RAVB_RXTSTAMP_TYPE_ALL should be
true, it will never be reached.  How should the code be changed?

thanks,
julia
