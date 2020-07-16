Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A5DC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 234B9207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="2oaE269/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgGPPAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:00:39 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:18900 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbgGPPAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:00:38 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 6097FB2A;
        Thu, 16 Jul 2020 17:00:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        message-id:references:in-reply-to:subject:subject:from:from:date
        :date:content-transfer-encoding:content-type:content-type
        :mime-version:received:received:received; s=dkim20160331; t=
        1594911634; x=1596726035; bh=sprv0swZgJ0cprIpnN8M/f26efVa2WNU/nN
        rTW2ClXc=; b=2oaE269/hlYwcjuH1a66XNC4wFgUlrvOysCgr9o59i1p0lhs5UB
        W6wIqr0TafviV4bZTNidSPk3HbDy+AwMGOF8UH1oUf8w3qgGCYueXCXWgHobgToW
        +5noYaTaVsSdsoUqT0F5m0+d9qUVENt0BAMtXDpxZS/A8VsOS2nxGCqcjftWwKUW
        7rP+B2kXXkmcoUSalZvKDSQdCuHPuMhiC5Mfs+Gwa0zPfmxOzShv/stTH/dRiY3m
        tA3Gk5tGYiNRraQzu33x1ciXUYFZRMsLORq2ZvXQaZ6oswafZlPINruWDKehJiLf
        uYPTZrumfJAMCKDZFcfCm6t8iwGfUWK5kfChSB/GMsW10yFKwqWS+P+lKwkgqxCY
        aL5DrGgpC+RTxIqYNa+/4m73GrKoO7rsE1RA7OmDYaPhvUUqqgfwzs4PFzCILkqN
        z+AqO1Kv7R4Gmu8VWdPcCeibZaVbmZU2ruxcus+HpoTH6KB3B1/HWzPU+PhGFqvJ
        iQu9Wr5HtTR+gtRmdnj6XOIyLJhFXcEPKdNbjS6xgM5oG12dRoS7XhA6GYFG/Kvj
        Otk7YIi0V8KoVYILiNzmXGYQYicpk1HBpXIVA+qeluIE7L4tKZAv9r+ajClNLh3h
        NQMZshssBvX4axB6sbPiPL5aEy9LK3PGv/ORm+aaFCy1e2S2NzxW3wq4=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fngKv0t-mioE; Thu, 16 Jul 2020 17:00:34 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 7762AA6D;
        Thu, 16 Jul 2020 17:00:34 +0200 (CEST)
Received: from int-subm003.mykolab.com (unknown [10.9.37.3])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 014D4A77;
        Thu, 16 Jul 2020 17:00:33 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 16 Jul 2020 17:00:32 +0200
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 1/1] doc:it_IT: process: coding-style.rst: Correct
 __maybe_unused compiler label
In-Reply-To: <20200715122328.3882187-1-lee.jones@linaro.org>
References: <20200715122328.3882187-1-lee.jones@linaro.org>
Message-ID: <4e50d1ee2ebd55f8f87fcd5c631e97f3@vaga.pv.it>
X-Sender: federico.vaga@vaga.pv.it
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Of course, you are right! Thanks

On 2020-07-15 14:23, Lee Jones wrote:
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
> diff --git a/Documentation/translations/it_IT/process/coding-style.rst
> b/Documentation/translations/it_IT/process/coding-style.rst
> index 6f4f85832deea..a346f1f2ce21f 100644
> --- a/Documentation/translations/it_IT/process/coding-style.rst
> +++ b/Documentation/translations/it_IT/process/coding-style.rst
> @@ -1097,7 +1097,7 @@ la direttiva condizionale su di esse.
> 
>  Se avete una variabile o funzione che potrebbe non essere usata in 
> alcune
>  configurazioni, e quindi il compilatore potrebbe avvisarvi circa la 
> definizione
> -inutilizzata, marcate questa definizione come __maybe_used piuttosto 
> che
> +inutilizzata, marcate questa definizione come __maybe_unused piuttosto 
> che
>  racchiuderla in una direttiva condizionale del preprocessore.  
> (Comunque,
>  se una variabile o funzione è *sempre* inutilizzata, rimuovetela).

-- 
Federico Vaga
http://www.federicovaga.it/
