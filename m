Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC21BC2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FE620788
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgCXPRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:17:25 -0400
Received: from smtprelay0017.hostedemail.com ([216.40.44.17]:55732 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727168AbgCXPRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:17:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 8D6D1182CED2A;
        Tue, 24 Mar 2020 15:17:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: chair87_65693e825c5c
X-Filterd-Recvd-Size: 1739
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 24 Mar 2020 15:17:23 +0000 (UTC)
Message-ID: <fb5a17c67f504f5761069ee446cc1b703dd8b54f.camel@perches.com>
Subject: Re: [PATCH] rearrange the output text, cosmetic changes
From:   Joe Perches <joe@perches.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, linux@leemhuis.info,
        rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 24 Mar 2020 08:15:33 -0700
In-Reply-To: <20200324084513.18237-1-unixbhaskar@gmail.com>
References: <20200324084513.18237-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-24 at 14:15 +0530, Bhaskar Chowdhury wrote:
> As the subject like says, purely cosmetic changes to read cleanly.
> Jumbled up the line.

Subject line should show tools or kernel-chktaint

and:

> diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
[]
> @@ -195,8 +195,9 @@ else
>  	echo " * kernel was built with the struct randomization plugin (#17)"
>  fi
> 
> -echo "For a more detailed explanation of the various taint flags see"
> -echo " Documentation/admin-guide/tainted-kernels.rst in the the Linux kernel sources"
> -echo " or https://kernel.org/doc/html/latest/admin-guide/tainted-kernels.html"
>  echo "Raw taint value as int/string: $taint/'$out'"
> +echo
> +echo "For a more detailed explanation of the various taint flags see below pointers:"
> +echo "1) Documentation/admin-guide/tainted-kernels.rst in  the Linux kernel sources"

One extra space between "in  the"


