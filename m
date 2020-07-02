Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC31C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72470208FE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skU5G1aD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgGBSvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgGBSvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 14:51:46 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98132C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 11:51:46 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bf7so2330005plb.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 11:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SzSS54e5bq1IFnXIIvO4DspIsZygQN1CJ03qjOV/T6I=;
        b=skU5G1aDBzVI2snI8XGozUM7qQgxSd7izAiIeccwo4I7Feqpn4pyqzAVSPUer3Hh9K
         ffAmWdo8GyUfJFsyP7cmkrrW7M1e2X+hUKPGrnAkFg8CAwC3gT9CSfTzHwSq1GKySJ0O
         vFMwTAdHDlGmu9ueRb4d+g+TqMhxaReiZkJXYFYUvAL8Wdi0Yo/sBMtddDC+7T/rWfA2
         v6wFmnA0WemapDZdoTwgnXs7cjFEKDjTyh8NYs6ojyToUh8XP0qfpYb4CGnspQG4EMLC
         qQje0LZHREcJ+w1lmTu1ZmCByBBdJDSai4Ig8RmibzE7Yi9BlTY+AZAZR5uijxh5Kaj8
         0fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SzSS54e5bq1IFnXIIvO4DspIsZygQN1CJ03qjOV/T6I=;
        b=nwXLn6XKMZn4Dn/vLlGE2ni3uri6WZK8fN6/qB00kpaM3GYLMFQRxYjBbUZCe2jWo1
         GxZginUUCpS8rBQpemY6JwwiFW0UZPzXGakM76UymE+zAaJOedtZFpn8Sz9nLGE9chRH
         dRxaZcL15nFKUrW02CfbctBXiOWyu2eY5mfziPZGnk3V7pbDqLW9cMxzhziMCIbcKyWO
         8OjH0bJeUY1FmJ0wcmoEk7mQlmnwsC1F6FzBtuEDU5ZTWGuxbg1iXSn6umB7JsOqssHw
         Pt7b2VNvgOIkvcg0I1Tx8aHY4uvcj9d08LAqO2iSJ8uSpygZLyF4ufDZ12WOzvdlQEYY
         557A==
X-Gm-Message-State: AOAM533Fu+dft455MXxX8pqaO+oV01Sg1GW1dJqn9LfkuwERIl7LEOH8
        r0IE+BaU941Jb1fWfrwt504=
X-Google-Smtp-Source: ABdhPJwafFGUWpt7uEzkYfqLdRUfoFvIEPIx2vTSqVn++JfBTlcWmD7vrAtYfcS3N6QfDZ/QQ/XpWg==
X-Received: by 2002:a17:90a:dc09:: with SMTP id i9mr34272574pjv.122.1593715905957;
        Thu, 02 Jul 2020 11:51:45 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id s10sm8949429pjl.41.2020.07.02.11.51.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 11:51:45 -0700 (PDT)
Date:   Thu, 2 Jul 2020 11:51:41 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "open list:FREESCALE SOC SOUND DRIVERS" 
        <linuxppc-dev@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] ASoC: fsl: fsl_asrc: fix kernel-doc
Message-ID: <20200702185141.GF23935@Asurada-Nvidia>
References: <20200702172227.164474-1-pierre-louis.bossart@linux.intel.com>
 <20200702172227.164474-6-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702172227.164474-6-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 12:22:26PM -0500, Pierre-Louis Bossart wrote:
> Fix W=1 warnings. fix kernel doc and describe arguments.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
