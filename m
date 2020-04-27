Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A3BC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D6A5206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DeHMW2ma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgD0UJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726587AbgD0UJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:09:12 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0D8C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 13:09:12 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k1so22088745wrx.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 13:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yBojgHeSyRRbf/5edynUHARWFt0QxeUjepC9RHCAMHU=;
        b=DeHMW2mat7dWXu6w6DHIDnhuWJLWFWETXXV1ZTp0no0EvE9LANYF2LsXaoJe/nTpkx
         iCEui5A2AfZITfPrdsp8JuRlnZN1AVfofmjTtOgclpFuGOd6gkuwByopjfENuPxkwL4I
         d5BcINJ+oPqf4A6Z2UjVUNSJATkcKzHKw4CueLnV+6DmPM6v+0+KY4JyMLdSNhNfSmxT
         OlPOi6Wi0Csl8SfTz+DVIpVn2lsSWv8g2hpp//9nljFxdBOhDTOGfqUpU5p2J10k8ain
         mZdIuhXlf9oVct3QVilEe4+osr1nIPUdC6ZoFOa60iOYOPZbx5pkfp94qD8K47rmAM5G
         ilkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yBojgHeSyRRbf/5edynUHARWFt0QxeUjepC9RHCAMHU=;
        b=n6xUyAWGXH+b0NHwbeyf0ehl+CFwM6hrpXOToZbXAEAXheJgFPL4iPGMa/Meq/LewR
         DeU7LzoxGUem68BB2RfBasNIi3DAE+WUbqYDAUt2jIWbCb3ZIJEnZRSqszswX0c11ok4
         P8h39klVn7MRpt+3MK8+JZ1eH+KKbtIaWYQnuP4THVhw514pN7yE/U0R+ueakeur3bZg
         NPBXOMySt8a6Wm678mK+zVpvvLx2WpuTM7ZNVZNl3SqHA6/j+XjMEmDgc6sdKD0BjBT0
         VXS4ixLsRX4qdcrURzy/zN3puseXy24IsQ5J5UroxfPuwYsAJuwBb8+sLQt1AmtwuuIU
         Wueg==
X-Gm-Message-State: AGi0PuZpdHPUj2PPqEt+s+a3YbV6zY7buA9LHrMqW8/f+HHo7v6C0zde
        kyFQXMmMj59Y0nJX6WkDG045Rg==
X-Google-Smtp-Source: APiQypKMblEi9amCpoRA+4wdErfGWCTPTXA/WRrAoBs817Vf2i6L96IT9gZSdqkAM7oM0Xa1uUXfDw==
X-Received: by 2002:adf:df82:: with SMTP id z2mr31433746wrl.58.1588018150689;
        Mon, 27 Apr 2020 13:09:10 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id n131sm322525wmf.35.2020.04.27.13.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 13:09:10 -0700 (PDT)
Subject: Re: [PATCH 1/2] drivers/clocksource/timer-of: Remove __init markings
To:     Saravana Kannan <saravanak@google.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
References: <d2934f74d77c637c41d7cb98710cb5363d09e83b.1585021186.git.baolin.wang7@gmail.com>
 <CADBw62pmiguVmuq334eskLAZ5CkrjxohW_fXNjNev+O1U15=OQ@mail.gmail.com>
 <bd800f7b-05fd-b393-fba6-1965ba89e1b3@linaro.org>
 <CAGETcx9da-U+dXA6sreTKJQiS3brYh3Hfh_qVYt06=3UOSmT_g@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <429da47b-ad51-30eb-ff36-b05780c941ba@linaro.org>
Date:   Mon, 27 Apr 2020 22:09:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx9da-U+dXA6sreTKJQiS3brYh3Hfh_qVYt06=3UOSmT_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2020 21:04, Saravana Kannan wrote:
> On Mon, Apr 27, 2020 at 10:13 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 13/04/2020 04:55, Baolin Wang wrote:
>>> Hi Daniel,
>>>
>>> On Tue, Mar 24, 2020 at 1:59 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>>>>
>>>> From: Saravana Kannan <saravanak@google.com>
>>>>
>>>> This allows timer drivers to be compiled as modules.
>>>>
>>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>>> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
>>>
>>> Do you have any comments for this patch set? Thanks.
>>
>> If my understanding is correct, this patch is part of the GKI picture
>> where hardware drivers are converted to modules.
>>
>> But do we really want to convert timer drivers to modules ?
>>
>> Is the core time framework able to support that (eg. load + unload )
> 
> So this will mainly be used for secondary timers that the system
> supports. Not for the main one that's set up during early boot for
> sched timer to work. For the primary timer during boot up, we still
> expect that to be the default ARM timer and don't want/expect that to
> be a module (it can't be).

My question is about clockevents_config_and_register() for instance, is
there a function to unregister in the core framework ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
