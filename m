Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74445C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477A92176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582098623;
	bh=n9/IYLfWjgkCKFVGCPxr4KX26RCkPAV8w7mDru6LtEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZeuMh7lgBHok4h2g52CntpPAFHHPPuYZsFNd02JEXg8Gzkk3eu0mdb9dK8D5D35c1
	 JfPLbo4JfidOOgox3i2vkjgI7tF+6KskvzFBKSpuNxIMtIsFO/7TXUhqvRxJzHOSo0
	 dYRPkUtHn2erT8ldvk6ainOtzoqL6B7WyLQGOkoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgBSHuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:50:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:57132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgBSHuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:50:21 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46494208E4;
        Wed, 19 Feb 2020 07:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582098621;
        bh=n9/IYLfWjgkCKFVGCPxr4KX26RCkPAV8w7mDru6LtEM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vDMncoWz6cyx/LEWprHHL1KKF8u2M0zVhoV3U7QW96vnLDpV9SpUz/C8WhZ/F6KQ9
         YncQJYbHErBSsNhGEwfBpLM0CHztjSaRJpeHZxAq+YnK2huwndGdG3vj4fJlNo7pip
         GuGWPMKe8h+xvf5GvRLEulvNK6ibg/YYZE7740ro=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j4K7f-006RxB-Dt; Wed, 19 Feb 2020 07:50:19 +0000
Date:   Wed, 19 Feb 2020 07:50:17 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, james.morse@arm.com,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 09/12] arm64: disable SCS for hypervisor code
Message-ID: <20200219075017.41e17f08@why>
In-Reply-To: <20200219000817.195049-10-samitolvanen@google.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
        <20200219000817.195049-1-samitolvanen@google.com>
        <20200219000817.195049-10-samitolvanen@google.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: samitolvanen@google.com, will@kernel.org, catalin.marinas@arm.com, rostedt@goodmis.org, mhiramat@kernel.org, ard.biesheuvel@linaro.org, mark.rutland@arm.com, james.morse@arm.com, Dave.Martin@arm.com, keescook@chromium.org, labbott@redhat.com, ndesaulniers@google.com, jannh@google.com, miguel.ojeda.sandonis@gmail.com, yamada.masahiro@socionext.com, clang-built-linux@googlegroups.com, kernel-hardening@lists.openwall.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 16:08:14 -0800
Sami Tolvanen <samitolvanen@google.com> wrote:

> Disable SCS for code that runs at a different exception level by
> adding __noscs to __hyp_text.
> 
> Suggested-by: James Morse <james.morse@arm.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Acked-by: Marc Zyngier <maz@kernel.org>

	M.
-- 
Jazz is not dead. It just smells funny...
