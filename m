Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B379CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C39F20787
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="jYzGloPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389747AbgEYKCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 06:02:13 -0400
Received: from mout.web.de ([212.227.15.14]:42859 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389678AbgEYKCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590400920;
        bh=I4AC220AsvLo1AfbrJuiQXJY0TZLYS/i5UQOwj/yE4M=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jYzGloPJe0SLYyvc21IyK/j1R07xIoVZaIrHmbhPjsjE2kUBWaQID2HIqIuPsiIvz
         zwKcPGiI1WmrytKo24kLYhyyVsoCY/3Zzhv4TV30n3ZE6KOpsXOugPQKu/B1Nop9Mx
         6cP+lnZXLCD4zB7QibuWigfsB/21Y6FbvO0+77jA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.186.124]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LiaAW-1j2jBM1P92-00cdoU; Mon, 25
 May 2020 12:02:00 +0200
Subject: Re: [PATCH v3] workqueue: Fix double kfree for rescuer
To:     Zhang Qiang <qiang.zhang@windriver.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200525093019.2253-1-qiang.zhang@windriver.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7c320424-fb25-1c4a-3d52-5d381c7b2884@web.de>
Date:   Mon, 25 May 2020 12:01:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200525093019.2253-1-qiang.zhang@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L4hbfwj2vomAq8IAhHRYfpD90cmwhfM0pN5j4bMaF66si+sg6zh
 FAacoqGPX6M53LHs9SrwraAtYEFTVom/LE4d4CiLBSrhf8uQ5LrvYfKT2WsR3vtYA69A1MO
 qb+TLGKNqSqpbiIrhBjdBwxvRuSKC2/Un9LQyXccm9Ar3N/fnlrXplXgrtLfIeZBwvz+B6l
 dPiz6s7TL6AroQASX5Snw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QT8xuCdb2Lg=:znCo0DV3xEPPm9Y24UgYn8
 MEh+McKaaJXHxlwJrby3C7dDRwcEeL8m2UtBKJq/qZBibdNQ7m8Y407jCflK/RCmAmP/HSJQa
 OpktclxelSqFZwgqySnHZKJL+2o3YcabTH7G1DV9maBXw9NCe4OHeMOS4kEGYX+v7zzOBShF5
 2uWRGIL6FHIRji2dZaLIipgKzRe+vUsKafFDid0dbWVmE3IB2FuENHMHG8oBbiv/GPlFPr5kA
 PldOGCKzPUZXg6mtVylqLJ2ruSc2GMZE/fDJ8fpyt1K5zq54UuIZVnWyGGa3HQZTDsYpQMIUf
 uidj2LU36OzxixiUizMOuBhbszbicaKXjbGi032tI9Q+U9hCPCNS6zm+F2RWzR6sSAUWU+O5K
 yEkz+Mms2sXspPbIbdUPGaR+LfL2FTgrdpjGUMOHMfdWxVknN+7q004kaizvvwj5mxuhMqx/9
 F+dQ2vCltB30CcndTnP2GtqgtoAhwGX3WoowNqm1tE6xc1ErxkXpD7g0XLqQyljAbQWxOLx3o
 sdMaA1wAQ3lef5UVurLHcYDFS/a8Qia4CTX0v5vUQQpcs2Gu+3ufL5KSrWn5G8Uz0rtNLH5Xl
 tnIjJuN+yhLW4Z48EPqlEY/Xc3ZbuEKYtMnIfFw2EAIJwe5y6j8qhM2119qaTNWh7zKcyJObp
 ZDF7kjwhZjso3LKYENH/P+uQJ3DTpTMl27jCeWymd40aWHeBLUJUeZG49dapNby57/qXqnzHv
 2t+CnK0x8dCMfFnuIYplLLS0T/yBwxBrYe/a5QfS70m1f6p5aND8u38+JScN13GjEit+hzIzh
 praojYOSvfOtGq2VEVD65iP4/tuiT6YyEJGW+W7DXdKSEEN5kGLRQFtoC730CNt0lr2/eo/6f
 Bqs3jTgvzDNKCdXBQxumCEIyL+Szbkxjvu9zFqRHnm7DjM1bzks7kkCm+ovqr4TEqDwbB3vGz
 dY6SIkR2E8ShJf1PgE+iIEwwgTwCvdpAljqo0kq1FXjiHdIHIM2K1gwJwvd6QkZfciebjXXDh
 IwlVBg8YvNpEovbv6W2IQ6Gte4m4wKVc5YPqJq0gZhnlMprIRWbjYFiae/1nhbhuxWTJGCNk2
 poUFH9pDfx5A7WLZyC0j6ocxoJoOp0NAz62Zu8bqHCaTnpqVe8m+QIpJfdbGOBo+dv0KW8uZf
 BMGSeaB9OSBH5vjLIAgD+OM50dfTs/9uMNTdW9VN1TrDB+pRZSU3x+VHh7uNbXpYKSEF6NKr9
 dGzUB8MhgOgzGNCPA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The callback function "rcu_free_wq" could be called after memory
> was released for "rescuer" already, Thus delete a misplaced call
> of the function "kfree".

I got into the mood to follow your interpretation of the
software situation for a moment.

I have taken another look also at the implementation of the function =E2=
=80=9Cdestroy_workqueue=E2=80=9D.

* The function call =E2=80=9Ckfree(rescuer)=E2=80=9D can be performed ther=
e in an if branch
  after the statement =E2=80=9Cwq->rescuer =3D NULL=E2=80=9D was executed.

* This data processing is independent from a possible call of the
  function =E2=80=9Ccall_rcu(&wq->rcu, rcu_free_wq)=E2=80=9D in another if=
 branch.
  Thus it seems that a null pointer is intentionally passed by a data stru=
cture
  member to this callback function on demand.
  The corresponding call of the function =E2=80=9Ckfree=E2=80=9D can toler=
ate this special case.


Now I find that the proposed change can be inappropriate.
I'm sorry for undesirable confusion because of this patch review.

Regards,
Markus
