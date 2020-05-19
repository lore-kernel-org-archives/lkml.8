Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B522AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A761206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="XGFMKMtj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgESIwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 04:52:47 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:37796 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbgESIwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 04:52:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589878365; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Z/E0ZmgxBQcE9X4XQLy1um81tXBq5a1MLjRGgd52grY=; b=XGFMKMtjMH1lGJBX7ZC/23vDF+rZhA5vu18z+7Okhn06qmjXjUwI9HXW5pw2J4gAw6ZJAHOh
 yCrNGX0e/lY/yBp5LirdipUUpjO5lfKoRE8mQ04fOxcue5W/d+QNZfTG8tGn6E8YZz84hoyG
 zvjW+EVbLZz3cx/kWBGFWRx25YQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5ec39e5661db07dc42de97a1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 19 May 2020 08:52:38
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 29AF5C432C2; Tue, 19 May 2020 08:52:38 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 65DC9C433D2;
        Tue, 19 May 2020 08:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65DC9C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Wireless <linux-wireless@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: linux-next: Signed-off-by missing for commit in the wireless-drivers-next tree
References: <20200518230311.08df60cc@canb.auug.org.au>
Date:   Tue, 19 May 2020 11:52:32 +0300
In-Reply-To: <20200518230311.08df60cc@canb.auug.org.au> (Stephen Rothwell's
        message of "Mon, 18 May 2020 23:03:11 +1000")
Message-ID: <874kscfgrz.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Commits
>
>   89829c9e65ab ("mt76: mt7663: fix DMA unmap length")
>   c0f8055b3986 ("mt76: mt7622: fix DMA unmap length")
>
> are missing a Signed-off-by from their committer.

Darn, missed that. It's quite difficult to fix this one (there's a
signed tag etc) so I'll leave it be. But I definitely need to add some
automatic checking also for s-o-b.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
