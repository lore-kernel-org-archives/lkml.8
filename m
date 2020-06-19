Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E7FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 21:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 540E921D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 21:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgFSVhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 17:37:40 -0400
Received: from v6.sk ([167.172.42.174]:55366 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgFSVhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 17:37:40 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 22E10610B4;
        Fri, 19 Jun 2020 21:37:38 +0000 (UTC)
Date:   Fri, 19 Jun 2020 23:37:33 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jiri Kosina <trivial@kernel.org>, Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] MAINTAINERS: rectify MMP SUPPORT after moving
 cputype.h
Message-ID: <20200619213733.GA1105008@furthur.local>
References: <20200506053431.7464-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506053431.7464-1-lukas.bulwahn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 07:34:31AM +0200, Lukas Bulwahn wrote:
> Commit 32adcaa010fa ("ARM: mmp: move cputype.h to include/linux/soc/")
> added a file entry that does not point to the intended file location.
> 
> Since then, ./scripts/get_maintainer.pl --self-test complains:
> 
>   warning: no file matches F: linux/soc/mmp/
> 
> Rectify the MAINTAINERS entry now.
> 
> Fixes: 32adcaa010fa ("ARM: mmp: move cputype.h to include/linux/soc/")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Jiri, please pick this patch.

Jiri, I'm wondering if you could apply this? Otherwise maybe Olof could
queue this via arm-soc?

Thanks
Lubo

> v1 & v1-RESEND: was ignored.
> 
> v1 -> v2:
>   - v1 does not apply after reordering MAINTAINERS, i.e., commit 4400b7d68f6e
>   ("MAINTAINERS: sort entries by entry name") and commit 3b50142d8528
>   ("MAINTAINERS: sort field names for all entries").
>   - PATCH v2 applies on v5.7-rc1 now. Please pick v2 instead of v1.
> 
> v2-resend:
>   - still applies on v5.7-rc4 and next-20200505
>   - asking for inclusion through trivial tree, as maintainers are not
>     responding.
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e64e5db31497..a0fef0c33ba5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11327,7 +11327,7 @@ S:	Odd Fixes
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lkundrak/linux-mmp.git
>  F:	arch/arm/boot/dts/mmp*
>  F:	arch/arm/mach-mmp/
> -F:	linux/soc/mmp/
> +F:	include/linux/soc/mmp/
>  
>  MMP USB PHY DRIVERS
>  R:	Lubomir Rintel <lkundrak@v3.sk>
> -- 
> 2.17.1
> 
