Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF118C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3AB7206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgBSLEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 06:04:36 -0500
Received: from ms.lwn.net ([45.79.88.28]:33880 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgBSLEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 06:04:36 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 08BF12E5;
        Wed, 19 Feb 2020 11:04:34 +0000 (UTC)
Date:   Wed, 19 Feb 2020 04:04:30 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tony Fischetti <tony.fischetti@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: bring process docs up to date
Message-ID: <20200219040430.56a27430@lwn.net>
In-Reply-To: <20200217000826.55767-1-tony.fischetti@gmail.com>
References: <20200217000826.55767-1-tony.fischetti@gmail.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Feb 2020 19:08:26 -0500
Tony Fischetti <tony.fischetti@gmail.com> wrote:

> The guide to the kernel dev process documentation, for example, contains
> references to older kernels and their timelines. In addition, one of the
> "long term support kernels" listed have since reached EOL, and a new one
> has been named. This patch brings information/tables up to date.
> 
> Additionally, some very trivial grammatical errors, unclear sentences,
> and potentially unsavory diction have been edited.
> 
> Signed-off-by: Tony Fischetti <tony.fischetti@gmail.com>

I've applied this, thanks.

jon
