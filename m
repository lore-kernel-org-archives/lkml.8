Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8B3C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 711FD20702
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgGFUbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGFUbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 16:31:05 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8BBC061755;
        Mon,  6 Jul 2020 13:31:05 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5B81F2D6;
        Mon,  6 Jul 2020 20:31:05 +0000 (UTC)
Date:   Mon, 6 Jul 2020 14:31:04 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Security: Documentation: Replace deprecated :c:func:
 Usage
Message-ID: <20200706143104.48fa2bd1@lwn.net>
In-Reply-To: <20200706184956.6928-1-puranjay12@gmail.com>
References: <20200706184956.6928-1-puranjay12@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Jul 2020 00:19:56 +0530
Puranjay Mohan <puranjay12@gmail.com> wrote:

> Replace :c:func: with ``func()`` as the previous usage is deprecated.
> Remove an extra ')' to fix broken cross reference.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
> V2: Remove ``quotes`` around function names
> V1: Change the subject line and remove deprecated :c:func: usage
> ---
>  Documentation/security/credentials.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/security/credentials.rst b/Documentation/security/credentials.rst
> index 282e79feee6a..15175b11336c 100644
> --- a/Documentation/security/credentials.rst
> +++ b/Documentation/security/credentials.rst
> @@ -453,9 +453,9 @@ still at this point.
>  
>  When replacing the group list, the new list must be sorted before it
>  is added to the credential, as a binary search is used to test for
> -membership.  In practice, this means :c:func:`groups_sort` should be
> -called before :c:func:`set_groups` or :c:func:`set_current_groups`.
> -:c:func:`groups_sort)` must not be called on a ``struct group_list`` which
> +membership.  In practice, this means groups_sort() should be
> +called before set_groups() or set_current_groups().
> +groups_sort() must not be called on a ``struct group_list`` which
>  is shared as it may permute elements as part of the sorting process
>  even if the array is already sorted.

I've applied this, many thanks.

jon
