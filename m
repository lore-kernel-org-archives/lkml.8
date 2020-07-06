Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B27C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B709C20672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="GzSZ+Nco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgGFXwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 19:52:42 -0400
Received: from crapouillou.net ([89.234.176.41]:55458 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgGFXwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 19:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1594079559; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=URFquOorttvpmiJ+lfEVDd1Ropa0DJF6BFwngAVN5HY=;
        b=GzSZ+Ncoik/RV1tbn1NQ3agvUwXCTL9DJKl7RAqleMSt4WcQ1iQoEoIwKraltvtlXwdjT5
        PkrD9b1xBa/M3zTUj7NfrnQxGdwdEu/cKr8jGdxhmWBfebYr6cGEbaZ8GZj4gN4AKQgyKR
        bQlJTTRr6cSm5X73rU1bb+18AKVwuhk=
Date:   Tue, 07 Jul 2020 01:52:29 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] i2c: jz4780: remove redundant assignment to variable i
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Colin King <colin.king@canonical.com>, linux-i2c@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <HNN2DQ.3HHBK0781A0A1@crapouillou.net>
In-Reply-To: <20200704063217.GG1041@kunai>
References: <20200610125901.1134204-1-colin.king@canonical.com>
        <20200704063217.GG1041@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le sam. 4 juil. 2020 =E0 8:32, Wolfram Sang <wsa@kernel.org> a =E9crit :
> On Wed, Jun 10, 2020 at 01:59:01PM +0100, Colin King wrote:
>>  From: Colin Ian King <colin.king@canonical.com>
>>=20
>>  The variable i is being initialized with a value that is
>>  never read and it is being updated later with a new value. The
>>  initialization is redundant and can be removed.
>>=20
>>  Addresses-Coverity: ("Unused value")
>>  Signed-off-by: Colin Ian King <colin.king@canonical.com>
>=20
> What about 'ret'? Doesn't the same reasoning apply for it?
>=20

That's correct.

Colin, could you respin the patch and do the same for the 'ret'=20
variable?

Thanks,
-Paul


