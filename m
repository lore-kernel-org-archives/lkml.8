Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4FAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9AC3221E2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598431603;
	bh=HoUnL2q1WxrGMZkSItOoLBcbNE9id2blFCNhr5ujsSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zFShDxx2Yyf03Q9oJoP4r+uAybAhEvKpPklLChqSJNYq+BPz2Jm8Or8KMjZ/QeU2d
	 hjV7Wwu2yFEbJTT0kWkzN8h7no7uFKpAiZkDknOUUaKwp+GIMsXMwBrPFvVQcu9awh
	 XvzzQIYo2pyK6W7KZ2B54RQTQx+9oCy1FSpYhNK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgHZIql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:46:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbgHZIqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:46:40 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33F552071E;
        Wed, 26 Aug 2020 08:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598431600;
        bh=HoUnL2q1WxrGMZkSItOoLBcbNE9id2blFCNhr5ujsSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dih5vfgd2MSYnjNKJIwqN2EcDZjiYbs4WmUSide/Pmx/pPy68SGTT5MpMvQ2wpIqw
         TISsDTMzie7mChKUidct21AZ1AMPSbh/sYoup4B07jNaMmQhG5QvGAQx436EGER4yw
         DnqW7haaYdXOpEL3cHpWNavOYSSeRzpJojzVu8fQ=
Date:   Wed, 26 Aug 2020 14:16:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH v2] soundwire: intel: fix intel_suspend/resume defined
 but not used warning
Message-ID: <20200826084635.GX2639@vkoul-mobl>
References: <20200824133234.28115-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200824133234.28115-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-08-20, 21:32, Bard Liao wrote:
> When CONFIG_PM_SLEEP is not defined, GCC throws compilation warnings:
> 
> drivers/soundwire/intel.c:1799:12: warning: ‘intel_resume’ defined but not
> used [-Wunused-function]
>  static int intel_resume(struct device *dev)
>             ^~~~~~~~~~~~
> drivers/soundwire/intel.c:1683:12: warning: ‘intel_suspend’ defined but not
> used [-Wunused-function]
>  static int intel_suspend(struct device *dev)
>             ^~~~~~~~~~~~~
> 
> Fix by using __maybe_unused macro.

Applied, thanks

-- 
~Vinod
