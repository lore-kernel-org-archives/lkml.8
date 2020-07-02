Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0222C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F66421582
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgGBROI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 13:14:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbgGBROI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 13:14:08 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC32F21534;
        Thu,  2 Jul 2020 17:14:03 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        Bhupesh Sharma <bhsharma@redhat.com>
Cc:     Will Deacon <will@kernel.org>, Boris Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Dave Anderson <anderson@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        bhupesh.linux@gmail.com, Ingo Molnar <mingo@kernel.org>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>, linux-doc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        scott.branden@broadcom.com, Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        John Donnelly <john.p.donnelly@oracle.com>,
        kexec@lists.infradead.org
Subject: Re: [PATCH v6 0/2] Append new variables to vmcoreinfo (TCR_EL1.T1SZ for arm64 and MAX_PHYSMEM_BITS for all archs)
Date:   Thu,  2 Jul 2020 18:14:02 +0100
Message-Id: <159370984726.27923.4874334372278158979.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1589395957-24628-1-git-send-email-bhsharma@redhat.com>
References: <1589395957-24628-1-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 00:22:35 +0530, Bhupesh Sharma wrote:
> Apologies for the delayed update. Its been quite some time since I
> posted the last version (v5), but I have been really caught up in some
> other critical issues.
> 
> Changes since v5:
> ----------------
> - v5 can be viewed here:
>   http://lists.infradead.org/pipermail/kexec/2019-November/024055.html
> - Addressed review comments from James Morse and Boris.
> - Added Tested-by received from John on v5 patchset.
> - Rebased against arm64 (for-next/ptr-auth) branch which has Amit's
>   patchset for ARMv8.3-A Pointer Authentication feature vmcoreinfo
>   applied.
> 
> [...]

Applied to arm64 (for-next/vmcoreinfo), thanks!

[1/2] crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo
      https://git.kernel.org/arm64/c/1d50e5d0c505
[2/2] arm64/crash_core: Export TCR_EL1.T1SZ in vmcoreinfo
      https://git.kernel.org/arm64/c/bbdbc11804ff

-- 
Catalin

