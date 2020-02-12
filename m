Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDA4C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44349206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581541033;
	bh=cH/GvDcI5icHSrX1KzJxqGNWxsBUEqIC9+265JxXyFQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=UsC1CvTMAh3X3adMt5ie+0gC7iH7I9atiT9ariy8PYKJcn8uwDQ6+qo0pea7Y/3NF
	 6u9rv5JqTP67ICs7Qhtar7t1IXle9A92/bSKBlwrX9a7mcF7Da1AwWH0ahLaR6+kyo
	 QeGtVWgljpjsOhBfC4ANbhaZDxfoTGWnDQq9/5cQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgBLU5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:57:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729102AbgBLU5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:57:09 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B89F24681;
        Wed, 12 Feb 2020 20:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581541029;
        bh=cH/GvDcI5icHSrX1KzJxqGNWxsBUEqIC9+265JxXyFQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=08pG/Nqjx7K0Ga/+1IycS9fCtJymUDhlnV9u6Cu4CEd0ey8ngpo6odqHGdJTdX8JH
         XKlIw/Igo3vTQsxr5Ok5EXIM316FGYFcdhB0XYCWoyRB7vJlFHNRDaYWc9JOpDNZpL
         KBD42FXBfU6rOaNNMvlzBiVaWSeNHawm70yxI3z4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1581508657-12107-5-git-send-email-Anson.Huang@nxp.com>
References: <1581508657-12107-1-git-send-email-Anson.Huang@nxp.com> <1581508657-12107-5-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH 5/5] clk: imx8mp: Add missing of_node_put()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux-imx@nxp.com
To:     Anson Huang <Anson.Huang@nxp.com>, abel.vesa@nxp.com,
        allison@lohutok.net, festevam@gmail.com,
        gregkh@linuxfoundation.org, kernel@pengutronix.de,
        leonard.crestez@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, peng.fan@nxp.com, ping.bai@nxp.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Date:   Wed, 12 Feb 2020 12:57:08 -0800
Message-ID: <158154102844.184098.4130794456263378461@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2020-02-12 03:57:37)
> After finishing using device node got from of_find_compatible_node(),
> of_node_put() needs to be called.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
