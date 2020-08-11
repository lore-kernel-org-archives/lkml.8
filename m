Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048B0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D878A20768
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgHKQqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:46:16 -0400
Received: from ms.lwn.net ([45.79.88.28]:59368 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbgHKQqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:46:15 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7D49931A;
        Tue, 11 Aug 2020 16:46:15 +0000 (UTC)
Date:   Tue, 11 Aug 2020 10:46:14 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] mailmap: Update comments for with format and more
 detalis
Message-ID: <20200811104614.07754282@lwn.net>
In-Reply-To: <202008080013.58EBD83@keescook>
References: <202008080013.58EBD83@keescook>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Aug 2020 00:14:36 -0700
Kees Cook <keescook@chromium.org> wrote:

> Without having first read the git-shortlog man-page first, the format
> of .mailmap may not be immediately obvious. Add comments with pointers
> to the man-page, along with other details.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied, thanks.  I did take the liberty of removing the redundant "first"
from the changelog, though :)

jon
