Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDE1C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE862082E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588860307;
	bh=SiwCH8RCKfzXT3qqrhJZK6OicpexUtZYquQREUsumG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NEGflraFcJvFvjg9Z6Wk1tllU3fC6TEsvbehqq2XKV6VshkCC2YhUn1btMRXEbzRk
	 ddGTIgTuJJFJq7KU0h4UbVtxTGk5kKTJbk5lCP7r0tIFyZj4VB6aquI8eKRcdxSZ5i
	 K/Juh78n045fiWAfdjrYLzX6V9sz/e0fSRROF3A0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgEGOFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbgEGOFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:05:06 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BD282084D;
        Thu,  7 May 2020 14:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588860306;
        bh=SiwCH8RCKfzXT3qqrhJZK6OicpexUtZYquQREUsumG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AvO/xVWP7PR6qhNwWQTmOuJP+VmmvTjbcv7/q8WBox/SvGGpjlLs0ZpZWiMQQqE8k
         07XEMskdNPbV4W/3A3Sd8DKXulryXo/P7jizjir6hH/A3wgkZ1oTWAuapQYbWI+5An
         RgrPeC32TR1T/YvGhq3ltgPztLpwbdSfcFH4UqHk=
From:   Will Deacon <will@kernel.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCHv2] iommu/arm-smmu: Make remove callback message more informative
Date:   Thu,  7 May 2020 15:04:54 +0100
Message-Id: <158885763013.86999.17864741879925126551.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423095531.9868-1-saiprakash.ranjan@codeaurora.org>
References: <20200423095531.9868-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Apr 2020 15:25:31 +0530, Sai Prakash Ranjan wrote:
> Currently on reboot/shutdown, the following messages are
> displayed on the console as error messages before the
> system reboots/shutdown as part of remove callback.
> 
> On SC7180:
> 
>   arm-smmu 15000000.iommu: removing device with active domains!
>   arm-smmu 5040000.iommu: removing device with active domains!
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu: Make remove callback message more informative
      https://git.kernel.org/will/c/02782f3d60f1

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
