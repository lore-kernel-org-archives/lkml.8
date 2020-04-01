Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94001C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5F62073B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585730410;
	bh=IettRpxQKHjbXxTrJwRzoDBrplyvOcANa1c7iBza1LU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F3nLHGRLSiV+rV9fMbF6JupLbruCTV+dnSNmp1os3D//vVTyiLezmzn98T1zqcFEy
	 E2RlXd4H7zS7fj3waGz2fOoP/Zm0PtqKiGVSugyVLd29hDOh+4Mht9YDxv9bj2h2ic
	 OVgzH06l8dHeMwn/ZXgYdtjUNizzOpON2Tane+Wo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732126AbgDAIkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731753AbgDAIkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:40:07 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B00B72073B;
        Wed,  1 Apr 2020 08:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585730407;
        bh=IettRpxQKHjbXxTrJwRzoDBrplyvOcANa1c7iBza1LU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E69v0NqTT9HWVarFu0fAspnLLE/OtAiEou5LXE6Zd7So6v8F2L8g9FULYIgtbf6jW
         K8cbv5z/zLe5OtGAuyGLe1eU+o6+05Osz5F+0iTcfWF4+n+CdcSmk1sHUHOFQ7/8qt
         Vzvf7Ar8TBxQSX75nnYaGyMOpM0VLuK4vUrjzgpk=
Date:   Wed, 1 Apr 2020 09:40:02 +0100
From:   Will Deacon <will@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, cai@lca.pw, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kcsan: Move kcsan_{disable,enable}_current() to
 kcsan-checks.h
Message-ID: <20200401084002.GB16446@willie-the-truck>
References: <20200331193233.15180-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331193233.15180-1-elver@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 09:32:32PM +0200, Marco Elver wrote:
> Both affect access checks, and should therefore be in kcsan-checks.h.
> This is in preparation to use these in compiler.h.
> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/kcsan-checks.h | 16 ++++++++++++++++
>  include/linux/kcsan.h        | 16 ----------------
>  2 files changed, 16 insertions(+), 16 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
