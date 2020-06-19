Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9BAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 117A520C09
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391373AbgFST6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390834AbgFST6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:58:08 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB57DC06174E;
        Fri, 19 Jun 2020 12:58:08 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C96C32B8;
        Fri, 19 Jun 2020 19:58:07 +0000 (UTC)
Date:   Fri, 19 Jun 2020 13:58:06 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luigi Semenzato <semenzato@chromium.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        NeilBrown <neilb@suse.de>, Yang Shi <yang.shi@linux.alibaba.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: fs: proc.rst: fix a warning due to a merge
 conflict
Message-ID: <20200619135806.7f0e8b0f@lwn.net>
In-Reply-To: <28c4f4c5c66c0fd7cbce83fe11963ea6154f1d47.1591137229.git.mchehab+huawei@kernel.org>
References: <cover.1591137229.git.mchehab+huawei@kernel.org>
        <28c4f4c5c66c0fd7cbce83fe11963ea6154f1d47.1591137229.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 Jun 2020 00:38:14 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Changeset 424037b77519 ("mm: smaps: Report arm64 guarded pages in smaps")
> added a new parameter to a table. This causes Sphinx warnings,
> because there's now an extra "-" at the wrong place:
> 
> 	/devel/v4l/docs/Documentation/filesystems/proc.rst:548: WARNING: Malformed table.
> 	Text in column margin in table line 29.
> 
> 	==    =======================================
> 	rd    readable
> 	...
> 	bt  - arm64 BTI guarded page
> 	==    =======================================
> 
> Fixes: 424037b77519 ("mm: smaps: Report arm64 guarded pages in smaps")
> Fixes: c33e97efa9d9 ("docs: filesystems: convert proc.txt to ReST")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

I went ahead and applied this overdue patch, thanks.

jon
