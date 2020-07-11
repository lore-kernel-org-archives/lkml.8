Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9130C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 15:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98B6C207DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 15:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594482088;
	bh=QhEBZ6LDWG3Y1lgugGBg5FYc1wrjjWFWLzR00sIijlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AxJWZG4BTnPHg3xmx1OIU2q/PoPljK9FGxzu+HSjMx60BLYBrS0LH1oHAHUu0C0Ca
	 hsowj4EHD/U9XRC9hEPC5wFL/hFsm5FvNVg+RB6Gao7S9Gj3CGCyHzq5iTUhCor7cO
	 tnzDV4p79jOyWMz7GHLogquGbK/d3QJd+CTZYO0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgGKPl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 11:41:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbgGKPl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 11:41:26 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06730207D4;
        Sat, 11 Jul 2020 15:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594482086;
        bh=QhEBZ6LDWG3Y1lgugGBg5FYc1wrjjWFWLzR00sIijlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zrj/St4g7g5ojfj8wIaEXPVcdZRSzX2Ldf2nUBtpBiGwOKtLffkLmarom4HEUjGps
         maSP9r6hlLsbBrga5AnqS2J7SrcCfNn/cILH3aIfYK6gSO4T6Zb81/Ok4hHcDq70t7
         phMCxlpT/ziygEKywOoZYFCHtSr16V2Wihr+vRlY=
Date:   Sat, 11 Jul 2020 23:41:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Biwen Li <biwen.li@oss.nxp.com>
Cc:     ran.wang_1@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, Biwen Li <biwen.li@nxp.com>
Subject: Re: [v3 4/4] arm: dts: ls1021a: add ftm_alarm0 DT node
Message-ID: <20200711154121.GO21277@dragon>
References: <20200624024501.15974-1-biwen.li@oss.nxp.com>
 <20200624024501.15974-4-biwen.li@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624024501.15974-4-biwen.li@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 10:45:01AM +0800, Biwen Li wrote:
> From: Biwen Li <biwen.li@nxp.com>
> 
> The patch add ftm_alarm0 DT node
> 	- add rcpm node
> 	- add ftm_alarm0 node
> 	- aliases ftm_alarm0 as rtc1
> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>

s/arm/ARM in prefix.  I fixed it up and applied the patch.

Shawn
