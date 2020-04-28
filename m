Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAE2C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E652076A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgD1ShX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730451AbgD1ShR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:37:17 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8231EC03C1AB;
        Tue, 28 Apr 2020 11:37:17 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2D83D2D6;
        Tue, 28 Apr 2020 18:37:17 +0000 (UTC)
Date:   Tue, 28 Apr 2020 12:37:16 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: virt/kvm: close inline string literal
Message-ID: <20200428123716.5f9948ab@lwn.net>
In-Reply-To: <20200424152637.120876-1-steve@sk2.org>
References: <20200424152637.120876-1-steve@sk2.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020 17:26:37 +0200
Stephen Kitt <steve@sk2.org> wrote:

> This fixes
> 
> 	Documentation/virt/kvm/amd-memory-encryption.rst:76: WARNING: Inline literal start-string without end-string.
> 
> Fixes: 2da1ed62d55c ("KVM: SVM: document KVM_MEM_ENCRYPT_OP, let userspace detect if SEV is available")
> Signed-off-by: Stephen Kitt <steve@sk2.org>
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

Applied, thanks.

jon
