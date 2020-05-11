Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786B1C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D21E206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbgEKSyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 14:54:15 -0400
Received: from smtprelay0148.hostedemail.com ([216.40.44.148]:43678 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729453AbgEKSyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:54:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 536534DCF;
        Mon, 11 May 2020 18:54:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: grain11_24e0b558a6440
X-Filterd-Recvd-Size: 2578
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Mon, 11 May 2020 18:54:13 +0000 (UTC)
Message-ID: <59b3e2aac1388209d168a31294dfd2b1f7d21513.camel@perches.com>
Subject: Re: [PATCH] Revert "dynamic_debug: Remove unnecessary __used"
From:   Joe Perches <joe@perches.com>
To:     Elliot Berman <eberman@codeaurora.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     Trilok Soni <tsoni@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 11 May 2020 11:54:12 -0700
In-Reply-To: <1589221618-21808-1-git-send-email-eberman@codeaurora.org>
References: <1589221618-21808-1-git-send-email-eberman@codeaurora.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-11 at 11:26 -0700, Elliot Berman wrote:
> This reverts commit c0d2af637863940b1a4fb208224ca7acb905c39f.
> 
> Some compilers[1] may break dynamic_hex_dump by optimizing the
> DYNAMIC_DEBUG_BRANCH check inside __dynamic_func_call_no_desc and completely
> removing the dynamic debug metadata. Thus, there is no dynamic_debug control
> site to enable or disable. The if condition is optimized away based on the
> initial value of flags (i.e. if DEBUG macro is present).
> 
> [1]: This behavior is present on [aarch64-gnu-linux-gcc (Ubuntu/Linaro
> 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609] and [Android Common Kernel
> toolchain: "Android (6051079 based on r370808) clang version
> 10.0.1"] using arm64 default defconfig + DYNAMIC_DEBUG enabled.
> 
> Change-Id: I28e9b86088eee5d5ed2384fbcea2ac2e7337a559
> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
> ---

Change-Id: probably isn't necessary.

Is there a separate mechanism possible to avoid bloating the
otherwise unused content?

>  include/linux/dynamic_debug.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index abcd5fd..7518db4f 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -79,7 +79,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
>  			 const char *fmt, ...);
>  
>  #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)		\
> -	static struct _ddebug  __aligned(8)			\
> +	static struct _ddebug __used __aligned(8)		\
>  	__attribute__((section("__verbose"))) name = {		\
>  		.modname = KBUILD_MODNAME,			\
>  		.function = __func__,				\

