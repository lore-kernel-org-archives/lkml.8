Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07F8C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96382051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oAFdRSRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbgCPQJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:09:45 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38484 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731867AbgCPQJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=a4SkyFwUTn7jLPIQJrqhF70q9YReVX9hTIk2qJVhEFY=; b=oAFdRSRyjwGA7rmlMrui7YjmX7
        6MUbLJdG8hTMakntHtFtg5dD83ME/J5rQCvdToEkBQCsbgUHM01oSHhvcYU0SwEr5m70zMTS/dx87
        rM3sKo1qthSpM89vbkiTUIthGPOAnrwswfJPqn+k23PEHmeCYS1Y3tOHFFIXn3dYmqpI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jDsJ5-00085n-Kr; Mon, 16 Mar 2020 17:09:35 +0100
Date:   Mon, 16 Mar 2020 17:09:35 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Madalin Bucur <madalin.bucur@oss.nxp.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, shawnguo@kernel.org,
        leoyang.li@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] net: fsl/fman: treat all RGMII modes in
 memac_adjust_link()
Message-ID: <20200316160935.GA30840@lunn.ch>
References: <1584360358-8092-1-git-send-email-madalin.bucur@oss.nxp.com>
 <1584360358-8092-2-git-send-email-madalin.bucur@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584360358-8092-2-git-send-email-madalin.bucur@oss.nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 02:05:56PM +0200, Madalin Bucur wrote:
> Treat all internal delay variants the same as RGMII.
> 
> Signed-off-by: Madalin Bucur <madalin.bucur@oss.nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
