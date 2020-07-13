Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F865C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E81A5206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594610159;
	bh=YZzIW+KZpc0vqOCl/7oVkW5+VX1XWYHsXl9tcGS26FI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=utvYSoX71oBNy9l6M7c0lX0nFOygmxeFeZANGH35LBHNPEi568tc95JzeWVNRlPCC
	 umT8V4g28kPM4E0TAkuAqk18JLpQY1+w+L9c0P8mexY5AmoLZi3zSThPbiNHIs7x3L
	 U0Cn6ut3PtF6WH4vD2Eh6QA/1AJa//2Xwp7Cea7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgGMDP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 23:15:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgGMDP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 23:15:57 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C85BD2068F;
        Mon, 13 Jul 2020 03:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594610157;
        bh=YZzIW+KZpc0vqOCl/7oVkW5+VX1XWYHsXl9tcGS26FI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xMmz1NIH59pJQvE4XDhJ3Kpk649kZPlGk9O7qg4Vuc1zWSWbssqppShAXVmmG/Hck
         oEo/vvn3AqVIwk96fgF3BLYIxapJ9KiQ5zv7Sr84cY4Wnd2RFEe87mJ18+bLKfuNM7
         I9Cam+LsrYGcHTdTyioj1bn0cagJT0JOvJ+/84aE=
Date:   Mon, 13 Jul 2020 11:15:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andy Tang <andy.tang@nxp.com>
Cc:     Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH 1/2] arm64: dts: ls1088a: add more thermal zone
 support
Message-ID: <20200713031551.GB21277@dragon>
References: <20200630032014.22956-1-andy.tang@nxp.com>
 <CAHLCerO3B4Z67KP8VaF957Jkid21gLvzhS49gNeqUC+6muPkjA@mail.gmail.com>
 <DBBPR04MB609085CD69E4CCBDD49CCF66F36F0@DBBPR04MB6090.eurprd04.prod.outlook.com>
 <CAP245DV-_+5Ht=yP9Mnzb2vUqXDJSEeBPfbNh48mEt62PmBeWA@mail.gmail.com>
 <DBBPR04MB60907EC06EAABC949DD42E3EF36F0@DBBPR04MB6090.eurprd04.prod.outlook.com>
 <CAP245DUzQBmKvg9oit8StKyfvp==eVZZ7dh0DUAwKkQnjSL_yw@mail.gmail.com>
 <DBBPR04MB6090001AA0A668A924EEB0FCF36D0@DBBPR04MB6090.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBBPR04MB6090001AA0A668A924EEB0FCF36D0@DBBPR04MB6090.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 03:33:59AM +0000, Andy Tang wrote:
> Hi Shawn,
> 
> Do you think it is ok if the cooling devices are shared between thermal zones?

Yeah, Amit has the authority on thermal support, so follow his
suggestion, I would say :)

Shawn
