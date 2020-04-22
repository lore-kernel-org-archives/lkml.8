Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA886C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9788D20787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587559813;
	bh=WFKts5c9iIvh0wo38wHhgwtaKoPOd35R5D3/Tmxa4L8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S6g/eErob1qvjQEt8BplAwnkhYvN1Pzd8srPLwubfwNmzl+2jdDA52beOipYiDmhq
	 IidlPfBUyIPh9a6ag4unQ+n33g/ANuFpCxQZf7ZdnCGo1X28R99U6CwjN4pB8b+qD+
	 fOrGvlRFMqCKs9QbsGU/N7C4HYUh97mE2C+xQYAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgDVMuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:50:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbgDVMuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:50:12 -0400
Received: from localhost (unknown [171.61.101.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5092A20787;
        Wed, 22 Apr 2020 12:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587559812;
        bh=WFKts5c9iIvh0wo38wHhgwtaKoPOd35R5D3/Tmxa4L8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GHeOpYRfywSeOtn/P0/NGKnxKKVk1ygeiMXxECtprqdavHu5MWKITnUXm0IWOKh2m
         lN/bTF3UqsvtZpN1HloMT3xYcVNvwVAvqkMuKr2rYmGiKGDr31/YlfwAejsSwEfGVE
         FwnX8Bf4UOZOw0QW72NbKCrMQUpX8lkP1vdsFix0=
Date:   Wed, 22 Apr 2020 18:20:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: db845c: fix asm dai setup
Message-ID: <20200422125008.GP72691@vkoul-mobl>
References: <20200422102044.8995-1-srinivas.kandagatla@linaro.org>
 <20200422102044.8995-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422102044.8995-2-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-04-20, 11:20, Srinivas Kandagatla wrote:
> "direction" property is only valid for asm compressed dais,
> so remove it for non compressed dais

Reviewed-by: Vinod Koul <vkoul@kernel.org>
Tested-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
