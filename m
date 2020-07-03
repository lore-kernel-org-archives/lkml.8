Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1074CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1378207DA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgGCIvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:51:55 -0400
Received: from smtprelay0208.hostedemail.com ([216.40.44.208]:43960 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725648AbgGCIvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:51:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id C8DFD181D207E;
        Fri,  3 Jul 2020 08:51:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: joke15_500b9db26e90
X-Filterd-Recvd-Size: 1972
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Fri,  3 Jul 2020 08:51:52 +0000 (UTC)
Message-ID: <80902e5d0d5ef752e71672e9c5794d0f5f9ccd15.camel@perches.com>
Subject: Re: [PATCH] scripts/Lindent: increase the maximum line length to 100
From:   Joe Perches <joe@perches.com>
To:     Zong Li <zong.li@sifive.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 03 Jul 2020 01:51:51 -0700
In-Reply-To: <050476a0ee608046569588936394159d650ab535.1593763492.git.zong.li@sifive.com>
References: <050476a0ee608046569588936394159d650ab535.1593763492.git.zong.li@sifive.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-07-03 at 16:08 +0800, Zong Li wrote:
> As the patch 'bdc48fa11e46 ("checkpatch/coding-style: deprecate
> 80-column warning")', increase the default limit to 100 characters,
> we also increase the maximum line length to 100 for indent script.

I'd prefer to delete Lindent instead.

Also any reformatting tool like this will
_always_ use up to whatever the maximum
line length is rather than use a preferred
length of 80 and and only use the allowed
maximum length of 100 when necessary for
human readability.

> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  scripts/Lindent | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/Lindent b/scripts/Lindent
> index 1688c44c2df6..11f14a4f2048 100755
> --- a/scripts/Lindent
> +++ b/scripts/Lindent
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
>  
> -PARAM="-npro -kr -i8 -ts8 -sob -l80 -ss -ncs -cp1"
> +PARAM="-npro -kr -i8 -ts8 -sob -l100 -ss -ncs -cp1"
>  
>  RES=`indent --version | cut -d' ' -f3`
>  if [ "$RES" = "" ]; then

