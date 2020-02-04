Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780E8C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 12:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CCD20730
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 12:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgBDMBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 07:01:44 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:45725 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbgBDMBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 07:01:42 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48BjwN1rjLzB3x3; Tue,  4 Feb 2020 23:01:38 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 34b5a946a9543ce38d8ad1aacc4362533a813db7
In-Reply-To: <20200130195223.3843-1-krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] powerpc: configs: Cleanup old Kconfig options
Message-Id: <48BjwN1rjLzB3x3@ozlabs.org>
Date:   Tue,  4 Feb 2020 23:01:38 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-01-30 at 19:52:23 UTC, Krzysztof Kozlowski wrote:
> CONFIG_ENABLE_WARN_DEPRECATED is gone since
> commit 771c035372a0 ("deprecate the '__deprecated' attribute warnings
> entirely and for good").
> 
> CONFIG_IOSCHED_DEADLINE and CONFIG_IOSCHED_CFQ are gone since
> commit f382fb0bcef4 ("block: remove legacy IO schedulers").
> 
> The IOSCHED_DEADLINE was replaced by MQ_IOSCHED_DEADLINE and it will be
> now enabled by default (along with MQ_IOSCHED_KYBER).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/34b5a946a9543ce38d8ad1aacc4362533a813db7

cheers
