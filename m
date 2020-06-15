Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A6BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C416B2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbgFORsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 13:48:23 -0400
Received: from smtprelay0219.hostedemail.com ([216.40.44.219]:41310 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728585AbgFORsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 13:48:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 60AFF180AD393;
        Mon, 15 Jun 2020 17:48:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: thing04_3f0858226df8
X-Filterd-Recvd-Size: 2362
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon, 15 Jun 2020 17:48:20 +0000 (UTC)
Message-ID: <4e00b2fa91f1f818de4658f2695d4b433852959d.camel@perches.com>
Subject: Re: [PATCH 18/22] docs: trace: ring-buffer-design.txt: convert to
 ReST format
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-spdx@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Date:   Mon, 15 Jun 2020 10:48:10 -0700
In-Reply-To: <c11ee0be2bf63626887d7cd38e7572b31e2a2ce2.1592203650.git.mchehab+huawei@kernel.org>
References: <cover.1592203650.git.mchehab+huawei@kernel.org>
         <c11ee0be2bf63626887d7cd38e7572b31e2a2ce2.1592203650.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-15 at 08:50 +0200, Mauro Carvalho Chehab wrote:
> - Just like some media documents, this file is dual licensed
>   with GPL and GFDL. As right now the GFDL SPDX definition is
>   bogus (as it doesn't tell anything about invariant parts),
>   let's not use SPDX here. Let's use, instead, the same test
>   as we have on media.
[]
> diff --git a/Documentation/trace/ring-buffer-design.txt b/Documentation/trace/ring-buffer-design.rst
> []
> +.. Or, alternatively,
> +..
> +.. b) Permission is granted to copy, distribute and/or modify this
> +..    document under the terms of the GNU Free Documentation License,
> +..    Version 1.1 or any later version published by the Free Software
> +..    Foundation, with no Invariant Sections, no Front-Cover Texts
> +..    and no Back-Cover Texts. A copy of the license is available at
> +..    https://www.gnu.org/licenses/old-licenses/fdl-1.2.html

Use of a version 1.1 reference with a 1.2 link.

Perhaps the link should be:
https://www.gnu.org/licenses/old-licenses/fdl-1.1.html

> +..
> +.. TODO: replace it to GPL-2.0 OR GFDL-1.2-or-later WITH no-invariant-sections

Is there some reason a new GFDL entry has not yet been added
to the LICENSES directory?



