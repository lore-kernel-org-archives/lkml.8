Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45EDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C346B207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgFZRJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728308AbgFZRJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:09:29 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE20AC03E97A;
        Fri, 26 Jun 2020 10:09:28 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1F17B374;
        Fri, 26 Jun 2020 17:09:28 +0000 (UTC)
Date:   Fri, 26 Jun 2020 11:09:27 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Joakim =?UTF-8?B?TMO2bm5lZ3Jlbg==?= <joakimlonnegren@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones:
 Documentation/driver-api
Message-ID: <20200626110927.410eae46@lwn.net>
In-Reply-To: <20200621133512.46311-1-grandmaster@al2klimov.de>
References: <20200621133512.46311-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jun 2020 15:35:12 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

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
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  .../early-userspace/early_userspace_support.rst      |  4 ++--
>  Documentation/driver-api/memory-devices/ti-gpmc.rst  |  2 +-
>  Documentation/driver-api/mmc/mmc-tools.rst           |  2 +-
>  Documentation/driver-api/nvdimm/nvdimm.rst           | 12 ++++++------
>  Documentation/driver-api/nvdimm/security.rst         |  2 +-
>  Documentation/driver-api/rapidio/rapidio.rst         |  4 ++--
>  Documentation/driver-api/thermal/nouveau_thermal.rst |  2 +-
>  Documentation/driver-api/usb/writing_usb_driver.rst  |  4 ++--
>  8 files changed, 16 insertions(+), 16 deletions(-)

I've applied this one, thanks.

jon
