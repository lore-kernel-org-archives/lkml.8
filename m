Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFEDC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6ACA20663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="M/QdTmpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbgCPKnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:43:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44858 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730582AbgCPKnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 06:43:53 -0400
Received: from zn.tnic (p200300EC2F06AB0069F33882ABEAD541.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:ab00:69f3:3882:abea:d541])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 98ED41EC0CC5;
        Mon, 16 Mar 2020 11:43:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584355431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vWCrpYpiEQlq/JlZoyOrf+wSGtGepOt385jU76a55Tk=;
        b=M/QdTmpKfwlKaOhV5MQf0U5wXe4mam+nTnLNBgPer82TzkrRcs6jgk1CCTEA0ckoDN+GAm
        ff5wie5Aq+vu9IC7nrnlJuJfxrCj/UKqXC4LJNtIqBnFKDDKs6Fc9MxdTXhUHl5oo4YZcz
        DDqwcSzpGvpqg+tl/sPhpNmLUu+cqKI=
Date:   Mon, 16 Mar 2020 11:43:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "manish.narani@xilinx.com" <manish.narani@xilinx.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Frank Li <frank.li@nxp.com>
Subject: Re: [PATCH v2] EDAC: synopsys: Fix the wrong call of pinf->col
 parameter
Message-ID: <20200316104356.GH26126@zn.tnic>
References: <1582856183-5007-1-git-send-email-sherry.sun@nxp.com>
 <20200315195024.GB10926@zn.tnic>
 <AM6PR04MB658495A13744517A6E263D2292F90@AM6PR04MB6584.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM6PR04MB658495A13744517A6E263D2292F90@AM6PR04MB6584.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 01:30:39AM +0000, Sherry Sun wrote:
> Maybe you misunderstood the handle_error(), this function has already 
> distinguished between Zynq and ZynqMP through priv->p_data->quirks.
> And what I am doing in this patch is to remove the useless pinf->col in ZynqMP
> part, which won't break the Zynq part.

Ok, I see it now, thanks for clarifying.

Now, in your v2 pls fix this check in handle_error():

	if (!priv->p_data->quirks) {

to *actually* *explicitly* check that the platform for which
this function is called, really supports interrupts, i.e.,
DDR_ECC_INTR_SUPPORT, and not that the ->quirks thing is != 0. Like the
rest of the code does.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
