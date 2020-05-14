Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7A1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDAAC20575
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgENEfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 00:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgENEfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:35:13 -0400
X-Greylist: delayed 460 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 May 2020 21:35:13 PDT
Received: from trent.utfs.org (trent.utfs.org [IPv6:2a03:3680:0:3::67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617F8C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:35:13 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 4BDE463A86;
        Thu, 14 May 2020 06:27:26 +0200 (CEST)
Date:   Wed, 13 May 2020 21:27:26 -0700 (PDT)
From:   Christian Kujau <lists@nerdbynature.de>
To:     kernel test robot <rong.a.chen@intel.com>
cc:     Jia-Ju Bai <baijiaju1990@gmail.com>, shaggy@kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        lkp@lists.01.org, Markus.Elfring@web.de
Subject: Re: [Jfs-discussion] [fs] 05c5a0273b: netperf.Throughput_total_tps
 -71.8% regression
In-Reply-To: <20200512030929.GA5770@shao2-debian>
Message-ID: <alpine.DEB.2.22.395.2005132123020.14542@trent.utfs.org>
References: <20200512030929.GA5770@shao2-debian>
User-Agent: Alpine 2.22 (DEB 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020, kernel test robot wrote:
> FYI, we noticed a -71.8% regression of netperf.Throughput_total_tps due to commit:

As noted in this report, netperf is used to "measure various aspect of 
networking performance". Are we sure the bisect is correct? JFS is a 
filesystem and is not touching net/ in any way. So, having not attempted 
to reproduce this, maybe the JFS commit is a red herring?

C.
-- 
BOFH excuse #50:

Change in Earth's rotational speed
