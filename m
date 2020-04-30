Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1419BC47254
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0EA02070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgD3VFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:05:04 -0400
Received: from ms.lwn.net ([45.79.88.28]:58068 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgD3VFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:05:03 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 22D686E3;
        Thu, 30 Apr 2020 21:05:02 +0000 (UTC)
Date:   Thu, 30 Apr 2020 15:05:01 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     linux-doc@vger.kernel.org, pbonzini@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Documentation: fix `make htmldocs ` warning
Message-ID: <20200430150501.033bfa20@lwn.net>
In-Reply-To: <20200430205447.93458-1-vitor@massaru.org>
References: <20200430205447.93458-1-vitor@massaru.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 17:54:47 -0300
Vitor Massaru Iha <vitor@massaru.org> wrote:

> Fix 'make htmldocs' warning:
> Documentation/virt/kvm/amd-memory-encryption.rst:76: WARNING: Inline literal start-string without end-string.
> 
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> ---
>  Documentation/virt/kvm/amd-memory-encryption.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/amd-memory-encryption.rst b/Documentation/virt/kvm/amd-memory-encryption.rst
> index c3129b9ba5cb..57c01f531e61 100644
> --- a/Documentation/virt/kvm/amd-memory-encryption.rst
> +++ b/Documentation/virt/kvm/amd-memory-encryption.rst
> @@ -74,7 +74,7 @@ should point to a file descriptor that is opened on the ``/dev/sev``
>  device, if needed (see individual commands).
>  
>  On output, ``error`` is zero on success, or an error code.  Error codes
> -are defined in ``<linux/psp-dev.h>`.
> +are defined in ``<linux/psp-dev.h>``.

This one, too, is already fixed in docs-next.  If you're doing
documentation work, please work against that tree.

Also, "fix a warning" is almost never an appropriate subject line for any
kernel patch.  You're not fixing a warning, you're fixing some broken RST
in the file.  The subject line on the patch I merged fixing this problem
reads:

	docs: virt/kvm: close inline string literal

...which describes what is really going on.

Thanks,

jon
