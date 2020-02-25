Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E332DC35DF9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C321E21556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbgBYKMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 05:12:01 -0500
Received: from ms.lwn.net ([45.79.88.28]:53084 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729417AbgBYKMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:12:01 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1119A6D9;
        Tue, 25 Feb 2020 10:11:59 +0000 (UTC)
Date:   Tue, 25 Feb 2020 03:11:55 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: Fix empty parallelism argument
Message-ID: <20200225031155.312f11a8@lwn.net>
In-Reply-To: <202002211601.322B596B@keescook>
References: <202002211601.322B596B@keescook>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 16:02:39 -0800
Kees Cook <keescook@chromium.org> wrote:

> When there was no parallelism (no top-level -j arg and a pre-1.7
> sphinx-build), the argument passed would be empty ("") instead of just
> being missing, which would (understandably) badly confuse sphinx-build.
> Fix this by removing the quotes.
> 
> Reported-by: Rafael J. Wysocki <rafael@kernel.org>
> Fixes: 51e46c7a4007 ("docs, parallelism: Rearrange how jobserver reservations are made")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied, thanks for fixing this.

jon
