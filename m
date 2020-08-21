Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9433C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EC312087D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ofDn+FCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgHUJJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 05:09:10 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:49110 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727909AbgHUJJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:09:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598000949; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=b6+XrrWWJYfcTi8/ygFz7DNDATr1s72GNQa3v7qFG1o=;
 b=ofDn+FCDgCZa7TQo7ix3ulyQgHkHE/VNrGdsTtlXJglo7uhz+jf0TMYzjJP2ehWJarbbdX2w
 Eena2t/D6RKQGgE7X9Y11d6mkel96eL3z4PhRJXG6HlpOp6HnxqsMBQLMnhM/xCgf0yW0ON6
 QZoAcDivk6s+kU5e1T7Fo2y93Rk=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f3f8f35e8bbfbec10bf562d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 21 Aug 2020 09:09:09
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 679E9C4339C; Fri, 21 Aug 2020 09:09:09 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 91FEEC433CA;
        Fri, 21 Aug 2020 09:09:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 21 Aug 2020 14:39:08 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Tingwei Zhang <tingwei@codeaurora.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>, tsoni@codeaurora.org,
        Kim Phillips <kim.phillips@arm.com>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, Randy Dunlap <rdunlap@infradead.org>,
        Mian Yousaf Kaukab <ykaukab@suse.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 13/24] coresight: tmc: allow tmc to be built as a
 module
In-Reply-To: <20200821034445.967-14-tingwei@codeaurora.org>
References: <20200821034445.967-1-tingwei@codeaurora.org>
 <20200821034445.967-14-tingwei@codeaurora.org>
Message-ID: <864b3487f5fb7664f7eadf35c5238eb9@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-21 09:14, Tingwei Zhang wrote:
> From: Kim Phillips <kim.phillips@arm.com>
> 
> Allow to build coresight-tmc as a module, for ease of development.
> 
> - Kconfig becomes a tristate, to allow =m
> - append -core to source file name to allow module to
>   be called coresight-tmc by the Makefile
> - add an tmc_remove function, for module unload
> - add a MODULE_DEVICE_TABLE for autoloading on boot
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> Tested-by: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---

Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
