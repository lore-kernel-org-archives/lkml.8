Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B14C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4800D206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592815000;
	bh=p3/nAndPqD+xJSr38RP3st3phWO4emLpokfz2oHkG4o=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=a8T2CVWrn3zMUNh5j6iDHNfpFhtN61giSuyzCvA0tv1Jqzsk4V849P/JpcYsIGrcB
	 +RReUxov1JjaO8qgc0sr9KaHjXGVb0gYwQccHymY5xAjwNZF6dH9hvk4LjGuLhHiEZ
	 gJcPNpbgYBZqutmxhoRpOUb84L5xr2herwrf7Gzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgFVIgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:36:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgFVIgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:36:38 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 737B0206C3;
        Mon, 22 Jun 2020 08:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592814997;
        bh=p3/nAndPqD+xJSr38RP3st3phWO4emLpokfz2oHkG4o=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=F+oC2C6ZvX3DFlstmcmu9ZiRw5t6G3wCRTyqZ3JKEBm3CDgIpZnmVC0YbNiwSVRIf
         tVQoME3X6ac+Febu65absGTTSCg3cNaZJUIt6zbfLsuoCMQeFwdJ4vyN/paAD17R63
         0qkXyoMBD0xKrUWWh0yN51mlQC64LUOWeZa81t+s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202006211709.hxHhenC8%lkp@intel.com>
References: <202006211709.hxHhenC8%lkp@intel.com>
Subject: Re: drivers/clk/clk-divider.c:39:17: sparse: sparse: incorrect type in argument 1 (different base types)
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
To:     kernel test robot <lkp@intel.com>
Date:   Mon, 22 Jun 2020 01:36:36 -0700
Message-ID: <159281499670.62212.17969220355200979156@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting kernel test robot (2020-06-21 02:05:20)
> Hi Stephen,
>=20
> First bad commit (maybe !=3D root cause):
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   64677779e8962c20b580b471790fe42367750599
> commit: bbd7ffdbef6888459f301c5889f3b14ada38b913 clk: Allow the common cl=
k framework to be selectable
> date:   7 weeks ago
> config: alpha-randconfig-s032-20200621 (attached as .config)
> compiler: alpha-linux-gcc (GCC) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.2-rc2-13-gc59158c8-dirty
>         git checkout bbd7ffdbef6888459f301c5889f3b14ada38b913
>         # save the attached .config to linux build tree
>         make W=3D1 C=3D1 ARCH=3Dalpha CF=3D'-fdiagnostic-prefix -D__CHECK=
_ENDIAN__'
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
>=20
> sparse warnings: (new ones prefixed by >>)
>=20
>    drivers/clk/clk-divider.c:31:24: sparse: sparse: cast to restricted __=
be32
>    drivers/clk/clk-divider.c:31:24: sparse: sparse: cast to restricted __=
be32
>    drivers/clk/clk-divider.c:31:24: sparse: sparse: cast to restricted __=
be32
>    drivers/clk/clk-divider.c:31:24: sparse: sparse: cast to restricted __=
be32
>    drivers/clk/clk-divider.c:31:24: sparse: sparse: cast to restricted __=
be32
>    drivers/clk/clk-divider.c:31:24: sparse: sparse: cast to restricted __=
be32
>    drivers/clk/clk-divider.c:31:24: sparse: sparse: cast to restricted __=
be32
>    drivers/clk/clk-divider.c:31:24: sparse: sparse: cast to restricted __=
be32
>    drivers/clk/clk-divider.c:31:24: sparse: sparse: cast to restricted __=
be32
>    drivers/clk/clk-divider.c:31:24: sparse: sparse: cast to restricted __=
be32
>    drivers/clk/clk-divider.c:31:24: sparse: sparse: cast to restricted __=
be32
>    drivers/clk/clk-divider.c:31:24: sparse: sparse: cast to restricted __=
be32
>    drivers/clk/clk-divider.c:31:24: sparse: sparse: cast to restricted __=
be32
>    drivers/clk/clk-divider.c:31:24: sparse: sparse: cast to restricted __=
be32
>    drivers/clk/clk-divider.c:31:24: sparse: sparse: cast to restricted __=
be32
>    drivers/clk/clk-divider.c:31:24: sparse: sparse: cast to restricted __=
be32
>    drivers/clk/clk-divider.c:31:24: sparse: sparse: cast to restricted __=
be32
>    drivers/clk/clk-divider.c:31:24: sparse: sparse: cast to restricted __=
be32
> >> drivers/clk/clk-divider.c:39:17: sparse: sparse: incorrect type in arg=
ument 1 (different base types) @@     expected unsigned int [usertype] @@  =
   got restricted __be32 [usertype] @@
> >> drivers/clk/clk-divider.c:39:17: sparse:     expected unsigned int [us=
ertype]
>    drivers/clk/clk-divider.c:39:17: sparse:     got restricted __be32 [us=
ertype]
>=20
> vim +39 drivers/clk/clk-divider.c
>=20
> 9d9f78ed9af0e4 Mike Turquette 2012-03-15  17 =20
> 9d9f78ed9af0e4 Mike Turquette 2012-03-15  18  /*
> 9d9f78ed9af0e4 Mike Turquette 2012-03-15  19   * DOC: basic adjustable di=
vider clock that cannot gate
> 9d9f78ed9af0e4 Mike Turquette 2012-03-15  20   *
> 9d9f78ed9af0e4 Mike Turquette 2012-03-15  21   * Traits of this clock:
> 9d9f78ed9af0e4 Mike Turquette 2012-03-15  22   * prepare - clk_prepare on=
ly ensures that parents are prepared
> 9d9f78ed9af0e4 Mike Turquette 2012-03-15  23   * enable - clk_enable only=
 ensures that parents are enabled
> 9556f9dad8f576 Brian Norris   2015-04-13  24   * rate - rate is adjustabl=
e.  clk->rate =3D ceiling(parent->rate / divisor)
> 9d9f78ed9af0e4 Mike Turquette 2012-03-15  25   * parent - fixed parent.  =
No clk_set_parent support
> 9d9f78ed9af0e4 Mike Turquette 2012-03-15  26   */
> 9d9f78ed9af0e4 Mike Turquette 2012-03-15  27 =20
> 434d69fad63b44 Jonas Gorski   2019-04-18  28  static inline u32 clk_div_r=
eadl(struct clk_divider *divider)
> 434d69fad63b44 Jonas Gorski   2019-04-18  29  {
> 434d69fad63b44 Jonas Gorski   2019-04-18  30    if (divider->flags & CLK_=
DIVIDER_BIG_ENDIAN)
> 434d69fad63b44 Jonas Gorski   2019-04-18 @31            return ioread32be=
(divider->reg);

Ok. I guess we'll need to force cast the pointer to be __be32 in this
case. Before it wasn't in generic code so the architecture was masking
the issue.
