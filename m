Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79179C3F2CE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1E720663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="Yxwz0OuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbgCPPYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:24:46 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:46468 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731483AbgCPPYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:24:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id B89793F6F5;
        Mon, 16 Mar 2020 16:24:43 +0100 (CET)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=Yxwz0OuS;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xl9vV7p1JUBb; Mon, 16 Mar 2020 16:24:42 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id E48693F71B;
        Mon, 16 Mar 2020 16:24:32 +0100 (CET)
Received: from linlap1.host.shipmail.org (unknown [94.191.152.149])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 6659236044C;
        Mon, 16 Mar 2020 16:24:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1584372272; bh=Zx64ANFWAXny81LonXtbdHLC72j6+QdgVCTHhsAyJ8s=;
        h=To:Cc:From:Subject:Date:From;
        b=Yxwz0OuSt//0A1K1nNas6YYz0cbLutJ2A146s8UquROIs1VEA4PXf7jlF3HVkj+1A
         QK2Wm1+6D63fhGtX8rLqvBr43IXNEBbHfx9kAexW405aWoF2yxdZcic9boV7I9U89U
         BZvockfGfJQRvFN63Ejo71HVYGaQZilUHb47cc6U=
To:     Christoph Hellwig <hch@infradead.org>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Subject: DMA, TTM and memory encryption
Organization: VMware Inc.
Message-ID: <3d2317cd-bc40-47cb-3dae-8caa80acd767@shipmail.org>
Date:   Mon, 16 Mar 2020 16:24:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christoph,

It would be good to revisit this to see if we could set a direction for 
supporting user-space mapping of dma-coherent memory with TTM.

I think in the end, what TTM needs is a DMA interface similar to the one 
outlined here:

https://lore.kernel.org/lkml/b811f66d-2353-23c6-c9fa-e279cdb0f832@shipmail.org/

That could without too much effort be implemented for all architectures 
TTM supports and also for those weird architectures you've described 
that need special treatment, it would probably suffice with a more 
elaborate definition of the dma_pfn_t together with the dma coherent 
fault work you were suggesting earlier.

Regardless, once this patchset is in,

https://lore.kernel.org/lkml/20200304114527.3636-1-thomas_os@shipmail.org/

a short term solution would be to export the dma_pgprot() function and 
have TTM use it to set the pgprot for dma-coherent memory.

What do you think about this?

Thanks,

Thomas


