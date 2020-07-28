Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A91C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C01BD20672
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="jcfrnPdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgG1Bqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 21:46:50 -0400
Received: from crapouillou.net ([89.234.176.41]:51062 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgG1Bqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 21:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595900807; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fId9MTw7EAQqIZV//F4HzgjDYjr3WRdR9GS7djBJRO4=;
        b=jcfrnPdoGGkpEg4jX7ZzCFUqc6lR1BoV+kmA74KiqcVEYgUhWvW21torNmjmuhIzEvs/0G
        TITpNHmbgrEklyOUoHFaPcGpnSsJ8cFDrySzIi3E7PvVTHGNKLTcZ0Q0J6eXBzL1YTsT9n
        MAh0gJkLQieKt62eh54qEJkqL6chAW8=
Date:   Tue, 28 Jul 2020 03:46:33 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 0/3] Add functions to operate USB PHY related clock.
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Zhou Yanjie <zhouyanjie@wanyeetech.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Message-Id: <LXO5EQ.MCOXM56RYF7P3@crapouillou.net>
In-Reply-To: <159589916426.1360974.7420398609893038@swboyd.mtv.corp.google.com>
References: <20200630163852.47267-1-zhouyanjie@wanyeetech.com>
        <d4899cde-ac7c-e7a4-5819-59fcacbd3745@wanyeetech.com>
        <159589916426.1360974.7420398609893038@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le lun. 27 juil. 2020 =E0 18:19, Stephen Boyd <sboyd@kernel.org> a=20
=E9crit :
> Quoting Zhou Yanjie (2020-07-24 21:01:38)
>>  Gentle ping.
>>=20
>=20
> I was hoping Paul would review but I guess not. I applied the patches=20
> to
> clk-next.

I did receive the "gentle ping" and was going to review it soonish :(

I said for v1 that I don't like how it comes out with magic Hz values...

-Paul


