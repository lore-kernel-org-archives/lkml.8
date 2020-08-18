Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F42C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 23:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2303320738
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 23:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="BhG+YRSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgHRXBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 19:01:19 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:31597 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726985AbgHRXBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 19:01:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597791678; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=q6lRhjA9zeB4fTgQes9XK0LoNkoG62IeMO8jAUu+N58=;
 b=BhG+YRSa7gb1IHGTarGFJi8y8vo+pYW5kblcEFKdTN1JSppejL8DUjtgA4ujO0GK2A27jzeu
 XY5ULyfyYo/OJSNzJoWV0OizW07jtuvKoLlIjx+mqOHVY3c2sOr/GYdJ2+LPv0QkuUNVGITP
 LZ0T+6emx+nK7WbpXdbgV7Revcc=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f3c5daecbcd42bdee568662 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Aug 2020 23:01:02
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AA9ACC4339C; Tue, 18 Aug 2020 23:01:00 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: khsieh)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7EE0FC433C6;
        Tue, 18 Aug 2020 23:00:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 18 Aug 2020 16:00:59 -0700
From:   khsieh@codeaurora.org
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     robdclark@gmail.com, sean@poorly.run, tanmay@codeaurora.org,
        abhinavk@codeaurora.org, aravindh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v3] drm/msm/dp: Add DP compliance tests on Snapdragon
 Chipsets
In-Reply-To: <159778797494.334488.5009772006048435758@swboyd.mtv.corp.google.com>
References: <20200818211546.559-1-khsieh@codeaurora.org>
 <159778797494.334488.5009772006048435758@swboyd.mtv.corp.google.com>
Message-ID: <ee1ad6b96a0d8be83abda0cb1b3ebc59@codeaurora.org>
X-Sender: khsieh@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-18 14:59, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2020-08-18 14:15:46)
>> add event thread to execute events serially from event queue. Also
>> timeout mode is supported  which allow an event be deferred to be
>> executed at later time. Both link and phy compliant tests had been
>> done successfully.
>> 
>> Changes in v2:
>> - Fix potential deadlock by removing redundant connect_mutex
>> - Check and enable link clock during modeset
>> - Drop unused code and fix function prototypes.
>> - set sink power to normal operation state (D0) before DPCD read
>> 
>> Changes in v3:
>> - push idle pattern at main link before timing generator off
>> - add timeout handles for both connect and disconnect
>> 
>> This patch depends-on following series:
>> https://lkml.kernel.org/lkml/20200812044223.19279-1-tanmay@codeaurora.org/t.atom
> 
> There's a v11 of this series. Can you rebase again?
> 
>> 
>> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
>> Signed-off-by: Guenter Roeck <groeck@chromium.org>
>> Signed-off-by: Tanmay Shah <tanmay@codeaurora.org>
> 
> And fix this SoB chain to be proper with Co-developed-by tags and your
> tag coming last as you're the sender of the patch.
Tanmay and Guenter signed-off were added by mistake. I will remove them
