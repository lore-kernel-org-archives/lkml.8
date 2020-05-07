Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E59C4724C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85E2920838
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588860313;
	bh=UGMaIlmDe2PXXTCKVFDLhA4MiqbreTvt2g9+e67JfNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PYm2P03ZmNmOUBR/fuM45HSsLMVPgry62Nm058AHSSO7loFdOUgXxVhy6DSnAw79R
	 fjJIgPzBn6kENyDnw4R6wtRXqdL1wEXvWdjyj5ZCjumiMlmFCc2Clx1GZfJgFFu4Fq
	 hxUCMzEEeYe4I+6EkLWjHY+17gBP3D98TN2Ateao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgEGOFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgEGOFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:05:11 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C79592082E;
        Thu,  7 May 2020 14:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588860311;
        bh=UGMaIlmDe2PXXTCKVFDLhA4MiqbreTvt2g9+e67JfNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zWjmSSzhb+E9LNn9Z+3SfSebl0OxqpT9NebL/MFNLynazreXVZlpJguuZojkRlq+4
         IStMR7EFrTps/BTPAntLRtv9KJML9JuFnWVl6Caz4peuX90hr5R0F5E4naRYX2MaIw
         zaIaIiP+z1LcjeJ1v0to2hGmQ40JoPpCUbnt5uFQ=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        Tamas Zsoldos <tamas.zsoldos@arm.com>
Subject: Re: [PATCH] arm64: vdso: Add --eh-frame-hdr to ldflags
Date:   Thu,  7 May 2020 15:04:56 +0100
Message-Id: <158885881702.237249.11426070057323434764.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507104049.47834-1-vincenzo.frascino@arm.com>
References: <20200507104049.47834-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 11:40:49 +0100, Vincenzo Frascino wrote:
> LLVM's unwinder depends on the .eh_frame_hdr being present for
> unwinding. However, when compiling Linux with GCC, the section
> is not present in the vdso library object and when compiling
> with Clang, it is present, but it has zero length.
> 
> With GCC the problem was not spotted because libgcc unwinder does
> not require the .eh_frame_hdr section to be present.
> 
> [...]

Applied to arm64 (for-next/vdso), thanks!

[1/1] arm64: vdso: Add --eh-frame-hdr to ldflags
      https://git.kernel.org/arm64/c/7e9f5e6629f6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
