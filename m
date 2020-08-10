Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B935BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C6C207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6E7+/kr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgHJTl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbgHJTl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:41:58 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BDEC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 12:41:58 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id i10so10943132ljn.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 12:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t3MbX65KIUWMPLc7RGhWJAsNuiP2t/VlQvqq1Z62b84=;
        b=n6E7+/krC3iwvFn7bleMh855o86woO8XEPcDKwgjXoBCb29MYt2LjwOGWwb/CpckH4
         2lCuILQcT9v16oxREuJaamyc6eUhEDIYAA3tuQ0JeKjDQvBTBtU54ZNfBpRudaaq8yRK
         UO3i+pG7losqM5/AW+n924V/PatY4TY3X86ZK4/1RmbrmuwDXkPDVmvnnP1bPPXhN2yV
         Tk7HTZutCu2/Zxl/tIhNmsEdOnH0TA9mDJcz/oOElYv2bhCJ9qh2JtOMMVjSR5ZkrOTK
         NqTvHZU7hk2LQ2wfQrdOgfwkWmaVzbjGXgsX2PXJ1a8X40sQO1yggXSnKGIk7O7cEqh/
         6jBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t3MbX65KIUWMPLc7RGhWJAsNuiP2t/VlQvqq1Z62b84=;
        b=HLwvRcduhlxMkiEamGdiVePY9TCTRkinoOCkce2Lj6u4GOwwEWkjBmqcPYUhwIAjMz
         VDPcKgouewMbnEGd4deWvJqy8CYWwR1rjlx5mSr2/W6N9Ifx3jRTStOJ9O7uLJezmVDK
         jS9fHbDtpDfFBVEWAHvdN3ZcHr+i9zb7HN7ZUdez1l6yUgr/ZzL7GIkIYcbV0MYXpxjR
         ZaBKM1x7AygZvKCfLiERWqHPJ9MSaX+gHODf0m6TpSCCj78Uk/6Kskvr0i4to5cpNROV
         5DU1r/vPo9FDUVnyNAYua7pCJO4TzeO52Qc1lVudFAU32VDaCcVb7HWKd60Lu5z01xyy
         1v1g==
X-Gm-Message-State: AOAM532pWgjptExqWaIZrZpEvmlLWMJIJXx8bhYjHdWPhpOcrG8Ti9EO
        LRen71/Q9ncTNl7wBnp2j5elGjHe
X-Google-Smtp-Source: ABdhPJyJSurW/J0/w29cF+nS7qB8sWyZkwtCMHDksKyF6soWxnaF9eDYWXWyNZpVGU5XEEywE8JWEg==
X-Received: by 2002:a2e:5811:: with SMTP id m17mr1321925ljb.96.1597088516475;
        Mon, 10 Aug 2020 12:41:56 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id m64sm12006833lfd.0.2020.08.10.12.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 12:41:55 -0700 (PDT)
Subject: Re: regulator: deadlock vs memory reclaim
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
References: <20200809222537.GA5522@qmqm.qmqm.pl>
 <20200810153928.GD6438@sirena.org.uk> <20200810160936.GA1100@qmqm.qmqm.pl>
 <20200810173136.GF6438@sirena.org.uk> <20200810192547.GB26750@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <08f030a2-3a6f-3ab4-1855-3016884db79d@gmail.com>
Date:   Mon, 10 Aug 2020 22:41:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810192547.GB26750@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.08.2020 22:25, Michał Mirosław пишет:
>>>>> regulator_lock_dependent() starts by taking regulator_list_mutex, The
>>>>> same mutex covers eg. regulator initialization, including memory allocations
>>>>> that happen there. This will deadlock when you have filesystem on eg. eMMC
>>>>> (which uses a regulator to control module voltages) and you register
>>>>> a new regulator (hotplug a device?) when under memory pressure.
>>>> OK, that's very much a corner case, it only applies in the case of
>>>> coupled regulators.  The most obvious thing here would be to move the
>>>> allocations on registration out of the locked region, we really only
>>>> need this in the regulator_find_coupler() call I think.  If the
>>>> regulator isn't coupled we don't need to take the lock at all.
>>> Currently, regulator_lock_dependent() is called by eg. regulator_enable() and
>>> regulator_get_voltage(), so actually any regulator can deadlock this way.
>> The initialization cases that are the trigger are only done for coupled
>> regulators though AFAICT, otherwise we're not doing allocations with the
>> lock held and should be able to progress.
> 
> I caught a few lockdep complaints that suggest otherwise, but I'm still
> looking into that.

The problem looks obvious to me. The regulator_init_coupling() is
protected with the list_mutex, the regulator_lock_dependent() also
protected with the list_mutex. Hence if offending reclaim happens from
init_coupling(), then there is a lockup.

1. mutex_lock(&regulator_list_mutex);

2. regulator_init_coupling()

3. kzalloc()

4. reclaim ...

5. regulator_get_voltage()

6. regulator_lock_dependent()

7. mutex_lock(&regulator_list_mutex);

It should be enough just to keep the regulator_find_coupler() under
lock, or even completely remove the locking around init_coupling(). I
think it should be better to keep the find_coupler() protected.

Michał, does this fix yours problem?

--- >8 ---
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 75ff7c563c5d..513f95c6f837 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -5040,7 +5040,10 @@ static int regulator_init_coupling(struct
regulator_dev *rdev)
 	if (!of_check_coupling_data(rdev))
 		return -EPERM;

+	mutex_lock(&regulator_list_mutex);
 	rdev->coupling_desc.coupler = regulator_find_coupler(rdev);
+	mutex_unlock(&regulator_list_mutex);
+
 	if (IS_ERR(rdev->coupling_desc.coupler)) {
 		err = PTR_ERR(rdev->coupling_desc.coupler);
 		rdev_err(rdev, "failed to get coupler: %d\n", err);
@@ -5248,9 +5251,7 @@ regulator_register(const struct regulator_desc
*regulator_desc,
 	if (ret < 0)
 		goto wash;

-	mutex_lock(&regulator_list_mutex);
 	ret = regulator_init_coupling(rdev);
-	mutex_unlock(&regulator_list_mutex);
 	if (ret < 0)
 		goto wash;


--- >8 ---
