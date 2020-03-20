Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160E3C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 08:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CA020752
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 08:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgCTIx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 04:53:59 -0400
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:46542 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726232AbgCTIx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 04:53:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 4752E18012006;
        Fri, 20 Mar 2020 08:53:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: glue61_3f8a7f1491e21
X-Filterd-Recvd-Size: 2818
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Mar 2020 08:53:56 +0000 (UTC)
Message-ID: <4d40a0b9434042f51c4b21cd48db7ac55522db5a.camel@perches.com>
Subject: Re: [v2,1/1] EDAC: (pnd2) Fix the log level and remove the word
 "error" for message "Failed to register device with error %d"
From:   Joe Perches <joe@perches.com>
To:     "she90122 ." <she90122@gmail.com>
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Amy.Shih" <Amy.Shih@advantech.com.tw>,
        "Oakley.Ding" <Oakley.Ding@advantech.com.tw>
Date:   Fri, 20 Mar 2020 01:52:10 -0700
In-Reply-To: <CAMhTFw=OUaVSLGz1tyHJYiq6UXBNni5=fBp16M7vPXjA0HHEEA@mail.gmail.com>
References: <CAMhTFw=OUaVSLGz1tyHJYiq6UXBNni5=fBp16M7vPXjA0HHEEA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-03-20 at 16:26 +0800, she90122 . wrote:
> From: Amy Shih <amy.shih@advantech.com.tw>
> 
> Fix the log level from "KERN_ERR" to "KERN_INFO" and remove the word
> "error" for message "Failed to register device with error %d", since
> it is not the error message but the information to notice the user.
> 
> Signed-off-by: Amy Shih <amy.shih@advantech.com.tw>
> ---
> Changes in v2:
> - Remove the word "error" from output message.
> ---
>  drivers/edac/pnd2_edac.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c index
> 933f772..399da3e 100644
> --- a/drivers/edac/pnd2_edac.c
> +++ b/drivers/edac/pnd2_edac.c
> @@ -1572,7 +1572,8 @@ static int __init pnd2_init(void)
> 
>   rc = pnd2_probe();
>   if (rc < 0) {
> - pnd2_printk(KERN_ERR, "Failed to register device with error %d.\n", rc);
> + pnd2_printk(KERN_INFO,
> +     "Failed to register device - %d.\n", rc);
>   return rc;
>   }

This will not apply as it's whitespace damaged.

Another possibility would be to use the new %pe extension.
---
 drivers/edac/pnd2_edac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 933f77..370f219 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1572,7 +1572,8 @@ static int __init pnd2_init(void)
 
 	rc = pnd2_probe();
 	if (rc < 0) {
-		pnd2_printk(KERN_ERR, "Failed to register device with error %d.\n", rc);
+		pnd2_printk(KERN_INFO, "Failed to register device - %pe\n",
+			    ERR_PTR(rc));
 		return rc;
 	}
 

