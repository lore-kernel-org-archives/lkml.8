Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E389C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BD2E206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="b0dKLKlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbgFVOJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:09:32 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:37237 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728956AbgFVOJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:09:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592834970; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=s3NxHG85uBrThLOR8Tzl8+hTmtkXquHMs1fqhh1eQsk=; b=b0dKLKlR85MZ33dEGPVvwFshF5Z6aiWlcsz2FB5uaMwLPCW5ix2vnNmEIRBDkdjk4xY8RDEJ
 EK3Ks5bS6uqF/lUvgouMmlodJQl7yFRHha41iuWcPynqrFNUYDE6yPBlq+tuXu/40ReGYfyI
 aYQtrcIdvqeCZhhSB21+A3xJbHM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5ef0bb99e144dd5115330ae0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Jun 2020 14:09:29
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 12B47C43391; Mon, 22 Jun 2020 14:09:29 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 32DBEC433C6;
        Mon, 22 Jun 2020 14:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32DBEC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Joseph Chuang <joseph.chuang@cypress.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c:1710:40: sparse: sparse: incorrect type in initializer (different base types)
References: <202006190422.VymyEbuu%lkp@intel.com>
Date:   Mon, 22 Jun 2020 17:09:24 +0300
In-Reply-To: <202006190422.VymyEbuu%lkp@intel.com> (kernel test robot's
        message of "Fri, 19 Jun 2020 04:37:24 +0800")
Message-ID: <87a70vgpkb.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ linux-wireless

kernel test robot <lkp@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5e857ce6eae7ca21b2055cca4885545e29228fe2
> commit: 9c29da3f4e7ef9810bdfaf3d8aa5e6d2e33136f8 brcmfmac: Fix P2P
> Group Formation failure via Go-neg method
> date:   6 weeks ago
> config: riscv-randconfig-s032-20200618 (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.2-rc1-10-gc17b1b06-dirty
>         git checkout 9c29da3f4e7ef9810bdfaf3d8aa5e6d2e33136f8
>         # save the attached .config to linux build tree
>         make W=1 C=1 ARCH=riscv CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>
>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c:1710:40:
>>> sparse: sparse: incorrect type in initializer (different base
>>> types) @@ expected signed int [usertype] requested_dwell @@ got
>>> restricted __le32 [usertype] dwell_time @@
>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c:1710:40:
>>> sparse: expected signed int [usertype] requested_dwell
>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c:1710:40:
>>> sparse: got restricted __le32 [usertype] dwell_time

Joseph, please send a followup patch to fix these.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
