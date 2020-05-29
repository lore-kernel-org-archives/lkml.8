Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7A7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5795220C09
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="DZUMxf4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgE2RfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 13:35:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50638 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbgE2Rel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 13:34:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590773676; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=XRfNcqmO1nNRir+woQxFL8ywfhZuQljPXU7oGLs9AeQ=;
 b=DZUMxf4BAfEXBQMkOMws6tdoENZXt0viO/8wgxCgGCU/zNCextsykb0h5lwGGfkEkI8VclDb
 6tQf+/erN0bYaygrI7uhjoJPs8H8KuUNQlRk6p6Qraa+Uq8i8CpH1iAFdlwUnfSbWgoB9M/U
 +8IetBU39QEoWY2+CafykacW4xc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5ed147ac5086732481010d44 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 17:34:36
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 28C54C433CA; Fri, 29 May 2020 17:34:36 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5194AC433C6;
        Fri, 29 May 2020 17:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5194AC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wlcore: fix runtime pm imbalance in wl1271_op_suspend
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200520125724.12832-1-dinghao.liu@zju.edu.cn>
References: <20200520125724.12832-1-dinghao.liu@zju.edu.cn>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     dinghao.liu@zju.edu.cn, kjlu@umn.edu,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maital Hahn <maitalm@ti.com>,
        Fuqian Huang <huangfq.daxian@gmail.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Tony Lindgren <tony@atomide.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200529173436.28C54C433CA@smtp.codeaurora.org>
Date:   Fri, 29 May 2020 17:34:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:

> When wlcore_hw_interrupt_notify() returns an error code,
> a pairing runtime PM usage counter decrement is needed to
> keep the counter balanced.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> Acked-by: Tony Lindgren <tony@atomide.com>

Patch applied to wireless-drivers-next.git, thanks.

3e69ed2b52fd wlcore: fix runtime pm imbalance in wl1271_op_suspend

-- 
https://patchwork.kernel.org/patch/11560333/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

