Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB258C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D37A20656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594280470;
	bh=8TPE8MlksTEoEbJL5UUAlS3fRlRoMv5XuAwY+bQUacc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xK2rEqWDhrGw85C5cG3++KMsj34EWUWn+KgMuhfboWzVUlcspQWyxbfzxZDaaqc66
	 zF576duM+MuvKx2lDOW06/EbMCBYxdHyV6gLifHhw1WBgdaqalhCALYEHC2igUH2L1
	 YkgM+/V3MDus80SYF8lmK/sdjyqkvznuqhLbYJwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgGIHlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:41:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgGIHlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:41:08 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64ACE20656;
        Thu,  9 Jul 2020 07:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594280467;
        bh=8TPE8MlksTEoEbJL5UUAlS3fRlRoMv5XuAwY+bQUacc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hSbetUizYHUWyB9PBS4v3OcknoYRztwBatTztVEpb06IhKplsQGLDoRgOxLABOlxK
         uOmksZSWb5mhmiib3MMBQXZIaKggDdnB4b4+Wb6szqRandi6flWum4KsE37dtarGET
         kXRMXwSWt0WIwKQAbkypt6XA7YbP8D1Idp/jdRwQ=
Date:   Thu, 9 Jul 2020 13:10:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "maxime@cerno.tech" <maxime@cerno.tech>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "jsarha@ti.com" <jsarha@ti.com>,
        "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>,
        "praneeth@ti.com" <praneeth@ti.com>,
        Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>
Subject: Re: [PATCH v2 0/2] Add support to get/set PHY attributes using PHY
 framework
Message-ID: <20200709074059.GJ34333@vkoul-mobl>
References: <1590503704-15057-1-git-send-email-yamonkar@cadence.com>
 <DM6PR07MB615442045742A117202DA5ABC5640@DM6PR07MB6154.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR07MB615442045742A117202DA5ABC5640@DM6PR07MB6154.namprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-07-20, 07:02, Swapnil Kashinath Jakhade wrote:
> Ping requesting review comments.
> https://lkml.org/lkml/2020/5/26/507

I dont have this, can you repost?

Thanks
> 
> Thanks & regards,
> Swapnil
> 
> > -----Original Message-----
> > From: Yuti Amonkar <yamonkar@cadence.com>
> > Sent: Tuesday, May 26, 2020 8:05 PM
> > To: linux-kernel@vger.kernel.org; kishon@ti.com; robh+dt@kernel.org;
> > mark.rutland@arm.com; maxime@cerno.tech
> > Cc: nsekhar@ti.com; jsarha@ti.com; tomi.valkeinen@ti.com;
> > praneeth@ti.com; Milind Parab <mparab@cadence.com>; Swapnil Kashinath
> > Jakhade <sjakhade@cadence.com>; Yuti Suresh Amonkar
> > <yamonkar@cadence.com>
> > Subject: [PATCH v2 0/2] Add support to get/set PHY attributes using PHY
> > framework
> > 
> > This patch series adds support to use kernel PHY subsystem APIs to get/set
> > PHY attributes like number of lanes and maximum link rate.
> > 
> > It includes following patches:
> > 
> > 1. v2-0001-phy-Add-max_link_rate-as-a-PHY-attribute-and-APIs.patch
> > This patch adds max_link_rate as a PHY attribute along with a pair of APIs
> > that allow the generic PHY subsystem to get/set PHY attributes supported by
> > the PHY.
> > The PHY provider driver may use phy_set_attrs() API to set the values that
> > PHY supports.
> > The controller driver may then use phy_get_attrs() API to fetch the PHY
> > attributes in order to properly configure the controller.
> > 
> > 2. v2-0002-phy-phy-cadence-torrent-Use-kernel-PHY-API-to-set.patch
> > This patch uses kernel PHY API phy_set_attrs to set corresponding PHY
> > properties in Cadence Torrent PHY driver. This will enable drivers using this
> > PHY to read these properties using PHY framework.
> > 
> > The phy_get_attrs() API will be used in the DRM bridge driver [1] which is in
> > process of upstreaming.
> > 
> > [1]
> > 
> > https://lkml.org/lkml/2020/2/26/263
> > 
> > Version History:
> > 
> > v2:
> >     - Implemented single pair of functions to get/set all PHY attributes
> > 
> > Swapnil Jakhade (1):
> >   phy: phy-cadence-torrent: Use kernel PHY API to set PHY attributes
> > 
> > Yuti Amonkar (1):
> >   phy: Add max_link_rate as a PHY attribute and APIs to get/set
> >     phy_attrs
> > 
> >  drivers/phy/cadence/phy-cadence-torrent.c |  7 +++++++
> >  include/linux/phy/phy.h                   | 25 +++++++++++++++++++++++
> >  2 files changed, 32 insertions(+)
> > 
> > --
> > 2.17.1

-- 
~Vinod
