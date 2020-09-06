Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FE6C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 11:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CD362078E
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 11:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tnOC0k7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgIFLzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 07:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgIFLzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 07:55:23 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0145C061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 04:55:22 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s205so12890749lja.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 04:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xtHTNthR0VmgfzbLPEx0nhiE270M0FPD6Umo5/xXPG4=;
        b=tnOC0k7U1KRn9eGLVrtEbCqG9UPOT/iN7hezoUzPsbqBIfYoY0YVJ47AWief6avjL6
         7qVeo+Ds4JB/R0VqgTXJ6+e1TTPApkPToRswlISX0Vidfkqk4Yb6OHenqUlYuQUmW0Vn
         4rn5arEuTLBb/KHss/E4JHiYGyvyDF4sdlAZF/2IZsgBscIYIdOrzVLvflKFXUtnvWTq
         aFNHelPHki5MXX8cGR9Z2lRJUTCyPopa89moxvFjBUKI1Djc09YkaOTA/izGJRAUOqo0
         aX9rX+d80FByyY94nl1cAWT3F6+l6HINdQE5dfOAlA3fmcCVT6eYOnAmU9GrA/b4yNNU
         /Nzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xtHTNthR0VmgfzbLPEx0nhiE270M0FPD6Umo5/xXPG4=;
        b=CXvSeEr4tbdOQaCxgmOls+H9DS9spmcE7tVbqQEuQ2+LZ19m/X14obr6klae90vb9G
         Jyw/7Qc6mjPB1bj/sgr5kf5LkaSB+AmrEn/Kq6DZd0KBdTWME81rSw776J/UnDKny/b5
         rSxG6EpX5kOEn6Q89dP6ML0aSdc50xozb5U+YMgxKywMcBQBQhbn2OWZRjdNhwWfi3CK
         5Us7ZW5qtqLyqg/sJjGwRQ1Q6mqdc8MTs7PaVENh82MKa0msmZrUGGadeyZLZuhoGjcP
         0hD29gFhoK/7rZteNHAp2bNls1HpwMv4ytu0tIujl3YfL92wgmy/G2aEdEiRsjYfnd7r
         zcBQ==
X-Gm-Message-State: AOAM531BWad1Gw6HrfIG2vZfGMa62LSvMYU6SwVLnf2MlWiH54A1HvEM
        IycBorLTJD29tLxR0wa5kEIs3pwrS/4=
X-Google-Smtp-Source: ABdhPJxZ+TNvSTJUYYVVjcc87zSLz82yBfKFnEeiAUPPOlkG+Ejl0/myeAdtGcx1lCWKSDVPiiPydA==
X-Received: by 2002:a2e:a588:: with SMTP id m8mr7845010ljp.210.1599393319577;
        Sun, 06 Sep 2020 04:55:19 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id u26sm4021717ljd.47.2020.09.06.04.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 04:55:18 -0700 (PDT)
Subject: Re: [PATCH 1/3] regulator: don't require mutex for
 regulator_notifier_call_chain()
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
References: <cover.1597032945.git.mirq-linux@rere.qmqm.pl>
 <5a0da9017c69a4dbc3f9b50f44476fce80a73387.1597032945.git.mirq-linux@rere.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <df4d51cb-4a03-c460-b317-1a2bd635f1b5@gmail.com>
Date:   Sun, 6 Sep 2020 14:55:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5a0da9017c69a4dbc3f9b50f44476fce80a73387.1597032945.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.08.2020 07:33, Michał Mirosław пишет:
> Since 3801b86aa482 ("regulator: Refactor supply implementation
> to work as regular consumers") we no longer cascade notifications
> and so notifier head's built-in rwsem is enough to protect the
> notifier chain. Remove the requirement to fix one case where
> rdev->mutex might be forced to be taken recursively.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/regulator/core.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index b0662927487c..f4035167e7ba 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -4658,14 +4658,11 @@ EXPORT_SYMBOL_GPL(regulator_bulk_free);
>   * @data: callback-specific data.
>   *
>   * Called by regulator drivers to notify clients a regulator event has
> - * occurred. We also notify regulator clients downstream.
> - * Note lock must be held by caller.
> + * occurred.
>   */
>  int regulator_notifier_call_chain(struct regulator_dev *rdev,
>  				  unsigned long event, void *data)
>  {
> -	lockdep_assert_held_once(&rdev->mutex.base);
> -
>  	_notifier_call_chain(rdev, event, data);
>  	return NOTIFY_DONE;
>  
> 

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
