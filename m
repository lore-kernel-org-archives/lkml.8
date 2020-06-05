Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F89C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC0C9206FA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgFESCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:02:48 -0400
Received: from trent.utfs.org ([94.185.90.103]:44102 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbgFESCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 14:02:48 -0400
X-Greylist: delayed 33983 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jun 2020 14:02:47 EDT
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 050E75FE75;
        Fri,  5 Jun 2020 20:02:46 +0200 (CEST)
Date:   Fri, 5 Jun 2020 11:02:45 -0700 (PDT)
From:   Christian Kujau <lists@nerdbynature.de>
To:     =?UTF-8?Q?J=C3=BCrgen_Gro=C3=9F?= <jgross@suse.com>
cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: 5.7.0 / BUG: kernel NULL pointer dereference /
 setup_cpu_watcher
In-Reply-To: <7e2dec0c-8e27-6454-7793-d1246262283d@suse.com>
Message-ID: <alpine.DEB.2.22.395.2006051059200.13291@trent.utfs.org>
References: <alpine.DEB.2.22.395.2006050059530.13291@trent.utfs.org> <7e2dec0c-8e27-6454-7793-d1246262283d@suse.com>
User-Agent: Alpine 2.22 (DEB 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jun 2020, Jürgen Groß wrote:
> Do you happen to start the guest with vcpus < maxvcpus?

Indeed, I was booting with vcpus=2, maxvcpus=4. Setting both to the same 
value made the domU boot.

> If yes there is already a patch pending for 5.8:
> https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git/commit/?h=for-linus-5.8&id=c54b071c192dfe8061336f650ceaf358e6386e0b

Applied that manually and now the system boots even with vcpus < maxvcpus. 
So, if this still matters:
 
   Tested-by: Christian Kujau <lists@nerdbynature.de>

Thank you for your response, and the fix!

Christian.
-- 
BOFH excuse #146:

Communications satellite used by the military for star wars.
