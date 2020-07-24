Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4867C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B09DE206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgGXR01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:26:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbgGXR01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:26:27 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 355E320674;
        Fri, 24 Jul 2020 17:26:25 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrei Vagin <avagin@gmail.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH 1/6] arm64/vdso: use the fault callback to map vvar pages
Date:   Fri, 24 Jul 2020 18:26:23 +0100
Message-Id: <159561069973.19270.10637845392621633755.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200624083321.144975-2-avagin@gmail.com>
References: <20200624083321.144975-1-avagin@gmail.com> <20200624083321.144975-2-avagin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020 01:33:16 -0700, Andrei Vagin wrote:
> Currently the vdso has no awareness of time namespaces, which may
> apply distinct offsets to processes in different namespaces. To handle
> this within the vdso, we'll need to expose a per-namespace data page.
> 
> As a preparatory step, this patch separates the vdso data page from
> the code pages, and has it faulted in via its own fault callback.
> Subsquent patches will extend this to support distinct pages per time
> namespace.
> 
> [...]

Applied to arm64 (for-next/timens), provisionally.

One potential issue I did not check is the compat vDSO. The arm32 port
does not support timens currently. IIUC, with these patches and
COMPAT_VDSO enabled, it will allow timens for compat processes. Normally
I'd like the arm32 support first before updating compat but I don't
think there would be any interface incompatibility here.

However, does this still work for arm32 processes if COMPAT_VDSO is
disabled in the arm64 kernel?

[1/6] arm64/vdso: use the fault callback to map vvar pages
      https://git.kernel.org/arm64/c/d53b5c013e1e
[2/6] arm64/vdso: Zap vvar pages when switching to a time namespace
      https://git.kernel.org/arm64/c/1b6867d2916b
[3/6] arm64/vdso: Add time namespace page
      https://git.kernel.org/arm64/c/3503d56cc723
[4/6] arm64/vdso: Handle faults on timens page
      https://git.kernel.org/arm64/c/ee3cda8e4606
[5/6] arm64/vdso: Restrict splitting VVAR VMA
      https://git.kernel.org/arm64/c/bcf996434240
[6/6] arm64: enable time namespace support
      https://git.kernel.org/arm64/c/9614cc576d76

Thanks!

-- 
Catalin

