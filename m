Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C248C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D8820810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 21:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590786865;
	bh=yFRDxNh58uuyFlzO1eMMtyMIiJEIafrnBU49+xaJiK0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=0x54vNey4XH5U/KrmrTQ1ogbvwSD/unZeYCadttbsd4paNROgNIc0+hTgQBImoUoI
	 sxX/qQmRPR26Q++2nmbSSr57OlDAxBWyfgnxOx6shuSRJgu3I7B1AaNaTanQRrxdXT
	 al94mGlFyghghnIPRf7ktB6xxlqhJMB45PIouRls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgE2VOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 17:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgE2VOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 17:14:24 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98CFC206A4;
        Fri, 29 May 2020 21:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590786863;
        bh=yFRDxNh58uuyFlzO1eMMtyMIiJEIafrnBU49+xaJiK0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=GS0eKtdXDrhQSWaEv2ZJrGcCCgEdw2uyumKYsrinyRHwzBmiAF+UBLaCa+JyDFyuy
         IBx2/tDSI/M0ybyrpV8wfp1yBrCNgKwYbsMo3FxPOjydgzhYu8gAshvMc6oeFPCQ64
         3N/s27HXfSxm90NUqDfh3FcPCyLh8I/P7HmeDxvM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f11b46d7-0d94-b4b3-350a-19e5a98d5289@loongson.cn>
References: <1590590362-11570-1-git-send-email-yangtiezhu@loongson.cn> <51c21311-a301-1a55-3eb1-a11583e7df43@loongson.cn> <159070775347.69627.5841986835404441281@swboyd.mtv.corp.google.com> <be070b91-4954-c66c-970c-a64f72eb54dc@loongson.cn> <159072469537.69627.2358538167030427315@swboyd.mtv.corp.google.com> <0936ce03-935d-d863-0bd1-a005ba1d40e0@loongson.cn> <159072670557.69627.15526584762592289463@swboyd.mtv.corp.google.com> <8e60fafd-724a-c4ef-b0a0-53e092ad6bdc@loongson.cn> <159074496638.69627.15702116074645440806@swboyd.mtv.corp.google.com> <f11b46d7-0d94-b4b3-350a-19e5a98d5289@loongson.cn>
Subject: Re: [PATCH v4 1/2] clk: hisilicon: Use correct return value about hisi_reset_init()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
To:     Michael Turquette <mturquette@baylibre.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Date:   Fri, 29 May 2020 14:14:22 -0700
Message-ID: <159078686285.69627.11416031375116687757@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tiezhu Yang (2020-05-29 03:20:11)
> On 05/29/2020 05:36 PM, Stephen Boyd wrote:
> > Quoting Tiezhu Yang (2020-05-28 23:44:20)
> >> On 05/29/2020 12:31 PM, Stephen Boyd wrote:
> >>> Quoting Tiezhu Yang (2020-05-28 21:02:05)
> >>> I think you didn't understand my question. I'm asking where is this
> >>> patch applied to the kernel and what commit is it? I don't see it in =
the
> >>> clk tree.
> >> Sorry for that, actually I do not quite understand what you mean.
> >>
> >> In my opinion, after the following commit,  when devm_ioremap_resource=
()
> >> is called in hisi_reset_init(), hisi_reset_init() still returns NULL a=
nd
> >> it only returns
> >> -ENOMEM when call hisi_reset_init() failed, I think it may returns
> >> -EINVAL, -EBUSY
> >> or -ENOMEM if failed, this is what I want to fix.
> >>
> >> "reset: hisilicon: fix potential NULL pointer dereference"
> >> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/commit/d=
rivers/clk/hisilicon/reset.c?h=3Dclk-next&id=3De9a2310fb689151166df7fd99710=
93362d34bd79
> >>
> > This commit doesn't change the value that is returned by
> > hisi_reset_init() on an error. It still returns NULL when an error
> > happens.
>=20
> Yes, I agree, but after this commit e9a2310fb689 ("reset:
> hisilicon: fix potential NULL pointer dereference"), the
> return value of hisi_reset_init() is not so correct because
> it replaces devm_ioremap() with devm_ioremap_resource().

Where does the return value of hisi_reset_init() change in that commit?
The usage of devm_ioremap_resource() vs. devm_ioremap() doesn't change
the return value of hisi_reset_init().

>=20
> Do you think the code of this patch is OK but the "Fixes:" commit
> is not accurate? If so, can we remove the "Fixes:" tag?
>=20

No. The patch is incorrect and the Fixes tag is incorrect.
