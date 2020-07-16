Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3B8C433EB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 960E120787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgGPM4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbgGPM40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:56:26 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A7EC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 05:56:26 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4B6vQ92NLtz9sTm; Thu, 16 Jul 2020 22:56:16 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mpe@ellerman.id.au, Sourabh Jain <sourabhjain@linux.ibm.com>
Cc:     linuxppc-dev@ozlabs.org, mahesh@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, hbathini@linux.ibm.com
In-Reply-To: <20200713052435.183750-1-sourabhjain@linux.ibm.com>
References: <20200713052435.183750-1-sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v6] powerpc/fadump: fix race between pstore write and fadump crash trigger
Message-Id: <159490401653.3805857.8284745366151771293.b4-ty@ellerman.id.au>
Date:   Thu, 16 Jul 2020 22:56:16 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 10:54:35 +0530, Sourabh Jain wrote:
> When we enter into fadump crash path via system reset we fail to update
> the pstore.
> 
> On the system reset path we first update the pstore then we go for fadump
> crash. But the problem here is when all the CPUs try to get the pstore
> lock to initiate the pstore write, only one CPUs will acquire the lock
> and proceed with the pstore write. Since it in NMI context CPUs that fail
> to get lock do not wait for their turn to write to the pstore and simply
> proceed with the next operation which is fadump crash. One of the CPU who
> proceeded with fadump crash path triggers the crash and does not wait for
> the CPU who gets the pstore lock to complete the pstore update.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/fadump: fix race between pstore write and fadump crash trigger
      https://git.kernel.org/powerpc/c/ba608c4fa12cfd0cab0e153249c29441f4dd3312

cheers
