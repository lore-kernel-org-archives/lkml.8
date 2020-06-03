Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E181BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B012077D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgFCGyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 02:54:47 -0400
Received: from winnie.ispras.ru ([83.149.199.91]:21904 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbgFCGyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 02:54:47 -0400
Received: from monopod.intra.ispras.ru (monopod.intra.ispras.ru [10.10.3.121])
        by smtp.ispras.ru (Postfix) with ESMTP id 2F94B203BF;
        Wed,  3 Jun 2020 09:54:42 +0300 (MSK)
Date:   Wed, 3 Jun 2020 09:54:42 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Shuah Khan <skhan@linuxfoundation.org>
cc:     linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu/amd: Fix event counter availability check
In-Reply-To: <c0f9f676-eff8-572d-9174-4c22c6095a3d@linuxfoundation.org>
Message-ID: <alpine.LNX.2.20.13.2006030935570.3181@monopod.intra.ispras.ru>
References: <20200529200738.1923-1-amonakov@ispras.ru> <alpine.LNX.2.20.13.2005311014450.16067@monopod.intra.ispras.ru> <c0f9f676-eff8-572d-9174-4c22c6095a3d@linuxfoundation.org>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jun 2020, Shuah Khan wrote:

> I changed the logic to read config to get max banks and counters
> before checking if counters are writable and tried writing to all.
> The result is the same and all of them aren't writable. However,
> when disable the writable check and assume they are, I can run
[snip]

This is similar to what I did. I also noticed that counters can
be successfully used with perf if the initial check is ignored.
I was considering sending a patch to remove the check and adjust
the event counting logic to use counters as read-only, but after
a bit more investigation I've noticed how late pci_enable_device
is done, and came up with this patch. It's a path of less resistance:
I'd expect maintainers to be more averse to removing the check
rather than fixing it so it works as intended (even though I think
the check should not be there in the first place).

However:

The ability to modify the counters is needed only for sampling the
events (getting an interrupt when a counter overflows). There's no
code to do that for these AMD IOMMU counters. A solution I would
prefer is to not write to those counters at all. It would simplify or
even remove a bunch of code. I can submit a corresponding patch if
there's general agreement this path is ok.

What do you think?

Alexander
