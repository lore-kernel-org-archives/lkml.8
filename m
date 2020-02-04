Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D37C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4940320730
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580799836;
	bh=HTGPXQ9wkE1o/Ti9Lpl2TuNVsDBpS1uSDCbHfoQO6mU=;
	h=In-Reply-To:References:From:To:Subject:Cc:Date:List-ID:From;
	b=Di6ONI6QWuY/bvbQVVULkZ9d10vXU5yLo6QETAl+Dv3sPK0Ne0SXoIXXrLFxk7jZC
	 EQHPmC6jXBqYaA8DBA9TC1JZeurDrgLA+bMNE91p2xmrOX4tNRdKur790lykGbDUMN
	 lSge14RfHFNZiYf5HSj5VVhp6Mvb4Hez2WD3a4Vg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgBDHDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 02:03:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:53414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgBDHDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 02:03:55 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB16A20674;
        Tue,  4 Feb 2020 07:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580799834;
        bh=HTGPXQ9wkE1o/Ti9Lpl2TuNVsDBpS1uSDCbHfoQO6mU=;
        h=In-Reply-To:References:From:To:Subject:Cc:Date:From;
        b=vMna10M09ifWPqBEQierFOk+cxdm9C2IcbIPRLFEHI3DZIZxGRX1SoeGoN7+v9HJB
         UrD5pfwvmK176YbJUSQsegrXEwVoY0AZXbKFGQ5Rmssc46EI4O5/d+HaBcWAEConI7
         zSyTjNkvPy+GtAfmTD16l/ZpkQhczlTy8zqHZOpg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200203223736.99645-1-colin.king@canonical.com>
References: <20200203223736.99645-1-colin.king@canonical.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Colin King <colin.king@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Michael Walle <michael@walle.cc>, Wen He <wen.he_1@nxp.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH][next] clk: ls1028a: fix a dereference of pointer 'parent' before a null check
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Mon, 03 Feb 2020 23:03:53 -0800
Message-Id: <20200204070354.AB16A20674@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2020-02-03 14:37:36)
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Currently the pointer 'parent' is being dereferenced before it is
> being null checked. Fix this by performing the null check before
> it is dereferenced.
>=20
> Addresses-Coverity: ("Dereference before null check")
> Fixes: d37010a3c162 ("clk: ls1028a: Add clock driver for Display output i=
nterface")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Applied to clk-next

