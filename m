Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D52C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62A7F2076A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594288489;
	bh=7UbckppFhMW3RvXbuOU5fp+t5vIyfpJIN3bxQ9PR7pY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uTuesesaPfz5iGnf1zMtIag5BV0MSNjPgeses1586ZRDOf+cCTieb+LBm04pu7csI
	 7qjYAvREnxvCokRGnFF0swI3qyRJTSqRqWbebpl2L5a6tRAnCKLXb1XWLETy/sbhtp
	 9yXelODz4xSsBB1lpbMFkrP2fRsdtGlnBTFZJvOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgGIJys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:54:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgGIJys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 05:54:48 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38FE120708;
        Thu,  9 Jul 2020 09:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594288487;
        bh=7UbckppFhMW3RvXbuOU5fp+t5vIyfpJIN3bxQ9PR7pY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jUTV6Gvqkgw2AL/H4vaAe+Eh8tRfkYhTfLwmbGeIcviD6rIIQxKfXeSRgQDAq3d3N
         arVcVWuuo1nu374YE8hm9ki7k2Od14otSf22riFtv+exobqqxlxVCMp9rv5l41UPIb
         PLVbvLkfVYERbIML0hsrpEYx4uD3hcNUX4f1pEII=
From:   Will Deacon <will@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Steven Price <steven.price@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Scull <ascull@google.com>
Subject: Re: [PATCH] arm64: Add missing sentinel to erratum_1463225
Date:   Thu,  9 Jul 2020 10:54:38 +0100
Message-Id: <159428414532.674057.17581737434886513688.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200709051345.14544-1-f.fainelli@gmail.com>
References: <20200709051345.14544-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jul 2020 22:13:40 -0700, Florian Fainelli wrote:
> When the erratum_1463225 array was introduced a sentinel at the end was
> missing thus causing a KASAN: global-out-of-bounds in
> is_affected_midr_range_list on arm64 error.

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: Add missing sentinel to erratum_1463225
      https://git.kernel.org/arm64/c/09c717c92b52

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
