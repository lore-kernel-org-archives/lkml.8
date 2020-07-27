Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB85CC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8975720809
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgG0WPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 18:15:51 -0400
Received: from ms.lwn.net ([45.79.88.28]:57908 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgG0WPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 18:15:51 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AE0DF2E7;
        Mon, 27 Jul 2020 22:15:50 +0000 (UTC)
Date:   Mon, 27 Jul 2020 16:15:49 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: filesystems: vfs: correct sync_mode flag names
Message-ID: <20200727161549.1d3e31a0@lwn.net>
In-Reply-To: <1595791341-13209-1-git-send-email-Julia.Lawall@inria.fr>
References: <1595791341-13209-1-git-send-email-Julia.Lawall@inria.fr>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jul 2020 21:22:21 +0200
Julia Lawall <Julia.Lawall@inria.fr> wrote:

> Change the nonexistent flag names WBC_SYNC_ALL and WBC_SYNC_NONE to
> WB_SYNC_ALL and WB_SYNC_NONE, respectively, as used in the code with
> wbc->sync_mode.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  Documentation/filesystems/vfs.rst |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index da4b735..57e9b51 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -766,9 +766,9 @@ cache in your filesystem.  The following members are defined:
>  
>  ``writepages``
>  	called by the VM to write out pages associated with the
> -	address_space object.  If wbc->sync_mode is WBC_SYNC_ALL, then
> +	address_space object.  If wbc->sync_mode is WB_SYNC_ALL, then
>  	the writeback_control will specify a range of pages that must be
> -	written out.  If it is WBC_SYNC_NONE, then a nr_to_write is
> +	written out.  If it is WB_SYNC_NONE, then a nr_to_write is
>  	given and that many pages should be written if possible.  If no
>  	->writepages is given, then mpage_writepages is used instead.  
>  	This will choose pages from the address space that are tagged as

Applied, thanks.

jon
