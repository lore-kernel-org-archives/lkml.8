Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4BDC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 19:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137E62071C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 19:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584647951;
	bh=YVwv4E2Ut/NpWXxwh42s1vlrFtIvX7XJV7XAJ8Urwac=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=VBBf06mkoM1B8tzkizk1ayIFuG64C1TcIt95SjkyoJM/9w9enPtBHq42SjGF5mctp
	 uUEwjZPGN6Ta90w+wPrVPziFgag9i/Uy2nIyafmhczXrMYnFHUHt0j6Ps19eMZuSY5
	 pwQhd+WjjkiZ1jaN+B3A/sDvqRlhsQTAB6acQN1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgCST7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 15:59:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgCST7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 15:59:09 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BCAE206D7;
        Thu, 19 Mar 2020 19:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584647949;
        bh=YVwv4E2Ut/NpWXxwh42s1vlrFtIvX7XJV7XAJ8Urwac=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bLZFQRE2m4crqagFo1jQGa1OhV7nQ/fVZav6Xsr+O3gWbVYixldKSvf210VyOnxJP
         9IlEhmUnBAraujJYKEBQHhenhNk+84ifOD4jtFv/lgVnuERcMuVy96JuRFV5pVGICU
         5tlpRdpmfdTSK+KkovvguqmD3JUtM6z06XdVaHRU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1584495566-15110-1-git-send-email-Anson.Huang@nxp.com>
References: <1584495566-15110-1-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH] clk: imx: clk-sscg-pll: Remove unnecessary blank lines
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux-imx@nxp.com
To:     Anson Huang <Anson.Huang@nxp.com>, abel.vesa@nxp.com,
        festevam@gmail.com, jonas.gorski@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org, t-kristo@ti.com
Date:   Thu, 19 Mar 2020 12:59:08 -0700
Message-ID: <158464794846.152100.11284882735806407657@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2020-03-17 18:39:25)
> Remove many unnecessary blank lines for cleanup.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
