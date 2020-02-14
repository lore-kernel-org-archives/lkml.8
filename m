Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0530AC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 10:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D559D24649
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 10:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbgBNKCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 05:02:10 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:47224 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbgBNKCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 05:02:10 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 9072457127e571a4; Fri, 14 Feb 2020 11:02:07 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        erik.kaneda@intel.com
Cc:     lenb@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ACPICA: Fix a typo in acuuid.h
Date:   Fri, 14 Feb 2020 11:02:07 +0100
Message-ID: <2712088.SaWAGPlJqS@kreacher>
In-Reply-To: <20200214063003.29741-1-christophe.jaillet@wanadoo.fr>
References: <20200214063003.29741-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, February 14, 2020 7:30:03 AM CET Christophe JAILLET wrote:
> The comment related to the ending of the include guard should be related to
> __ACUUID_H__, not __AUUID_H__ (i.e. 'C' is missing).
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Erik, please route this through the upstream.

Thanks!

> ---
>  include/acpi/acuuid.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/acpi/acuuid.h b/include/acpi/acuuid.h
> index 9dd4689a39cf..9e1367b19069 100644
> --- a/include/acpi/acuuid.h
> +++ b/include/acpi/acuuid.h
> @@ -57,4 +57,4 @@
>  #define UUID_THERMAL_EXTENSIONS         "14d399cd-7a27-4b18-8fb4-7cb7b9f4e500"
>  #define UUID_DEVICE_PROPERTIES          "daffd814-6eba-4d8c-8a91-bc9bbf4aa301"
>  
> -#endif				/* __AUUID_H__ */
> +#endif				/* __ACUUID_H__ */
> 




