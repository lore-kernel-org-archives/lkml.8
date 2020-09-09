Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563C9C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B76F206D4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbgIIReR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:34:17 -0400
Received: from ms.lwn.net ([45.79.88.28]:58514 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgIIReN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 13:34:13 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6578E7C0;
        Wed,  9 Sep 2020 17:34:13 +0000 (UTC)
Date:   Wed, 9 Sep 2020 11:34:12 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: remove current_security() reference
Message-ID: <20200909113412.35413bd6@lwn.net>
In-Reply-To: <20200830142509.5738-1-efremov@linux.com>
References: <20200830142509.5738-1-efremov@linux.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Aug 2020 17:25:09 +0300
Denis Efremov <efremov@linux.com> wrote:

> Commit 15322a0d90b6 ("lsm: remove current_security()") removed
> current_security() from the sources.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  Documentation/security/credentials.rst | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/security/credentials.rst b/Documentation/security/credentials.rst
> index d9387209d143..357328d566c8 100644
> --- a/Documentation/security/credentials.rst
> +++ b/Documentation/security/credentials.rst
> @@ -323,7 +323,6 @@ credentials (the value is simply returned in each case)::
>  	uid_t current_fsuid(void)	Current's file access UID
>  	gid_t current_fsgid(void)	Current's file access GID
>  	kernel_cap_t current_cap(void)	Current's effective capabilities
> -	void *current_security(void)	Current's LSM security pointer
>  	struct user_struct *current_user(void)  Current's user account

Applied, thanks.

jon
