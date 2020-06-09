Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC17C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FC4C206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591735533;
	bh=xyTkY/EBZzRsQjdeEb1UxNmZY3VqTXj97G3wNIG2tco=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=E0LSHvO+MyaI39QLRZAeQ8+KbKr5tfSjaljdkRCP8Gh/PfbOzvoBuzlPMFmhGquSs
	 yUyfYbzPcHuoIOUPBAGsLi9T7HI7ixo3PIx4NKAF6p/uusqPmsp+acufHIRMoEq0xf
	 HvHC5ewQOEm9cBbQkgNDBGyneMUZ21Tr2oDtMBZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgFIUpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:45:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbgFIUpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 16:45:31 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9097D2068D;
        Tue,  9 Jun 2020 20:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591735531;
        bh=xyTkY/EBZzRsQjdeEb1UxNmZY3VqTXj97G3wNIG2tco=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lZQ5WvDCeE/NPYvTNjpmObCymatYCoM0opAOEkSsIY2kHXwlMcCPDQWzGuXqF7l9r
         O+InKLz3T0GCeSuux9OEsuz7qvxhUTNjSlKBntTvueTjJlrW2oJXV6KDUSFnL4MO82
         UPpE+jYCJ233kvXCUOgXSsevsvPWcrzJ6T5kNMq0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200602121030.39132-1-colin.king@canonical.com>
References: <20200602121030.39132-1-colin.king@canonical.com>
Subject: Re: [PATCH][next] clk: baikal-t1: fix spelling mistake "Uncompatible" -> "Incompatible"
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel-janitors@vger.kernel.org
To:     Colin King <colin.king@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Jun 2020 13:45:30 -0700
Message-ID: <159173553087.242598.11888201445358111435@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2020-06-02 05:10:30)
> From: Colin Ian King <colin.king@canonical.com>
>=20
> There is a spelling mistake in a pr_err error message. Fix it.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Applied to clk-next
