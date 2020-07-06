Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD15AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9C6F20723
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgGFSOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:14:10 -0400
Received: from ms.lwn.net ([45.79.88.28]:56586 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729569AbgGFSOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 14:14:09 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CDE0A2AE;
        Mon,  6 Jul 2020 18:14:08 +0000 (UTC)
Date:   Mon, 6 Jul 2020 12:14:07 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Security: Documentation: fix: `make htmldocs` warnings
Message-ID: <20200706121407.6c24f537@lwn.net>
In-Reply-To: <20200706180010.29032-1-puranjay12@gmail.com>
References: <20200706180010.29032-1-puranjay12@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Jul 2020 23:30:10 +0530
Puranjay Mohan <puranjay12@gmail.com> wrote:

> Remove extra ')' after function name to fix warnings.
> It solves following warning :
> WARNING: Unparseable C cross-reference: 'groups_sort)'
> Invalid C declaration: Expected end of definition. [error at 11]
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  Documentation/security/credentials.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/security/credentials.rst b/Documentation/security/credentials.rst
> index 282e79feee6a..d51e42b92395 100644
> --- a/Documentation/security/credentials.rst
> +++ b/Documentation/security/credentials.rst
> @@ -455,7 +455,7 @@ When replacing the group list, the new list must be sorted before it
>  is added to the credential, as a binary search is used to test for
>  membership.  In practice, this means :c:func:`groups_sort` should be
>  called before :c:func:`set_groups` or :c:func:`set_current_groups`.
> -:c:func:`groups_sort)` must not be called on a ``struct group_list`` which
> +:c:func:`groups_sort` must not be called on a ``struct group_list`` which
>  is shared as it may permute elements as part of the sorting process
>  even if the array is already sorted.

So this is a great fix, thanks for sending it.  That said, there are a
couple of ways in which this fix can be made even better:

 - The simpler of the two is to change the subject line of the patch.
   "Fix a warning" is almost never a good description of what you're
   doing; what you are actually doing is fixing a broken cross reference.
   So the subject line should say that.

 - In this case, though, there is a much better thing to do.  We
   deprecated the use of :c:func: around a year ago; the docs build system
   can now do the right thing automatically.  So a fix that would both
   eliminate the warning and improve the document as a whole would be to
   replace every instance of:

	:c:func:`function_name`

   with:

	function_name()

Is there any chance I could get you to send a patch that does that?

Thanks,

jon
