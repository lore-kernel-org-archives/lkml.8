Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F304C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5607D2080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bjIYzggr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgGWXWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:22:03 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5387 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgGWXWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 19:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595546524; x=1627082524;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QgeslEf13WULvCxIOUP4MQ+OmCsX7gpbdkOpEsc+l7k=;
  b=bjIYzggr13ZfjjpRhtCJoLeoueWrEZYUbyxbkP01YRIUnj5MS0tzbyK+
   JzogF3oV517kKLTYE36hs/HM6cKL1D+i6s/TOKYuRDm3ByLEwj6PlavWN
   0jQHW2ONrkNoGmN2o+gMMDDwr/cRvl58h43DRNOT9vShvqIHICjaWfxI9
   ai/QHz9V2r9ywHNRVJr5E24i8/m1nNHEg4iUSNVzSa3p5Mvesr2BDs0b1
   gF1eXFeKifkvYIEYBbidn1gPpveXBB9wLqfDX4S0Qq9pM3VgqqM2TtajP
   qxiugpMf1MrAJBfxSk4rY0+mh4gsP5ovVRG8g9oDZXflW48TYxSMW3LuM
   Q==;
IronPort-SDR: cAQl5o5vxYIbbHmq0jCHSomOpbLo7MT+cfuc89UXcL/neg0X/nvAnexHLpYYCfx5vcLsCcxDIF
 Pe3bbOh8kpMbkmULar13NWADXSPNKmmzFpUNXQvZDrTSRrh7pCsbcL5l1klOyCkPs1JcgpRHlF
 mazRQXUxnAkRK2NznO9EWfh1nvdaVCNrrhQq7XCrjPdnK+3JjNMx+//7S1K0U9UhJdakO9I60j
 hooouX+Htp05eRscN9Icwwvg7erMXWPmFpxTaJL0rkFHES4FvkV8eUCRKK9mQsdDmjUI2S/Nnq
 jx4=
X-IronPort-AV: E=Sophos;i="5.75,388,1589212800"; 
   d="scan'208";a="246304471"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2020 07:22:04 +0800
IronPort-SDR: A685du3fDRLzqCOVDoE/3cKvvNi/bs23ylvn9j/socAgIab+OXhm7n8QA0YtSpv7zv4MEyGsCr
 1WGBf6a970zH1hbDoW/s2C4Puepu7Z3no=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 16:09:41 -0700
IronPort-SDR: ZPvGnB3aMrvnPWiKC7eRCLgc2ktzcPW7hTaG4A1gddAOuTb3tpozRaADX96nfFxia79ARXWeH9
 j6d7hGRNqG/w==
WDCIronportException: Internal
Received: from unknown (HELO redsun52) ([10.149.66.28])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 16:22:01 -0700
Date:   Fri, 24 Jul 2020 00:21:57 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@wdc.com>
To:     linux-riscv@lists.infradead.org
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] riscv: ptrace: NT_PRFPREG regset access fixes
Message-ID: <alpine.LFD.2.21.2007232038170.24175@redsun52.ssa.fujisawa.hgst.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 In the course of adding RISC-V/Linux support to `gdbserver' I examined 
our Linux regset code to make sure I get the userland side right and 
discovered a discrepancy between how our internal `user_regset_copyout' 
and `user_regset_copyout' API has been defined and how we call it in the 
RISC-V backend in the handling of the NT_PRFPREG regset.  Additionally I 
found that code violating our coding style.

 To address these issues I made this small patch set, addressing each of 
them separately.  See individual change descriptions for details.

 These changes are hopefully obviously correct, however to make sure I 
have verified them manually with a HiFive Unleashed board running 
`gdbserver' controlled remotely by GDB and also by running the full GDB 
testsuite in the same environment using the lp64d ABI, without and with 
the changes applied.

 Please apply.

  Maciej
