Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48284C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 247DA20707
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590724911;
	bh=1WNI7RAiKibSqKWPWpBYS8Qzixi6Z4HSzWvJQMo6A4k=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=d013So7GtSyDWrsyRZgmP2PqFpOkaHrlTqIpVV2WxipKXjQdPNxf0MlKyFPcM1/7Q
	 A9KwRzFy6CcGxUd3K7GLWpu9xGb5P68t3V2PszqknS+g/qYSa1om6zVrs178ceuuno
	 bHNIp7aRbUIkXyoGfK/a9Ef+ucUqd09jKFwYbhFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391822AbgE2EBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 00:01:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388127AbgE2EBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:01:48 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6BB520707;
        Fri, 29 May 2020 04:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590724907;
        bh=1WNI7RAiKibSqKWPWpBYS8Qzixi6Z4HSzWvJQMo6A4k=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=GKtguxKkwxFETeNWK9W76X+vqblYPns+9TeSLUah4xHLtax2aYczacfNqARKzU/oP
         stcRO7HDY9l7uoFBy0t18/j1fBK+XhcBJ459qyVwjSkXdmN32FKUrb0inqVuRrkm7U
         hkqjm9qmTporUdzn9DC2gZUU/p+TNmfJUFuu9SEE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200507061544.11388-1-mike.looijmans@topic.nl>
References: <20200507061544.11388-1-mike.looijmans@topic.nl>
Subject: Re: [PATCH] clk: clk-si5341: Add support for the Si5345 series
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>
To:     Mike Looijmans <mike.looijmans@topic.nl>, linux-clk@vger.kernel.org
Date:   Thu, 28 May 2020 21:01:47 -0700
Message-ID: <159072490710.69627.8324972787165118318@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Looijmans (2020-05-06 23:15:44)
> Add support for the Si5342, Si5344 and Si5345 chips. These are equivalent
> to the Si5341 family, but with more clock input options (which are not
> supported yet by this driver).
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---

Applied to clk-next
