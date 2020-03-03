Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425CAC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AD92465E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qj2EFX/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgCCBwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 20:52:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38708 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgCCBwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 20:52:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=NSfLdsm5L9JTNJGf8ZM7w0TrSlZzxMgfaVEelZp4YqA=; b=qj2EFX/WYxnKXYE1pca5FuJSgX
        iywR9Np684IGNBma4IquuP12AvVpkZ0F9A/o/eLXK6yS79LNgrQXP7cCDKzJo4YlI2YYwPQov18jF
        Cw73pwtaykBx8dQ/8aPmI0/rKrcKGC5glWks+YtFUWDtzgt3VFQeG2fyo6fe0COfRV5zThdkLtgt/
        bp2Thi5KrjiKfaIUrftLUvCdy/pxmw9nOthcf/J6lWYw0TinuPXYT/8MhNbmZsCdB0ZPauEQwKeC5
        71LTUgNbum0dFS+K6IEwFk48BRGFNxJQxXpf8AIylbhVoVVOqnVARp4AlZHH6PFoaEQJg1DYpvKqr
        32pNcUcQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j8wjd-0000f0-H0; Tue, 03 Mar 2020 01:52:37 +0000
Subject: Re: [PATCH v3] Documentation: bootconfig: Update boot configuration
 documentation
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
References: <158313621831.3082.9886161529613724376.stgit@devnote2>
 <158313622831.3082.8237132211731864948.stgit@devnote2>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8c032093-c652-5e33-36ad-732f73beabab@infradead.org>
Date:   Mon, 2 Mar 2020 17:52:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158313622831.3082.8237132211731864948.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/20 12:03 AM, Masami Hiramatsu wrote:
> Update boot configuration documentation.
> 
>  - Not using "config" abbreviation but configuration or description.
>  - Rewrite descriptions of node and its maxinum number.
>  - Add a section of use cases of boot configuration.
>  - Move how to use bootconfig to earlier section.
>  - Fix some typos, indents and format mistakes.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
> Changes in v3:
>  - Specify that comments also count in size.
>  - Fix a confusing sentence.
>  - Add O=<builddir> to make command.


Hi Masami-san,

I think that you misunderstood me.  I am asking that you
make "make O=builddir -C tools/bootconfig" work properly, i.e.,
the bootconfig binary should be built in the <builddir>.

Presently when I enter that command, the bootconfig binary
is still built in the kernel source tree.

> Changes in v2:
>  - Fixes additional typos (Thanks Markus and Randy!)
>  - Change a section title to "Tree Structured Key".
> ---
>  Documentation/admin-guide/bootconfig.rst |  181 +++++++++++++++++++-----------
>  Documentation/trace/boottime-trace.rst   |    2 
>  2 files changed, 117 insertions(+), 66 deletions(-)
> 


All of the other changes look good to me.

thanks.
-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
