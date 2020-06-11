Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB58C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92A2A207C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dHDdmhkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgFKLDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgFKLDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:03:07 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94566C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 04:03:06 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l10so5676451wrr.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 04:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0dfYykT4uCGlBJJlDVhKYQoGL9ipg8GyMSn2BLjnWO0=;
        b=dHDdmhkPp2Yk1Ynn0oOjWdvRSeg927sxcM/1GWaMiEK/rpMqqrnSnawoFUa2RH/ped
         c28YVS3tKiAs+cVIu1gWMxFCY9J+HIJ+M/hDi7VLzcVnRHK5w3hTMJwgWh4x+isJBubx
         yUFPym80oxSs1ilf8ooAvP4Cw8TX6eZJr3LKa+LAqNXA7KP/6V8nee1oBZiOk97HdOrc
         nZs0RXC0v5a43xo8Jj/kkVCWSZ30dE3gOz4SdbtfB2D2kbDWsS6G9Tp8+CUiWNTBJukm
         rty2OQt08EflrG4LnXn1W2TqFw2pN4ScRhKkvwO+U2WuUYuI6DyUQW3vE2SKq8om9U5C
         PgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0dfYykT4uCGlBJJlDVhKYQoGL9ipg8GyMSn2BLjnWO0=;
        b=prGYbe98TXsvIsBKfmlYpq+bgiUCraw4/X4O3ptAldarfhYLaqFmPX5dzBUQUCV4yC
         3xKca1h+npnEnZxltUsZ5sKAeTxKnbIpI3DN8YEMiF38cIX/kLMsI0SzCQZOM8CKSFA2
         FawfnpFm5A0khlNsxbmPOcmGJZqcZR2JSaPuueIH4PyD/SIqqvCKe/YLGkdQ9Ooe1gnd
         lfDmE2JobbUeUKrA2B9isFpyw0Bd+Bh04NmXArhwu7a46qECW/hbvTvveRzma8vAtrY0
         JgAKWaOl71QURBaibbHhZOzMqSsrefM/73thgWIiX9I7SGG+Aw6PmYndYdDjJhnsYiyV
         35Wg==
X-Gm-Message-State: AOAM531svS1PNW4xgpoRP+D3SlaSYIV8Xhc63YyENqpwx6kBk8Bfd0ba
        Asw6h9Ycz4lFYAoATye/fv3NuA==
X-Google-Smtp-Source: ABdhPJyYUPQUlaF05prp+rc77goBfdUqvAZpodZ0lxArUY8PBj/CCYqZh1fOjbXS6DuFscs3QIZQ3Q==
X-Received: by 2002:a5d:6cc1:: with SMTP id c1mr9281886wrc.144.1591873384987;
        Thu, 11 Jun 2020 04:03:04 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id o8sm3787787wmb.20.2020.06.11.04.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 04:03:04 -0700 (PDT)
Date:   Thu, 11 Jun 2020 12:03:01 +0100
From:   Quentin Perret <qperret@google.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        hsinyi@chromium.org, joelaf@google.com, peterz@infradead.org,
        drinkcat@chromium.org, gwendal@chromium.org,
        ctheegal@codeaurora.org, Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cros_ec_spi: Even though we're RT priority, don't bump
 cpu freq
Message-ID: <20200611110301.GA132747@google.com>
References: <20200610151818.1.I666ecd9c6f3c6405bd75831a21001b8109b6438c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610151818.1.I666ecd9c6f3c6405bd75831a21001b8109b6438c@changeid>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Wednesday 10 Jun 2020 at 15:18:43 (-0700), Douglas Anderson wrote:
> The cros_ec_spi driver is realtime priority so that it doesn't get
> preempted by other taks while it's talking to the EC but overall it
> really doesn't need lots of compute power.  Unfortunately, by default,
> the kernel assumes that all realtime tasks should cause the cpufreq to
> jump to max and burn through power to get things done as quickly as
> possible.  That's just not the correct behavior for cros_ec_spi.

Is this specific to this driver, or something you would want applied
more globally to all RT tasks in ChromeOS (which is what we'd like to
have in Android for instance)?

IOW, how do you feel about 20200511154053.7822-1-qais.yousef@arm.com ?

Otherwise, the patch looks good to me.

Thanks,
Quentin
