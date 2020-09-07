Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE11C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4567721556
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbgIGRWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:22:52 -0400
Received: from foss.arm.com ([217.140.110.172]:36098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729601AbgIGNpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:45:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1326E1045;
        Mon,  7 Sep 2020 06:32:31 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D09663F66E;
        Mon,  7 Sep 2020 06:32:29 -0700 (PDT)
Date:   Mon, 7 Sep 2020 14:32:24 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org, Tomasz Maciej Nowak <tmn505@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Xogium <contact@xogium.me>, marek.behun@nic.cz
Subject: Re: [PATCH v3 0/5] PCIe aardvark controller improvements
Message-ID: <20200907133224.GA9398@e121166-lin.cambridge.arm.com>
References: <20200907111038.5811-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200907111038.5811-1-pali@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 01:10:33PM +0200, Pali Rohár wrote:
> Hi,
> 
> we have some more improvements for PCIe aardvark controller (Armada 3720
> SOC - EspressoBIN and Turris MOX).
> 
> The main improvement is that with these patches the driver can be compiled
> as a module, and can be reloaded at runtime.
> 
> Marek & Pali
> 
> 
> Changes in V3:
> * Rebased on top of the v5.9-rc1 release

Applied to pci/aardvark, thanks !

Lorenzo

> Changes in V2 for patch 4/5:
> * Protect pci_stop_root_bus() and pci_remove_root_bus() function calls by
>   pci_lock_rescan_remove() and pci_unlock_rescan_remove()
> 
> Pali Rohár (5):
>   PCI: aardvark: Fix compilation on s390
>   PCI: aardvark: Check for errors from pci_bridge_emul_init() call
>   PCI: pci-bridge-emul: Export API functions
>   PCI: aardvark: Implement driver 'remove' function and allow to build
>     it as module
>   PCI: aardvark: Move PCIe reset card code to advk_pcie_train_link()
> 
>  drivers/pci/controller/Kconfig        |   2 +-
>  drivers/pci/controller/pci-aardvark.c | 104 ++++++++++++++++----------
>  drivers/pci/pci-bridge-emul.c         |   4 +
>  3 files changed, 71 insertions(+), 39 deletions(-)
> 
> -- 
> 2.20.1
> 
