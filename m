Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14001C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF83B20739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgGPM4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:56:05 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46607 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728652AbgGPM4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:56:02 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4B6vPn2Rw8z9sTX; Thu, 16 Jul 2020 22:55:56 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linux-kernel@vger.kernel.org, ajd@linux.ibm.com, arnd@arndb.de,
        fbarrat@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        gregkh@linuxfoundation.org
In-Reply-To: <20200713175506.36676-1-grandmaster@al2klimov.de>
References: <20200713175506.36676-1-grandmaster@al2klimov.de>
Subject: Re: [PATCH] ocxl: Replace HTTP links with HTTPS ones
Message-Id: <159490401723.3805857.13113660971237867416.b4-ty@ellerman.id.au>
Date:   Thu, 16 Jul 2020 22:55:56 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 19:55:06 +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.

Applied to powerpc/next.

[1/1] ocxl: Replace HTTP links with HTTPS ones
      https://git.kernel.org/powerpc/c/07497137a5efa9b2628c18083e8b07b33160153d

cheers
