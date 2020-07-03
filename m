Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB48C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E97AA20772
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgGCM3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 08:29:51 -0400
Received: from ms.lwn.net ([45.79.88.28]:43246 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgGCM3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 08:29:51 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 28DF7384;
        Fri,  3 Jul 2020 12:29:51 +0000 (UTC)
Date:   Fri, 3 Jul 2020 06:29:50 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Danny Lin <danny@kdrag0n.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] editorconfig: Add automatic editor configuration
 file
Message-ID: <20200703062950.5e8c1785@lwn.net>
In-Reply-To: <20200703073143.423557-1-danny@kdrag0n.dev>
References: <16043769.gqpzGLO8mG@pinwheel>
        <20200703073143.423557-1-danny@kdrag0n.dev>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Jul 2020 00:31:43 -0700
Danny Lin <danny@kdrag0n.dev> wrote:

> EditorConfig is a standard for defining basic editor configuration in
> projects. There is support available for 47 code editors as of writing,
> including both built-in and extension support. Many notable projects
> have adopted the standard already, including zsh, htop, and qemu.
> 
> While this isn't a full-fledged C code style specifier, it does set some
> basic ground rules that make it more convenient for contributors to use
> any editor of their choice and not have to worry about indentation, line
> endings, encoding, final newlines, etc. This should make it
> significantly easier to conform to the kernel's general code style when
> used in combination with clang-format.
> 
> For more information, check the official EditorConfig website:
> https://editorconfig.org/
> 
> Signed-off-by: Danny Lin <danny@kdrag0n.dev>
> ---

So I worry a bit that not everybody will welcome the addition of a dotfile
that may be magically interpreted by their editor.  I also worry that the
file itself could become a battleground for people wanting to argue about
style issues.

Perhaps I worry a bit too much...?

jon
