Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDACC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C91A821548
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388500AbgFST3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388345AbgFST3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:29:20 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0483C06174E;
        Fri, 19 Jun 2020 12:29:20 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5579C23B;
        Fri, 19 Jun 2020 19:29:20 +0000 (UTC)
Date:   Fri, 19 Jun 2020 13:29:19 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc:it_IT: add symbol-namespace translation
Message-ID: <20200619132919.30ab63e5@lwn.net>
In-Reply-To: <20200614201053.59502-1-federico.vaga@vaga.pv.it>
References: <20200614201053.59502-1-federico.vaga@vaga.pv.it>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jun 2020 22:10:53 +0200
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> - add complete translation of symbol-namespaces.rst
> - fix references to this page within the italian translation
> - add document to main indexes
> 
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> ---
>  .../translations/it_IT/core-api/index.rst     |  18 ++
>  .../it_IT/core-api/symbol-namespaces.rst      | 166 ++++++++++++++++++
>  Documentation/translations/it_IT/index.rst    |   5 +-
>  .../it_IT/kernel-hacking/hacking.rst          |   4 +-
>  4 files changed, 189 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/translations/it_IT/core-api/index.rst
>  create mode 100644 Documentation/translations/it_IT/core-api/symbol-namespaces.rst

Applied, thanks.

jon
