Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2441EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0180320656
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596052366;
	bh=7aLIg1Ll9aS1JCS6HxcmE7vMs0qcoG8upa6JQXXgedc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=HJKj2/dslO5/AluCLVbO8GOqs16n37pFgEkC/t4nNdxtYO5TVnAgm+VYF2R2tB+Py
	 2HivGkAP4OhsDFffSEIVJ3HQ82SPLiivQajZAQnY9LI+MCIgvnftYNpjDRQzvva2ZN
	 fMOGY87Ip6p/cnca7pDvBXk4Zp4D57m4iUDWElmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgG2Two (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:52:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2Two (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 15:52:44 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3CE12064B;
        Wed, 29 Jul 2020 19:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596052364;
        bh=7aLIg1Ll9aS1JCS6HxcmE7vMs0qcoG8upa6JQXXgedc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=w66DvpfPcrXZu2307eHBD1e9L5QkHO/PkGU5xLiUVoL0GG/HGScOe8A2CZCmtgrv5
         6SBYNtcqEgst0v8JYud9U9sOrt46yutzBDkyq3qC8SGo5fvlOTznC1LxdUydIWIjl2
         JthQpdffqjARyWwyTsLyQojH6Q48TK/3f2XMcxaU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200729113456.4072290-1-arnd@arndb.de>
References: <20200729113456.4072290-1-arnd@arndb.de>
Subject: Re: [PATCH] clk: mmp: avoid missing prototype warning
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Wed, 29 Jul 2020 12:52:42 -0700
Message-ID: <159605236281.1360974.15458666297570212765@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2020-07-29 04:34:39)
> The kernel test robot points out two harmless warnings in the
> mmp clk drivers:
>=20
> drivers/clk/mmp/clk-pxa168.c:68:13: warning: no previous prototype for 'p=
xa168_clk_init' [-Wmissing-prototypes]
> drivers/clk/mmp/clk-pxa910.c:66:13: warning: no previous prototype for 'p=
xa910_clk_init' [-Wmissing-prototypes]
>=20
> Fix these by including corresponding header file.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied to clk-next
