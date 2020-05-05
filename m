Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D51C47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A148206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbgEEPmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729447AbgEEPmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:42:14 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA912C061A0F;
        Tue,  5 May 2020 08:42:14 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 42E86737;
        Tue,  5 May 2020 15:42:14 +0000 (UTC)
Date:   Tue, 5 May 2020 09:42:13 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     linux-doc@vger.kernel.org, mchehab@kernel.org,
        linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [RESEND] doc: misc-device: add uacce to toctree(index)
Message-ID: <20200505094213.6c652cc6@lwn.net>
In-Reply-To: <20200430225828.114033-1-vitor@massaru.org>
References: <20200430225828.114033-1-vitor@massaru.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 19:58:28 -0300
Vitor Massaru Iha <vitor@massaru.org> wrote:

> This fixes:
> 
> Documentation/misc-devices/uacce.rst: WARNING: document isn't included in any toctree
> 
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> ---
>  Documentation/misc-devices/index.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
> index c1dcd2628911..1ecc05fbe6f4 100644
> --- a/Documentation/misc-devices/index.rst
> +++ b/Documentation/misc-devices/index.rst
> @@ -21,4 +21,5 @@ fit into other categories.
>     lis3lv02d
>     max6875
>     mic/index
> +   uacce

Applied, thanks.

jon
