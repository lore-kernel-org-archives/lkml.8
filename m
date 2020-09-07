Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CE1C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B4BB208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599500544;
	bh=1kDnLVFqzUH6CQ8yg91FlxkD3s6uN6+leIwZezvx2tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yWBdpZp4bXzTF82RBMADRZ5Mg/c6tn3NAGY6G4t0Ufre3sizNGpL40gm8+7AHgWoE
	 OV9WfF+btO3rBAOBY93K7jMmLMcKAW39CjjcfOSuXHaBKWfz9cdGZ3WIY27dNKldac
	 qKD2HK+cLHZEmOrvHo1gQZT2Eyaymj1pGlpwlTMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbgIGRmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:42:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:49842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731422AbgIGRmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 13:42:03 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75718206E7;
        Mon,  7 Sep 2020 17:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599500523;
        bh=1kDnLVFqzUH6CQ8yg91FlxkD3s6uN6+leIwZezvx2tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dvwT/ePn33sVALbr6WwKNwXWkZFj8YDlt96TXffmwy9b6U+tq/EBRs7QRD6GtuOb7
         aeJgPEYahT7eP+eFnbWeYakrWLgWcDXyS/ztrdxiDgliD+cm4bXNWgFi659tWqN1lb
         Gf7LU7JaOB1rSGIb6pPRyjAdo2UcgFxneWcpx1GA=
Received: by pali.im (Postfix)
        id 0D420814; Mon,  7 Sep 2020 19:42:00 +0200 (CEST)
Date:   Mon, 7 Sep 2020 19:42:00 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andre Heider <a.heider@gmail.com>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Add ethernet switch
 aliases
Message-ID: <20200907174200.yqojaguthi6khn3v@pali>
References: <20200907112718.5994-1-pali@kernel.org>
 <3ec54259-4bfe-8462-e8d5-083fc009707a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ec54259-4bfe-8462-e8d5-083fc009707a@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 September 2020 19:13:41 Andre Heider wrote:
> > @@ -120,7 +124,7 @@
> >   			#address-cells = <1>;
> >   			#size-cells = <0>;
> > -			port@0 {
> > +			switch0port0: port@0 {
> 
> This label is unused it seems.

Yes, it is unused, but I defined labels for all ports so it would be
clean that ports are indexed from zero and not from one. Also it looks
inconsistent if some of DSA ports have labels and some does not.

> 
> >   				reg = <0>;
> >   				label = "cpu";
> >   				ethernet = <&eth0>;
> > @@ -131,19 +135,19 @@
> >   				};
> >   			};
> > -			port@1 {
> > +			switch0port1: port@1 {
> >   				reg = <1>;
> >   				label = "wan";
> >   				phy-handle = <&switch0phy0>;
> >   			};
> > -			port@2 {
> > +			switch0port2: port@2 {
> >   				reg = <2>;
> >   				label = "lan0";
> >   				phy-handle = <&switch0phy1>;
> >   			};
> > -			port@3 {
> > +			switch0port3: port@3 {
> >   				reg = <3>;
> >   				label = "lan1";
> >   				phy-handle = <&switch0phy2>;
> > 
> 
