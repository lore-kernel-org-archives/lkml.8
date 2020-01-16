Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DABC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64889217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579198712;
	bh=eK+zgsqPWz6GAYkJtti8rLXXAgfol0Ms7k1eGuEjvcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nlt2wWiv0g5g1kfEXIujdDrCCnOdAJEsVhldjq/w1TX3rENZc13fvt6owM9jzVfa9
	 gXJJSpGGCEXsAB9fa9j6tIa1qQHZ9giqixl3+uBWoaAsFqHQ1feBuPLbQ5bTAOFn2A
	 jw9sPB8XM6Z659kmotA6XLReyB6hLYnFfReYTNLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395410AbgAPSSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:18:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387827AbgAPSS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:18:27 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD97820684;
        Thu, 16 Jan 2020 18:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579198706;
        bh=eK+zgsqPWz6GAYkJtti8rLXXAgfol0Ms7k1eGuEjvcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uSA1/16Jv5t+QkTG5DUYDIw5GCOnYY7mMdMEHjQJg4sRtJx0p92p7BGyiz1r3y+zt
         HIA5X6uhHXR8fQZhMAgOktn72OxXqWdijpihtIWgO3rxYSaNPqu/WwZgGkRoZGgc3f
         iezAkiFdQPopG1zeb3Cek072wQSLs3i8/5I2lSlQ=
Date:   Thu, 16 Jan 2020 18:18:20 +0000
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 12/15] arm64: vdso: disable Shadow Call Stack
Message-ID: <20200116181820.GB22420@willie-the-truck>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191206221351.38241-1-samitolvanen@google.com>
 <20191206221351.38241-13-samitolvanen@google.com>
 <20200116174648.GE21396@willie-the-truck>
 <CABCJKucWusLEaLyq=Dv5pWjxcUX7Q9dL=fSstwNK4eJ_6k33=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKucWusLEaLyq=Dv5pWjxcUX7Q9dL=fSstwNK4eJ_6k33=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 10:14:24AM -0800, Sami Tolvanen wrote:
> On Thu, Jan 16, 2020 at 9:46 AM Will Deacon <will@kernel.org> wrote:
> > Should we be removing -ffixed-x18 too, or does that not propagate here
> > anyway?
> 
> No, we shouldn't touch -ffixed-x18 here. The vDSO is always built with
> x18 reserved since commit 98cd3c3f83fbb ("arm64: vdso: Build vDSO with
> -ffixed-x18").

Thanks, in which case:

Acked-by: Will Deacon <will@kernel.org>

Will
