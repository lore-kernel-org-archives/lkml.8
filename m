Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DEFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A83F2311A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbgHFRXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:23:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:44440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730034AbgHFRXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:23:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9939DACC6;
        Thu,  6 Aug 2020 12:07:56 +0000 (UTC)
Date:   Thu, 6 Aug 2020 14:07:39 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] samples/livepatch: Add README.rst disclaimer
Message-ID: <20200806120738.GQ24529@alley>
References: <20200721161407.26806-1-joe.lawrence@redhat.com>
 <20200721161407.26806-3-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721161407.26806-3-joe.lawrence@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-07-21 12:14:07, Joe Lawrence wrote:
> The livepatch samples aren't very careful with respect to compiler
> IPA-optimization of target kernel functions.
> 
> Add a quick disclaimer and pointer to the compiler-considerations.rst
> file to warn readers.
> 
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  samples/livepatch/README.rst | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 samples/livepatch/README.rst

I am not sure if the RST format makes sense here. But it does not
harm. Either way:

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
