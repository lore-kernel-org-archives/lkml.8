Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C43C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2F0F208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="trpRupFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgESJEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 05:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgESJEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 05:04:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275D5C05BD09
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 02:04:24 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w64so2549337wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 02:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TRUKrhEDvmas9xbqBpI5eK4i0cGdO3vlXJ/AHu3xRYU=;
        b=trpRupFW1M7ki7aL3dKNLYSFtviNCiZiGyEk0VI0fAwqLOew+P/vqdMH4PgeXYQwFQ
         0PDCWdXWwejp82rCVc68RCE9JnLxyrwu/H5cclySsYRlFzq27HVrviBrth84qv2TPY6R
         3pE69qBjyGmKdjZPgxhXi+e0L0PNqH4XQXFJmxFOjbAvr9msXKS0tfU6vHNFwgYKiM7/
         vCdtImiQn8S7LLG8+d0uwFh/4mNac5zA6t8N6qkZbDI+6j6XsLfWgh4hJlC6hRHA/68K
         wHZ3kARLfk5vmZ6Gen4L5NWrTVBwW+5B5fCzfeew0hxp7FzhOaulVLk4Twh+PnTe5Ytx
         jA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TRUKrhEDvmas9xbqBpI5eK4i0cGdO3vlXJ/AHu3xRYU=;
        b=EOO8vLcImTP/VziT5A97t40raaspadg4zoWdcJhBFmSjldgjxGNmYL93SM+e2nsVr5
         fRfH6VJIYTA1+YuRsKpH5OaROoMrSwxsafHWut1uFoMg5mw6STIwe2/diLg3rcmpclBX
         mp/QVhm+ntbvDihWbHn7x9S3IlvU49h10/c2hpeaxbkExHk2LWKarfySdrCqZrYDlTc9
         Xz2qWkeGtvbQtnWh6NFJl0H2lfzJ00VsJPQOeJQOANXCZ9AQ4Othj1pewEkzNtB+bRxI
         XfK0qmcD272L9uJEPDs60iAJf0+UI3AQpvzlrEcBxVxeBV0VygebWXoGQV8a/EQbjkl9
         KRKw==
X-Gm-Message-State: AOAM530tKRartIMgPi97s3Bqel/eqADtDHl/o5s/n0Cu0KbfGDhULIhf
        Gxdbj8JjHzkFyN2yvKi+ciU=
X-Google-Smtp-Source: ABdhPJwWCcYoNzmHFAM5uYaZlva33QM5VyOq8Gd7cJm6+UEZuT5wDqwCSIb09WmBYIU9GQlcVz+1Xg==
X-Received: by 2002:a1c:2314:: with SMTP id j20mr2907200wmj.139.1589879062350;
        Tue, 19 May 2020 02:04:22 -0700 (PDT)
Received: from ubuntu-g3.micron.com ([165.225.86.140])
        by smtp.googlemail.com with ESMTPSA id x22sm2923759wmi.32.2020.05.19.02.04.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 02:04:21 -0700 (PDT)
Message-ID: <8de0911281b4c03671841027ec165422789b63f2.camel@gmail.com>
Subject: Re: [PATCH v4 0/5] Micron SLC NAND filling block
From:   Bean Huo <huobean@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, vigneshr@ti.com, s.hauer@pengutronix.de,
        boris.brezillon@collabora.com, derosier@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Date:   Tue, 19 May 2020 11:04:15 +0200
In-Reply-To: <20200518172253.1c3b9d32@xps13>
References: <20200518135943.11749-1-huobean@gmail.com>
         <20200518172253.1c3b9d32@xps13>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,  Miquel

On Mon, 2020-05-18 at 17:22 +0200, Miquel Raynal wrote:
> Hi Bean,
> 
> Bean Huo <huobean@gmail.com> wrote on Mon, 18 May 2020 15:59:38
> +0200:
> 
> > From: Bean Huo <beanhuo@micron.com>
> > 
> > After submission of patch V1 [1] and V2 [2], we stopped its update
> > since we get
> > stuck in the solution on how to avoid the power-loss issue in case
> > power-cut
> > hits the block filling. In the v1 and v2, to avoid this issue, we
> > always damaged
> > page0, page1, this's based on the hypothesis that NAND FS is UBIFS.
> > This
> > FS-specifical code is unacceptable in the MTD layer. Also, it
> > cannot cover all
> > NAND based file system. Based on the current discussion, seems that
> > re-write all
> > first 15 page from page0 is a satisfactory solution.
> 
> We have a layering problem now. Maybe we should just have an MTD
> internal variable like min_written_pages_before_erase that the Micron
> driver could set to a !0 value.
> 
> Then, the handling could be done by the user (UBI/UBIFS, JFFS2, MTD
> user if exported).
> 

This is NAND its own problem, if no significant adantage, I don't think
it's a good solution to extend the problem to the upper FS layer.
also, in the FS erase path, doesn't have the programmed pages counter.
we should repeat the same approach as we did in MTD layer.

> > 
> > Meanwhile, I borrowed one idea from Miquel Raynal patchset [3], in
> > which keeps
> > a recode of programmed pages, base on it, for most of the cases, we
> > don't need
> > to read every page to see if current erasing block is a partially
> > programmed
> > block.
> > 
> > Changelog:
> > 
> > v3 - v4:
> >     1. In the patch 4/5, change to directly use ecc.strength to
> > judge the page
> >        is a empty page or not, rather than max_bitflips < mtd-
> > >bitflip_threshold
> >     2. In the patch 5/5, for the powerloss case, from the next time
> > boot up,
> >        lots of page will be programmed from >page15 address, if
> > still using
> >        first_p as GENMASK() bitmask starting position, writtenp
> > will be always 0,
> >        fix it by changing its bitmask starting at bit position 0.
> > 
> > v2 - v3:
> >     1. Rebase patch to the latest MTD git tree
> >     2. Add a record that keeps tracking the programmed pages in the
> > first 16
> >        pages
> >     3. Change from program odd pages, damage page 0 and page 1, to
> > program all
> >        first 15 pages
> >     4. Address issues which exist in the V2.
> > 
> > v1 - v2:
> >     1. Rebased V1 to latest Linux kernel.
> >     2. Add erase preparation function pointer in
> > nand_manufacturer_ops.
> > 
> > 
> > [1] https://www.spinics.net/lists/linux-mtd/msg04112.html
> > [2] https://www.spinics.net/lists/linux-mtd/msg04450.html
> > [3] https://www.spinics.net/lists/linux-mtd/msg13083.html
> > 
> > 
> > Bean Huo (5):
> >   mtd: rawnand: group all NAND specific ops into new nand_chip_ops
> >   mtd: rawnand: Add {pre,post}_erase hooks in nand_chip_ops
> >   mtd: rawnand: Add write_oob hook in nand_chip_ops
> >   mtd: rawnand: Introduce a new function
> > nand_check_is_erased_page()
> >   mtd: rawnand: micron: Micron SLC NAND filling block
> 
> When you take my patches in your series, especially when not touching
> them at all, you should keep my Authorship and SoB first, then add
> your
> SoB.
> 

sorry for my fault, I thought adding your Signed-off-by in 3/5 is
suffient. you mean I should add your signed-off-by in 5/5 as well?
I will do that in next version.

thanks Miquel.


BTW: would you please help me review other code?


 
Bean


> 
> Thanks,
> Miquèl

