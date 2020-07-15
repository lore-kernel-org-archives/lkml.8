Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A24C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73EFC20656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="GCd22q1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731194AbgGOKit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 06:38:49 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:14411 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728430AbgGOKis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 06:38:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594809528; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=lmuj4L635dOFeW6CLqdMxBr0KmO6bVimi9ks4elW24c=;
 b=GCd22q1wmWv+4htaqE14bLerKNnF4bk20jdbjYydwfict/fDmumeta5atHZiS3yPoVeaIR/z
 266AJf3zn3RxsN8ZkTHP1StDdAx+aGCV46FH15cHEIQEcFE5gy6cG0RVsJsJdeYMZK8NsJEI
 CuabJK53jIdmzVAMBJau5B/6jGA=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n16.prod.us-west-2.postgun.com with SMTP id
 5f0edc972991e765cd7226d8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Jul 2020 10:38:15
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1A992C433A1; Wed, 15 Jul 2020 10:38:15 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DC775C433CA;
        Wed, 15 Jul 2020 10:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC775C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1] rtl818x_pci: use generic power management
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200623094454.12427-1-vaibhavgupta40@gmail.com>
References: <20200623094454.12427-1-vaibhavgupta40@gmail.com>
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200715103815.1A992C433A1@smtp.codeaurora.org>
Date:   Wed, 15 Jul 2020 10:38:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:

> Earlier, drivers had to manage the device's power states, and related
> operations, themselves. With the generic approach, these are done by PCI
> core.
> 
> The only driver-specific jobs, .suspend() and .resume() doing were invoking
> PCI helper functions pci_save/restore_state() and
> pci_set_power_state(). This is not recommeneded as PCI core takes care of
> that. Hence they became empty-body functions, thus define them NULL.
> 
> Compile-tested only.
> 
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

ef6425107ccc rtl818x_pci: use generic power management

-- 
https://patchwork.kernel.org/patch/11620213/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

