Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B44BC35672
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 16:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AAD206E2
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 16:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="JSLYr+qF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgBVQIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 11:08:54 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:39540 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbgBVQIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 11:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1582387731; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eRQZmPKeUKxi/IcQxTfTHS1nMgyC5MrOVQ71R2Qggss=;
        b=JSLYr+qFr7WbmyuuNv6ua1P8rhNSOlF5biZs8G9cg8a34Wj1aZBM8a9BNqFvcVLSmOSfnJ
        NRsFXiXQvV7KpS50pVr3teyzDUKOKo0tbZ4yLuOiblLXzls8BjC96FVfe0VK+dxxecWVRf
        6o4yOATYg1mgxzUg8Glgo1FfazsDEbI=
Date:   Sat, 22 Feb 2020 13:08:39 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/2] MAINTAINERS: Set MIPS status to Odd Fixes
To:     Paul Burton <paulburton@kernel.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1582387719.3.1@crapouillou.net>
In-Reply-To: <20200219191730.1277800-3-paulburton@kernel.org>
References: <20200219191730.1277800-1-paulburton@kernel.org>
        <20200219191730.1277800-3-paulburton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

So I think Thomas is the best candidate to be maintainer, since he has=20
both experience and free time ;)

I'm sort-of the maintainer for the Ingenic platform and drivers, if=20
Jiaxun wants to do the same for Loongson hardware, that would make=20
Thomas' job easier. Having three co-maintainers with equal rights would=20
be a total mess.

-Paul


Le mer., f=E9vr. 19, 2020 at 11:17, Paul Burton <paulburton@kernel.org>=20
a =E9crit :
> My time with MIPS the company has reached its end, and so at best I'll
> have little time spend on maintaining arch/mips/. Reflect that in
> MAINTAINERS by changing status to Odd Fixes. Hopefully this might spur
> the involvement of someone with more time, but even if not it should
> help serve to avoid unrealistic expectations.
>=20
> Signed-off-by: Paul Burton <paulburton@kernel.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index afa228ade18e..67f05f6dbf77 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11120,7 +11120,7 @@ W:	http://www.linux-mips.org/
>  T:	git git://git.linux-mips.org/pub/scm/ralf/linux.git
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
>  Q:	http://patchwork.linux-mips.org/project/linux-mips/list/
> -S:	Supported
> +S:	Odd Fixes
>  F:	Documentation/devicetree/bindings/mips/
>  F:	Documentation/mips/
>  F:	arch/mips/

=

