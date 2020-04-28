Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E882BC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A6D2085B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgD1S1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729012AbgD1S1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:27:37 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5016C03C1AB;
        Tue, 28 Apr 2020 11:27:37 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1D61B4B7;
        Tue, 28 Apr 2020 18:27:37 +0000 (UTC)
Date:   Tue, 28 Apr 2020 12:27:36 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] Documentation: x86: fix space instead of tab in uefi
 doc
Message-ID: <20200428122736.219e21ba@lwn.net>
In-Reply-To: <1588080745-21999-1-git-send-email-f.suligoi@asem.it>
References: <1588080745-21999-1-git-send-email-f.suligoi@asem.it>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 15:32:25 +0200
Flavio Suligoi <f.suligoi@asem.it> wrote:

> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>  Documentation/x86/x86_64/uefi.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/x86/x86_64/uefi.rst b/Documentation/x86/x86_64/uefi.rst
> index 88c3ba3..3b89410 100644
> --- a/Documentation/x86/x86_64/uefi.rst
> +++ b/Documentation/x86/x86_64/uefi.rst
> @@ -36,7 +36,7 @@ Mechanics
>  
>  	elilo bootloader with x86_64 support, elilo configuration file,
>  	kernel image built in first step and corresponding
> -	initrd. Instructions on building elilo	and its dependencies
> +	initrd. Instructions on building elilo and its dependencies
>  	can be found in the elilo sourceforge project.

Applied, thanks.

jon
