Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A75C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 01:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BD720409
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 01:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgCTB4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 21:56:23 -0400
Received: from smtprelay0198.hostedemail.com ([216.40.44.198]:55934 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726867AbgCTB4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 21:56:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 65A95182CF665;
        Fri, 20 Mar 2020 01:56:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: kick45_376b8a8970b3b
X-Filterd-Recvd-Size: 1850
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Mar 2020 01:56:20 +0000 (UTC)
Message-ID: <e67eefc91d4f54a5fbf64be9e6bee94680461b60.camel@perches.com>
Subject: Re: [v1,1/1] EDAC: (pnd2) Fix the log level for message "Failed to
 register device with error %d"
From:   Joe Perches <joe@perches.com>
To:     Amy.Shih@advantech.com.tw, she90122@gmail.com
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        oakley.ding@advantech.com.tw
Date:   Thu, 19 Mar 2020 18:54:34 -0700
In-Reply-To: <20200317062828.18807-1-Amy.Shih@advantech.com.tw>
References: <20200317062828.18807-1-Amy.Shih@advantech.com.tw>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-17 at 06:28 +0000, Amy.Shih@advantech.com.tw wrote:
> From: Amy Shih <amy.shih@advantech.com.tw>
> 
> Fix the log level from "KERN_ERR" to "KERN_INFO" for message "Failed to
> register device with error %d", since it is not the error message but
> the information to notice the user.
[]
> diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
[]
> @@ -1572,7 +1572,8 @@ static int __init pnd2_init(void)
>  
>  	rc = pnd2_probe();
>  	if (rc < 0) {
> -		pnd2_printk(KERN_ERR, "Failed to register device with error %d.\n", rc);
> +		pnd2_printk(KERN_INFO,
> +			    "Failed to register device with error %d.\n", rc);

So there's no need to use the word "error"
in the output message either.

	"Failed to register device - %d\n", rc

would be enough.


