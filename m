Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA4AC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1165620767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="xhhVgTq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgIAOz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:55:57 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:24688 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727058AbgIALqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:46:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598960740; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=liKI+Th2GySsbUd2xn9K1QLhy5bhTX64G88wpmW0HAU=; b=xhhVgTq+pI3cSKpgDVH120wCn8FnDeeo63wu5PEbBgPiBfqKwj24ce/S8MOykc9HWH+5orZj
 8341xsdFbGm+1rUweRubyeYfaugBeT2TDN64pK98rLr8vl/LboeRBTbrTpswpdqBtNqtBgtj
 bdNl0sfzTLPa46AQ6E5CoOhDu6k=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f4e34644f13e63f04d5fc8d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 01 Sep 2020 11:45:40
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 69988C433AD; Tue,  1 Sep 2020 11:45:39 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D073C433C9;
        Tue,  1 Sep 2020 11:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D073C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     "Bouganim\, Raz" <r-bouganim@ti.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "linuxarm\@huawei.com" <linuxarm@huawei.com>,
        "mauro.chehab\@huawei.com" <mauro.chehab@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "Hahn\, Maital" <maitalm@ti.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Tony Lindgren <tony@atomide.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Johannes Berg <johannes.berg@intel.com>,
        "Fuqian Huang" <huangfq.daxian@gmail.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH] Revert "wlcore: Adding suppoprt for IGTK key in wlcore driver"
References: <f0a2cb7ea606f1a284d4c23cbf983da2954ce9b6.1598420968.git.mchehab+huawei@kernel.org>
        <20200901093129.8A0FAC433B1@smtp.codeaurora.org>
        <49d4cdaf6aad40f591e8b2f17e09007c@ti.com>
Date:   Tue, 01 Sep 2020 14:45:33 +0300
In-Reply-To: <49d4cdaf6aad40f591e8b2f17e09007c@ti.com> (Raz Bouganim's message
        of "Tue, 1 Sep 2020 10:59:47 +0000")
Message-ID: <87k0xd67qa.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Bouganim, Raz" <r-bouganim@ti.com> writes:

> We are going to release a new FW version 8.9.0.0.83 that contains
> support with the new IGTK key.
>
> In addition, we also going to release a new patch that mandates the
> driver to work with an 8.9.0.0.83 FW version or above.
>
> We going to push it today/tomorrow.

You shouldn't break the support for old firmware, instead please
implement it so that both old and new firmware are supported at the same
time.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
