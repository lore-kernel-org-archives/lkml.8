Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B704EC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD5D2078C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgD0Rsk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:48:40 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:32833 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgD0Rsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:48:39 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id CC82620005;
        Mon, 27 Apr 2020 17:48:36 +0000 (UTC)
Date:   Mon, 27 Apr 2020 19:48:35 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <tony@atomide.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>
Subject: Re: [PATCH v2 05/12] mtd: rawnand: stm32_fmc2: remove useless
 inline comments
Message-ID: <20200427194835.4d0e1d66@xps13>
In-Reply-To: <1586966256-29548-6-git-send-email-christophe.kerello@st.com>
References: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
        <1586966256-29548-6-git-send-email-christophe.kerello@st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Christophe Kerello <christophe.kerello@st.com> wrote on Wed, 15 Apr
2020 17:57:29 +0200:

> Remove inline comments that are useless since function label are
> self explanatory.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> ---

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miquèl
