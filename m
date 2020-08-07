Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB9DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 315802075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="NiJoSnAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgHGOs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:48:26 -0400
Received: from sonic316-54.consmr.mail.gq1.yahoo.com ([98.137.69.30]:35434
        "EHLO sonic316-54.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726030AbgHGOs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 10:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1596811704; bh=DRdKyhPGIi9crruXXUy170YawLE0IdKbv+gBvEcp4AM=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=NiJoSnATbMRLRjHMinPnle5lIzryqrmYBEmotq/eMoeImwyOzfzZ5Mgpnhm0DB4pAyZUB29p60D5QIiIu+cx42RdOpkKzLE+4Gz+pwCCKMrEJs7/IjGXXiDoAGaV0bUpbT77NF3gGPXzKEEKAJDJwvT3rfrjLn0hKFAFNU6Gz2pSXCK+NNLlvw4z3eX8VekkckiZsCaqIaQRyb2GccHRo2YoDkxPTRJuGWOH6F8sFf6oTooKlHXjpI9FjI5AIIjjXJUfdQrWl0hX8K+E+FS5iM+2t3vDoQoYwt4kr0XEb9L6TM6tpYs8he5HpLYwrhX62cEB2Ydz8yvCZqx2uoreBg==
X-YMail-OSG: ovvgQ1UVM1mz5EpcWqKWrUhoX_TiqyFhP7NxGwI_FX4aNp2Ut0eg4r4_hrNn4uS
 2aANjSospXsm0irwLJG7CoQ38HHMkT6CTiz2raCHgrUt1WKS_E1W.29j8G.S2v6_ITUCn2MM7G2z
 u.BnBOVpjhlQFVFfWuTpnUQTBp18COCaSUy7UNbZ8nND2JujTr.EqTsV9u7L9EcYily5Iok29ASX
 QGF7oTS85JgvrZUiCxCKJMxS_pu59ZNbtJ0F8YHLol3wYwTBBoQzwdtkPrUBRGodRXqEL6GcQWFC
 vpNde3EbhFYewhsYWcFd9jCbuNrZ.RFjduzEOGGqFqc9Phc9b54a7iMnZciFpOVERDobRQr_Sk8d
 bdg10fRLLolzCkpFGQjoZGYFshE0TVTt3o42D4KCfB3XIHyoiKsS1iKehsd__pb01xEYkH2IOXKv
 06yNR.ZnG0dtg6PL3GrkE5zxmrd7EjiQxomWmDZQX619lcYP7QoL54sCxFVikeZPuwtJ4kebwqag
 T.4UoYW4UELEgqzIOL8b20Tp2_HBhgkJOBem_NflNqylBPIOtiOY0.ObC3y0x_mi2uIUugizRFiR
 5uVQwqS4U8G.LHz6kXcebsEB9qwBYDd_xjTxpFCbDbSI1VYLlvlLULW8bzqqaTCutbD18KovCG_W
 1ZQt.aKCOLreZQt0_PWk43ONIS7CcA6NMevuCi9GEX2X6ybxKsyU2CdJjdjsaFQU0_1cqwNXiQO1
 rp4hsbm9Sk4uY61EOxq5iYfFFeWjqOqRa512PfMllXSmZRRpy02nshYSgOxPG5B9bZJ6CchZTBcg
 QJ87vEunZ__1YQJ9aXj7fHHOHaxxoeaC1IRtkhxnD5X9o3Dr2FN6XzovSGLFkFp8qOh_JKxhIY9d
 sn4w.IyuQnLqKv.OZIC9maMN8QzM2Pnnd.FrmTYmJqDisDq8jgjOsB5V6NO5QtvQIPrzlk2_9Oca
 jFFTy20BBxbJaZziUietLqtnCj783DwdXJghbC2Ct737B859knEIjaCA0TBAnu4FY3xDpn1.le0L
 rclBjVEHuCGZ4Pdqc6bOG9611dxdX5h3zH6MA7ZsLrIP7LyiUkwa7XKfBXPueyYA4Oj5Fh1SipoU
 xOG6mm18qqDduABQ0xqUDNWHHipG03owWXyJiqPCcwgWjFy3vJaLFAwCHM5MIYC5XqacLs5Y31Mr
 rJgbknL1LOFKntvlsQXbSfHjsxsG13zaxmupCo0xWCGzlVrhgh2Z3U4BKpfF4vzqFjSemE9e6PNt
 XwE_Pw_.fuMjlaozA35gMnoizdeAsJDpYJZSf_Q88QDDgF0y50qi1wWrXVPTB5vpi213WnCwVskD
 HXGR3DSZp7uBtuJM93vstqeL_GanKnCmiiX40F0x2IYz13Gj.8pXSIs6F.F9Gp15wfE_z7o1jfEC
 zRojRcu_83f29TR5kl4hA8yEUgCiu9olKM037eC2vNabmcPdS_YQx0tAdz1wp_RiPYs4UROtuXQ7
 9CA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Fri, 7 Aug 2020 14:48:24 +0000
Received: by smtp420.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 24b5f98ba496c054505f6f72607bc988;
          Fri, 07 Aug 2020 14:48:21 +0000 (UTC)
Date:   Fri, 7 Aug 2020 22:48:12 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: fs/erofs/zdata.c:198:22: sparse: sparse: non size-preserving
 integer to pointer cast
Message-ID: <20200807144801.GA30258@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <202008072005.Myrby1lg%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008072005.Myrby1lg%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.16436 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 07, 2020 at 08:08:10PM +0800, kernel test robot wrote:
> Hi Gao,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   86cfccb66937dd6cbf26ed619958b9e587e6a115
> commit: 47e4937a4a7ca4184fd282791dfee76c6799966a erofs: move erofs out of staging
> date:   12 months ago
> config: s390-randconfig-s032-20200807 (attached as .config)
> compiler: s390-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.2-118-ge1578773-dirty
>         git checkout 47e4937a4a7ca4184fd282791dfee76c6799966a
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=s390 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
> >> fs/erofs/zdata.c:198:22: sparse: sparse: non size-preserving integer to pointer cast
>    fs/erofs/zdata.c:282:22: sparse: sparse: non size-preserving integer to pointer cast
>    fs/erofs/zdata.c:1094:24: sparse: sparse: non size-preserving integer to pointer cast

I don't think these are valid warnings.

All these three lines are using cmpxchg struct page * (which is equivalent to unsigned long
in these cmpxchg macros) and nothing special at all in my opinion (Especially the last two
lines).

+198	if (!cmpxchg_relaxed(pages, NULL, tagptr_cast_ptr(t)))
+282	if (!cmpxchg(clt->compressedpages++, NULL, page))
+1094	if (oldpage != cmpxchg(&pcl->compressed_pages[nr], oldpage, page)) {

btw, recently sparse warnings quite confuse me (p.s. they're all on alpha/s390/sparc archs and relate
to cmpxchg/xchg by accident), I have no idea what happened with sparse.

Thanks,
Gao Xiang

