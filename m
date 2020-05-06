Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811E0C47254
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 00:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B7820721
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 00:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="sZ9fySB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbgEFAeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 20:34:09 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:28644 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728512AbgEFAeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 20:34:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588725248; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=z/jABXqPP5ZITSWE+wzLng9/Rfx9IcUqoPAPBImRD0I=; b=sZ9fySB++ZPWByTLSzuFMi2RuITUgArKaN4uliD/Bl6gIpZAlX7/nFQvYZeeEJOGA61Lunzi
 kOSpYLM8EuFmkay6Xs57uOATDKpvtcZ59WGO19GJSdsr9MbSbAUytGpheB0KO70k2t9kwxUK
 AXmUBnb3TcfAJPau2Vi8oNFrPMM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb205f3.7f853363cdf8-smtp-out-n03;
 Wed, 06 May 2020 00:33:55 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BFB32C432C2; Wed,  6 May 2020 00:33:54 +0000 (UTC)
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E0914C433D2;
        Wed,  6 May 2020 00:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0914C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v6 8/8] bus: mhi: core: Ensure non-zero session or
 sequence ID values are used
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>, mani@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantk@codeaurora.org
References: <1588718832-4891-1-git-send-email-bbhatt@codeaurora.org>
 <1588718832-4891-9-git-send-email-bbhatt@codeaurora.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <f0079ae7-869c-90ee-1645-115e1d9066d9@codeaurora.org>
Date:   Tue, 5 May 2020 18:33:52 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588718832-4891-9-git-send-email-bbhatt@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/2020 4:47 PM, Bhaumik Bhatt wrote:
> While writing any sequence or session identifiers, it is possible that
> the host could write a zero value, whereas only non-zero values should
> be supported writes to those registers. Ensure that the host does not
> write a non-zero value for them and also log them in debug messages.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> ---

Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>

-- 
Jeffrey Hugo
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
