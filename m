Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109FBC10DAA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9EF620757
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgIIRhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:37:02 -0400
Received: from ms.lwn.net ([45.79.88.28]:58556 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgIIRhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 13:37:00 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E906237C;
        Wed,  9 Sep 2020 17:36:59 +0000 (UTC)
Date:   Wed, 9 Sep 2020 11:36:58 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2] Documentation: submit-checklist: add clean builds
 for new Documentation
Message-ID: <20200909113658.405f11bb@lwn.net>
In-Reply-To: <cf5bbdf5-03ff-0606-a6d4-ca196d90aee9@infradead.org>
References: <cf5bbdf5-03ff-0606-a6d4-ca196d90aee9@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Aug 2020 17:43:54 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Add to Documentation/process/submit-checklist.rst that patch
> submitters should run "make htmldocs" and verify that any
> Documentation/ changes (patches) are clean (no new warnings/errors).
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> ---
> v2: insert "new" inside "without warnings/errors" (Mike)
> 
>  Documentation/process/submit-checklist.rst |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> --- linux-next-20200821.orig/Documentation/process/submit-checklist.rst
> +++ linux-next-20200821/Documentation/process/submit-checklist.rst
> @@ -24,6 +24,10 @@ and elsewhere regarding submitting Linux
>  
>    c) Builds successfully when using ``O=builddir``
>  
> +  d) Any Documentation/ changes build successfully without new warnings/errors.
> +     Use ``make htmldocs`` or ``make pdfdocs`` to check the build and
> +     fix any issues.
> +

Applied, thanks.

jon
