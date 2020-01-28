Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D677AC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 06:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2FA12173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 06:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgA1GyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 01:54:22 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40264 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgA1GyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 01:54:22 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id BBFC12852C3;
        Tue, 28 Jan 2020 06:54:20 +0000 (GMT)
Date:   Tue, 28 Jan 2020 07:54:17 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        linux-mtd@lists.infradead.org, vigneshr@ti.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: nand: Rename Toshiba Memory to Kioxia
Message-ID: <20200128075417.0fb68e10@collabora.com>
In-Reply-To: <20200127165148.1f8ef0f7@xps13>
References: <1579766643-4983-1-git-send-email-ytc-mb-yfuruyama7@kioxia.com>
        <20200127165148.1f8ef0f7@xps13>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2020 16:51:48 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Yoshio,
> 
> Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com> wrote on Thu, 23 Jan
> 2020 17:04:03 +0900:
> 
> > Rename Toshiba Memory to Kioxia since the company name has changed.  
> 
> I wonder how much this is a noisy change compared to its benefits
> 
> I would like more feedback. Richard, Boris, is this the first name we
> run into this situation? Ho was this handled in the past?

I don't think that's really useful. Maybe just add a comment above the
NAND_MFR_TOSHIBA definition stating that Toshiba and Kioxia ID are the
same. If Koxia starts producing new chip under the Koxia brand, new
files/structs/funcs/... can be prefixed with koxia instead of Toshiba.
