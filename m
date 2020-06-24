Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34930C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11C2E20781
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593006908;
	bh=/1svtZ7NFc/8pJ2Kp6i4gm4ajra1i4VBRLm1WItsEMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PQAxdbgsWysPgu85A6bhnEjWplR/2yrI5ztA5HyLwvLoLCrmY5JpG7jcZl2Wc77/M
	 PbEnDXZv09tJEsfWqgV2SdCCWcQwTps2LRBwVWI1xK9hAGLK7Tsnga/jiSxWYXl0Ky
	 F9t3IVMIVenSGw39IYJTGblVP2o7ZKjxFkRfxLjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391164AbgFXNzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389668AbgFXNzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:55:05 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CD7320724;
        Wed, 24 Jun 2020 13:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593006905;
        bh=/1svtZ7NFc/8pJ2Kp6i4gm4ajra1i4VBRLm1WItsEMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qTWXXWzzkiccoVFz/2cLbK9y/b4meGyKs970QbtqAoJKFfrYOE8wJQNan/2zkjIbG
         M9gInwgc0i5vdEgc9IJfSprW2ZMaMPfd25JecqOiJlhvlLKNXm9xCTx1tcU3dr6wx2
         XnwsVCEoVoSbiftJU5wdTX+rn7DxiauXaityvSg4=
From:   Will Deacon <will@kernel.org>
To:     Iurii Zaikin <yzaikin@google.com>, PaX Team <pageexec@freemail.hu>,
        Mathias Krause <minipli@googlemail.com>, x86@kernel.org,
        Sven Schnelle <svens@stackframe.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Emese Revfy <re.emese@gmail.com>,
        kernel-hardening@lists.openwall.com,
        Laura Abbott <labbott@redhat.com>,
        Brad Spengler <spender@grsecurity.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jessica Yu <jeyu@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kbuild@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Alexander Monakov <amonakov@ispras.ru>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexander Popov <alex.popov@linux.com>, gcc@gcc.gnu.org,
        Jann Horn <jannh@google.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        notify@kernel.org
Subject: Re: [PATCH v2 0/5] Improvements of the stackleak gcc plugin
Date:   Wed, 24 Jun 2020 14:54:49 +0100
Message-Id: <159300400829.52405.11593787740425104484.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200624123330.83226-1-alex.popov@linux.com>
References: <20200624123330.83226-1-alex.popov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020 15:33:25 +0300, Alexander Popov wrote:
> This is the v2 of the patch series with various improvements of the
> stackleak gcc plugin.
> 
> The first three patches disable unneeded gcc plugin instrumentation for
> some files.
> 
> The fourth patch is the main improvement. It eliminates an unwanted
> side-effect of kernel code instrumentation performed by stackleak gcc
> plugin. This patch is a deep reengineering of the idea described on
> grsecurity blog:
>   https://grsecurity.net/resolving_an_unfortunate_stackleak_interaction
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: vdso: Don't use gcc plugins for building vgettimeofday.c
      https://git.kernel.org/arm64/c/e56404e8e475

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
