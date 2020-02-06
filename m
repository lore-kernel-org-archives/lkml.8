Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87733C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 10:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F13214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 10:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O9XIG10R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgBFKbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 05:31:12 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36168 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbgBFKbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:31:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=doRr41+uHYQPX4/to1I/1srPnHzm/CaLlIXj8w9Vubs=; b=O9XIG10RJTp9t1KXQg2NFLAhGf
        +gipjAzct3zUGo4Hyf9EXunyT5NgIUBfSiRIcZJt8HPofZwC8xQet/QxB0qiVlRipsJYmF1Nvm96k
        cQZQmF1xIcEPKZcvzf3CkUzkhwNWRV1SpwSsdISIhizHw7pz61xKYs7HxGgghNYyVtkQlt3f+9JHG
        Fb4dZblXX3+XwHvlmeJoP0sm0Wl0Plbx9z2G5OZtxM9AMBT1WU/sZkZRALvH9fpuNj8TrigZBSNH9
        Z+M8+QiUbaQzhsyC0BtstPUOnyUpGp7GvoV7zWtNYZ4i11n9mcGWZHr300AVj0uwgpw+hRo2dvhJx
        FJXyLhTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izeR0-0007UO-4E; Thu, 06 Feb 2020 10:30:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 15F553007F2;
        Thu,  6 Feb 2020 11:29:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F9132B789F42; Thu,  6 Feb 2020 11:30:55 +0100 (CET)
Date:   Thu, 6 Feb 2020 11:30:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, keescook@chromium.org,
        rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 05/11] x86: Makefile: Add build and config option for
 CONFIG_FG_KASLR
Message-ID: <20200206103055.GV14879@hirez.programming.kicks-ass.net>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-6-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200205223950.1212394-6-kristen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 02:39:44PM -0800, Kristen Carlson Accardi wrote:
> Allow user to select CONFIG_FG_KASLR if dependencies are met. Change
> the make file to build with -ffunction-sections if CONFIG_FG_KASLR
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> ---
>  Makefile         |  4 ++++
>  arch/x86/Kconfig | 13 +++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index c50ef91f6136..41438a921666 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -846,6 +846,10 @@ ifdef CONFIG_LIVEPATCH
>  KBUILD_CFLAGS += $(call cc-option, -flive-patching=inline-clone)
>  endif
>  
> +ifdef CONFIG_FG_KASLR
> +KBUILD_CFLAGS += -ffunction-sections
> +endif

The GCC manual has:

  -ffunction-sections
  -fdata-sections

      Place each function or data item into its own section in the output
      file if the target supports arbitrary sections. The name of the
      function or the name of the data item determines the section’s name
      in the output file.

      Use these options on systems where the linker can perform
      optimizations to improve locality of reference in the instruction
      space. Most systems using the ELF object format have linkers with
      such optimizations. On AIX, the linker rearranges sections (CSECTs)
      based on the call graph. The performance impact varies.

      Together with a linker garbage collection (linker --gc-sections
      option) these options may lead to smaller statically-linked
      executables (after stripping).

      On ELF/DWARF systems these options do not degenerate the quality of
      the debug information. There could be issues with other object
      files/debug info formats.

      Only use these options when there are significant benefits from
      doing so. When you specify these options, the assembler and linker
      create larger object and executable files and are also slower. These
      options affect code generation. They prevent optimizations by the
      compiler and assembler using relative locations inside a translation
      unit since the locations are unknown until link time. An example of
      such an optimization is relaxing calls to short call instructions.

In particular:

  "They prevent optimizations by the compiler and assembler using
  relative locations inside a translation unit since the locations are
  unknown until link time."

I suppose in practise this only means tail-calls are affected and will
no longer use JMP.d8. Or are more things affected?

(Also, should not the next patch come before this one?)
