Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC8EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1630D20C09
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389611AbgFSTj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389188AbgFSTj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:39:29 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D72C06174E;
        Fri, 19 Jun 2020 12:39:29 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 047FF23B;
        Fri, 19 Jun 2020 19:39:28 +0000 (UTC)
Date:   Fri, 19 Jun 2020 13:39:27 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH v3] docs: deprecated.rst: Add zero-length and
 one-element arrays
Message-ID: <20200619133927.654ab7d2@lwn.net>
In-Reply-To: <20200608213711.GA22271@embeddedor>
References: <20200608213711.GA22271@embeddedor>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jun 2020 16:37:11 -0500
"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> Add zero-length and one-element arrays to the list.
> 
> While I continue replacing zero-length and one-element arrays with
> flexible-array members, I need a reference to point people to, so
> they don't introduce more instances of such arrays. And while here,
> add a note to the "open-coded arithmetic in allocator arguments"
> section, on the use of struct_size() and the arrays-to-deprecate
> mentioned here.
> 
> Co-developed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v3:
>  - Add changes written by Kees.
>  - Add Co-developed-by tag to include Kees in the changelog text.
> 
> Changes in v2:
>  - Adjust some markup links for readability.
> 
>  Documentation/process/deprecated.rst | 118 +++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)

Applied, thanks.

jon
