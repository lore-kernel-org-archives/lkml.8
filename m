Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6292C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B6520786
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgCXLMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:12:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35664 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgCXLMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 07:12:20 -0400
Received: from mail-pj1-f70.google.com ([209.85.216.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jGhTl-00042Q-OP
        for linux-kernel@vger.kernel.org; Tue, 24 Mar 2020 11:12:17 +0000
Received: by mail-pj1-f70.google.com with SMTP id go23so2296682pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 04:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dELJVRYxlGhu9i4AEGE2L20IBZeNNSP6rwQj75nRA8o=;
        b=V1/1r03YT8UMVqbSAGRXCJZvBvhadzRZNbQIeOIoclYiqBfPTpmzj5dM6zCZppak8I
         CZSOnvkLmMDdzh3j/J93iS85HtvMQ6h7VplpDpaZz8Fv8TQbnonJ8jstDc9TBZm5jRLs
         5TMI+Sr9UO9NpZsagwd+Z8mxfJJ5BapI13MopdEMWKhEVq4OK2aV56A9mDLzS/QmyMLo
         eUtiJN4I1QwR2NNGnZ8LlB/DwwkELY98HUl+dimy3gekTDVdBfNjYCC36b3oAf8KH1ZN
         9bboFSTya5IJWd3lTS9OxVmWrJvs7VzzDrTgJ+m5SfX2ryJWxtPkNIWRI0t99L3vLvlk
         HEdw==
X-Gm-Message-State: ANhLgQ3wxzBn98fB71NlsSQsuyt0XkiSnyJPP7QzWxp/CMCok63ycbMM
        UixbiKwS3EY6KZllaGD/3rOVrS+HlULboGOGN95WaKc3wLSB3zEIkZiEZqZPJ8UExt037GfCae0
        oDk7CRU//y8drhqI+zouhEufoYegfAscZVGt5AJJfmQ==
X-Received: by 2002:a17:902:7c93:: with SMTP id y19mr25768297pll.205.1585048336453;
        Tue, 24 Mar 2020 04:12:16 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuuc7MjGY+CwC3+ErOa9ylgdy79ZtRmDNqn9BMbHQ5gvDNiWd72hPuEejlqGyNqoohZeL72nQ==
X-Received: by 2002:a17:902:7c93:: with SMTP id y19mr25768263pll.205.1585048336044;
        Tue, 24 Mar 2020 04:12:16 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id z12sm17044363pfj.144.2020.03.24.04.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 04:12:15 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] i2c: nvidia-gpu: Handle timeout correctly in
 gpu_i2c_check_status()
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200324110930.GH1134@ninjato>
Date:   Tue, 24 Mar 2020 19:12:13 +0800
Cc:     ajayg@nvidia.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:I2C CONTROLLER DRIVER FOR NVIDIA GPU" 
        <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <9771BC92-1785-4E9A-81C7-E72C2C65CE22@canonical.com>
References: <20200311165806.12365-1-kai.heng.feng@canonical.com>
 <20200324110930.GH1134@ninjato>
To:     Wolfram Sang <wsa@the-dreams.de>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

> On Mar 24, 2020, at 19:09, Wolfram Sang <wsa@the-dreams.de> wrote:
> 
> 
>> 	} while (time_is_after_jiffies(target));
>> 
>> -	if (time_is_before_jiffies(target)) {
>> +	if (time_is_before_eq_jiffies(target)) {
> 
> While unlikely, there is a tiny race between the time_is_* calls,
> jiffies could update inbetween them.
> 
> So, for the sake of good programming practice, I'd recommend to set a
> flag in the do_while-loop and the have the logic above solely based on
> the flag.
> 

Ok, I'll send a v2 based on your suggestion.

Kai-Heng

