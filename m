Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6242BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3778220810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590786687;
	bh=IKTLWQZ0nXrdPIln+K4BgJazMseCXQzHI5QAr6W3cPc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=qmG7ORdgX+sVzNM2M7ZyxbDjYYxjzL/h1i0cT+cELp+rqFF23WG8p14ooyMJ9VPd5
	 FCJ+J8JGGhsKCbPyH97Y9woONUe+Hd8kBxL4+tsPKUNgfJPJsgjN9fwRnKKJF3u0BF
	 wNZZLXcxjJ1klvs0oTIp0u3ZFugNvcHzkwA8nUuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgE2VL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgE2VLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:11:24 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B38A206A4;
        Fri, 29 May 2020 21:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590786684;
        bh=IKTLWQZ0nXrdPIln+K4BgJazMseCXQzHI5QAr6W3cPc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=tGHlB8v/jaGtTbWGJ/6kq/y9+mwMiy+z5eDkTJXNOMQRBj3SNMvm+FmD2JdlR7mcy
         ru85udX+U94D62kwaVAJO6w8+4K64mXLQ0ZnQjKzNClmMveCwd7TzkX5rW6tc9uA00
         WBQlDJhic4fsrbvT2Rz/5OxnzgbcrMIJFp30fQDY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200529191431.GA2779176@bogus>
References: <20200528031549.13846-1-zhouyanjie@wanyeetech.com> <20200528031549.13846-4-zhouyanjie@wanyeetech.com> <20200529191431.GA2779176@bogus>
Subject: Re: [PATCH v13 3/7] dt-bindings: clock: Add documentation for X1830 bindings.
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        zhenwenjin@gmail.com, sernia.zhou@foxmail.com,
        paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Rob Herring <robh@kernel.org>,
        Zhou Yanjie <zhouyanjie@wanyeetech.com>
Date:   Fri, 29 May 2020 14:11:23 -0700
Message-ID: <159078668338.69627.5841582436445900180@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2020-05-29 12:14:31)
>=20
> Acked-by: Rob Herring <robh@kernel.org>

Please apply to bindings tree Rob. The yaml conversion is in your tree.
