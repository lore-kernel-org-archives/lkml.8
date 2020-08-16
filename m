Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7E4C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 11:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E820B20716
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 11:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Krl/v7U3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgHPLWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 07:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728639AbgHPLWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 07:22:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E52C061786;
        Sun, 16 Aug 2020 04:21:56 -0700 (PDT)
Received: from zn.tnic (p200300ec2f26be005d37f199a58e243d.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:be00:5d37:f199:a58e:243d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3CC941EC027B;
        Sun, 16 Aug 2020 13:21:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597576910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cMXvEXkyTsrY8sFsp1lnP4ixT5jJSQ6YbHxQfH0FNg4=;
        b=Krl/v7U3lVDL8glqCYGHcilbKhYp7xlwSoeGOYfIWisRhmgp569YSVCqhzsCaIfn8zjoc0
        mC+uzv36mSVuWb++7yBXMOS+hyDvHpjaWPjVrT4ymB62HU4Xv+pfqAn+Eb9BtkifX2ovaW
        60JxbV021VbIljRwwcb0rQgiuI1C5Ug=
Date:   Sun, 16 Aug 2020 13:22:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Shenhar, Talel" <talel@amazon.com>
Cc:     mchehab@kernel.org, james.morse@arm.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will@kernel.org, linux-edac@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, hhhawa@amazon.com,
        ronenk@amazon.com, jonnyc@amazon.com, hanochu@amazon.com,
        eitan@amazon.com
Subject: Re: [PATCH v9 2/2] EDAC: al-mc-edac: Introduce Amazon's Annapurna
 Labs Memory Controller EDAC
Message-ID: <20200816112244.GG21914@zn.tnic>
References: <20200728095155.18506-1-talel@amazon.com>
 <20200728095155.18506-3-talel@amazon.com>
 <20200815183358.GE25814@zn.tnic>
 <5d516c64-ecd8-6f36-5f95-6708fe0f3fd5@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d516c64-ecd8-6f36-5f95-6708fe0f3fd5@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 12:17:31PM +0300, Shenhar, Talel wrote:
> Let me know what you think.

Well, devm_al_mc_edac_free() devm_al_mc_edac_del() look like useless
wrappers to me and can be removed and you can use edac_mc_del_mc() and
edac_mc_free() directly. But then you need to cast them in an ugly way
so that it builds:

        ret = devm_add_action(&pdev->dev, (void (*)(void *data))edac_mc_free, mci);

I guess we can leave them as is and then lift them into the EDAC core if
someone else wants to do the same devm_* thing.

al_mc_edac_get_scrub_mode() doesn't need a prefix because it is used
only once and the compiler is simply inlining it so you can forget the
stack trace visibility:

$ readelf -s drivers/edac/al_mc_edac.ko | grep scrub
$

The others are fine, I guess, since they're function pointers and cannot be
inlined as such so you want them prefixed:

$ readelf -s drivers/edac/al_mc_edac.ko | grep al_mc_edac
    23: 00000000     0 FILE    LOCAL  DEFAULT  ABS al_mc_edac.c
    25: 00000000     4 FUNC    LOCAL  DEFAULT    1 devm_al_mc_edac_free
    27: 00000004     4 FUNC    LOCAL  DEFAULT    1 devm_al_mc_edac_del
    31: 00000124    24 FUNC    LOCAL  DEFAULT    1 al_mc_edac_irq_handler_ce
    35: 00000260    24 FUNC    LOCAL  DEFAULT    1 al_mc_edac_irq_handler_ue
    36: 00000278    56 FUNC    LOCAL  DEFAULT    1 al_mc_edac_check
    37: 000002b0   680 FUNC    LOCAL  DEFAULT    1 al_mc_edac_probe
    47: 00000000    20 FUNC    LOCAL  DEFAULT    3 al_mc_edac_driver_init
    51: 00000000    12 FUNC    LOCAL  DEFAULT    5 al_mc_edac_driver_exit
    53: 00000000   392 OBJECT  LOCAL  DEFAULT   16 al_mc_edac_of_match
    59: 00000000   104 OBJECT  LOCAL  DEFAULT   20 al_mc_edac_driver
    61: 00000000     0 FILE    LOCAL  DEFAULT  ABS al_mc_edac.mod.c
    88: 00000000   392 OBJECT  GLOBAL DEFAULT   16 __mod_of__al_mc_edac_of_m

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
