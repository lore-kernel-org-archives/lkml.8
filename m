Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE19C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7DB2187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgBNGfw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:35:52 -0500
Received: from mga09.intel.com ([134.134.136.24]:50157 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbgBNGfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 01:35:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 22:35:51 -0800
X-IronPort-AV: E=Sophos;i="5.70,439,1574150400"; 
   d="scan'208";a="227499154"
Received: from ablank-mobl.ger.corp.intel.com (HELO localhost) ([10.252.39.179])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 22:35:48 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH] drm/i915: Cast remain to unsigned long in eb_relocate_vma
In-Reply-To: <20200214054706.33870-1-natechancellor@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200214054706.33870-1-natechancellor@gmail.com>
Date:   Fri, 14 Feb 2020 08:36:15 +0200
Message-ID: <87v9o965gg.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2020, Nathan Chancellor <natechancellor@gmail.com> wrote:
> A recent commit in clang added -Wtautological-compare to -Wall, which is
> enabled for i915 after -Wtautological-compare is disabled for the rest
> of the kernel so we see the following warning on x86_64:
>
>  ../drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1433:22: warning:
>  result of comparison of constant 576460752303423487 with expression of
>  type 'unsigned int' is always false
>  [-Wtautological-constant-out-of-range-compare]
>          if (unlikely(remain > N_RELOC(ULONG_MAX)))
>             ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
>  ../include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
>  # define unlikely(x)    __builtin_expect(!!(x), 0)
>                                             ^
>  1 warning generated.
>
> It is not wrong in the case where ULONG_MAX > UINT_MAX but it does not
> account for the case where this file is built for 32-bit x86, where
> ULONG_MAX == UINT_MAX and this check is still relevant.
>
> Cast remain to unsigned long, which keeps the generated code the same
> (verified with clang-11 on x86_64 and GCC 9.2.0 on x86 and x86_64) and
> the warning is silenced so we can catch more potential issues in the
> future.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/778
> Suggested-by: Michel Dänzer <michel@daenzer.net>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Works for me as a workaround,

Reviewed-by: Jani Nikula <jani.nikula@intel.com>


> ---
>
> Round 3 :)
>
> Previous threads/patches:
>
> https://lore.kernel.org/lkml/20191123195321.41305-1-natechancellor@gmail.com/
> https://lore.kernel.org/lkml/20200211050808.29463-1-natechancellor@gmail.com/
>
>  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> index 60c984e10c4a..47f4d8ab281e 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> @@ -1430,7 +1430,7 @@ static int eb_relocate_vma(struct i915_execbuffer *eb, struct i915_vma *vma)
>  
>  	urelocs = u64_to_user_ptr(entry->relocs_ptr);
>  	remain = entry->relocation_count;
> -	if (unlikely(remain > N_RELOC(ULONG_MAX)))
> +	if (unlikely((unsigned long)remain > N_RELOC(ULONG_MAX)))
>  		return -EINVAL;
>  
>  	/*

-- 
Jani Nikula, Intel Open Source Graphics Center
