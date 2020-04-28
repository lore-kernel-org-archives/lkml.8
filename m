Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A61FC83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B02C206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588085414;
	bh=LWipAStYi79F+d7G07tuftJAQ0mns7uxI/o8zViRGqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fZ5WJ8XcYY9fETAqWaGYratrXoKnEbgOZP4A3v5a0w8FF6l4Xdjlhm9lW0uM2+j0i
	 m8wiXUo1+LMTT+AkBTVLUzzkJQitISNLNZ3J9sQ0Qr06M+z0AvkXEgNKboDflc1ntB
	 dkYx5F7WdsEf4cQEp9M/4mzRUGZ/5924FbCjneAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgD1OuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:50:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728152AbgD1OuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:50:05 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B633020757;
        Tue, 28 Apr 2020 14:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588085404;
        bh=LWipAStYi79F+d7G07tuftJAQ0mns7uxI/o8zViRGqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tVZDyXO8PpMiQx6ar06TlCMmvIktiRYKFayMlT4+kb4WrmoEjZckUC/dK5SzGyfaD
         CPnB5VLwZIPw4RQhUt9lFyxcfDixvJ/Vjj9D/4nrYkuC3mAp2stMclTw0Ad9cmzmhl
         7zE/OKZ7JmbdmIxgueaio1B7oxyfhvy0J0Kuoz9U=
From:   Will Deacon <will@kernel.org>
To:     Zou Wei <zou_wei@huawei.com>, catalin.marinas@arm.com
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] arm64: smp: Make cpus_stuck_in_kernel static
Date:   Tue, 28 Apr 2020 15:49:42 +0100
Message-Id: <158807939800.210366.14753763551423768523.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1587623606-96698-1-git-send-email-zou_wei@huawei.com>
References: <1587623606-96698-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Apr 2020 14:33:26 +0800, Zou Wei wrote:
> Fix the following sparse warning:
> 
> arch/arm64/kernel/smp.c:68:5: warning: symbol 'cpus_stuck_in_kernel'
> was not declared. Should it be static?

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: smp: Make cpus_stuck_in_kernel static
      https://git.kernel.org/arm64/c/2eaf63ba84dc

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
