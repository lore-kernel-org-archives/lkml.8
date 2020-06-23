Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56B1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA11820874
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388711AbgFWXMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 19:12:10 -0400
Received: from smtprelay0121.hostedemail.com ([216.40.44.121]:43652 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387709AbgFWXMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 19:12:08 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 45A69182D3514;
        Tue, 23 Jun 2020 23:12:07 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 2CE9C18080;
        Tue, 23 Jun 2020 23:12:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wool80_25070cf26e3f
X-Filterd-Recvd-Size: 1697
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 Jun 2020 23:12:05 +0000 (UTC)
Message-ID: <f47454785a47df6758625d52974753d1a519163d.camel@perches.com>
Subject: Re: [PATCH v2 9/9] docs: staging: use small font for literal
 includes
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Date:   Tue, 23 Jun 2020 16:12:04 -0700
In-Reply-To: <22bcadb42ba2c391d13a9f8cd1ccfa9349e3b555.1592905407.git.mchehab+huawei@kernel.org>
References: <cover.1592905407.git.mchehab+huawei@kernel.org>
         <22bcadb42ba2c391d13a9f8cd1ccfa9349e3b555.1592905407.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-23 at 11:53 +0200, Mauro Carvalho Chehab wrote:
> The normal font is too big to display 80 columns, causing extra
> breaks to be added at weird places.
> 
> change to the footnotesize, as this would fit a little bit
> better.
[]
> diff --git a/Documentation/staging/index.rst b/Documentation/staging/index.rst
[]
> @@ -19,14 +19,41 @@ Unsorted Documentation
>  Atomic Types
>  ============
>  
> -.. literalinclude:: ../atomic_t.txt
> +.. raw:: latex
> +
> +    \footnotesize
> +
> +.. include:: ../atomic_t.txt
> +   :literal:
> +
> +.. raw:: latex
> +
> +    \normalsize

Is there something like push/pop for styles?
Maybe some variant of include:: with a style?

