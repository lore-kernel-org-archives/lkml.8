Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D11C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A41F8207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592238857;
	bh=OqfWA/CHtbNnQWA0yNQcf14RySEDAIJDOlbonBobvcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ogj4rKE9YboMkWf4jYuxvQQCYlP5N6w1lqVojPPctzSJmrQwvIXRNRUZ9GYfvtVmw
	 BlVWMwHjk1UHMaByqG9wN2Faq4Z0wFbRT/GVIryeRIp7btCxtf0YmtfG6lKYwQr97O
	 d08DB/3X9Hxv+qPQQ6qfNTzRKWDU6A5tbqYyLBiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731066AbgFOQeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:34:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730852AbgFOQeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:34:14 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 791B22080D;
        Mon, 15 Jun 2020 16:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592238854;
        bh=OqfWA/CHtbNnQWA0yNQcf14RySEDAIJDOlbonBobvcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iqfiAkHKOU6SWYzst2eQ+iqy9jOFcH1vxOLYCMqgtTOJ5/Z7EyltZ3zgUZYAdbCMK
         QRfjjlNfkQOYPmv5i5GAjcHbom8oaxvo12qDryS9hZv/FJgjM39yP3e2p5WB3fxA7n
         hucHG7gQdLFc9i/1BEaoNXVxtTGFspnUA5UJW0WQ=
From:   Will Deacon <will@kernel.org>
To:     mark.rutland@arm.com, anshuman.khandual@arm.com, sashal@kernel.org,
        catalin.marinas@arm.com, ard.biesheuvel@arm.com,
        Shyam Thombre <sthombre@codeaurora.org>, will.deacon@arm.com
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: mm: reset address tag set by kasan sw tagging
Date:   Mon, 15 Jun 2020 17:34:02 +0100
Message-Id: <159223432421.132562.15172582070330227879.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1591787384-5823-1-git-send-email-sthombre@codeaurora.org>
References: <1591787384-5823-1-git-send-email-sthombre@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jun 2020 16:39:44 +0530, Shyam Thombre wrote:
> KASAN sw tagging sets a random tag of 8 bits in the top byte of the pointer
> returned by the memory allocating functions. So for the functions unaware
> of this change, the top 8 bits of the address must be reset which is done
> by the function arch_kasan_reset_tag().

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: mm: reset address tag set by kasan sw tagging
      https://git.kernel.org/arm64/c/8dd4daa04278

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
