Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FF7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B772072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="hdycCPFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgHXIJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:09:46 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:30868 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgHXIJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:09:40 -0400
IronPort-SDR: jyHNpcABxvrMT3iwX09PHAQANO6jgWDXgf1nqbIq7hPfoQOxk8HpOEddhGGgfFbuThywjZicGQ
 XNmd2b6M+vA5kfSzkAYtnV+Nr1a3GvcyBHSM5hqZm3am5gz0alga5XFQQ7j5aoOeme6ugL/kY7
 H+sQvpxd/bCHRhUeS8t5bjOAfv8wgiNAM6F8+cS0VVkro9eZW8m0BksICfn4HNWQ4jB37ppnbk
 iFdK07u6TIx3NHs+HEiNRAXcaNbZWGRf3BvVcEtQAZCiFJHatj1T2dR2/534CUwQQ93L3+y/nH
 j5k=
X-IronPort-AV: E=Sophos;i="5.76,347,1592863200"; 
   d="scan'208";a="13568269"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 24 Aug 2020 10:09:35 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 24 Aug 2020 10:09:35 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 24 Aug 2020 10:09:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1598256575; x=1629792575;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ud79nQ2nap6MBgkz3zH+Wze9pGT+3q3moHjPa+SicZE=;
  b=hdycCPFFmhpfIYHdH+AKDmiCdF33RQbJkq4Sa37Ni6GnciNwT9mJtlg6
   skz8Ntzpxlo7JcQzlbVDsPQoDBsdrII9M1ElycNgobW6LAoVZkreA7uIK
   feogt6FUyEV1HbbabmVG2SmWXnUH4fMngPZeKT5XVdCiudNDDiCiPkMBl
   t3mRValjpWZc1YJ6ZTmyHOIhFXYTOWHd6PezhsaoLz8zDI0RA/q3HPvrG
   sWwj5zvwQtrJryHuphzLaqkwtwqGPR0geDZAliNkcffBNphp91ZLcBQB9
   ZvP39YJdM9D1+Dh1zzFJMmUaO/E43IRIQW6SbXWbKw3nhFIC/z5tS/5T9
   w==;
IronPort-SDR: 8QcPYtC7vpm/OOpW8PpYCkxoltjwIDTJbeqLsyUuQFgi4S9AgxT2ZvG+A84fhDGSVVCu7hZ++H
 vbiMiv61pSi1d9zzyRtp2nwVC3b50C6z5J91IDHu+lBw5tHuB3wloRW10OC+Uvd2FgXflJhJuu
 v8mjeYU0ILdlW8x1guBoT1jBxz0fVDV8OAtfmTgG8l81Uy9aqgmfKmtEEossLrHke7rfNUIOzt
 VBiV11syIVXr58BU+23xn1sKUL0KQVJ6zeGbiKDA1yvYzY/OcLjb2wcob3dJgza9lCs8J+Ldxt
 eFk=
X-IronPort-AV: E=Sophos;i="5.76,347,1592863200"; 
   d="scan'208";a="13568268"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 24 Aug 2020 10:09:35 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 68D89280065;
        Mon, 24 Aug 2020 10:09:35 +0200 (CEST)
Message-ID: <d7e3dc09f8308d413a14760a231eecd6a972fa27.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: [PATCH net-next 2/2] net: phy: dp83867: apply ti,
 led-function and ti, led-ctrl to registers
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Dan Murphy <dmurphy@ti.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Aug 2020 10:09:33 +0200
In-Reply-To: <20200822160842.GE2347062@lunn.ch>
References: <20200821072146.8117-1-matthias.schiffer@ew.tq-group.com>
         <20200821072146.8117-2-matthias.schiffer@ew.tq-group.com>
         <20200822160842.GE2347062@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-08-22 at 18:08 +0200, Andrew Lunn wrote:
> On Fri, Aug 21, 2020 at 09:21:46AM +0200, Matthias Schiffer wrote:
> > These DT bindings are already in use by the imx7-mba7 DTS, but they
> > were
> > not supported by the PHY driver so far.
> > 
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com
> > >
> 
> Sorry, but NACK.
> 
> Please look at the work Marek Behún is doing
> 
> https://lkml.org/lkml/2020/7/28/765
> 
> 	Andrew
> 	

Thanks, this is looking quite nice. I hope Marek's patches are
finalized soon.

Matthias

