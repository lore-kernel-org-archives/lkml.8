Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3F2C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A4220775
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585232542;
	bh=YlsR+y4MevduxIpBHtlSqX0E4PR8rEoNyXJuFhZpfCs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=Q0Fgx8EIW6i8wzLoVh02rXdPLTdO5bWbIdwZxT5kuvTgzqYp2+8IRYsQjj04DiS8f
	 7iVjlcFt/HGJgrIFRUcYP6ygW8BLys29NZ+H0AR7UwXLXg4yTp43UE0CXwMpXzWu75
	 amOB3jAAR+Z+i5z03E2upO8SN80t+Lm/lBmkNX98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgCZOWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:22:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbgCZOWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:22:21 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD322206F8;
        Thu, 26 Mar 2020 14:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585232541;
        bh=YlsR+y4MevduxIpBHtlSqX0E4PR8rEoNyXJuFhZpfCs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aUzqJqzYSCnTgPyA/P32W4O9j/LzdzCb6cnGRFJy0Cwv8RSWlx1+hK3ZUovfKdEtI
         tvJHNho2Hbq8acMNBk8LnaocRhllSCzcGoE/b6S8E7jLJ4VgMCZdp/FAj24UGX+eaI
         onNUYLGqPj9hTNVjVXaO6egDdALibnysCDzybkNY=
Date:   Thu, 26 Mar 2020 09:22:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH v5 1/6] dt-bindings: pci: Update iProc PCI binding for
 INTx support
Message-ID: <20200326142218.GA259277@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585205326-25326-2-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  $ git log --oneline Documentation/devicetree/bindings/pci/

  34129bb831cc ("dt-bindings: PCI: intel: Fix dt_binding_check compilation failure")
  e1ac611f57c9 ("dt-bindings: PCI: Convert generic host binding to DT schema")
  919ba6e739eb ("dt-bindings: PCI: Convert Arm Versatile binding to DT schema")
  0956dcb853dc ("dt-bindings: PCI: Add bindings for brcmstb's PCIe device")
  5d28bee7c91e ("dt-bindings: PCI: qcom: Add support for SDM845 PCIe")
  e54ea45a4955 ("dt-bindings: PCI: intel: Add YAML schemas for the PCIe RC controller")
  d8725e38dd9f ("dt-bindings: pci: layerscape-pci: add compatible strings "fsl, ls1028a-pcie"")

Capitalize yours match and put the useful information at the
beginning; maybe something like this:

  dt-bindings: PCI: iproc: Improve INTx modeling

On Thu, Mar 26, 2020 at 12:18:41PM +0530, Srinath Mannam wrote:
> From: Ray Jui <ray.jui@broadcom.com>
> 
> Update the iProc PCIe binding document for better modeling of the legacy
> interrupt (INTx) support.
