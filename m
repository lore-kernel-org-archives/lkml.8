Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B80C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EADF20780
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593475850;
	bh=yFS0VJadwhKck6VDo5N1DabnFiD0iq24T0FTT68BaQI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=K0J6kFR3kRIUCcfkcO5tC0UGoomX3WRsWJcHOFyaF7Rq1zcpS4YJRXRANn10Sh5s5
	 2SkZfXqexaF8hOjCMnqBagYOlRMYW+VfrDeGGqgTNOohsFYqR//Op9tLXoD2lTKrmh
	 ghUFTO3mOTGpKzV45E2o821c+w0Lh1dtf/wUVBag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgF3AKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 20:10:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgF3AKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 20:10:48 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1701820780;
        Tue, 30 Jun 2020 00:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593475848;
        bh=yFS0VJadwhKck6VDo5N1DabnFiD0iq24T0FTT68BaQI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=alcA1coVQsr2zF44KCWnETZZRs0osgtGigVDpRiyAXIpcaLxZA1WrM416Z+lzjP/G
         UchNn4pGeVK3cw8bzt3+9jdhOLA0uUyvPETsTGufDVEb+MygmmFIFtYV8aEHRauVOx
         VJG8tTSUlDvf7GKaEyFBCl1vEdOZ1q1wFKH0TP64=
Date:   Mon, 29 Jun 2020 17:10:46 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alex Elder <elder@linaro.org>
Cc:     davem@davemloft.net, evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/3] net: ipa: no checksum offload for SDM845 LAN RX
Message-ID: <20200629171046.4b3ed68c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200629212038.1153054-3-elder@linaro.org>
References: <20200629212038.1153054-1-elder@linaro.org>
        <20200629212038.1153054-3-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 16:20:37 -0500 Alex Elder wrote:
> The AP LAN RX endpoint should not have download checksum offload
> enabled.
> 
> The receive handler does properly accomodate the trailer that's
> added by the hardware, but we ignore it.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>

For this net series - would you mind adding Fixes tags to each patch?

Also checkpatch sayeth:

WARNING: 'accomodate' may be misspelled - perhaps 'accommodate'?
#10: 
The receive handler does properly accomodate the trailer that's

