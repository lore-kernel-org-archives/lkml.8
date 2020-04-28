Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1268FC83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3134206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588085425;
	bh=+2uEQ5jvQ4UxBlh92CGWag4inP7/rNpwFZ6aC1jFuMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dub8+GdNcP0dtpVKUhfc3LnYHSbI7es8GhORg7uW/frwYbqGu/LHGJrYs6lbATA8R
	 bjoFCNXb+1ZOJx74U9T0mGNP82ATS+O15mLpc+q59NbZXqShGE94j5M+HTvcBTpGN0
	 54s/YC/q30HQRIR2hf4fVDXXvzApdAYP8HMDXHIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgD1OuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:50:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728111AbgD1Ot4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:49:56 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0E6D206C0;
        Tue, 28 Apr 2020 14:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588085396;
        bh=+2uEQ5jvQ4UxBlh92CGWag4inP7/rNpwFZ6aC1jFuMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OYvzKlwV/caAVRS6ehwRKnrHiHxaz3/jtm7hABUvTOH/cL7dBP5NHyKP4wY4FO2Pi
         VHA26yye6972XZDe9WfiSd9FOLTTUaYyKp8CeWVeJ1iTx5lwNZnoMKQSjlNAv7VwJk
         g0b4sYzSTIy7S9vQl35ARhIV/2CGt2Ka0CJlpXc4=
From:   Will Deacon <will@kernel.org>
To:     Gavin Shan <gshan@redhat.com>, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        mark.rutland@arm.com, shan.gavin@gmail.com, steve.capper@arm.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/kernel: Fix range on invalidating dcache for boot page tables
Date:   Tue, 28 Apr 2020 15:49:37 +0100
Message-Id: <158808168421.218901.8759664423433870069.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427235700.112220-1-gshan@redhat.com>
References: <20200427235700.112220-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 09:57:00 +1000, Gavin Shan wrote:
> Prior to commit 8eb7e28d4c642c31 ("arm64/mm: move runtime pgds to
> rodata"), idmap_pgd_dir, tramp_pg_dir, reserved_ttbr0, swapper_pg_dir,
> and init_pg_dir were contiguous at the end of the kernel image. The
> maintenance at the end of __create_page_tables assumed these were
> contiguous, and affected everything from the start of idmap_pg_dir
> to the end of init_pg_dir.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/kernel: Fix range on invalidating dcache for boot page tables
      https://git.kernel.org/arm64/c/9d2d75ede59b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
