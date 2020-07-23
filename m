Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0161EC433F8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D7D2065E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgGWUnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbgGWUm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:42:59 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7640AC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 13:42:59 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DEE4D2CD;
        Thu, 23 Jul 2020 20:42:58 +0000 (UTC)
Date:   Thu, 23 Jul 2020 14:42:57 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@collabora.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, mingo@redhat.com, dvhart@infradead.org,
        kernel@collabora.com, mchehab@kernel.org
Subject: Re: [PATCH] futex: MAINTAINERS: Re-add selftests directory
Message-ID: <20200723144257.54a09ee8@lwn.net>
In-Reply-To: <20200715131036.9692-1-andrealmeid@collabora.com>
References: <20200715131036.9692-1-andrealmeid@collabora.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 10:10:36 -0300
André Almeida <andrealmeid@collabora.com> wrote:

> Commit 95ca6d73a8a97 ("docs: move locking-specific documents to
> locking/") accidentally replaced the selftests line for a duplicated
> documentation one. Revert this change.
> 
> Signed-off-by: André Almeida <andrealmeid@collabora.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b4a43a9e7fbc..d03d34c51737 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7107,7 +7107,7 @@ F:	include/linux/futex.h
>  F:	include/uapi/linux/futex.h
>  F:	kernel/futex.c
>  F:	tools/perf/bench/futex*
> -F:	Documentation/locking/*futex*
> +F:	tools/testing/selftests/futex/

Applied (with an added Fixes: tag), thanks.

jon
