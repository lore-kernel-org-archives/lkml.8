Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5510AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2948620706
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="sakmImFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgHRMuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:50:15 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:34450 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbgHRMuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:50:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597755014; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=oevYdqFGLDHN5iSBw8FvMUwlcjiMNTgT96naIwWWoCU=;
 b=sakmImFt7zHJ/q4Om0tPr6NtoRM7I+mFe1FIbAPcYx176zL42zS9JZKXx164guMhP42MNKhp
 np4X7rm4O8iOulyO9BVOEzaXqzlGuMiYQFDwwv9KhGOfRFqAqXY6v0VtlHriLz+0x7Ri1ggp
 oFgt0BROw4tSxC8r2L+Lm8HTFpk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f3bce7ed48d4625ca7f6212 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Aug 2020 12:50:06
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 77FBEC433A0; Tue, 18 Aug 2020 12:50:04 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6EE5BC433CA;
        Tue, 18 Aug 2020 12:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6EE5BC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmfmac: check ndev pointer
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200802161804.6126-1-trix@redhat.com>
References: <20200802161804.6126-1-trix@redhat.com>
To:     trix@redhat.com
Cc:     arend.vanspriel@broadcom.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, chi-hsien.lin@cypress.com,
        wright.feng@cypress.com, davem@davemloft.net, kuba@kernel.org,
        rafal@milecki.pl, tklauser@distanz.ch,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200818125004.77FBEC433A0@smtp.codeaurora.org>
Date:   Tue, 18 Aug 2020 12:50:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trix@redhat.com wrote:

> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this error
> 
> brcmfmac/core.c:490:4: warning: Dereference of null pointer
>         (*ifp)->ndev->stats.rx_errors++;
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> In this block of code
> 
> 	if (ret || !(*ifp) || !(*ifp)->ndev) {
> 		if (ret != -ENODATA && *ifp)
> 			(*ifp)->ndev->stats.rx_errors++;
> 		brcmu_pkt_buf_free_skb(skb);
> 		return -ENODATA;
> 	}
> 
> (*ifp)->ndev being NULL is caught as an error
> But then it is used to report the error.
> 
> So add a check before using it.
> 
> Fixes: 91b632803ee4 ("brcmfmac: Use net_device_stats from struct net_device")
> Signed-off-by: Tom Rix <trix@redhat.com>

Patch applied to wireless-drivers-next.git, thanks.

9c9f015bc9f8 brcmfmac: check ndev pointer

-- 
https://patchwork.kernel.org/patch/11696567/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

