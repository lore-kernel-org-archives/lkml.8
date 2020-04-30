Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02EEC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC56208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588281163;
	bh=ZD0jljxwJlB1qZk4zuXOvumuhDv7yUCcoT6YJz1JRXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u5aSaQKcLJqerEr4mEt5b9ZEa52oGsLesrfYFuxEudoxstRioLVB/2WPVIZhXdtfl
	 oE/ajx7RncNg26KOUcGejG1kqAOPwkl7gFStpcxZH6uZGKMBMCKngGVwTpSjfabgMh
	 +AojqXQlWZORyyzLY0EH5ZiCZO1i8w8uJ4kALYnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgD3VMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:12:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbgD3VMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:12:42 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 176AA207DD;
        Thu, 30 Apr 2020 21:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588281161;
        bh=ZD0jljxwJlB1qZk4zuXOvumuhDv7yUCcoT6YJz1JRXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mirM/kzSKwe1mHuJk5PQ1mOaSLvi7v/LHKLnjZk9S6O/zYkBpOkwcn/Nw4bwlenzF
         ZD3f6fqWR70X1JeimYBzkAExHM6GphHXuV/1Ds7P71C752KiHyHbS8p3rnNcGamPaY
         wfRn3q/1eXaWUVvgUXhzcAQ0soKR4OXjdWIuRJZg=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Cc:     Will Deacon <will@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/2] Make memory size reporting in kexec_file_load() accurate
Date:   Thu, 30 Apr 2020 22:12:25 +0100
Message-Id: <158827870560.24445.10969636442610279958.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430163142.27282-1-l.stelmach@samsung.com>
References: <20200430105034.17513-1-l.stelmach@samsung.com> <CGME20200430163213eucas1p2c5c040b5d34cf2f41286b99751df7cb2@eucas1p2.samsung.com> <20200430163142.27282-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 18:31:40 +0200, =?UTF-8?q?=C5=81ukasz=20Stelmach?= wrote:
> Calling kexec_add_buffer() page-alligns the value of kbuf.memsz, so it
> is not same as the requested value. Hence both bufsz and memsz should
> after kexec_add_buffer() is called should be be reported separately.
> 
> Łukasz Stelmach (2):
>   arm64: kexec_file: print appropriate variable
>   x86: kexec_file: print appropriate variable
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/2] arm64: kexec_file: print appropriate variable
      https://git.kernel.org/arm64/c/51075e0cb759
[2/2] x86: kexec_file: print appropriate variable
      (not applied)

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
