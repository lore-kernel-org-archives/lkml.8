Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9CAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB0B20674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgEROxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 10:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgEROxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:53:50 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11740C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 07:53:50 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jah95-0003jS-Ve; Mon, 18 May 2020 16:53:36 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 40E77100606; Mon, 18 May 2020 16:53:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        bp@alien8.de, luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Sasha Levin <sashal@kernel.org>,
        x86@kernel.org
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
In-Reply-To: <20200511045311.4785-1-sashal@kernel.org>
References: <20200511045311.4785-1-sashal@kernel.org>
Date:   Mon, 18 May 2020 16:53:35 +0200
Message-ID: <871rnhxpjk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Cc: +x86@kernel.org ....

Sasha Levin <sashal@kernel.org> writes:

> Benefits:
> Currently a user process that wishes to read or write the FS/GS base must
> make a system call. But recent X86 processors have added new instructions
> for use in 64-bit mode that allow direct access to the FS and GS segment
> base addresses.  The operating system controls whether applications can
> use these instructions with a %cr4 control bit.
>
> In addition to benefits to applications, performance improvements to the
> OS context switch code are possible by making use of these instructions. A
> third party reported out promising performance numbers out of their
> initial benchmarking of the previous version of this patch series [9].
>
> Enablement check:
> The kernel provides information about the enabled state of FSGSBASE to
> applications using the ELF_AUX vector. If the HWCAP2_FSGSBASE bit is set in
> the AUX vector, the kernel has FSGSBASE instructions enabled and
> applications can use them.
>
> Kernel changes:
> Major changes made in the kernel are in context switch, paranoid path, and
> ptrace. In a context switch, a task's FS/GS base will be secured regardless
> of its selector. In the paranoid path, GS base is unconditionally
> overwritten to the kernel GS base on entry and the original GS base is
> restored on exit. Ptrace includes divergence of FS/GS index and base
> values.
>
> Security:
> For mitigating the Spectre v1 SWAPGS issue, LFENCE instructions were added
> on most kernel entries. Those patches are dependent on previous behaviors
> that users couldn't load a kernel address into the GS base. These patches
> change that assumption since the user can load any address into GS base.
> The changes to the kernel entry path in this patch series take account of
> the SWAPGS issue.
