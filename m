Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98422C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86E7720728
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgD0Sux convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:50:53 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:58313 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgD0Suw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:50:52 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C56C7240007;
        Mon, 27 Apr 2020 18:50:48 +0000 (UTC)
Date:   Mon, 27 Apr 2020 20:50:47 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Christophe Kerello <christophe.kerello@st.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <tony@atomide.com>, marex@denx.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 08/12] mtd: rawnand: stm32_fmc2: use
 FIELD_PREP/FIELD_GET macros
Message-ID: <20200427205047.2da8b3c2@xps13>
In-Reply-To: <20200416214513.43b7b6e1@collabora.com>
References: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
        <1586966256-29548-9-git-send-email-christophe.kerello@st.com>
        <20200416214513.43b7b6e1@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Boris Brezillon <boris.brezillon@collabora.com> wrote on Thu, 16 Apr
2020 21:45:13 +0200:

> On Wed, 15 Apr 2020 17:57:32 +0200
> Christophe Kerello <christophe.kerello@st.com> wrote:
> 
> > This patch removes custom macros and uses FIELD_PREP and FIELD_GET macros.  
> 
> Oh, nice. I didn't know about these macros. This could have saved me
> from defining a whole bunch of setters/getters in driver code...
> 
> 

Love these too! I will definitely use them in the future.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
