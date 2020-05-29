Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D72C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D48AA207D3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590726707;
	bh=vUX7nQGYANb7wtXorQxJhcu4PyfoL81nOGhO8sRAgpg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=H2yfV1A1/7m62Df4o6ceHm26lQPWE1wxYtE+Kuf6fhR49RqlSYl0j6P7XLvX612Xg
	 3U9eFFPxEQPEW6LZyFI45+kWJGg+xzdt0wUrgP6ggZGgxiiQzMSanyDShWrj11dw/T
	 5XzC7fGjYTCOBGeK3SE0NpYop0W0banLLaOIzKVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgE2Ebr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 00:31:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgE2Ebq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:31:46 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34B4C2075A;
        Fri, 29 May 2020 04:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590726706;
        bh=vUX7nQGYANb7wtXorQxJhcu4PyfoL81nOGhO8sRAgpg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XH6mIZD2vzGjqki+RL2Q1KuqTklDMievwePhR69uaZsnbKf++qt+QJTSNpJcyaGgL
         3y1WAgO/A7wFnFfJWZM1xh6fJTpff9BHKmP+8fOWJ17somJDUvUcvqMyW4FU1by8Kp
         ZSEyf2qGHhFFlx6Kb7b+DVK9/XexC+MpjsqUfPsg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0936ce03-935d-d863-0bd1-a005ba1d40e0@loongson.cn>
References: <1590590362-11570-1-git-send-email-yangtiezhu@loongson.cn> <159060638492.88029.3855641102752089121@swboyd.mtv.corp.google.com> <51c21311-a301-1a55-3eb1-a11583e7df43@loongson.cn> <159070775347.69627.5841986835404441281@swboyd.mtv.corp.google.com> <be070b91-4954-c66c-970c-a64f72eb54dc@loongson.cn> <159072469537.69627.2358538167030427315@swboyd.mtv.corp.google.com> <0936ce03-935d-d863-0bd1-a005ba1d40e0@loongson.cn>
Subject: Re: [PATCH v4 1/2] clk: hisilicon: Use correct return value about hisi_reset_init()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
To:     Michael Turquette <mturquette@baylibre.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Date:   Thu, 28 May 2020 21:31:45 -0700
Message-ID: <159072670557.69627.15526584762592289463@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tiezhu Yang (2020-05-28 21:02:05)
> On 05/29/2020 11:58 AM, Stephen Boyd wrote:
> > Quoting Tiezhu Yang (2020-05-28 19:03:54)
> >> On 05/29/2020 07:15 AM, Stephen Boyd wrote:
> >>> Quoting Tiezhu Yang (2020-05-27 19:27:42)
> >>>> On 05/28/2020 03:06 AM, Stephen Boyd wrote:
> >>>>> Quoting Tiezhu Yang (2020-05-27 07:39:21)
> >>>>>> The return value about hisi_reset_init() is not correct, fix it.
> >>>>>>
> >>>>>> Fixes: e9a2310fb689 ("reset: hisilicon: fix potential NULL pointer=
 dereference")
> >>>>> hisi_reset_init() returns NULL on error in that commit. This patch
> >>>>> doesn't make sense.
> >>>> Hi Stephen,
> >>>>
> >>>> The initial aim of this patch is to use correct return value about
> >>>> hisi_reset_init(), maybe NULL is OK, but the return value in this
> >>>> patch is more accurate.
> >>> The implementation of hisi_reset_init() that I see is this:
> >>>
> >>>
> >>>        struct hisi_reset_controller *rstc;
> >>>
> >>>        rstc =3D devm_kmalloc(&pdev->dev, sizeof(*rstc), GFP_KERNEL);
> >>>        if (!rstc)
> >>>                return NULL;
> >>>
> >>>        rstc->membase =3D devm_platform_ioremap_resource(pdev, 0);
> >>>        if (IS_ERR(rstc->membase))
> >>>                return NULL;
> >>>
> >>>        spin_lock_init(&rstc->lock);
> >>>        rstc->rcdev.owner =3D THIS_MODULE;
> >>>        rstc->rcdev.ops =3D &hisi_reset_ops;
> >>>        rstc->rcdev.of_node =3D pdev->dev.of_node;
> >>>        rstc->rcdev.of_reset_n_cells =3D 2;
> >>>        rstc->rcdev.of_xlate =3D hisi_reset_of_xlate;
> >>>        reset_controller_register(&rstc->rcdev);
> >>>
> >>>        return rstc;
> >>>
> >>> And that returns NULL on an error and a valid pointer on success.
> >>> Changing the code to check the return value of hisi_reset_init() for =
an
> >>> error pointer is simply wrong without updating hisi_reset_init() to
> >>> return an error pointer on error. Where is the patch that changes
> >>> hisi_reset_init() to return an error pointer?
> >> Hi Stephen,
> >>
> >> Do you mean the following changes?
> > Yes where is this change?
>=20
> ERR_PTR(-ENOMEM) and ERR_CAST(rstc->membase)
>=20

I think you didn't understand my question. I'm asking where is this
patch applied to the kernel and what commit is it? I don't see it in the
clk tree.
