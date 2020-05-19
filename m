Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50838C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3083620826
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 06:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="UUFWnT71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgESGrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 02:47:23 -0400
Received: from mail1.perex.cz ([77.48.224.245]:41904 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgESGrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 02:47:22 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id CDFD4A003F;
        Tue, 19 May 2020 08:47:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz CDFD4A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1589870840; bh=pQ3wORf2jqZ8g7HnW11X9V+drcvq8Y92kOSzANz/7lE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UUFWnT71rm2ZlIIi7q0jNjd4TbRrAyPj0W4xsI3tetb06R7jeZFyaYvzgfPle9BC6
         JYIaqJpXXJ9HgcN8sW9IvvvRIfJ/AyKatNPvUaaonpo+nDbabgIWwYy+tFWuxIzSm9
         KKsEJxDDOPBg2cU1xyAmr95m/Bz0FJmSr0pz2yv4=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Tue, 19 May 2020 08:47:02 +0200 (CEST)
Subject: Re: [PATCH v2 0/5] soundwire: bus_type: add sdw_master_device support
To:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org,
        tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        mengdong.lin@intel.com, slawomir.blauciak@intel.com,
        sanyog.r.kale@intel.com, rander.wang@linux.intel.com,
        bard.liao@intel.com
References: <20200518174322.31561-1-yung-chuan.liao@linux.intel.com>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <c3817139-4a2f-57cc-94dc-efc1d0457288@perex.cz>
Date:   Tue, 19 May 2020 08:47:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518174322.31561-1-yung-chuan.liao@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 18. 05. 20 v 19:43 Bard Liao napsal(a):
> This series adds sdw master devices support.
> 
> changes in v2:
>   - Allocate sdw_master_device dynamically
>   - Use unique bus id as master id
>   - Keep checking parent devices
>   - Enable runtime_pm on Master device
> 
> Bard Liao (2):
>    soundwire: bus: add unique bus id
>    soundwire: master: add runtime pm support
> 
> Pierre-Louis Bossart (3):
>    soundwire: bus: rename sdw_bus_master_add/delete, add arguments
>    soundwire: bus_type: introduce sdw_slave_type and sdw_master_type
>    soundwire: bus_type: add sdw_master_device support
> 
>   .../driver-api/soundwire/summary.rst          |  7 +-
>   drivers/soundwire/Makefile                    |  2 +-
>   drivers/soundwire/bus.c                       | 47 ++++++++--
>   drivers/soundwire/bus.h                       |  3 +
>   drivers/soundwire/bus_type.c                  | 19 ++--
>   drivers/soundwire/intel.c                     |  9 +-
>   drivers/soundwire/master.c                    | 88 +++++++++++++++++++
>   drivers/soundwire/qcom.c                      |  7 +-
>   drivers/soundwire/slave.c                     |  8 +-
>   include/linux/soundwire/sdw.h                 | 24 ++++-
>   include/linux/soundwire/sdw_type.h            |  9 +-
>   11 files changed, 191 insertions(+), 32 deletions(-)
>   create mode 100644 drivers/soundwire/master.c
> 

The code looks really clean now. Thank you for your work.

Acked-by: Jaroslav Kysela <perex@perex.cz>


				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
