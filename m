Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D49C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E981C2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589486260;
	bh=9+FiLG+m7K/fE15NsdWiSNgCFSpJx0DMvea4x9+tPi8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=wNs9gy1jwh0hznpgUizhT0hPK0QdotopjROcecEmLXMZiZ1ugV8ci5nrdDy2OqnVX
	 QxHqbyPTBlnuP/kyMq7mUFIHSnwqYlkVUFsGQPs1zFiwdM5GW2pzeSbVaFkNGsClQH
	 XGSckUdTGJH3Gc9dFRoCuPwmVbVa2RJkcryAu1a0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgENT5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgENT5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 15:57:38 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AF2E2065C;
        Thu, 14 May 2020 19:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589486258;
        bh=9+FiLG+m7K/fE15NsdWiSNgCFSpJx0DMvea4x9+tPi8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BU0ljWvw3RMT5CbVNzna4kyqjgpYlluRGx7a0FcdyXSOVT44Q46SOhKPFOEUwM/9n
         vIjvqBCA0mCr95rlEHkMs3LiQDtWzIQqwm1PevuwDrRJ90Zvr5vKZuoFDTGuIc6caB
         9mHYwNG5fI+q0TcFROZujx703aSf+XCu9xMmt5ts=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200409064416.83340-9-sboyd@kernel.org>
References: <20200409064416.83340-1-sboyd@kernel.org> <20200409064416.83340-9-sboyd@kernel.org>
Subject: Re: [PATCH v2 08/10] ARM: mmp: Remove legacy clk code
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Thu, 14 May 2020 12:57:37 -0700
Message-ID: <158948625761.215346.15511536578781632283@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-04-08 23:44:14)
> Remove all the legacy clk code that supports a non-common clk framework
> implementation of 'struct clk' in mach-mmp. This code doesn't look to be
> compiled anymore given that the MMP is fully supported in the
> multi-platform config via ARCH_MULTIPLATFORM as of commit 377524dc4d77
> ("ARM: mmp: move into ARCH_MULTIPLATFORM"). The ARCH_MULTIPLATFORM
> config selects COMMON_CLK and therefore the Makefile rule can never
> actually compile the code in these files.
>=20
> Cc: Lubomir Rintel <lkundrak@v3.sk>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next + a fix for problem reported in -next
