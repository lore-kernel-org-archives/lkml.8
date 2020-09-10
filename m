Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0283DC2D0A7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EBDA20882
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599724343;
	bh=ijucEkauTD7Oq3ltMK6SO/FeIANicHwPTK7VsIGPYl4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=Pt5VE10ItJZFuWTetYh5oaxGTARIwwUhUNAwgXOjR//yn/gKVqar5YBz/t8DiQ4pK
	 AhwArAXc0Jr8tyI0xTFZBIIIRECrdfCFvfJZT2wZU6PvN5yYHhJm2YvAjrZDFbKpLI
	 Cl5r8AvUAtEfy3HMuuR89vCXf1d9Qsm0YOOGJ8o4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgIJHwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:52:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgIJHwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:52:22 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4208F20809;
        Thu, 10 Sep 2020 07:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599724341;
        bh=ijucEkauTD7Oq3ltMK6SO/FeIANicHwPTK7VsIGPYl4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LNom3T6QTTA51pYBdbKQ74uZJ5by1QMhxIkfUmDr5vgd+7DNcUvRzfHinj7TCXRN3
         DRqktnRsVwlfk8KfE23W1oaQaO+P6lala2NVBXFimEPYfIDcvNC0IVBpmI0Bchc40+
         /ClkcpoeHh/P8J5a0Y2xqQz5+pp88mJu70SE3be0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200828154735.435374-1-jbrunet@baylibre.com>
References: <20200828154735.435374-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] clk: meson: make shipped controller configurable
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org
Date:   Thu, 10 Sep 2020 00:52:19 -0700
Message-ID: <159972433977.2295844.12910258806178190962@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2020-08-28 08:47:35)
> Add the necessary so bits so unnecessary amlogic clock controllers can be

s/so//

> compiled out. This allows to save a few kB when necessary.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
