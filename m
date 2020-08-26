Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1749CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4962080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbgHZMri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbgHZMrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:47:37 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42994C061574;
        Wed, 26 Aug 2020 05:47:37 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8F799378;
        Wed, 26 Aug 2020 12:47:34 +0000 (UTC)
Date:   Wed, 26 Aug 2020 06:47:33 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] docs: trace: ring-buffer-design.rst: use the new SPDX
 tag
Message-ID: <20200826064733.33c22a2c@lwn.net>
In-Reply-To: <290d101bee434e54acec13778c67c77802fbc953.1598426895.git.mchehab+huawei@kernel.org>
References: <290d101bee434e54acec13778c67c77802fbc953.1598426895.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 09:28:24 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> SPDX v3.10 gained support for GFDL-1.2 with no invariant sections:
> 
> 	https://spdx.org/licenses/GFDL-1.2-invariants-only.html
> 
> Let's use it, instead of keeping a license text for this file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/trace/ring-buffer-design.rst | 26 +---------------------
>  1 file changed, 1 insertion(+), 25 deletions(-)

[CC expanded]

If we're going to do this, I think we should also add GFDL to the right
place in the LICENSES directory - deprecated/ or at best dual/.  But even
SPDX (https://spdx.org/licenses/GFDL-1.2.html) says this license is
deprecated.

Beyond that, https://spdx.org/licenses/GFDL-1.2-invariants-only.html seems
to disagree with your interpretation; it seems you would want 
GFDL-1.2-only-no-invariants ?

jon
> 
> diff --git a/Documentation/trace/ring-buffer-design.rst b/Documentation/trace/ring-buffer-design.rst
> index 9c8d22a53d6c..a76435610b58 100644
> --- a/Documentation/trace/ring-buffer-design.rst
> +++ b/Documentation/trace/ring-buffer-design.rst
> @@ -1,28 +1,4 @@
> -.. This file is dual-licensed: you can use it either under the terms
> -.. of the GPL 2.0 or the GFDL 1.2 license, at your option. Note that this
> -.. dual licensing only applies to this file, and not this project as a
> -.. whole.
> -..
> -.. a) This file is free software; you can redistribute it and/or
> -..    modify it under the terms of the GNU General Public License as
> -..    published by the Free Software Foundation version 2 of
> -..    the License.
> -..
> -..    This file is distributed in the hope that it will be useful,
> -..    but WITHOUT ANY WARRANTY; without even the implied warranty of
> -..    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -..    GNU General Public License for more details.
> -..
> -.. Or, alternatively,
> -..
> -.. b) Permission is granted to copy, distribute and/or modify this
> -..    document under the terms of the GNU Free Documentation License,
> -..    Version 1.2 version published by the Free Software
> -..    Foundation, with no Invariant Sections, no Front-Cover Texts
> -..    and no Back-Cover Texts. A copy of the license is included at
> -..    Documentation/userspace-api/media/fdl-appendix.rst.
> -..
> -.. TODO: replace it to GPL-2.0 OR GFDL-1.2 WITH no-invariant-sections
> +.. SPDX-License-Identifier: GPL-2.0 OR GFDL-1.2-invariants-only
>  
>  ===========================
>  Lockless Ring Buffer Design
