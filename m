Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417BAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D30208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390834AbgFSUNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 16:13:31 -0400
Received: from ms.lwn.net ([45.79.88.28]:55554 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbgFSUNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 16:13:30 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5AA3D23B;
        Fri, 19 Jun 2020 20:13:30 +0000 (UTC)
Date:   Fri, 19 Jun 2020 14:13:29 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 18/22] docs: trace: ring-buffer-design.txt: convert to
 ReST format
Message-ID: <20200619141329.3867e57e@lwn.net>
In-Reply-To: <c11ee0be2bf63626887d7cd38e7572b31e2a2ce2.1592203650.git.mchehab+huawei@kernel.org>
References: <cover.1592203650.git.mchehab+huawei@kernel.org>
        <c11ee0be2bf63626887d7cd38e7572b31e2a2ce2.1592203650.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 08:50:23 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

[CC += Steve]

> - Just like some media documents, this file is dual licensed
>   with GPL and GFDL. As right now the GFDL SPDX definition is
>   bogus (as it doesn't tell anything about invariant parts),
>   let's not use SPDX here. Let's use, instead, the same test
>   as we have on media.

The dual-licensing really can't be expressed with an SPDX tag?  Because...

[...]

> +.. This file is dual-licensed: you can use it either under the terms
> +.. of the GPL 2.0 or the GFDL 1.2+ license, at your option. Note that this
> +.. dual licensing only applies to this file, and not this project as a
> +.. whole.
> +..
> +.. a) This file is free software; you can redistribute it and/or
> +..    modify it under the terms of the GNU General Public License as
> +..    published by the Free Software Foundation version 2 of
> +..    the License.
> +..
> +..    This file is distributed in the hope that it will be useful,
> +..    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +..    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +..    GNU General Public License for more details.
> +..
> +.. Or, alternatively,
> +..
> +.. b) Permission is granted to copy, distribute and/or modify this
> +..    document under the terms of the GNU Free Documentation License,
> +..    Version 1.1 or any later version published by the Free Software
> +..    Foundation, with no Invariant Sections, no Front-Cover Texts
> +..    and no Back-Cover Texts. A copy of the license is available at
> +..    https://www.gnu.org/licenses/old-licenses/fdl-1.2.html
> +..
> +.. TODO: replace it to GPL-2.0 OR GFDL-1.2-or-later WITH no-invariant-sections

...adding all that boilerplate is kind of a bummer.

At a minimum I'd want an ack from Steve (who wasn't copied) before
applying this, but it would be better to add a bit more SPDX
infrastructure to express this if possible.

Thanks,

jon
