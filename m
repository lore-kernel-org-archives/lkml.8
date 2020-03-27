Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DEDC2D0EE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 18:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF682072F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 18:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgC0S10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:27:26 -0400
Received: from smtprelay0016.hostedemail.com ([216.40.44.16]:52816 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726275AbgC0S10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 14:27:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id DC564181D330D;
        Fri, 27 Mar 2020 18:27:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: comb05_5cf10df77e138
X-Filterd-Recvd-Size: 1870
Received: from XPS-9350 (unknown [172.58.92.163])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Fri, 27 Mar 2020 18:27:18 +0000 (UTC)
Message-ID: <32d1dee7e9c7dd104cd7405a22fb5d5e3ef61303.camel@perches.com>
Subject: Re: [PATCH net-next 6/9] net: phy: add backplane kr driver support
From:   Joe Perches <joe@perches.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florinel Iordache <florinel.iordache@nxp.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, f.fainelli@gmail.com,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, kuba@kernel.org,
        corbet@lwn.net, shawnguo@kernel.org, leoyang.li@nxp.com,
        madalin.bucur@oss.nxp.com, ioana.ciornei@nxp.com,
        linux-kernel@vger.kernel.org
Date:   Fri, 27 Mar 2020 11:25:26 -0700
In-Reply-To: <20200327142245.GF11004@lunn.ch>
References: <1585230682-24417-1-git-send-email-florinel.iordache@nxp.com>
         <1585230682-24417-7-git-send-email-florinel.iordache@nxp.com>
         <20200327142245.GF11004@lunn.ch>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-03-27 at 15:22 +0100, Andrew Lunn wrote:
> > +/* Backplane custom logging */
> > +#define BPDEV_LOG(name) \
> > +	char log_buffer[LOG_BUFFER_SIZE]; \
> > +	va_list args; va_start(args, msg); \
> > +	vsnprintf(log_buffer, LOG_BUFFER_SIZE - 1, msg, args); \
> > +	if (!bpphy->attached_dev) \
> > +		dev_##name(&bpphy->mdio.dev, log_buffer); \
> > +	else \
> > +		dev_##name(&bpphy->mdio.dev, "%s: %s", \
> > +			netdev_name(bpphy->attached_dev), log_buffer); \
> > +	va_end(args)

This could also use %pV instead of an intermediate buffer.

It's also bad form to use macros with required
external variables.

