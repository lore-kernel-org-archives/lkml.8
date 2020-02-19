Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AC5C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243E02465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 10:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgBSKoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 05:44:24 -0500
Received: from ms.lwn.net ([45.79.88.28]:33734 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgBSKoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 05:44:23 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D88832DC;
        Wed, 19 Feb 2020 10:44:21 +0000 (UTC)
Date:   Wed, 19 Feb 2020 03:44:16 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] docs: add a script to check sysctl docs
Message-ID: <20200219034416.4d82dc16@lwn.net>
In-Reply-To: <20200218125923.685-8-steve@sk2.org>
References: <20200218125923.685-1-steve@sk2.org>
        <20200218125923.685-8-steve@sk2.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 13:59:22 +0100
Stephen Kitt <steve@sk2.org> wrote:

> This script allows sysctl documentation to be checked against the
> kernel source code, to identify missing or obsolete entries. Running
> it against 5.5 shows for example that sysctl/kernel.rst has two
> obsolete entries and is missing 52 entries.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>

So I like the idea here, but I have a couple of nits and one larger
thought...
> ---
>  Documentation/admin-guide/sysctl/kernel.rst |   3 +
>  scripts/check-sysctl-docs                   | 181 ++++++++++++++++++++
>  2 files changed, 184 insertions(+)
>  create mode 100755 scripts/check-sysctl-docs
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index a67c218c4066..3d21e076aea4 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -2,6 +2,9 @@
>  Documentation for /proc/sys/kernel/
>  ===================================
>  
> +.. See scripts/check-sysctl-docs to keep this up to date
> +
> +
>  Copyright (c) 1998, 1999,  Rik van Riel <riel@nl.linux.org>
>  
>  Copyright (c) 2009,        Shen Feng<shen@cn.fujitsu.com>
> diff --git a/scripts/check-sysctl-docs b/scripts/check-sysctl-docs
> new file mode 100755
> index 000000000000..b3b47c188a2d
> --- /dev/null
> +++ b/scripts/check-sysctl-docs
> @@ -0,0 +1,181 @@
> +#!/usr/bin/gawk -f
> +# SPDX-License-Identifier: GPL-2.0-only

By Documentation/process/license-rules.rst, that should be "GPL-2.0"; the
absence of a "+" means "only".

> +# Script to check sysctl documentation against source files
> +#
> +# Copyright © 2020 Stephen Kitt

Some people object to the introduction of unnecessary non-ASCII text, and
this one would count; can we take the © symbol out?

Now for the bigger thought...  I wonder if what we really want to do is
to adopt some form of the kerneldoc format for sysctl knobs?  That would
allow the documentation to be placed in the source right next to the
table entries, which might, in the optimistic world I inhabit, help
developers to keep them up to date.

That, of course, is more work than what you've done; until somebody feels
inspired to do that work I'll happily accept a tweaked version of this
script.  But one can always dream...

Thanks,

jon
