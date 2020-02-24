Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2685DC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05752082F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="L6ubBwVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgBXNuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 08:50:19 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:44106 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgBXNuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:50:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1582552217; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gayg0dvW7Vxh44527/5/QBVVwgamIXCkDGSKwc5wh8w=;
        b=L6ubBwVUI9l2GUxjJRsIXFgTlgmiqPeEY/Ds8x9vSobalTK9GybsBhSdLfkjsMyxSliMl+
        t5nsDtaGy4eJtwcBn0zxeoTZpnAuNvVu9n54j3xa/DJRuN2sH9O2XUCXpUBSPltLEcpzRm
        wKGju+jBzSc4pTRK2ZtM6VZGpPr3RQI=
Date:   Mon, 24 Feb 2020 10:50:04 -0300
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/2] MAINTAINERS: Set MIPS status to Odd Fixes
To:     Philippe =?iso-8859-1?q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc:     Paul Burton <paulburton@kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Message-Id: <1582552204.3.0@crapouillou.net>
In-Reply-To: <CAAdtpL5JgO0Wtned6KKKKYyM7ZWQ6Y=9X=EQRWYYXgOZ7nbWBg@mail.gmail.com>
References: <20200219191730.1277800-1-paulburton@kernel.org>
        <20200219191730.1277800-3-paulburton@kernel.org>
        <1582387719.3.1@crapouillou.net>
        <CAAdtpL5JgO0Wtned6KKKKYyM7ZWQ6Y=9X=EQRWYYXgOZ7nbWBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,


Le lun., f=E9vr. 24, 2020 at 09:37, Philippe Mathieu-Daud=E9=20
<f4bug@amsat.org> a =E9crit :
> On Sat, Feb 22, 2020 at 5:08 PM Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>=20
>>  Hi,
>>=20
>>  So I think Thomas is the best candidate to be maintainer, since he=20
>> has
>>  both experience and free time ;)
>>=20
>>  I'm sort-of the maintainer for the Ingenic platform and drivers, if
>>  Jiaxun wants to do the same for Loongson hardware, that would make
>>  Thomas' job easier. Having three co-maintainers with equal rights=20
>> would
>>  be a total mess.
>=20
> You might want to add yourself a R: entry in MAINTAINERS, to be listed
> as designated reviewer on the Ingenic patches.
> (Similarly for Jiaxun with Loongson).

I'm in there already as a M: entry.

-Paul

>>=20
>>  Le mer., f=E9vr. 19, 2020 at 11:17, Paul Burton=20
>> <paulburton@kernel.org>
>>  a =E9crit :
>>  > My time with MIPS the company has reached its end, and so at best=20
>> I'll
>>  > have little time spend on maintaining arch/mips/. Reflect that in
>>  > MAINTAINERS by changing status to Odd Fixes. Hopefully this might=20
>> spur
>>  > the involvement of someone with more time, but even if not it=20
>> should
>>  > help serve to avoid unrealistic expectations.
>>  >
>>  > Signed-off-by: Paul Burton <paulburton@kernel.org>
>>  > ---
>>  >  MAINTAINERS | 2 +-
>>  >  1 file changed, 1 insertion(+), 1 deletion(-)
>>  >
>>  > diff --git a/MAINTAINERS b/MAINTAINERS
>>  > index afa228ade18e..67f05f6dbf77 100644
>>  > --- a/MAINTAINERS
>>  > +++ b/MAINTAINERS
>>  > @@ -11120,7 +11120,7 @@ W:    http://www.linux-mips.org/
>>  >  T:   git git://git.linux-mips.org/pub/scm/ralf/linux.git
>>  >  T:   git=20
>> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
>>  >  Q:   http://patchwork.linux-mips.org/project/linux-mips/list/
>>  > -S:   Supported
>>  > +S:   Odd Fixes
>>  >  F:   Documentation/devicetree/bindings/mips/
>>  >  F:   Documentation/mips/
>>  >  F:   arch/mips/
>>=20
>>=20

=

