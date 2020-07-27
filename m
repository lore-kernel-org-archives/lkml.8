Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9B9C433ED
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E430021D95
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgG0H1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgG0H1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:27:03 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D698C0619D4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 00:27:03 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BFWb71j4Yz9sV7; Mon, 27 Jul 2020 17:26:57 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Vaibhav Jain <vaibhav@linux.ibm.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hulk Robot <hulkci@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Santosh Sivaraj <santosh@fossix.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200725091949.75234-1-weiyongjun1@huawei.com>
References: <20200725091949.75234-1-weiyongjun1@huawei.com>
Subject: Re: [PATCH -next] powerpc/papr_scm: Make some symbols static
Message-Id: <159583478705.602200.4759051429110235059.b4-ty@ellerman.id.au>
Date:   Mon, 27 Jul 2020 17:26:57 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jul 2020 17:19:49 +0800, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> arch/powerpc/platforms/pseries/papr_scm.c:97:1: warning:
>  symbol 'papr_nd_regions' was not declared. Should it be static?
> arch/powerpc/platforms/pseries/papr_scm.c:98:1: warning:
>  symbol 'papr_ndr_lock' was not declared. Should it be static?
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/papr_scm: Make some symbols static
      https://git.kernel.org/powerpc/c/19a551b254e6c308348a46a65332aa03c01767ed

cheers
