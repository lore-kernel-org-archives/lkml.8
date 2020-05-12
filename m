Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262D7CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 024BA20720
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 17:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589305245;
	bh=/URzC6VGuwBTM/0QXjea3OFpEst1nciR25t4Xb7qZE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=au4SCjTddWqlsP+BwNh6EJq8R/oeZvBXXCFAWgrRyVRvwmb4AfhEgswwiAGxq3ulQ
	 qbHResHuV2hWsTOx4QlfHEJzT7/owd4HM3V8aSLTl9vKSk1eRIYssRjWVjck+5eo2y
	 5zIBpznakp67lUKdmHNp/cHk0AbsGLFIG6C8cung=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgELRko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 13:40:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgELRkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 13:40:43 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9014A20714;
        Tue, 12 May 2020 17:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589305243;
        bh=/URzC6VGuwBTM/0QXjea3OFpEst1nciR25t4Xb7qZE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TyqnCB2Lre2uRgpoes9HvChWMD4LHKM1zC9Y9ma0CYbabycrdKdUPXSut/yyxZKI0
         Ea0jJgN5nP3eWeJlnswJ0+Ug7K/nXCgJaOawH51Bs3xZCicJAVkSn7CkrM5BOiP8Fp
         ZlzKGciYHBtF7FjiLl3/DucPveBeb9q2ZQWEpZfE=
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: cpufeature: Add "or" to mitigations for multiple errata
Date:   Tue, 12 May 2020 18:40:37 +0100
Message-Id: <158930503373.2884.12713544688468253876.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200512145255.5520-1-geert+renesas@glider.be>
References: <20200512145255.5520-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 16:52:55 +0200, Geert Uytterhoeven wrote:
> Several actions are not mitigations for a single erratum, but for
> multiple errata.  However, printing a line like
> 
>     CPU features: detected: ARM errata 1165522, 1530923
> 
> may give the false impression that all three listed errata have been
> detected.  This can confuse the user, who may think his Cortex-A55 is
> suddenly affected by a Cortex-A76 erratum.
> 
> [...]

Applied to arm64 (for-next/kconfig), thanks!

[1/1] arm64: cpufeature: Add "or" to mitigations for multiple errata
      https://git.kernel.org/arm64/c/357dd8a2aff2

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
