Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E607C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 278A120776
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590707759;
	bh=6cRaMxa58tPApeIWKOSjOlyLMARaxMhQCEfel1rmCmU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=yXhVpy+nNTsczdCyLCydbfCVeM9rUrcWEOy2Ufix7/mxhPsHodNFzBeiVFcspapBB
	 oLMLc7pH6glH+3EZ2tEadFY9o8Lws5hg7SumBwy5Wrx5I5bTsT/HyTTewmOhu5KN4j
	 YsWLdvyskoGAr6jQFpRPNfe0H9cFNyV9FsVXokL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391579AbgE1XP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 19:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391508AbgE1XPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:15:54 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C5E720776;
        Thu, 28 May 2020 23:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590707754;
        bh=6cRaMxa58tPApeIWKOSjOlyLMARaxMhQCEfel1rmCmU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=UxtajneJu7lsjX8Uo5AuI7/mwnxyJdr4lqsaOz6snFoJN6452mridIBT7wtciVndj
         gJkHEOTHzBCxrUGNB6bEuR4trNb0m1OJOY5VfdFWjmKLbvhG5xZXO84+dpHcK/xTMC
         Drk4aLSl2kReD6JvQzEAJzfn7aERE6l1Ug+bkR7s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <51c21311-a301-1a55-3eb1-a11583e7df43@loongson.cn>
References: <1590590362-11570-1-git-send-email-yangtiezhu@loongson.cn> <159060638492.88029.3855641102752089121@swboyd.mtv.corp.google.com> <51c21311-a301-1a55-3eb1-a11583e7df43@loongson.cn>
Subject: Re: [PATCH v4 1/2] clk: hisilicon: Use correct return value about hisi_reset_init()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
To:     Michael Turquette <mturquette@baylibre.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Date:   Thu, 28 May 2020 16:15:53 -0700
Message-ID: <159070775347.69627.5841986835404441281@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tiezhu Yang (2020-05-27 19:27:42)
> On 05/28/2020 03:06 AM, Stephen Boyd wrote:
> > Quoting Tiezhu Yang (2020-05-27 07:39:21)
> >> The return value about hisi_reset_init() is not correct, fix it.
> >>
> >> Fixes: e9a2310fb689 ("reset: hisilicon: fix potential NULL pointer der=
eference")
> > hisi_reset_init() returns NULL on error in that commit. This patch
> > doesn't make sense.
>=20
> Hi Stephen,
>=20
> The initial aim of this patch is to use correct return value about
> hisi_reset_init(), maybe NULL is OK, but the return value in this
> patch is more accurate.

The implementation of hisi_reset_init() that I see is this:


	struct hisi_reset_controller *rstc;

	rstc =3D devm_kmalloc(&pdev->dev, sizeof(*rstc), GFP_KERNEL);
	if (!rstc)
		return NULL;

	rstc->membase =3D devm_platform_ioremap_resource(pdev, 0);
	if (IS_ERR(rstc->membase))
		return NULL;

	spin_lock_init(&rstc->lock);
	rstc->rcdev.owner =3D THIS_MODULE;
	rstc->rcdev.ops =3D &hisi_reset_ops;
	rstc->rcdev.of_node =3D pdev->dev.of_node;
	rstc->rcdev.of_reset_n_cells =3D 2;
	rstc->rcdev.of_xlate =3D hisi_reset_of_xlate;
	reset_controller_register(&rstc->rcdev);

	return rstc;

And that returns NULL on an error and a valid pointer on success.
Changing the code to check the return value of hisi_reset_init() for an
error pointer is simply wrong without updating hisi_reset_init() to
return an error pointer on error. Where is the patch that changes
hisi_reset_init() to return an error pointer?
