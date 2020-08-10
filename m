Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E59C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F302B2065C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJItNacS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgHJUPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgHJUPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:15:32 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E35C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:15:31 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id v9so11030440ljk.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zH/zS83czE+d1+Q2jJrEPMFkS6rW0BZiw6A+vsWCpgs=;
        b=UJItNacSqkOaOzh/p4kbdlpFRFZtsHip+7I6QhfhyOihUAmwrV6NKX+DWoayeujpJP
         mfB2qOMH104EEo/iYodN9z7EV+nAwQQPBsdV7mA/gtZfVtXT3rEfwSk5hjAPEVhJnBpB
         R/jMcTnPss+RFbsJJLY9hWP4Xc1tufhEdFaOOATpW3v9FylBhF+N8/fB5LGGYn39RHOM
         HFNjiKicwh0uwdvFh1BMQRW38wPGOLEQbDHkNQHBTuI6VXPZK0GI3/kszXhTKwHZ0zxU
         7Mikw+J6BtmUe2sgTSz306ly0MfypsMX34x1glyeC4EG8+dvF1UxLnaCzfKAqYJYZgjG
         iRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zH/zS83czE+d1+Q2jJrEPMFkS6rW0BZiw6A+vsWCpgs=;
        b=Ic3JCOBj2TdFxM127a9t5MIngwrjbSANS+96ElSew5d9hFNYx9Slav8boR9HS8ZdWE
         wngXCjrMzTaaCkiIUTQaJ67p/RRmXy4pxgsZ2+du3+K0hquf8GDTh0Aa5j8Z4rOLEI34
         FHnxTldkZ5RZUbf3CfL/dHUlmuhIoaGVpSWwdo7P7DfxcQNQKyKD0APd+7a2Zn4NnQpa
         MHzpyB6Ld7ZurmfpsTxKV3wwXu0Wcq3PyHcTIXQH47lXn64NWAd5jJxrhvdlVs4OVj1Z
         NAdvh0ABEBq5KhPaXvdSwoV/hu/+jVN/CvXIUzzR4tY+Pq78EhEaSxH4+K3Xuxc05TQS
         jiYg==
X-Gm-Message-State: AOAM533D5WJuPM+j694qXICFE3O3FsF6a41z0ZMFCxcuKu3Uvufdeu21
        wtjzDDW7hUduPryiVRukP+gMdfLY
X-Google-Smtp-Source: ABdhPJxonPnM77+TfbzNVOREfw5YTXjnZmFB1pwyb7m4sCvCeOIv8LVLfkHDknKNeZD9lu/jNOdOsw==
X-Received: by 2002:a2e:990c:: with SMTP id v12mr1412040lji.449.1597090529427;
        Mon, 10 Aug 2020 13:15:29 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id h6sm11011029lfc.84.2020.08.10.13.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 13:15:28 -0700 (PDT)
Subject: Re: regulator: deadlock vs memory reclaim
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
References: <cover.1597089543.git.mirq-linux@rere.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9a5c8ca6-2027-4d89-e290-6db564b99962@gmail.com>
Date:   Mon, 10 Aug 2020 23:15:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1597089543.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.08.2020 23:09, Michał Mirosław пишет:
> At first I also thought so, but there's more. Below is a lockdep
> complaint with your patch applied. I did a similar patch and then two more
> (following) and that is still not enough (sysfs/debugfs do allocations,
> too).

Then it should be good to move the locking for init_coupling() like I
suggested and use GFP_NOWAIT for the two other cases. It all could be a
single small patch. Could you please check whether GFP_NOWAIT helps?
