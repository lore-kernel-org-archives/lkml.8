Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7176FC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 14:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 321DA2137B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 14:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599490686;
	bh=f8HxqXH7tHss6ZiCBaaA0cUjl6LlaIV5sUDUNL9e7yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BZYl2ldN91Qle3Yn9K3C4e5/rhcH2hIyn910TJyMcBMtUW5PsZ61t/hU46rVhu653
	 SN8fyKQ/7brnys6w2SZNk1+DETBOSKwhzZd21adcYsQeAmtEJe717LGA5d7CwSV/pp
	 t3XkVvc79Bfzv3dTneRaQ17NRuDFQgxCf2vo7OrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgIGO6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 10:58:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730043AbgIGOwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:52:16 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C6AE207C3;
        Mon,  7 Sep 2020 14:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599490336;
        bh=f8HxqXH7tHss6ZiCBaaA0cUjl6LlaIV5sUDUNL9e7yg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=orHIKfDizSwpfmH34MNTOHyuhXW86bupmxfvz/ZrEPD8JYyYK80o9iCkK1haZTLUG
         Z3oBkzfgKks1O7surQiFDs/NVyRB7cR8SE2zo+FYTcRL/F8haqKxFrorpNlOZSodAp
         k91d+RjTpVsKS2ELEY053kB23Wb6hV14Zqb2GgnM=
Received: by pali.im (Postfix)
        id EF6DB814; Mon,  7 Sep 2020 16:52:13 +0200 (CEST)
Date:   Mon, 7 Sep 2020 16:52:13 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Andre Heider <a.heider@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Add ethernet switch
 aliases
Message-ID: <20200907145213.fwlyz4k6scible7x@pali>
References: <20200907112718.5994-1-pali@kernel.org>
 <20200907144228.GV3112546@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200907144228.GV3112546@lunn.ch>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 September 2020 16:42:28 Andrew Lunn wrote:
> On Mon, Sep 07, 2020 at 01:27:17PM +0200, Pali Rohár wrote:
> > Espressobin boards have 3 ethernet ports and some of them got assigned more
> > then one MAC address. MAC addresses are stored in U-Boot environment.
> > 
> > Since commit a2c7023f7075c ("net: dsa: read mac address from DT for slave
> > device") kernel can use MAC addresses from DT for particular DSA port.
> > 
> > Currently Espressobin DTS file contains alias just for ethernet0.
> > 
> > This patch defines additional ethernet aliases in Espressobin DTS files, so
> > bootloader can fill correct MAC address for DSA switch ports if more MAC
> > addresses were specified.
> > 
> > DT alias ethernet1 is used for wan port, DT aliases ethernet2 and ethernet3
> > are used for lan ports for both Espressobin revisions (V5 and V7).
> > 
> > Fixes: 5253cb8c00a6f ("arm64: dts: marvell: espressobin: add ethernet alias")
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> I'm not sure a Fixes: is appropriate here. What is actually broken?
> This just seems like a new feature.

Hello Andrew! With "fixes" I mean that this patch fixes aliases list in
that mentioned commit as it was incomplete. Probably better would be
"related" or "extended" keyword in this case. But I do not know.

I would not say it is a "new feature". But rather that patch in this
email fixes issue that Linux kernel did not set correct MAC address for
DSA slave ports. I think it is something which could be backported also
to stable releases as "ignoring" vendor/factory MAC address is not
correct behavior.

If you have an idea how to reformulate commit description I will do it.
