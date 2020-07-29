Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EF9C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120FB2078E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbgG2AYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:24:53 -0400
Received: from smtprelay0025.hostedemail.com ([216.40.44.25]:35608 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728236AbgG2AYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 20:24:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 157F1100E7B40;
        Wed, 29 Jul 2020 00:24:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hat27_0201f6926f6e
X-Filterd-Recvd-Size: 1546
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 29 Jul 2020 00:24:50 +0000 (UTC)
Message-ID: <c4cb56cca7928f92d642aef467244db434bff26f.camel@perches.com>
Subject: Re: [PATCH] staging/speakup: Move out of staging
From:   Joe Perches <joe@perches.com>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     speakup@linux-speakup.org
Date:   Tue, 28 Jul 2020 17:24:47 -0700
In-Reply-To: <20200728211208.691249-1-samuel.thibault@ens-lyon.org>
References: <20200728211208.691249-1-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-28 at 23:12 +0200, Samuel Thibault wrote:
> The nasty TODO items are done.

Nice.

> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -16077,6 +16077,15 @@ Q:	https://patchwork.kernel.org/project/linux-sparse/list/
>  B:	https://bugzilla.kernel.org/enter_bug.cgi?component=Sparse&product=Tools
>  F:	include/linux/compiler.h
>  
> +SPEAKUP CONSOLE SPEECH DRIVER
> +M:	William Hubbs <w.d.hubbs@gmail.com>
> +M:	Chris Brannon <chris@the-brannons.com>
> +M:	Kirk Reiser <kirk@reisers.ca>
> +M:	Samuel Thibault <samuel.thibault@ens-lyon.org>
> +L:	speakup@linux-speakup.org
> +W:	http://www.linux-speakup.org/
> +F:	drivers/accessibility/speakup/

S:? 	Supported / Maintained / Odd Fixes ?


