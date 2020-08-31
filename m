Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C9CC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C243206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgHaWhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 18:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgHaWhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 18:37:23 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41535C061573;
        Mon, 31 Aug 2020 15:37:22 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 57BFB537;
        Mon, 31 Aug 2020 22:37:21 +0000 (UTC)
Date:   Mon, 31 Aug 2020 16:37:20 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        h.peter.anvin@intel.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] [v2] Documentation: clarify driver licensing rules
Message-ID: <20200831163720.3c70d17d@lwn.net>
In-Reply-To: <20200814145625.8B708079@viggo.jf.intel.com>
References: <20200814145625.8B708079@viggo.jf.intel.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 07:56:25 -0700
Dave Hansen <dave.hansen@linux.intel.com> wrote:

> Greg has challenged some recent driver submitters on their license
> choices. He was correct to do so, as the choices in these instances
> did not always advance the aims of the submitters.
> 
> But, this left submitters (and the folks who help them pick licenses)
> a bit confused. They have read things like
> Documentation/process/license-rules.rst which says:
> 
> 	individual source files can have a different license
> 	which is required to be compatible with the GPL-2.0
> 
> and Documentation/process/submitting-drivers.rst:
> 
> 	We don't insist on any kind of exclusive GPL licensing,
> 	and if you wish ... you may well wish to release under
> 	multiple licenses.
> 
> As written, these appear a _bit_ more laissez faire than we've been in
> practice lately. It sounds like we at least expect submitters to make
> a well-reasoned license choice and to explain their rationale. It does
> not appear that we blindly accept anything that is simply
> GPLv2-compatible.
> 
> Drivers appear to be the most acute source of misunderstanding, so fix
> the driver documentation first. Update it to clarify expectations.

Applied, thanks.

jon
