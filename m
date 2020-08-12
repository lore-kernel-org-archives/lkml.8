Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640F7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF8320786
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkvEbeAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgHLIgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 04:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgHLIgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 04:36:20 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB91C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 01:36:20 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id t10so1326393ejs.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 01:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GWBpPbEU/iJqb9l6tqby6CJl7qX3Zl21wxv1zYud858=;
        b=MkvEbeAPb5ubVtof/Jdk49xt8BXTQRhLo3IH7GhWPxeWFt3BSCuSQS7vR6EsyphPmK
         xzolBRsmyvZZ04BXBx4ppy/afj0C9iMOY5yZWoESyWIWXKF9Avji1Pi64rBVjXaGqUkG
         ZymOmojQwqfHVsHMshtAw2nZGEsx2XKdFk02lZDVf79lLmmcKwjDUHopRb0pNZGwPyK6
         G25PM+oXH0o5MqCNO46GwiM0Fhvk7S5+eXTspa1fPj1wJ9iqgmqjGtbe4WingW7xEURf
         ny5yBnvTkNnOG67SpZMMZ94pO8IGziIxHC7LYqTZVibOmS0EeJK46KCrIlrOYq0KXgWM
         jscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=GWBpPbEU/iJqb9l6tqby6CJl7qX3Zl21wxv1zYud858=;
        b=c/D1L+3sdoS8D0Z17wSyQdL/wb8e5LqmfAZCszJVgQE6FSdOnUuDs+Qtv7CXzPZwoT
         Q6rJKYbuXJXoRB2FA5Qr6HcPte/mde+axnKyGS8reG9GIAcWkx4H9RrV+bUeimm8K+Ev
         3rkQf4g4z/M9cBDwL6FcKXazEIpgHXDfRTi5YLqRqUuvNdE7XT9dHm61gGZiME79uP4M
         Zt3BuY0yA9DcVeYDRKGZAtLbYM2T2dRkcVCEPEF0anvJv1+oIW1mBdyJFKKkZDXk527k
         PfHA4RrBcCvKE5h0HlyyVUE+/5+6sgBXI7O9t+dyJq/iKkHJzGAjVjH1RKk4mMSiaLW4
         LnsQ==
X-Gm-Message-State: AOAM531I5F7w0pf7Waohjk8QAzQWLecMCQKVw5qsMAFNbGWZbXdU++w7
        pIBB4NrtYvgbE7eA8fPGQ0E=
X-Google-Smtp-Source: ABdhPJz6XwqwoQZ2sET1yeizbK5XmsWn7o3q9U/n9bqEViw6u8cZIvdEfbcYlbhzB76ATmjrRrfz1w==
X-Received: by 2002:a17:906:57ca:: with SMTP id u10mr5256932ejr.290.1597221378955;
        Wed, 12 Aug 2020 01:36:18 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id js19sm1060322ejb.76.2020.08.12.01.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 01:36:17 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] locking/rwsem: remove redundant semicolon of
 down_write_nest_lock
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20200811111852.190209-1-christian.koenig@amd.com>
 <20200812081057.GJ2674@hirez.programming.kicks-ass.net>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8356e96d-8732-0e2e-e962-dec671c19eb2@gmail.com>
Date:   Wed, 12 Aug 2020 10:36:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812081057.GJ2674@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 12.08.20 um 10:10 schrieb peterz@infradead.org:
> On Tue, Aug 11, 2020 at 01:18:52PM +0200, Christian König wrote:
>> From: Guchun Chen <guchun.chen@amd.com>
>>
>> Otherwise, braces are needed when using it.
>>
>> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
> Thanks!

Do you pick it up or can I push it through drm-misc-fixes?

If the former please let me know when it hits Linus tree since I have a 
driver which contains some extra {} because of this.

Thanks,
Christian.
