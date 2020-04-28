Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FB3C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 05:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44961206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 05:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588051090;
	bh=7fQtyv0sJdMk8KaFRz/LIegQuDI2xdySVTwl0CmQsbM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=FVAT3pZjc6R43U1BPs+4WtVRRwiWx/d/C8t372ico2eFWUZ9qMrXgHPDFG0yR3PYD
	 TR1o3TigOGuQjWphcHyAhd/eVuJNHtjqaglWWVuuph8g1lDhhdysdKO+cnoK4Sb2Qr
	 qitlXfjZe0Buqcr2SMavWO3COUEXKOeuIxK5egVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgD1FSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 01:18:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgD1FSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 01:18:09 -0400
Received: from localhost (unknown [106.51.110.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 094B2206A1;
        Tue, 28 Apr 2020 05:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588051089;
        bh=7fQtyv0sJdMk8KaFRz/LIegQuDI2xdySVTwl0CmQsbM=;
        h=Date:From:To:Cc:Subject:From;
        b=TPXh1nmZI5Eysmc1EAetaCn+fvzcHyFAK6lnN9gh6c+qmFJD83k0FZ3uUUHQxc0Py
         ED6ELzzpBodLRQvHWavfsDieZHBvGWB2whO4ci3O9WSBYKCqWkZ+Z6znr2zQGxSS2X
         BX3/zxM3hcgkABEnorMXxQEwHUWwkz6ldGObg2aY=
Date:   Tue, 28 Apr 2020 10:48:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Moving linux-phy tree
Message-ID: <20200428051804.GZ56386@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

Kishon has asked me to co-maintain the linux-phy subsystem [1], so can
you please switch the linux-phy tree to new location [2] and list both
of us as as contacts for this tree.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git/commit/?h=fixes&id=c31cd5a5b2f2e5c645f90a788ca6961a8dbbb2fb
[2]: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git

Thanks
-- 
~Vinod
