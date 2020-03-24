Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB47C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570172076F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="F5i6vnOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgCXQoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:44:06 -0400
Received: from mout.gmx.net ([212.227.15.18]:48651 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbgCXQoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585068241;
        bh=uDoUJhkJb4hl+iIZ1m2XaAjLxBbKQqeDdd8yxFyi3Lw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=F5i6vnOXk4KGVO9jJrZMf2E0ahKx9oCRr5pwlnRhp/89kyS+k7FuDf4VkOKT2GB26
         WiQL/GfTIidtZ8QdvhV+ZxrDh4AuBOeZEtpsIWm/f9YHIq4OM1bru7ywhEI87t9uVO
         iA/gVa6UdXurJn8FG+Ky/qP70TAnoU3HpwrDcG1Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MxDkw-1jRxkW3PdQ-00xdpA; Tue, 24
 Mar 2020 17:44:00 +0100
Date:   Tue, 24 Mar 2020 17:43:45 +0100
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: Use DIV_ROUND_UP macro instead of
 specific code
Message-ID: <20200324164345.GA3288@ubuntu>
References: <20200322112342.9040-1-oscar.carter@gmx.com>
 <20200323104200.GA501377@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323104200.GA501377@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:52Pz4aGzyfh4T83UpBCKGpJwia/di0Cgm2N8bT4Qi2nskYuj65m
 ROFRFsPh+NT/E9sm98QNva4ILouiGnGF1XouJRF3SPSKaLBsOxs/OBOksTsYXZdidEjVWgn
 nahL8N+ShzLXoB0IMC/K7cfUiqBDAD1A4GEzulcSthLUhb/+nGnOoQ6RkvRETfrPos+bv6i
 46tV4FCSrJ+xcRe+4ylRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M3qT6mZ0I4o=:Yz/q0MgsTiX+deJiv5SVgP
 OcOtsYY3cZWP+gjL8c7Q3tU9NHtbMjFkyV/5l4NbCvWjn0LlJVyD9QSlOtimNaHvIuw4Usx2+
 i3EkCJ167XETU8eL8voOkTuSGeK3V1nd5NXrlUBfZZ3cHI2Af4wPtjMbOp4Gjw7w3yZvZ/EZF
 ykAJuPI8Xx3yqJUfZPRM0i+QqSIRFOy3GG+8wb7geHsK0q3HDv6N96qIG+rXBzznBZPaS9J0m
 qjXPvIYySJML3w18sME7nzerBq3oXVWYhjaF1RFcBCc8FlpXd8/h2KCDzkKaTOTmo+yeC2LeW
 caNleMzZU5TLe4pS9CxFAtBk2tLPf+9NVEuFeE5s8NkAJkLese20JVNekNv74woIgxoQ+QPtx
 w/3B+1bWW3vI9JE0nbP8E1pjeHzLLWgZhR49Jzpn71l8KX2wfydGen8TBcUz6MGuIfrNelIMz
 608Bd+t7tUyl1MM+K+WAH6RfKZC5W/toAzwR6xU6YUL5+aMnuSdW221OB/MhNkPU5N3R9fdwE
 35rZkUz8dBfnGjxs5w+DMxBr/E5FISCUQcFbYWZYSmQte49bVoE8C5CgV84acj0EQZy5bHeQk
 prdjEDSK+les30X9Y6uMFZxoOQPmCsx0Ol16eF3Cr3gaMeEd6y2OnviLl/K4jli9IUokc6uWj
 GhqdNWZMwxCm5oWr9/U9IeOaXdBB+1gCORftxNRBk/2jh9E/UVL3ZYnyCv9oG9vybNLtweIat
 YRC7Qje9/61ZerQw9/Qz9k3FpsoclGcKhduyG0HG5blcZgOUJrP8lFxdUQCQqFAFOw1ymCj55
 fNnqOIZhdwp7XZjjIOB7EqqnGe9KumNHkj22Mvys8I6i2ON0VRzGhGz8QyrMxHaaOU4IhxeMC
 fqS7sbRrPWJSqge71LhL7phgxZ1ODMOociWlF4l86fmXscCFEyc85+/vckKX4CV8vFVx564Vc
 pZcxPOMFtsIUl3Ixgze2PcbJtgzUdJEwAiQ8t2Y/tcgg9vrSayqBVrzz8CH0z3sZNSiKoUjiA
 hRCGq/RVX12mtnOgHhgpKpE8TGqpRasf7s7yc1caj8opgS/8RptrNLgHSTyHQYgKrJB1LRBTg
 50Ow/X2WIpWlt9wgRnSDMq9gapTDOQU6OoBP88mAYAe2av0X+jwxTcq1SHtXPvy3/s9joVe4L
 ACqR39go4zfUOh7PGs6rYz6JlvVYLjJWRVNtOUHtviK1sHNAG91wquHMGWzzVpxyNooNxyIvt
 Vr9ybXD4slatf/k+e
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 11:42:00AM +0100, Greg Kroah-Hartman wrote:
> On Sun, Mar 22, 2020 at 12:23:42PM +0100, Oscar Carter wrote:
> > Use DIV_ROUND_UP macro instead of specific code with the same purpose.
> > Also, remove the unused variables.
> >
> > Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> > ---
> >  drivers/staging/vt6656/baseband.c | 21 ++++-----------------
> >  1 file changed, 4 insertions(+), 17 deletions(-)
>
> Please rebase this against my staging-next branch of my staging.git tree
> and resend it as it does not apply to it at the moment at all.
>
Ok, I rebase against your staging-next branch and I resend the patch as a =
new
version.

> thanks,
>
> greg k-h
