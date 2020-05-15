Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEF8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E30AB206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgEOSEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 14:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgEOSEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:04:05 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FE8C061A0C;
        Fri, 15 May 2020 11:04:05 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 82EAC72D;
        Fri, 15 May 2020 18:04:05 +0000 (UTC)
Date:   Fri, 15 May 2020 12:04:04 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/14] docs: move digsig docs to the security book
Message-ID: <20200515120404.289e2729@lwn.net>
In-Reply-To: <6af5365404c7bd9d008e7e3a77ba83587fd33012.1588345503.git.mchehab+huawei@kernel.org>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
        <6af5365404c7bd9d008e7e3a77ba83587fd33012.1588345503.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 May 2020 17:37:53 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/{digsig.txt => security/digsig.rst} | 0
>  Documentation/security/index.rst                  | 1 +
>  2 files changed, 1 insertion(+)
>  rename Documentation/{digsig.txt => security/digsig.rst} (100%)
> 
> diff --git a/Documentation/digsig.txt b/Documentation/security/digsig.rst
> similarity index 100%
> rename from Documentation/digsig.txt
> rename to Documentation/security/digsig.rst
> diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
> index fc503dd689a7..8129405eb2cc 100644
> --- a/Documentation/security/index.rst
> +++ b/Documentation/security/index.rst
> @@ -15,3 +15,4 @@ Security Documentation
>     self-protection
>     siphash
>     tpm/index
> +   digsig

Applied, thanks.

jon
