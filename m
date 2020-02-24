Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4C9C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F1D20714
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 06:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582526381;
	bh=E75ambiZWtDC8+PzuPEM8PwrEqFHtP0j+JO70AOquzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t7LFWdJ/Ghz12JmeFpHk1L8hPRS4oaffkbRC36EDC0Qrlo5VT+zmN9Cdq7W9aW/Ml
	 s5J4pc/ZgEWPyXj5kohdnQtPCOFWtQvX/UHkFqyR/fSxi61/VPI9O1sAS+eFa8yOZB
	 l8VRcNEmQC/84Kii+jd2LBJ0nHOLCpLsoGPuQMlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgBXGjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 01:39:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:35300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgBXGjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 01:39:40 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BC9820661;
        Mon, 24 Feb 2020 06:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582526379;
        bh=E75ambiZWtDC8+PzuPEM8PwrEqFHtP0j+JO70AOquzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VVGC9XIfm/Ss6rxMN8hoMIyaU6Mbgjg2qJU69VxnHI7Ms0QJQvAtUG/3GAPo/X/jH
         oCZi/v+bq0pWYxbA82xUjWibhiPKwuRq88DwYHiIA0KBP3S9srMb5tqDXTlSBEZL1U
         7+9zNlk+NF02H24zKGrNunIVRbPZ/y8CYnxi9V7c=
Date:   Mon, 24 Feb 2020 14:39:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Michael Walle <michael@walle.cc>, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        netdev <netdev@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vivien Didelot <vivien.didelot@gmail.com>
Subject: Re: [PATCH v2 net-next/devicetree 5/5] arm64: dts: fsl: ls1028a:
 enable switch PHYs on RDB
Message-ID: <20200224063933.GN27688@dragon>
References: <20200219151259.14273-6-olteanv@gmail.com>
 <20200222114136.595-1-michael@walle.cc>
 <CA+h21hrXAFWfjcKfj+QAcQauDqvLS0Vzp9Uvv6ewqxDSF7yRpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+h21hrXAFWfjcKfj+QAcQauDqvLS0Vzp9Uvv6ewqxDSF7yRpg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 02:17:54PM +0200, Vladimir Oltean wrote:
> Hi Michael,
> 
> On Sat, 22 Feb 2020 at 13:41, Michael Walle <michael@walle.cc> wrote:
> >
> > Hi,
> >
> > status should be the last property, correct?
> >
> > -michael
> 
> I know of no such convention to exist.

Hmm, it's a convention for DTS files that I'm looking after.

Shawn
