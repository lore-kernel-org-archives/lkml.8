Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F42C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E275206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgGWUEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgGWUEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:04:54 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFCBC0619DC;
        Thu, 23 Jul 2020 13:04:54 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A19562CD;
        Thu, 23 Jul 2020 20:04:53 +0000 (UTC)
Date:   Thu, 23 Jul 2020 14:04:52 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Replace HTTP links with HTTPS ones
Message-ID: <20200723140452.59c51a7a@lwn.net>
In-Reply-To: <20200720211231.63831-1-grandmaster@al2klimov.de>
References: <CAMj1kXEzaa3BtNF9kgB=UGMx-uvosGwcUbdT3O2qZ1K0XhyUiQ@mail.gmail.com>
        <20200720211231.63831-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 23:12:31 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

>  Documentation/arm64/arm-acpi.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/arm64/arm-acpi.rst b/Documentation/arm64/arm-acpi.rst
> index 872dbbc73d4a..8f675c38c244 100644
> --- a/Documentation/arm64/arm-acpi.rst
> +++ b/Documentation/arm64/arm-acpi.rst
> @@ -273,7 +273,7 @@ only use the _DSD Device Properties UUID [5]:
>  
>     - UUID: daffd814-6eba-4d8c-8a91-bc9bbf4aa301
>  
> -   - http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
> +   - https://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
>  
>  The UEFI Forum provides a mechanism for registering device properties [4]
>  so that they may be used across all operating systems supporting ACPI.

Applied, thanks.

jon
