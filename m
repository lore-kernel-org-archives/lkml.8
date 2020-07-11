Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB93C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 15:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A82207DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 15:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594481958;
	bh=hRvcy07A1ly37WaIhOWAp6nVfqLl6kd+hMNuAo2HY7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0gTL2fFQuOWxCjgujb5ZobNx0nLyWdx0IX+DZO5jA9OGb1xFtl3z5Bj+kQojUvbFS
	 ZNwTLTIQTxZeY1svY4SbbjWEPrhpw18DG4F/ud7NBLowh0D+7nQsn5afUTpafjw6V9
	 ooLl3/+BRYP0dXXBk0Y4MinGsr3YcZ99RpL+6Mbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgGKPjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 11:39:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbgGKPjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 11:39:16 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A584207D4;
        Sat, 11 Jul 2020 15:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594481956;
        bh=hRvcy07A1ly37WaIhOWAp6nVfqLl6kd+hMNuAo2HY7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZGq4tXO9+2gtfx7fEhDyeruZOKYB7wVTWjicUGmZ4YYI8SjZcCdRpgdWPbwymKaKg
         0aS5aRmGkrkn4sr/XRLu6OoF0rJlwS9PhxTTtcOFJ+8pWkRktXdh+28MFNpFznF0RX
         V4EMpN8VmafAD0DZ96M5NGCID7+E2m6YEB3hQHk4=
Date:   Sat, 11 Jul 2020 23:39:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Biwen Li <biwen.li@oss.nxp.com>
Cc:     ran.wang_1@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, Biwen Li <biwen.li@nxp.com>
Subject: Re: [v3 1/4] arm64: dts: lx2160a: add ftm_alarm0 DT node
Message-ID: <20200711153906.GL21277@dragon>
References: <20200624024501.15974-1-biwen.li@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624024501.15974-1-biwen.li@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 10:44:58AM +0800, Biwen Li wrote:
> From: Biwen Li <biwen.li@nxp.com>
> 
> The patch adds ftm_alarm0 DT node for Soc LX2160A
> FlexTimer1 module is used to wakeup the system in deep sleep
> 
> Signed-off-by: Biwen Li <biwen.li@nxp.com>

Applied, thanks.
