Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5962FC2D0E9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317D320714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 18:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgCZS5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 14:57:12 -0400
Received: from smtprelay0084.hostedemail.com ([216.40.44.84]:60970 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726340AbgCZS5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 14:57:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 4CDDD837F24D;
        Thu, 26 Mar 2020 18:57:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: box88_4315bd86663d
X-Filterd-Recvd-Size: 1839
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu, 26 Mar 2020 18:57:08 +0000 (UTC)
Message-ID: <46bf05a81237ed716bf06b48891fcd7c129eae5d.camel@perches.com>
Subject: Re: [PATCH net-next 6/9] net: phy: add backplane kr driver support
From:   Joe Perches <joe@perches.com>
To:     David Miller <davem@davemloft.net>, florinel.iordache@nxp.com
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, kuba@kernel.org,
        corbet@lwn.net, shawnguo@kernel.org, leoyang.li@nxp.com,
        madalin.bucur@oss.nxp.com, ioana.ciornei@nxp.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 26 Mar 2020 11:55:17 -0700
In-Reply-To: <20200326.115330.2250343131621391364.davem@davemloft.net>
References: <1585230682-24417-1-git-send-email-florinel.iordache@nxp.com>
         <1585230682-24417-7-git-send-email-florinel.iordache@nxp.com>
         <20200326.115330.2250343131621391364.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-26 at 11:53 -0700, David Miller wrote:
> From: Florinel Iordache <florinel.iordache@nxp.com>
> Date: Thu, 26 Mar 2020 15:51:19 +0200
> 
> > +static void kr_reset_master_lane(struct kr_lane_info *krln)
> > +{
> > +     struct phy_device *bpphy = krln->bpphy;
> > +     struct backplane_phy_info *bp_phy = bpphy->priv;
> > +     const struct lane_io_ops *lane_ops = krln->bp_phy->bp_dev.lane_ops;
> 
> Please use reverse christmas tree ordering for local variables.

How (any why) do you suggest the first 2 entries here
should be ordered?


