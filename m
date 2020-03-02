Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E09C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D0724673
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 19:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgCBTuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 14:50:35 -0500
Received: from ms.lwn.net ([45.79.88.28]:58336 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgCBTuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 14:50:35 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 88E5E823;
        Mon,  2 Mar 2020 19:50:34 +0000 (UTC)
Date:   Mon, 2 Mar 2020 12:50:33 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v3] Documentation: bootconfig: Update boot configuration
 documentation
Message-ID: <20200302125033.4a62e88e@lwn.net>
In-Reply-To: <158313622831.3082.8237132211731864948.stgit@devnote2>
References: <158313621831.3082.9886161529613724376.stgit@devnote2>
        <158313622831.3082.8237132211731864948.stgit@devnote2>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Mar 2020 17:03:48 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

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
> Changes in v2:
>  - Fixes additional typos (Thanks Markus and Randy!)
>  - Change a section title to "Tree Structured Key".
> ---

So I tried to apply this but failed - it's built on other changes to
bootconfig.rst that went into linux-next via Steve's tree.  So Steve,
would you like to take this one too?

Thanks,

jon
