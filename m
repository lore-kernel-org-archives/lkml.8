Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E3EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18F5F207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbgEZHUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:20:16 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:42555 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731378AbgEZHUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:20:13 -0400
Received: from toerring.de ([88.75.114.2]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M3DaN-1jaT4f2j5p-003Zzj; Tue, 26 May 2020 09:20:08 +0200
Received: by toerring.de (Postfix, from userid 1000)
        id 1921C2720C03; Tue, 26 May 2020 09:20:08 +0200 (CEST)
Date:   Tue, 26 May 2020 09:20:07 +0200
From:   Jens Thoms Toerring <jt@toerring.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regmap: fix alignment issues
Message-ID: <20200526072007.GB29047@toerring.de>
Reply-To: jt@toerring.de
References: <20200525214726.GA19717@toerring.de>
 <CAHp75VdJVdpNjiHsd+dGiAJ79q6hDgYZzy8eZ3zP5ESmv1U-4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdJVdpNjiHsd+dGiAJ79q6hDgYZzy8eZ3zP5ESmv1U-4A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K1:WXKPfvLw31Cv0aeb40iGwuI70XdZv0DaMWn6cqlR8rUnFN55jJE
 iF3fsya+4ihhyKaTVpuujVDpZnuCZhXTAXOK1fZ4GyyNFg59bElTlmu+tHBdkFTSV9Nw0pg
 odseYquwXfeFqP4c1u5dG2I+RWq2cjdPkOXg+RfLO3oW/6fLlmon8Ep5KLLQWxaDtmmdYSx
 5hMKKYdnDPbiYn3JlZw9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vFRZ52z5SGQ=:VdmyqympMN5tv6PRyYz8y+
 A3EgGa20cVv98T91NQX29tN/hb4dx8ma2tx6z5ZAjytCHNrSiWhbOf9/EBzmNKzVQsTbIhBb6
 PPWQ4gaXB3yJOQjzZdoZQpyGtQAPb3Vfvz/ZOCAPZgKqjmTFEbI1UlVP6nmA7kBTCEV3QhgU8
 sFhBF7auK/39Cm496rUS2QbVKoCWogDi3ZNETzwlk3FHetVi2EvjKR1Rj6hVk0XMxmrUI1I2l
 6uzbM3p/YYJLfUmaCII2dNLREBGq8ordmKkOq6r1BEEskBlHC66im45KxFBsqblHvBlNdSOjV
 IYYHc/nXwHHVP0rOcBZRfTJ/b3Z9BWT/lE2yBsicF1aoiBJSBFbSEw/VLKK2P1VeM+O+1oLMU
 n699ct8OX5/cOoIAq/L2PgXrFzD/QdpRof6kfLt75pgUb+nSdrjq9mTtePpV2xSPsQfH82TQp
 Jj+FZvUcclgP/ozsiPdwoqolErHA81QvLrg1gX2N3BvkxCpE6PQS6nMT/Cy2DD0mEFodMlKhZ
 Kj6eO4B8frlOCw3WIvGrLjp38+YxxdF/uPQiYRPC56beHvLWsy+TFh/9ezqlGxcyNclMrzoAv
 Jo25W969npqcTr0MZdQQYevdygbpgidEcg4l1c2bgBbPgntlMouhxc6A4h29NPPyZVgMk/czZ
 CLwXAnRCZL4mZ+S8AR+00mtc5N3Y/DwRLB1AfT+LwrjvfZlyYWriAS0ilUFPSKWG0R8rPkv0Y
 JXx3nscGiMhs/0+nhpgW2mNvb/uxKJ0DZTnqsIs9BFOSBLRHNgSRGeVOGS56mq4LsY05rGo0N
 oXxNoIfYe2WUV3v6fY/hqNxBJ+Oz00rxj6/sN7GXIJzEjsE3+A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 01:42:36AM +0300, Andy Shevchenko wrote:
> On Tuesday, May 26, 2020, Jens Thoms Toerring <jt@toerring.de> wrote:
> 
> > The assembly and disassembly of data to be sent to or received from a
> > device invoke functions (regmap_format_XXX() and regmap_parse_XXX())
> > that extract or insert data items into a buffer. In some cases these
> > functions are invoked with buffer pointers with odd addresses but try
> > to directly assign from or to those address. On architectures with
> > strict alignment requirements this leads to kernel crashes for u16 and
> > u32 values. The assignments have are replaced by memcpy() calls.
> >
> >
> Don't we have put_/get_unaligned_b/leXX() for this?

Nice, didn't know about them, thank you. Will amend the patch.

-- 
  \   Jens Thoms Toerring  ________      jt@toerring.de
   \_______________________________      http://toerring.de
