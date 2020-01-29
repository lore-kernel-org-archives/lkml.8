Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828F2C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6537B207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgA2FR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:17:26 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:50881 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgA2FR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:26 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sDh2bzQz9sRp; Wed, 29 Jan 2020 16:17:24 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 25dd118f4b2773490df12b9d190c1956cf3250c3
In-Reply-To: <20191120134115.14918-1-krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] macintosh: Fix Kconfig indentation
Message-Id: <486sDh2bzQz9sRp@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:24 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-20 at 13:41:15 UTC, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/25dd118f4b2773490df12b9d190c1956cf3250c3

cheers
