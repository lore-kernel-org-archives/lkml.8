Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF9FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 17:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 636D42072D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 17:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgHHReg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 13:34:36 -0400
Received: from smtprelay0203.hostedemail.com ([216.40.44.203]:54000 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726242AbgHHReg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 13:34:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 25F30182244FF;
        Sat,  8 Aug 2020 17:34:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fifth29_370365026fca
X-Filterd-Recvd-Size: 2511
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sat,  8 Aug 2020 17:34:34 +0000 (UTC)
Message-ID: <841240882e8b21aa069d8ca863a67d5d407cda30.camel@perches.com>
Subject: Re: [PATCH] mailmap: Update comments for with format and more
 detalis
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date:   Sat, 08 Aug 2020 10:34:33 -0700
In-Reply-To: <202008080013.58EBD83@keescook>
References: <202008080013.58EBD83@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-08-08 at 00:14 -0700, Kees Cook wrote:
> Without having first read the git-shortlog man-page first, the format
> of .mailmap may not be immediately obvious. Add comments with pointers
> to the man-page, along with other details.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> I'm adding this to my earlier .mailmap update series:
> https://lore.kernel.org/lkml/20200730183702.702552-1-keescook@chromium.org/
> ---
>  .mailmap | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 6c1c04a63b18..3a991e19928c 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -2,11 +2,16 @@
>  # This list is used by git-shortlog

and scripts/get_maintainer.pl

Today, this list is primarily used not for
messed up email addresses.  It's mostly used
to map no longer in-use email addresses to
current email address.

>  to fix a few botched name translations
>  # in the git archive, either because the author's full name was messed up
>  # and/or not always written the same way, making contributions from the
> -# same person appearing not to be so or badly displayed.
> +# same person appearing not to be so or badly displayed. Also allows for
> +# old email addresses to map to new email addresses.
>  #
> +# For format details, see "MAPPING AUTHORS" in "man git-shortlog".
> +#
> +# Please keep this list dictionary sorted.
> +#
> +# This comment is parsed by git-shortlog:
>  # repo-abbrev: /pub/scm/linux/kernel/git/
>  #
> -
>  Aaron Durbin <adurbin@google.com>
>  Adam Oldham <oldhamca@gmail.com>
>  Adam Radford <aradford@gmail.com>
> -- 
> 2.25.1
> 
> 

