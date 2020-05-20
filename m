Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09B3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFCAA2072C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589997285;
	bh=EV94N2IIkGZzV+14r1rugh4SSd9XfTPJ8E4cS0nEkS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GuhktaBBTdrsgCnlgZZrE64gMU0oq3xDbh8uWJ6FCPQOTjHB99T9/CQzJFw8zGZHO
	 TzzfHu9vUWihGZ9pAN4KnaEsk0S9Dg00bdzUjZ/3GsB0aGQJSFJZtBzXvSEUhx9FVg
	 R31Mie+n5VKSrcSmGBqkxNCUUxZnSAHGGH0sP7qQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgETRyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 13:54:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbgETRyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:54:44 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04AE4206B6;
        Wed, 20 May 2020 17:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589997284;
        bh=EV94N2IIkGZzV+14r1rugh4SSd9XfTPJ8E4cS0nEkS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cfHXIMvbuOyN/UvyyunVQAwg5AvLKmQ653t5+gRzkHhMBCkJIXahw7D++Novj8c3X
         sq9SqqgPBsADAQpz81mVYWr+VrQKGsyYBH90xFtxmCvs00LWkdmL4Y1EFpXqjZ0DlI
         0DQOS/Sp9rvnHsg4w+pc7x5n3FVyaE5js6ccjj8E=
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH V2] arm64/cpufeature: Drop open encodings while extracting parange
Date:   Wed, 20 May 2020 18:54:36 +0100
Message-Id: <158999641420.123499.9803666962947435393.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1589360614-1164-1-git-send-email-anshuman.khandual@arm.com>
References: <1589360614-1164-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 14:33:34 +0530, Anshuman Khandual wrote:
> Currently there are multiple instances of parange feature width mask open
> encodings while fetching it's value. Even the width mask value (0x7) itself
> is not accurate. It should be (0xf) per ID_AA64MMFR0_EL1.PARange[3:0] as in
> ARM ARM (0487F.a). Replace them with cpuid_feature_extract_unsigned_field()
> which can extract given standard feature (4 bits width i.e 0xf mask) field.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Applied to arm64 (for-next/cpufeature), thanks!

[1/1] arm64/cpufeature: Drop open encodings while extracting parange
      https://git.kernel.org/arm64/c/f73531f0257f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
