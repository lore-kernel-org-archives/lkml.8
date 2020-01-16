Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE4CC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAC42072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733073AbgAPTwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:52:02 -0500
Received: from ms.lwn.net ([45.79.88.28]:44572 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730082AbgAPTwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 14:52:01 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A771E2CA;
        Thu, 16 Jan 2020 19:52:00 +0000 (UTC)
Date:   Thu, 16 Jan 2020 12:51:59 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     mchehab+samsung@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v4 0/9] Documentation: nfs: Convert a few documents to
 RST and move them to admin-guide
Message-ID: <20200116125159.5e1cb227@lwn.net>
In-Reply-To: <cover.1578697871.git.dwlsalmeida@gmail.com>
References: <cover.1578697871.git.dwlsalmeida@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 20:24:22 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:

> This series converts a few docs in Documentation/filesystems/nfs to RST.
> The docs were also moved into admin-guide because they contain information
> that might be useful for system administrators
> 
> Most changes are related to aesthetics and presentation, i.e. the content
> itself remains mostly untouched. The use of markup was limited in order
> not to negatively impact the plain-text reading experience.

OK, I've applied the full set to docs-next.  Many thanks for doing this
work and for your patience in getting it ready to apply!

jon
