Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01928C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3638207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgFIF3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 01:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgFIF3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:29:49 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4848C03E969
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 22:29:48 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49gzFy57Skz9sV3; Tue,  9 Jun 2020 15:29:42 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au
Cc:     apopple@linux.ibm.com, christophe.leroy@c-s.fr,
        linux-kernel@vger.kernel.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        mikey@neuling.org, paulus@samba.org
In-Reply-To: <20200602041208.128913-1-ravi.bangoria@linux.ibm.com>
References: <20200602041208.128913-1-ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH] hw_breakpoint: Fix build warnings with clang
Message-Id: <159168035653.1381411.3943139630396101455.b4-ty@ellerman.id.au>
Date:   Tue,  9 Jun 2020 15:29:42 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jun 2020 09:42:08 +0530, Ravi Bangoria wrote:
> kbuild test robot reported few build warnings with hw_breakpoint code
> when compiled with clang[1]. Fix those.
> 
> [1]: https://lore.kernel.org/linuxppc-dev/202005192233.oi9CjRtA%25lkp@intel.com/

Applied to powerpc/next.

[1/1] hw-breakpoints: Fix build warnings with clang
      https://git.kernel.org/powerpc/c/ef3534a94fdbdeab4c89d18d0164be2ad5d6dbb7

cheers
