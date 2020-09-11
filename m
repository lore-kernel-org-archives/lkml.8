Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F29C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 444EB221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599842042;
	bh=XAOq0210n7nJdY2TnJbtZnt0KCDi3Hx+aItFjItbew0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0vuMrw2oHu7+YaIVeaDpWRBhWqS1cviSedgUrAkWY4n0tsUTEqeg8BWMYv2F43gOo
	 2lo4iOQF8Mq9tDlZD1hKH51x/TF4mjNr91wblU0SCpYZL7w4A0uB2p141v3HCIjNBI
	 Ur5VwI3Yd3qvxmjPeVu9WjVZLnlQMQaFk6qK+Ly4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgIKQeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:34:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgIKQdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:33:51 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A894E208FE;
        Fri, 11 Sep 2020 16:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599842031;
        bh=XAOq0210n7nJdY2TnJbtZnt0KCDi3Hx+aItFjItbew0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uTw9AvVhCOCo84qkBPV3m1+IKr8viHTdca3w2ulh5RL3cQn7ads724s66BCozMODY
         h0Icxi97Wq08T1AMG8tqa45si6frpUnN3jtlFHADWb+xNQuy2e9J49wijPJ53MFyJb
         BkukTNtOJUiG2pIzlqo51xcIXCeyaX0BP8n4cHZc=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, Gavin Shan <gshan@redhat.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        anshuman.khandual@arm.com, shan.gavin@gmail.com
Subject: Re: [PATCH v2 1/3] arm64/mm: Remove CONT_RANGE_OFFSET
Date:   Fri, 11 Sep 2020 17:33:44 +0100
Message-Id: <159983844259.1467384.16465875642356581877.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200910095936.20307-1-gshan@redhat.com>
References: <20200910095936.20307-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020 19:59:34 +1000, Gavin Shan wrote:
> The macro was introduced by commit <ecf35a237a85> ("arm64: PTE/PMD
> contiguous bit definition") at the beginning. It's only used by
> commit <348a65cdcbbf> ("arm64: Mark kernel page ranges contiguous"),
> which was reverted later by commit <667c27597ca8>. This makes the
> macro unused.
> 
> This removes the unused macro (CONT_RANGE_OFFSET).

Applied to arm64 (for-next/mm), thanks!

[1/3] arm64/mm: Remove CONT_RANGE_OFFSET
      https://git.kernel.org/arm64/c/11e339d53a73
[2/3] arm64/mm: Unify CONT_PTE_SHIFT
      https://git.kernel.org/arm64/c/c0d6de327f18
[3/3] arm64/mm: Unify CONT_PMD_SHIFT
      https://git.kernel.org/arm64/c/e676594115f0

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
