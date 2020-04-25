Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF186C55191
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 01:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 846D9208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 01:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587777434;
	bh=Idxg/CHEHUX2quDQvmQ+IGIQKvLPhn0rX68vGxJyrw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nrx78LocmvD6N7CK3r5uA0mugbZIETzPEC99gyv6Lk4wwU8J/6hJfhjRQMGXZfcVJ
	 bAxkHX8j4+7s415UqPAwc3lM0zE6I567DXu9L9TeYR/vzUCjGEe2rj97W3z+qWRXML
	 C3nJrGfOlr8rAsfuFJATPwYYDIbqdoimQ1SnrCik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDYBRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 21:17:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbgDYBRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 21:17:13 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B82C20748;
        Sat, 25 Apr 2020 01:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587777433;
        bh=Idxg/CHEHUX2quDQvmQ+IGIQKvLPhn0rX68vGxJyrw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XlAu9bwuvMSQG4JuLn1X8jL6UJRZDrw9tWe/0xx0vmqnQV3ONcIAMpivkKQrLJBtB
         BwU01mYtdMYrRpZfUvVBdSaw20rdXdqkhC6zSdlTpgQEUFqLPGTzwFCXPqRIjGQwRB
         sDvHq3PAPq+7bgwiWKYjJOFXs3Jl0L+nJGEofrCk=
Date:   Sat, 25 Apr 2020 09:16:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ashish Kumar <Ashish.kumar@nxp.com>
Subject: Re: [PATCH] arm64: dts: ls1012a: Add QSPI node properties
Message-ID: <20200425011642.GJ8571@dragon>
References: <1585566991-24049-1-git-send-email-kuldeep.singh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585566991-24049-1-git-send-email-kuldeep.singh@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 04:46:30PM +0530, Kuldeep Singh wrote:
> Add support for QSPI on NXP layerscape LS1012A-RDB, LS1012A-QDS,
> LS1012A-FRDM and LS1012A-FRWY boards.
> 
> LS1012A-RDB has 2 Spansion "s25fs512s" flashes of size 64M each and only
> one can be accessed at a time.
> LS1012A-QDS/FRDM has 1 spansion "s25fs512s" flash of size 64M.
> LS1012A-FRWY has one winbond "w25q16dw" flash of size 2M.
> 
> Use generic compatibles as "jedec,spi-nor" for automatic detection of
> flash. Configure RX and TX buswidth values as 2 as only two I/O lines are
> available for data transfer.
> 
> Add ls1012a(si) node alongwith flash nodes.
> 
> Signed-off-by: Ashish Kumar <Ashish.kumar@nxp.com>
> Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>

Applied both, thanks.
