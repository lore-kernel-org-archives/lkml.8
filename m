Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89ECBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF492063A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgGPJKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 05:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgGPJKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 05:10:51 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572F6C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 02:10:51 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jvzuV-005dVk-Ii; Thu, 16 Jul 2020 11:10:35 +0200
Message-ID: <159691324719ca79fbb8c206da527fc1f2bbc1ed.camel@sipsolutions.net>
Subject: Re: [PATCH v3 3/3] um: allow static linking for non-glibc
 implementations
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ignat Korchagin <ignat@cloudflare.com>, jdike@addtoit.com,
        richard@nod.at, anton.ivanov@cambridgegreys.com,
        brendanhiggins@google.com, masahiroy@kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@cloudflare.com
Date:   Thu, 16 Jul 2020 11:10:19 +0200
In-Reply-To: <20200715201159.54166-4-ignat@cloudflare.com>
References: <20200715201159.54166-1-ignat@cloudflare.com>
         <20200715201159.54166-4-ignat@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-15 at 21:11 +0100, Ignat Korchagin wrote:
> It is possible to produce a statically linked UML binary with UML_NET_VECTOR,
> UML_NET_VDE and UML_NET_PCAP options enabled using alternative libc
> implementations, which do not rely on NSS, such as musl.
> 
> Allow static linking in this case.
> 
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Tested-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  arch/um/Kconfig         | 5 +----
>  arch/um/drivers/Kconfig | 3 ---
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 9318dc6d1a0c..beb98b3b9f75 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -62,12 +62,9 @@ config NR_CPUS
>  
>  source "arch/$(HEADER_ARCH)/um/Kconfig"
>  
> -config FORBID_STATIC_LINK
> -	bool
> -
>  config STATIC_LINK
>  	bool "Force a static link"
> -	depends on !FORBID_STATIC_LINK
> +	depends on CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS || (!UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP)

Come to think of it, in a way "FORBID_STATIC_LINK" was nicer because
there didn't need to be a single list of "what has dynamic dependencies"
like here the list of UML_NET_VECTOR, UML_NET_VDE, UML_NET_PCAP.

Maybe it could be

config MAY_HAVE_NON_STATIC_RUNTIME_DEPS
	bool

config STATIC_LINK
	...
	depends on !MAY_HAVE_NON_STATIC_RUNTIME_DEPS || CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS


and then UML_NET_VECTOR et al can

	select MAY_HAVE_NON_STATIC_RUNTIME_DEPS

so that the knowledge is still distributed to the corresponding options?

johannes

