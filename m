Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B2AC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D289222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgCJSaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:30:12 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57077 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJSaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:30:12 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 86791E0004;
        Tue, 10 Mar 2020 18:30:07 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mason Yang <masonccyang@mxic.com.tw>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     bbrezillon@kernel.org, juliensu@mxic.com.tw,
        s.hauer@pengutronix.de, yuehaibing@huawei.com,
        linux-kernel@vger.kernel.org, stefan@agner.ch, rfontana@redhat.com,
        linux-mtd@lists.infradead.org, frieder.schrempf@kontron.de,
        tglx@linutronix.de, allison@lohutok.net
Subject: Re: [PATCH v3 3/4] mtd: rawnand: Add support manufacturer specific suspend/resume operation
Date:   Tue, 10 Mar 2020 19:30:06 +0100
Message-Id: <20200310183006.17925-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1583220084-10890-4-git-send-email-masonccyang@mxic.com.tw>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: bee2279b01c2790aaa267c91ebdf55c2cb60f5ed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-03 at 07:21:23 UTC, Mason Yang wrote:
> Patch nand_suspend() & nand_resume() for manufacturer specific
> suspend/resume operation.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
