Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542A5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D37D207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="C6SN2qdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgE2L5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 07:57:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44010 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgE2L5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 07:57:22 -0400
Received: from zn.tnic (p200300ec2f0f5e0065ddb5c3466bc22e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5e00:65dd:b5c3:466b:c22e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D23861EC0322;
        Fri, 29 May 2020 13:57:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1590753440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Mb4Mz+1/XuDAyzOl/JMctcYrIrEgVvw4VqZ2/A1E4Xw=;
        b=C6SN2qdYZDruOlhzsnUprpL/JHgyg280ws6gxvTYqdcLiqUyL47xIiwtcBmGOQnzsu5rlA
        c/thwLPa7H6svEtrgzxU8NwKtRb4rBnfQsZzn9443OuKbyLTYwqhFpd5jeuCSVNnOONmKy
        4YsZUjeHeQOMHW7JEGljDmGwR8ENIeI=
Date:   Fri, 29 May 2020 13:57:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     linux-kernel@vger.kernel.org, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: 5.6.12 MCE on AMD EPYC 7502
Message-ID: <20200529115720.GF9011@zn.tnic>
References: <be415508-246f-d934-b449-4cadbdb0acc4@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be415508-246f-d934-b449-4cadbdb0acc4@yandex.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 01:55:29PM +0300, Dmitry Antipov wrote:
> Hello,
> 
> I'm facing the following kernel messages running Debian 9 with
> custom 5.6.12 kernel running on AMD EPYC 7502 - based hardware:
> 
> [138537.806814] mce: [Hardware Error]: Machine check events logged
> [138537.806818] [Hardware Error]: Corrected error, no action required.
> [138537.808456] [Hardware Error]: CPU:0 (17:31:0) MC27_STATUS[Over|CE|MiscV|-|-|-|SyndV|-|-|-]: 0xd82000000002080b
> [138537.810080] [Hardware Error]: IPID: 0x0001002e00001e01, Syndrome: 0x000000005a000005
> [138537.811694] [Hardware Error]: Power, Interrupts, etc. Ext. Error Code: 2, Link Error.
> [138537.813281] [Hardware Error]: cache level: L3/GEN, mem/io: IO, mem-tx: GEN, part-proc: SRC (no timeout)
> 
> Is it related to some (not so) known CPU errata?

Who knows.

> Should I try to update microcode, motherboard firmware, kernel, or whatever else?

Yeah, BIOS update might be a good idea, if there's a newer version for
your board.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
