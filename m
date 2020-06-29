Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1CFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93499206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="U6+PYPM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbgF2TTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:19:19 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:28427 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbgF2TTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:19:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593458344; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=XYv2wjyZ4cUXa4PLkiPA2CT1EcbjbybXQayJN+4gDCQ=;
 b=U6+PYPM0CGo4B8OXywb27wXUMPjIwCPKAjVcEesZU5MLdbG1Le0OEgKGyhC/iQrSGUCX2LYg
 yKZ0JIXEYiVqahkLlLSPlsSrsEuVWdS71tXqdIBH1LRLGYCaxbWl5DCULPL5sTEWbX52Yzrt
 lfBS2mh1Ggj0N4xAds6K73v4YKI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-west-2.postgun.com with SMTP id
 5ef9d56ff3deea03f319e92a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 29 Jun 2020 11:50:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 173B4C43395; Mon, 29 Jun 2020 11:50:07 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A66C2C433C6;
        Mon, 29 Jun 2020 11:50:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 29 Jun 2020 19:50:06 +0800
From:   cjhuang@codeaurora.org
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: Re: [PATCH] net: qrtr: free flow in __qrtr_node_release
In-Reply-To: <20200623.202629.352077396302165327.davem@davemloft.net>
References: <1592882523-12870-1-git-send-email-cjhuang@codeaurora.org>
 <20200623.202629.352077396302165327.davem@davemloft.net>
Message-ID: <f5754bde02e4026ace2ef4ca9fb8ae47@codeaurora.org>
X-Sender: cjhuang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-24 11:26, David Miller wrote:
> From: Carl Huang <cjhuang@codeaurora.org>
> Date: Tue, 23 Jun 2020 11:22:03 +0800
> 
>> @@ -168,6 +168,7 @@ static void __qrtr_node_release(struct kref *kref)
>>  	struct radix_tree_iter iter;
>>  	unsigned long flags;
>>  	void __rcu **slot;
>> +	struct qrtr_tx_flow *flow;
> 
> Please retain the reverse christmas tree ordering of local variables 
> here.

OK. Will send V2 for it.

> 
> Thanks.
