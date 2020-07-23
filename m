Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277AEC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 031CC2071A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595468800;
	bh=mdnxAsGZvqkIfXw6NhCN9KchVj393DErIHhly/Gxth8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=pLXilqGbRfQJzoctXrEky2ooAoXV5xlzrZgXTZ1B0VxLPhm5+kqtK7jLza+aj30Ri
	 2/2dJt6jlAfuMg10CJfjTPcDyZSb3Z0fJfJkco0ONbvNBunec4BkcA87lGd9F7V94B
	 lfKN//gKyxJCLc5CSsRNK1UZaQG8QhuKcwt7rqiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387469AbgGWBqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:46:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729198AbgGWBqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 21:46:38 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D27FF2071A;
        Thu, 23 Jul 2020 01:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595468797;
        bh=mdnxAsGZvqkIfXw6NhCN9KchVj393DErIHhly/Gxth8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Fcl+dyju318doGy/Nx4rHj4WqhqlpH6L6OyvyxiSvU4fs6W+uL2PCde8o8S7gWvAl
         6pzzNu26tA/GW+AGdEPN4K5PLE1ymDLaAG+V4rPRz6UKixCcuyzM5Mi2MO67930BtY
         2LYsOLV/9r6jiIs9FRvk3JXV9yam6EmZCyNra+OY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200625132736.88832-1-colin.king@canonical.com>
References: <20200625132736.88832-1-colin.king@canonical.com>
Subject: Re: [PATCH][next] clk: vc5: fix use of memory after it has been kfree'd
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Adam Ford <aford173@gmail.com>,
        Colin King <colin.king@canonical.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Date:   Wed, 22 Jul 2020 18:46:37 -0700
Message-ID: <159546879710.3847286.14955586064206205548@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2020-06-25 06:27:36)
> From: Colin Ian King <colin.king@canonical.com>
>=20
> There are a several places where printing an error message of
> init.name occurs after init.name has been kfree'd. Also the failure
> message is duplicated each time in the code. Fix this by adding
> a registration error failure path for these cases, moving the
> duplicated error messages to one common point and kfree'ing init.name
> only after it has been used.
>=20
> Changes also shrink the object code size by 171 bytes (x86-64, gcc 9.3):
>=20
> Before:
>    text    data     bss     dec     hex filename
>   21057    3960      64   25081    61f9 drivers/clk/clk-versaclock5.o
>=20
> After:
>    text    data     bss     dec     hex filename
>   20886    3960      64   24910    614e drivers/clk/clk-versaclock5.o
>=20
> Addresses-Coverity: ("Use after free")
> Fixes: f491276a5168 ("clk: vc5: Allow Versaclock driver to support multip=
le instances")
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Applied to clk-next
