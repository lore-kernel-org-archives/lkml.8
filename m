Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FE4C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC642065E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgGWUnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:43:53 -0400
Received: from ms.lwn.net ([45.79.88.28]:42616 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbgGWUnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:43:52 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B13782BA;
        Thu, 23 Jul 2020 20:43:52 +0000 (UTC)
Date:   Thu, 23 Jul 2020 14:43:51 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-doc@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 1/1] doc:it_IT: process: coding-style.rst: Correct
 __maybe_unused compiler label
Message-ID: <20200723144351.333341d2@lwn.net>
In-Reply-To: <20200715122328.3882187-1-lee.jones@linaro.org>
References: <20200715122328.3882187-1-lee.jones@linaro.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 13:23:28 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Flag is __maybe_unused, not __maybe_used.
> 
> Cc: Federico Vaga <federico.vaga@vaga.pv.it>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: clang-built-linux@googlegroups.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  Documentation/translations/it_IT/process/coding-style.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/translations/it_IT/process/coding-style.rst b/Documentation/translations/it_IT/process/coding-style.rst
> index 6f4f85832deea..a346f1f2ce21f 100644
> --- a/Documentation/translations/it_IT/process/coding-style.rst
> +++ b/Documentation/translations/it_IT/process/coding-style.rst
> @@ -1097,7 +1097,7 @@ la direttiva condizionale su di esse.
>  
>  Se avete una variabile o funzione che potrebbe non essere usata in alcune
>  configurazioni, e quindi il compilatore potrebbe avvisarvi circa la definizione
> -inutilizzata, marcate questa definizione come __maybe_used piuttosto che
> +inutilizzata, marcate questa definizione come __maybe_unused piuttosto che
>  racchiuderla in una direttiva condizionale del preprocessore.  (Comunque,

Applied, thanks.

jon
