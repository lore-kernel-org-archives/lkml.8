Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9534C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A17282075F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 19:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388386AbgEXT0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 15:26:03 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:58451 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388365AbgEXT0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 15:26:00 -0400
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id F4107240002;
        Sun, 24 May 2020 19:25:56 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?utf-8?q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
        computersforpeace@gmail.com, kdasu.kdev@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        sumit.semwal@linaro.org, linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v4 4/5] dt: bindings: brcmnand: add v2.1 and v2.2 support
Date:   Sun, 24 May 2020 21:25:50 +0200
Message-Id: <20200524192550.4559-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522121524.4161539-5-noltari@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: 191dd7b0d8899e3fc0c4c6627a244a5fad8f2cfb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-05-22 at 12:15:23 UTC, =?utf-8?q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= wrote:
> Added brcm,brcmnand-v2.1 and brcm,brcmnand-v2.2 as possible compatible
> strings to support brcmnand controllers v2.1 and v2.2.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
