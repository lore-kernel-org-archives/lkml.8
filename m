Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5F5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84FA5206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nA0sQtL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbgF2TOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731554AbgF2TNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:53 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69110C0D941E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:02:05 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EF217299;
        Mon, 29 Jun 2020 14:02:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1593432124;
        bh=eQbJn3vb0K78NPoXf+o0lEl+wgzeznRoWZwwR/EyWX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nA0sQtL16b7El+YqlTorIQEubvJwfP0WNhDTIvMI7hI5RnECeVA3SaemFBxEFAoaa
         Ud/pXw0EzF6DQZZVKVvUvMM/YHS4AfQP9kea3JNHeKFL7grT8arzlR07Zp31pf2jk4
         zcqz3zgeTDKOgvyAMoEeXWLpje6TeVfZTozo8IuY=
Date:   Mon, 29 Jun 2020 15:02:00 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v8 0/3] phy: zynqmp: Add PHY driver for the Xilinx ZynqMP
 Gigabit Transceiver
Message-ID: <20200629120200.GA10648@pendragon.ideasonboard.com>
References: <20200513172239.26444-1-laurent.pinchart@ideasonboard.com>
 <20200629093943.GB2599@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200629093943.GB2599@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Mon, Jun 29, 2020 at 03:09:43PM +0530, Vinod Koul wrote:
> On 13-05-20, 20:22, Laurent Pinchart wrote:
> > Hello,
> > 
> > The patch series adds a PHY driver for the Xilinx ZynqMP gigabit serial
> > transceivers (PS-GTR). The PS-GTR is a set of 4 PHYs that can be used by
> > the PCIe, USB 3.0, DisplayPort, SATA and Ethernet controllers that are
> > part of the Serial I/O Unit (SIOU).
> > 
> > The code is based on a previous version sent by Anurag Kumar Vulisha and
> > available at [1]. The DT bindings have been converted to YAML, and both
> > the bindings and the driver have been considerably reworked (and
> > simplified). The most notable changes is the removal of manual handling
> > of the reset lines of the PHY users (which belongs to the PHY users
> > themselves), and moving to the standard PHY .power_on() and .configure()
> > operations to replace functions that were previously exported by the
> > driver. Please see individual patches for a more detailed changelog.
> > 
> > Compared to v7, review comments on the PHY driver have been taken into
> > account, and the DT bindings have switched to the GPL-2.0-only OR
> > BSD-2-Clause license
> > 
> > The code is based on v5.6 and has been tested with DisplayPort on the
> > Xilinx ZC106 board.
> 
> This (dt patch and 8.1 update) fails to apply for me, can you please
> rebased on phy-next and resend. Also I saw this while trying to apply:
> 
> WARNING: Misordered MAINTAINERS entry - list 'S:' before 'T:'
> #403: FILE: MAINTAINERS:18605:
> +T:	git https://github.com/Xilinx/linux-xlnx.git
> +S:	Supported

Rebased, fixed and resent.

-- 
Regards,

Laurent Pinchart
