Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E42BC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A62C207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgEGGtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 02:49:53 -0400
Received: from smtprelay0227.hostedemail.com ([216.40.44.227]:39696 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725813AbgEGGtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:49:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 427BF1803950B;
        Thu,  7 May 2020 06:49:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: burst17_1bd6e369c792e
X-Filterd-Recvd-Size: 1816
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 May 2020 06:49:51 +0000 (UTC)
Message-ID: <5f2d179c35de8e7705f82a8c9a540dbd204bb978.camel@perches.com>
Subject: Re: [PATCH -next] ALSA: portman2x4: Use bitwise instead of
 arithmetic operator for flags
From:   Joe Perches <joe@perches.com>
To:     Samuel Zou <zou_wei@huawei.com>, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date:   Wed, 06 May 2020 23:49:50 -0700
In-Reply-To: <1588834135-14842-1-git-send-email-zou_wei@huawei.com>
References: <1588834135-14842-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-07 at 14:48 +0800, Samuel Zou wrote:
> Fix the following coccinelle warning:
> 
> sound/drivers/portman2x4.c:460:34-35: WARNING: sum of probable bitmasks, consider |

This one is reasonable.

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Samuel Zou <zou_wei@huawei.com>
> ---
>  sound/drivers/portman2x4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
> index ecefa7c..38603cb 100644
> --- a/sound/drivers/portman2x4.c
> +++ b/sound/drivers/portman2x4.c
> @@ -457,7 +457,7 @@ static int portman_probe(struct parport *p)
>  
>  	/* Set for RXDATA0 where no damage will be done. */
>  	/* 5 */
> -	parport_write_control(p, RXDATA0 + STROBE);	/* Write Strobe=1 to command reg. */
> +	parport_write_control(p, RXDATA0 | STROBE);	/* Write Strobe=1 to command reg. */
>  
>  	/* 6 */
>  	if ((parport_read_status(p) & ESTB) != ESTB)

