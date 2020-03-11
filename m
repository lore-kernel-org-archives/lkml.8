Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MENTIONS_GIT_HOSTING,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.0
Received: from relay12.mail.gandi.net ([217.70.178.232]:43629 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729977AbgCKPo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:44:56 -0400
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Kamal Dasu <kdasu.kdev@gmail.com>, linux-kernel@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Paul Burton <paulburton@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linaro-mm-sig@lists.linaro.org, Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org, dri-devel@lists.freedesktop.org,
        James Hogan <jhogan@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Brian Norris <computersforpeace@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH V4 1/3] dt: bindings: brcmnand: Add support for flash-edu
Date: Wed, 11 Mar 2020 16:44:45 +0100
Message-Id: <20200311154445.25555-1-miquel.raynal@bootlin.com>
In-Reply-To: <20200122213313.35820-2-kdasu.kdev@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2020-01-22 at 21:33:11 UTC, Kamal Dasu wrote:
> Adding support for EBI DMA unit (EDU).
> 
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

