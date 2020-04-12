Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01175C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 13:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E8720673
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 13:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="qPWBD9is"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgDLN3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 09:29:36 -0400
Received: from forward104o.mail.yandex.net ([37.140.190.179]:39408 "EHLO
        forward104o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbgDLN3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 09:29:35 -0400
Received: from forward102q.mail.yandex.net (forward102q.mail.yandex.net [IPv6:2a02:6b8:c0e:1ba:0:640:516:4e7d])
        by forward104o.mail.yandex.net (Yandex) with ESMTP id 05B57940544;
        Sun, 12 Apr 2020 16:29:33 +0300 (MSK)
Received: from mxback5q.mail.yandex.net (mxback5q.mail.yandex.net [IPv6:2a02:6b8:c0e:1ba:0:640:b716:ad89])
        by forward102q.mail.yandex.net (Yandex) with ESMTP id 00A8E7F20013;
        Sun, 12 Apr 2020 16:29:33 +0300 (MSK)
Received: from vla1-61ce7aa04735.qloud-c.yandex.net (vla1-61ce7aa04735.qloud-c.yandex.net [2a02:6b8:c0d:3e86:0:640:61ce:7aa0])
        by mxback5q.mail.yandex.net (mxback/Yandex) with ESMTP id fn6LxomBys-TWlmAoTw;
        Sun, 12 Apr 2020 16:29:32 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1586698172;
        bh=20Xym1g+2xCGcmJuCNInJKvW+oOdMSKnpImJLyKpihA=;
        h=In-Reply-To:From:Subject:Date:References:To:Message-ID;
        b=qPWBD9isSUDiBc3MbyJ7Ck6D+eeRBuBxlRzKowgfjkouZwjd7402O6xPeWFuYGSRf
         WSWdf4g+OoAX9ozjgDWkJV5HB8EE8PGzSWlcttBrR7xS9qf34IeZ4Hm911iXoTdeio
         6u+sM4rwoJD39xd+ge0ZGJCAAIbdc87/jX/bt2LU=
Authentication-Results: mxback5q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-61ce7aa04735.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id uGxk6FJkg5-TVXS9kgN;
        Sun, 12 Apr 2020 16:29:31 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190712071746.2474-5-nishkadg.linux@gmail.com>
Subject: Re: [PATCH 5/8] staging: rtl8188eu: Remove function rtw_modular64()
From:   Ivan Safonov <isaf21@yandex.ru>
Message-ID: <66fb1e37-107e-54f4-4986-ca4e4bb99d2d@yandex.ru>
Date:   Sun, 12 Apr 2020 16:34:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20190712071746.2474-5-nishkadg.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Remove function rtw_modular64 as all it does is call do_div.

This is wrong. Macro do_div(x, y) change first argument x, but 
rtw_modular64(x, y) preserve it.

> +			tsf = pmlmeext->TSFValue - do_div(pmlmeext->TSFValue, (pmlmeinfo->bcn_interval*1024)) - 1024; /* us */

rounddown(pmlmeext->TSFValue, pmlmeinfo->bcn_interval * 1024) - 1024
is a better replacement for

> -			tsf = pmlmeext->TSFValue - rtw_modular64(pmlmeext->TSFValue, (pmlmeinfo->bcn_interval*1024)) - 1024; /* us */

Patch '[PATCH 01/10] staging: rtl8723bs: Remove function 
rtw_modular64()' have same bug.

Ivan Safonov.
