Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF0CC3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229E82168B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581548516;
	bh=1Dc+b6kANOK+MTUko6hygKOXL+SmgqNxbhJ3tJ96sug=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=xgkflt6Jr2oqqtVUuEZAPg65mcr4oUqYxyp2RG0DW3gZaJfqnPw2gad/LEQuLuRYV
	 GxB8TdvK3Nkub90tpcYJY/gromAGAS+UIA6H/8MEQpe2QtjK54QWCjGNXvPxYWMmac
	 H5hT+eu5LKk5lO1jP6yH59DKKuoSJ61ug/nwS27g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgBLXBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:01:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbgBLXBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:01:55 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D49E521569;
        Wed, 12 Feb 2020 23:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581548514;
        bh=1Dc+b6kANOK+MTUko6hygKOXL+SmgqNxbhJ3tJ96sug=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=B02hWz3753ZHM5ekoQQLoas2pIjQX/l6HIjRBD/qLVakEVqrolq2dMisDy2ZrmOBj
         uI5cD+KoD+MoDWoDB43+lY112neAIEoLEiC5BJTxVB5IW8iC/5G+7Lsn8WV40so9vC
         1/xXlA7jUoSX70HtV6x5CkGw/S7Q1b00RW+ZO23Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1581498180-2652-1-git-send-email-Anson.Huang@nxp.com>
References: <1581498180-2652-1-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH] clk: imx: drop redundant initialization
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux-imx@nxp.com
To:     Anson Huang <Anson.Huang@nxp.com>, abel.vesa@nxp.com,
        allison@lohutok.net, broonie@kernel.org, festevam@gmail.com,
        gregkh@linuxfoundation.org, info@metux.net, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        peng.fan@nxp.com, rfontana@redhat.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org, tglx@linutronix.de
Date:   Wed, 12 Feb 2020 15:01:54 -0800
Message-ID: <158154851405.184098.10235896077677896514@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2020-02-12 01:03:00)
> No need to initialize flags as 0, remove the initialization.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
