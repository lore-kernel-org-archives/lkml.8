Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592A0C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 15:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 352092075B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 15:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="PmJpXNH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgHBPLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 11:11:24 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:13707 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgHBPLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 11:11:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596381083; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=noJOmZBUfmKwC6NPBQWiGOMLzdSMwaShNzRtd8ZKtHY=;
 b=PmJpXNH5Rphpyy4X3P3pVpyPUIrfOoqsmYOINsFBhSDGqZ2drBT0n7bAMDSlaTSJCs7LEwqa
 oNvMWQNvdPvuHdqruZSUrhgWF8KqIQfv8pRfQmW7n5Bay/H73WyV+KZz1bgppm49CRBEzVhv
 lHpFV6jD9opXiqZmnj99s+wAD7Y=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5f26d79a90893260dd08e31c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 02 Aug 2020 15:11:22
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B7E15C433C6; Sun,  2 Aug 2020 15:11:21 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C32E4C433C9;
        Sun,  2 Aug 2020 15:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C32E4C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH -next] mt7601u: Convert to DEFINE_SHOW_ATTRIBUTE
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200716085749.11105-1-miaoqinglang@huawei.com>
References: <20200716085749.11105-1-miaoqinglang@huawei.com>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kubakici@wp.pl>,
        <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200802151121.B7E15C433C6@smtp.codeaurora.org>
Date:   Sun,  2 Aug 2020 15:11:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qinglang Miao <miaoqinglang@huawei.com> wrote:

> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> Acked-by: Jakub Kicinski <kubakici@wp.pl>

Fails to apply to wireless-drivers-next:

fatal: sha1 information is lacking or useless (drivers/net/wireless/mediatek/mt7601u/debugfs.c).
error: could not build fake ancestor
Applying: mt7601u: Convert to DEFINE_SHOW_ATTRIBUTE
Patch failed at 0001 mt7601u: Convert to DEFINE_SHOW_ATTRIBUTE
The copy of the patch that failed is found in: .git/rebase-apply/patch

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/patch/11666949/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

