Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4682C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2A602072D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590725248;
	bh=h0pxr9/wzLOF/9tz6TDv1ocdVyQnEr4jdBl3VKWu6Zs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=VtAjn3v+Z6bVZlN9OlGCfcU8VWY3Ah2Krt+B6mi6H5lBjQs9RB7Va/IPL0IplpfbX
	 CCbJh4UmZKWyRzB2X6HGitMHY3VGmcIXktJdD2rRtYR8bBb0JbxNbo2KzQYt3S4P8A
	 1ZmJhXdYZ7Z8zZBk1voOCYTqVZwD9fgQXr3ooWkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgE2EH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 00:07:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgE2EHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:07:24 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3463220723;
        Fri, 29 May 2020 04:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590725244;
        bh=h0pxr9/wzLOF/9tz6TDv1ocdVyQnEr4jdBl3VKWu6Zs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=CHq95+kZOxfgFU58Zs4UZF12+xWI7UbACdIs7Xr1QTy+PP52K+8qHPgi/fP5VoWVx
         lE5aUUsDKCQGTEB6m6dHVJ5CY87umFj9wn27nIjWPiwhbyB5cq4yXF+8U/rfGfI+66
         4BHkmlO/qiuV5KPnhy44kH9zIHzZLKawAKoCuCkI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200311134115.13257-2-Eugeniy.Paltsev@synopsys.com>
References: <20200311134115.13257-1-Eugeniy.Paltsev@synopsys.com> <20200311134115.13257-2-Eugeniy.Paltsev@synopsys.com>
Subject: Re: [PATCH 1/3] CLK: HSDK: CGU: check if PLL is bypassed first
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        linux-clk@vger.kernel.org
Date:   Thu, 28 May 2020 21:07:23 -0700
Message-ID: <159072524355.69627.3014845775029445369@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eugeniy Paltsev (2020-03-11 06:41:13)
> If PLL is bypassed the EN (enable) bit has no effect on
> output clock.
>=20
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---

Applied to clk-next
