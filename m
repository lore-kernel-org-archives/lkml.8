Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B58CC47256
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 433762072E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 00:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgEBAKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 20:10:03 -0400
Received: from smtprelay0250.hostedemail.com ([216.40.44.250]:58482 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726437AbgEBAKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 20:10:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 4F02718224D76;
        Sat,  2 May 2020 00:10:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: desk86_1d52530fcbd4e
X-Filterd-Recvd-Size: 2008
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sat,  2 May 2020 00:10:01 +0000 (UTC)
Message-ID: <3aac8d7e3f11d7df5b8155c93beee447cf8f064b.camel@perches.com>
Subject: Re: [PATCH 14/14] docs: staging: use small font for literal includes
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Date:   Fri, 01 May 2020 17:10:00 -0700
In-Reply-To: <f0dd118559a49c1a8c1e248382f48d5a07c0751d.1588345503.git.mchehab+huawei@kernel.org>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
         <f0dd118559a49c1a8c1e248382f48d5a07c0751d.1588345503.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-05-01 at 17:37 +0200, Mauro Carvalho Chehab wrote:
> The normal font is too big to display 80 columns, causing extra
> breaks to be added at weird places.
> 
> change to the footnotesize, as this would fit a little bit
> better.
[]
> diff --git a/Documentation/staging/index.rst b/Documentation/staging/index.rst
[]
> @@ -19,17 +19,41 @@ Unsorted Documentation
>  Atomic Types
>  ============
>  
> +.. raw:: latex
> +
> +    \footnotesize

Please don't make the markup too invasive.

> +
>  .. include:: ../atomic_t.txt
>     :literal:
>  
> +.. raw:: latex
> +
> +    \normalsize
> +
>  Atomic bitops
>  =============
>  
> +.. raw:: latex
> +
> +    \footnotesize
> +
>  .. include:: ../atomic_bitops.txt
>     :literal:
>  
> +.. raw:: latex
> +
> +    \normalsize
> +
>  Memory Barriers
>  ===============
>  
> +.. raw:: latex
> +
> +    \footnotesize
> +
>  .. include:: ../memory-barriers.txt
>     :literal:
> +
> +.. raw:: latex
> +
> +    \normalsize

