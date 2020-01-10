Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E25AC33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5D320842
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 13:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="CiTatVn+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgAJNQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 08:16:27 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:51131 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727398AbgAJNQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 08:16:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578662185; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: From: Sender;
 bh=i+FSacw/oKHPosASdYmNACUkHU9zjbv90HutOF8oZS0=; b=CiTatVn+nwJ3IpFyd/mbdSAYYTe5IyAv5zAOs2LFg0n6IuQc/ms7WAO/QTKvxcPX+LxM7jaU
 BPgqCHUDPAps1Ot+VwmD+yYWd/PEyhCaLanPf57GpgmjPlH1UHqjrrW3Dupk2Pvg0xmbgLtw
 EACm9PbahxBUTslCzmVwuxW6hRA=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e187928.7f556634fa08-smtp-out-n03;
 Fri, 10 Jan 2020 13:16:24 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 49E1EC447A5; Fri, 10 Jan 2020 13:16:24 +0000 (UTC)
Received: from x230.qca.qualcomm.com (unknown [83.145.195.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8EFE4C447A4;
        Fri, 10 Jan 2020 13:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8EFE4C447A4
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: fix build warnings with format string
References: <20200106171452.201c3b4c@canb.auug.org.au>
        <1578322389-13716-1-git-send-email-akinobu.mita@gmail.com>
nTo:    Akinobu Mita <akinobu.mita@gmail.com>
Date:   Fri, 10 Jan 2020 15:16:18 +0200
In-Reply-To: <1578322389-13716-1-git-send-email-akinobu.mita@gmail.com>
        (Akinobu Mita's message of "Mon, 6 Jan 2020 23:53:09 +0900")
Message-ID: <87muavsb8d.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(please cc linux-wireless on all wireless patches)

Akinobu Mita <akinobu.mita@gmail.com> writes:

> This fixes build warnings introduced by commit "iwlegacy: use
> <linux/units.h> helpers" (iwlegacy-use-linux-unitsh-helpers.patch in -mm)
>
> The format '%d' has to be changed to '%ld' because the return type of
> kelvin_to_celsius() is 'long'.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Link: https://lore.kernel.org/r/20200106171452.201c3b4c@canb.auug.org.au
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: Stanislaw Gruszka <stf_xl@wp.pl>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

I don't know what's Andrew's workflow, but shouldn't the original patch
be fixed instead?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
