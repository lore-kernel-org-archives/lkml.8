Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4C3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9FA22076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3BVzboM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgHKQ1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729062AbgHKQ1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:27:46 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFC9C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 09:27:46 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id b11so6986691lfe.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 09:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9LmA9rFbWQkoH86VdZFSJCo5e4WNOqz5t8JDTFcumMQ=;
        b=N3BVzboMgmHhJbJAysEJ4hNlJx0IieWBOcazmUWxp0246nC1V+YEcwHLqagpW8HBY8
         b1eJ3LsdM4uVe3+h28J6kKjlV+cW0f44T0FcHt9TFmmvZ4uPpT7okFNZ+jFE5tb7RmaN
         xeeXyI3Iqvi32aoYq9K+R+DqGDD3+BOSvCzSxhHrFGr+Py4NirTydpQM8i7de0o5q1v5
         qbP5/dSiBt5w5E1PfPtPTPpOACPEWiDYbY5AzzoeT/Y4IPeBm0WWdu4VC/eeNTAS60To
         yQnB02kKQd/jK5Jk2lelWy6CachFKBmyLNPQY9qjCbC8zyGsiS0QQ+BB2puXZ4o7HPjR
         boSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9LmA9rFbWQkoH86VdZFSJCo5e4WNOqz5t8JDTFcumMQ=;
        b=EVeC7tpfg0VlQ+4/U7EYLt6ONDAeiAr5QZVkSc7IK6+t/3M6biVIU4+glwIltPcaQH
         Vnyp86SA7GusVIXH/X+slKBcLI5VywC5byXrFPYJZXevga08QPUJ85jbzZ74qtfDoLN5
         ngPnGWTpo9YPk9lSwa1475QjbaBIZ/Zx/KGrwYQYpxBW74UJyhFXS030IRk1p+PNjZ/e
         qgPiXAy4iRlEoZzpKpr1uK4LmApn2AhkdWQ+fwjLyVmH8EnVhAcPjaOVQdzKyx8M+m1w
         K8XUaGhCmdAQkubgj8d8jv3m4LRclif3PD9zpweAYaodZ+nopq7yyduBD0O6I+5MuEms
         XSJw==
X-Gm-Message-State: AOAM532PStacXpJzRJ29PFMj2bCnOFdd1JAOpdCcuOhCxR+ZvHTQkgEd
        HtfI8Ct3uisn3T2hlg+GpLw=
X-Google-Smtp-Source: ABdhPJz+SX46mXyacAKzAD5/5YyMHS1fx74DPIpmKJjuFVdmNfdJzdkWO88LOSXCxKkyPJnGfoeeZA==
X-Received: by 2002:ac2:494c:: with SMTP id o12mr3537054lfi.181.1597163264720;
        Tue, 11 Aug 2020 09:27:44 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id s9sm10060301ljh.46.2020.08.11.09.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 09:27:44 -0700 (PDT)
Subject: Re: [PATCH 1/7] regulator: push allocation in
 regulator_init_coupling() outside of lock
From:   Dmitry Osipenko <digetx@gmail.com>
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>
References: <cover.1597107682.git.mirq-linux@rere.qmqm.pl>
 <b305adf8bcde9417cdd5c9d84ef5ed99541f0e2c.1597107682.git.mirq-linux@rere.qmqm.pl>
 <0d61983a-ed11-e5c1-f2c8-954e5ae330f4@gmail.com>
Message-ID: <b27219ff-6cd8-399b-5710-cb5c2d99b21f@gmail.com>
Date:   Tue, 11 Aug 2020 19:27:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0d61983a-ed11-e5c1-f2c8-954e5ae330f4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

11.08.2020 18:59, Dmitry Osipenko пишет:
> 11.08.2020 04:07, Michał Mirosław пишет:
>> Allocating memory with regulator_list_mutex held makes lockdep unhappy
>> when memory pressure makes the system do fs_reclaim on eg. eMMC using
>> a regulator. Push the lock inside regulator_init_coupling() after the
>> allocation.
> ...
> 
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> 

On the other hand, couldn't it be better to just remove taking the
list_mutex from the regulator_lock_dependent()?

I think the list_mutex is only needed to protect from supply/couple
regulator being removed during of the locking process, but maybe this is
not something we should worry about?
