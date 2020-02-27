Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE86C3567B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A42524697
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Cl6/llDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbgB0NoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:44:07 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:33440 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbgB0NoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1582811040; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dBge0kS8tI19aaA+U6Z+hsWiHxFZ2KXAdWiVap/eqqA=;
        b=Cl6/llDEP5OoU+GcLqllvfpyAM+YbijAbig6InwGEyoE6a0g898ihqnuI/YS0kMUufiJtc
        znEE47nfhCB/ZtziZpxYDzP2nC+h4Z+eXtoe8b6qNoZq0NAUoXn7iIMq3EIa3fa2KJV5XP
        DKtkCqKr7zVNLUyk9gK7LG7ztuPXiQU=
Date:   Thu, 27 Feb 2020 10:43:44 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: linux-next: Fixes tag needs some work in the mips-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     James Hogan <jhogan@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Message-Id: <1582811024.3.0@crapouillou.net>
In-Reply-To: <20200227071718.5aac4713@canb.auug.org.au>
References: <20200227071718.5aac4713@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,


Le jeu., f=E9vr. 27, 2020 at 07:17, Stephen Rothwell=20
<sfr@canb.auug.org.au> a =E9crit :
> Hi all,
>=20
> In commit
>=20
>   3944dee0c6cd ("MIPS: Fix CONFIG_MIPS_CMDLINE_DTB_EXTEND handling")
>=20
> Fixes tag
>=20
>   Fixes: 7784cac69735 ("MIPS: cmdline: Clean up boot_command_line
>=20
> has these problem(s):
>=20
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
>=20
> Please do not split Fixes tags over more than one line.

My fault, sorry. I did not know they could not be splitted.

Cheers,
-Paul

>=20
> --
> Cheers,
> Stephen Rothwell

=

