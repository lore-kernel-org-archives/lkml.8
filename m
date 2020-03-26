Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A64DC2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325E820774
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 15:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585236502;
	bh=hLWw99VkerwY2yvNvNHjCZISiqZQOoDJZcOBRfe2TY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=AvC8WNzSZJWPch6125Yb7Nggg0ZSNDK7LBGhHJDG01tDj0L7GNJBQqua9x+HXqnvt
	 6OOj7PF7/b4gy7aSiR+1pMd2PrSKlfLOqkOjV/dQFZ/0fCGyop68LoXVwfkYXmVD5G
	 IILO2mNhkPKVPHGeBizjyBfla6AuN9qXdvJA71Ac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbgCZP2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbgCZP2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 11:28:21 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 597882073E;
        Thu, 26 Mar 2020 15:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585236500;
        bh=hLWw99VkerwY2yvNvNHjCZISiqZQOoDJZcOBRfe2TY8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mGsm3Gr2ex9ZW0K8sLYNNzmaZCh32ETgvfitHZ9j3QdIBeXXTuBf6KAVtCW84RTgt
         cPktU98SYyevdT2cD/uwZwMwwfb231/43dRA8cjKbQSLNmd8XIZjn169HlB39rKUIQ
         hnVZe2WnZCv9Ac1Y1WQJGnKGeTIH+a4h73qFtOB8=
Date:   Thu, 26 Mar 2020 10:28:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Roman Bacik <roman.bacik@broadcom.com>
Subject: Re: [PATCH 2/3] PCI: iproc: fix invalidating PAXB address mapping
Message-ID: <20200326152818.GA7634@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585206447-1363-3-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[fixed Andrew's email addr]

Change subject to match convention, e.g.,

  PCI: iproc: Invalidate correct PAXB inbound windows

On Thu, Mar 26, 2020 at 12:37:26PM +0530, Srinath Mannam wrote:
> From: Roman Bacik <roman.bacik@broadcom.com>
> 
> Second stage bootloader prior to Linux boot may use all inbound windows
> including IARR1/IMAP1. We need to ensure all previous configuration of
> inbound windows are invalidated during the initialization stage of the
> Linux iProc PCIe driver. Add fix to invalidate IARR1/IMAP1 because it was
> missed in previous patch.
> 
> Fixes: 9415743e4c8a ("PCI: iproc: Invalidate PAXB address mapping")
> Signed-off-by: Roman Bacik <roman.bacik@broadcom.com>
> ---
>  drivers/pci/controller/pcie-iproc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index 6972ca4..e7f0d58 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -351,6 +351,8 @@ static const u16 iproc_pcie_reg_paxb_v2[IPROC_PCIE_MAX_NUM_REG] = {
>  	[IPROC_PCIE_OMAP3]		= 0xdf8,
>  	[IPROC_PCIE_IARR0]		= 0xd00,
>  	[IPROC_PCIE_IMAP0]		= 0xc00,
> +	[IPROC_PCIE_IARR1]		= 0xd08,
> +	[IPROC_PCIE_IMAP1]		= 0xd70,

Wow, this is a little too subtle for my taste.

9415743e4c8a added this loop:

  +   for (idx = 0; idx < ib->nr_regions; idx++) {
  +       iproc_pcie_write_reg(pcie,
  +                            MAP_REG(IPROC_PCIE_IARR0, idx), 0);

This patch doesn't change the loop or the limit, so I *guess*
previously we invalidated IPROC_PCIE_IARR0, IPROC_PCIE_IARR2, ...,
(skipping IPROC_PCIE_IARR1), and now we will invalidate
IPROC_PCIE_IARR0, IPROC_PCIE_IARR1, ... instead?

>  	[IPROC_PCIE_IARR2]		= 0xd10,
>  	[IPROC_PCIE_IMAP2]		= 0xcc0,
>  	[IPROC_PCIE_IARR3]		= 0xe00,
