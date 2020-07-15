Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BE4C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2174120672
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgGOUkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 16:40:21 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:41926 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgGOUkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:40:17 -0400
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jul 2020 16:40:17 EDT
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 413A92FE3;
        Wed, 15 Jul 2020 22:31:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ibs7Zj-7XLWF; Wed, 15 Jul 2020 22:31:50 +0200 (CEST)
Received: from function (lfbn-bor-1-797-11.w86-234.abo.wanadoo.fr [86.234.239.11])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 6A5032FCD;
        Wed, 15 Jul 2020 22:31:50 +0200 (CEST)
Received: from samy by function with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1jvo4D-000k9L-Cw; Wed, 15 Jul 2020 22:31:49 +0200
Date:   Wed, 15 Jul 2020 22:31:49 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: speakup: Replace HTTP links with HTTPS ones
Message-ID: <20200715203149.b6cmsku5lfrx56rm@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20200713091305.32708-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200713091305.32708-1-grandmaster@al2klimov.de>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander A. Klimov, le lun. 13 juil. 2020 11:13:05 +0200, a ecrit:
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
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Thanks!

> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely or at least not just HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
>  Sorry again to all maintainers who complained about subject lines.
>  Now I realized that you want an actually perfect prefixes,
>  not just subsystem ones.
>  I tried my best...
>  And yes, *I could* (at least half-)automate it.
>  Impossible is nothing! :)
> 
> 
>  drivers/staging/speakup/spkguide.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/speakup/spkguide.txt b/drivers/staging/speakup/spkguide.txt
> index 1e622cd34363..3782f6a09e97 100644
> --- a/drivers/staging/speakup/spkguide.txt
> +++ b/drivers/staging/speakup/spkguide.txt
> @@ -1531,7 +1531,7 @@ The Free Software Foundation may publish new, revised versions
>  of the GNU Free Documentation License from time to time.  Such new
>  versions will be similar in spirit to the present version, but may
>  differ in detail to address new problems or concerns.  See
> -http://www.gnu.org/copyleft/.
> +https://www.gnu.org/copyleft/.
>  
>  Each version of the License is given a distinguishing version number.
>  If the Document specifies that a particular numbered version of this
> -- 
> 2.27.0
> 

-- 
Samuel
 J'ai un gros problème: j'ai cet exercice à rendre demain lundi, mais ma
 TI 89 ne sait pas le faire...
 Est-ce que quelqu'un pourrait m'aider??
 -+- OD In Guide du Neuneu Usenet : Comment ça ! Il faut réfléchir ?-+-
