Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54973C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1704B20663
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="vhY5OV6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgCZXTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:19:48 -0400
Received: from gateway21.websitewelcome.com ([192.185.46.113]:21493 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726359AbgCZXTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:19:48 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 9862B400CB9B4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 18:19:47 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id HbmtjOdpNAGTXHbmtjnLw2; Thu, 26 Mar 2020 18:19:47 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=s6LutiGk2IllAHlFGyWkD3z+bSbaKNTGXhQLNtAMbZU=; b=vhY5OV6SGw7bbrYBQQiQ1VOo6t
        LaHxWYVqHGcs4E5mi2Pm0j3mh6gFjFJ34zpsRPdsP7PdQh7rcA9B7EYeOqpLw3KNqfjUn3AOkWV2s
        rY2wq3isOFZ/QljsGc4u2BEeS10NRAUC2Ifp6+xDl2fBwExWYDH0dhSR+zXPQyWQASUu6J0i+al37
        HV30V73m3NU7wSD2fGwJCjGdtOklBUlApXzMNK8n8DONiB9RVJuEhyoOIo95sRzvRQ3cV/T8m0e7B
        GsFQoxQRU2N+dRn52UkPTrdLY49AlWjLczB/L/MmN1crfOPhirYh7a1fOiCGkvAyCOWsC5dhbgkQj
        h/dI3OcQ==;
Received: from cablelink-189-218-116-241.hosts.intercable.net ([189.218.116.241]:33582 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jHbmr-0012KV-NP; Thu, 26 Mar 2020 18:19:45 -0500
Date:   Thu, 26 Mar 2020 18:23:22 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2][next] m68k: amiga: config: Use flexible-array member and
 mark expected switch fall-through
Message-ID: <cover.1585264062.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.218.116.241
X-Source-L: No
X-Exim-ID: 1jHbmr-0012KV-NP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: cablelink-189-218-116-241.hosts.intercable.net (embeddedor) [189.218.116.241]:33582
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mark expected switch fall-through
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org

Hi,

This series aims to replace a zero-length array with a flexible-array
member and mark a switch case where we are expecting to fall through.

This also coverts some /* fall through */ comments to the new
pseudo-keyword fallthrough;

Building: allmodconfig m68k

Thanks

Gustavo A. R. Silva (2):
  [next] m68k: amiga: config: Replace zero-length array with
    flexible-array member
  [next] m68k: amiga: config: Mark expected switch fall-through

 arch/m68k/amiga/config.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.26.0

