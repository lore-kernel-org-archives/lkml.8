Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC44C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA1721D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583917978;
	bh=JmnH83cEqMuYqwzSAJmmIggEZjH2zaw0Mir9SbgqzBg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YZWoLTi8T57EL2AoOIL5yDhDDAbB4bg5BLRf/4ES9FBdbe3WA9TH1q680PZGdJsUm
	 4OrJne9oRWtYHowy0SACvrtgNp6AhGYQOSs/HI8txshmBeqH5bJvSbwlp1QU1+it3V
	 YtGMgx0QA2tLaEevXS4xqueM6R5EXVDWb2TVOZ20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgCKJM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:12:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbgCKJM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:12:57 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CB812146E;
        Wed, 11 Mar 2020 09:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583917976;
        bh=JmnH83cEqMuYqwzSAJmmIggEZjH2zaw0Mir9SbgqzBg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ILo3w++eSM5mDVtsHN7CfbOR+uFkOP8FGJV4g+jMwBHXf7Gp1Oq+92oifNxxhL+rA
         yGwUU0UbGeQwBbvp1Q38b4ryrd9AdHkucGojc6tgmNRWfgs46M7A/Cyb3wJUGk6Z8Y
         lVUKVDQ56EDE59d8xVIZCG7rSZjnK0cvMv158vw0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jBxQ6-00BrX3-KP; Wed, 11 Mar 2020 09:12:54 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 11 Mar 2020 09:12:54 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        aneesh.kumar@linux.ibm.com, steven.price@arm.com,
        broonie@kernel.org, guohanjun@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org,
        xiexiangyou@huawei.com, prime.zeng@hisilicon.com
Subject: Re: [RFC PATCH v1 0/3] arm64: tlb: add support for TTL field
In-Reply-To: <20200311025309.1743-1-yezhenyu2@huawei.com>
References: <20200311025309.1743-1-yezhenyu2@huawei.com>
Message-ID: <247ad619edf17eb266f856d937dac826@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yezhenyu2@huawei.com, mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org, aneesh.kumar@linux.ibm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhenyu,

On 2020-03-11 02:53, Zhenyu Ye wrote:
> ARMv8.4-TTL provides the TTL field in tlbi instruction to indicate
> the level of translation table walk holding the leaf entry for the
> address that is being invalidated. Hardware can use this information
> to determine if there was a risk of splintering.
> 
> This set of patches adds TTL field to __TLBI_ADDR, and uses
> Architecture-specific MM context to pass the TTL value to tlb 
> interface.
> 
> The default value of TTL is 0, which will not have any impact on the
> TLB maintenance instructions. The last patch trys to use TTL field in
> some obviously tlb-flush interface.

I have already posted some support for ARMv8.4-TTL as part of my NV 
series [1],
patches 62, 67, 68 and 69. This only deals with Stage-2 translation so 
far.
If you intend to add Stage-1, please build on top of what I have already 
posted
(I can extract the patches on a separate branch if you want).

Thanks,

         M.

[1] 
https://lore.kernel.org/linux-arm-kernel/20200211174938.27809-1-maz@kernel.org/
-- 
Jazz is not dead. It just smells funny...
