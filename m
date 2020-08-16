Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B04DC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBAD206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgHPPne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 11:43:34 -0400
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:47298 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726407AbgHPPnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 11:43:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 71AEF182CED2A;
        Sun, 16 Aug 2020 15:43:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cook80_0216d722700f
X-Filterd-Recvd-Size: 1586
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sun, 16 Aug 2020 15:43:31 +0000 (UTC)
Message-ID: <b2230c449f5077596e1ce67f835b5c5f93cf4639.camel@perches.com>
Subject: Re: checkpatch.pl- Cleared some white spaces which generated
 warnings and errors.
From:   Joe Perches <joe@perches.com>
To:     Piyush Thange <pthange19@gmail.com>, apw@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Sun, 16 Aug 2020 08:43:30 -0700
In-Reply-To: <d9f3bbf1-0912-1955-ae1f-a499d5b0b11b@gmail.com>
References: <d9f3bbf1-0912-1955-ae1f-a499d5b0b11b@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-08-16 at 18:25 +0530, Piyush Thange wrote:
> commit eb027935d819a3160404f05633ae47f8b8a061c8
[]
>      scripts:checkpatch.pl:Cleared the white spaces and errors occured 
> due to them.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -488,17 +488,7 @@ our $allocFunctions = qr{(?x:
>       dma_alloc_coherent
>   )};
> 
> -our $signature_tags = qr{(?xi:
> -    Signed-off-by:|
> -    Co-developed-by:|
> -    Acked-by:|
> -    Tested-by:|
> -    Reviewed-by:|
> -    Reported-by:|
> -    Suggested-by:|
> -    To:|
> -    Cc:
> -)};
> +our $signature_tags = 
> qr{(?xi:Signed-off-by:|Co-developed-by:|Acked-by:|Tested-by:|Reviewed-by:|Reported-by:|Suggested-by:|To:|Cc:)};

Do you think this is more readable now?
No thanks.


