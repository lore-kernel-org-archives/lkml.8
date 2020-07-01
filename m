Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60DCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A51A020747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S8DlUbKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgGAJ0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbgGAJ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:26:54 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1999CC061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 02:26:54 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o2so22463827wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 02:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hUqP04YbnIwknTm25effbuWO4Fx8xD8mWeeTwAQWJ1k=;
        b=S8DlUbKMA94Ob94Q5pmfff7dxw2dHdo+tp3UfhnZZhTyJpoPTyd0j1KPNFY+KG8/WY
         s04uykNl0+C86O2unYLbmerYwfXi5J5eskUkYGmwH/dZgnXMjhqm+zjlxk3aiJmHpwl7
         NaZgMR1g92MYOG+Lg2Z2glRJzn9Sddzrmvfku/RInTTMo3eaIhv9SW8FdL2Wko7e3/QW
         Rb5I2EyHOgXzL+7bZDVSFNSXlHx1PxDCgQ7cJGPfSizPO/mZI52RUe5/YOOAzSjLMlVH
         GWgXNiUxXog0QMISs7yqGO2Sdxy9ZIBbN27cGunxxIhm5Qa8d7M+xSO2ZM/456LrcPqM
         EpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hUqP04YbnIwknTm25effbuWO4Fx8xD8mWeeTwAQWJ1k=;
        b=Crcccn8BbhllsDgrdfb/xRrDz2/KRCtVoUbGRECT2ykFC2mxvFkxDUc1LF5V2qmlvA
         KG1/AeEjUaFODp9tRnI+XHp9ry3KGFF3SkszoFC2gT93jzisgcqmMgC+xgx/kHdd7TIM
         avAU24/K6UI8HXunWu5FJ0iUpcU2MVvkXqxQzO8dKIXULcALvCY9BB0EDpsFdB73SDKF
         O/evYinRWXGbzTNAkoDm0ygHwxDr2dmyG8ZqekHkAZaLcMEhPWQhF8UIZDMM1BEPIB3d
         CyUUwgEndBtQ2UCuNh0WR1g3F7BuVRjXXnp2fGglVxJ7wmAGDFYPdKuaECkR9UgvZIYn
         yQHQ==
X-Gm-Message-State: AOAM530gf+jgJP64wsh+exw1jOXcrVD+4eihDzNYEJjJC6hHl/xsJwjf
        eqJL2katMWdfrKmjADa7iG37ZYS8qms=
X-Google-Smtp-Source: ABdhPJxh3sI68EELjTYoOdn5y3/6haBcMClOegGIqbUzYO4FQMFbIStEfUoItGSre94GqfV5Sb11oQ==
X-Received: by 2002:a05:600c:2317:: with SMTP id 23mr26569747wmo.72.1593595611735;
        Wed, 01 Jul 2020 02:26:51 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07? ([2a01:e34:ed2f:f020:54f4:a99f:ab88:bc07])
        by smtp.googlemail.com with ESMTPSA id n125sm6528524wme.30.2020.07.01.02.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 02:26:51 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] thermal: core: Remove old uapi generic netlink
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200625144509.17918-1-daniel.lezcano@linaro.org>
 <20200625144509.17918-3-daniel.lezcano@linaro.org>
 <CAP245DUMjTQr2vKirZ+FxEYWC=VQ_k+OegxQgXcKDU8ThWuCsQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0fe6837f-9b44-4578-23f2-3e4932d01122@linaro.org>
Date:   Wed, 1 Jul 2020 11:26:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAP245DUMjTQr2vKirZ+FxEYWC=VQ_k+OegxQgXcKDU8ThWuCsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2020 13:47, Amit Kucheria wrote:
> On Thu, Jun 25, 2020 at 8:15 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> In order to set the scene for the new generic netlink thermal
>> management and notifications, let remove the old dead code remaining
> 
> s/management/management api/
> 
> s/let/let's/
> 
>> in the uapi headers.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  include/linux/thermal.h      |  5 -----
>>  include/uapi/linux/thermal.h | 12 +-----------
>>  2 files changed, 1 insertion(+), 16 deletions(-)
>>
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index faf7ad031e42..fc93a6348082 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -302,11 +302,6 @@ struct thermal_zone_params {
>>         int offset;
>>  };
>>
>> -struct thermal_genl_event {
>> -       u32 orig;
>> -       enum events event;
>> -};
>> -
>>  /**
>>   * struct thermal_zone_of_device_ops - scallbacks for handling DT based zones
>>   *
>> diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
>> index 96218378dda8..22df67ed9e9c 100644
>> --- a/include/uapi/linux/thermal.h
>> +++ b/include/uapi/linux/thermal.h
>> @@ -6,21 +6,12 @@
>>
>>  /* Adding event notification support elements */
>>  #define THERMAL_GENL_FAMILY_NAME                "thermal_event"
>> -#define THERMAL_GENL_VERSION                    0x01
>> +#define THERMAL_GENL_VERSION                    0x02
> 
> This hunk should be removed since you set version back to 1 in the
> next patch and we don't actually intend to bump the version yet.

Well, I've been very strict here for git-bisecting.

I move to V2 because of the removal, but when adding the new genetlink
code, the family name changed, so we returned back to the V1 as it is a
new genetlink thermal brand.

The name is change because it is no longer event based but also sampling
and commands.

>>  #define THERMAL_GENL_MCAST_GROUP_NAME           "thermal_mc_grp"
>>
>> -/* Events supported by Thermal Netlink */
>> -enum events {
>> -       THERMAL_AUX0,
>> -       THERMAL_AUX1,
>> -       THERMAL_CRITICAL,
>> -       THERMAL_DEV_FAULT,
>> -};
>> -
>>  /* attributes of thermal_genl_family */
>>  enum {
>>         THERMAL_GENL_ATTR_UNSPEC,
>> -       THERMAL_GENL_ATTR_EVENT,
>>         __THERMAL_GENL_ATTR_MAX,
>>  };
>>  #define THERMAL_GENL_ATTR_MAX (__THERMAL_GENL_ATTR_MAX - 1)
>> @@ -28,7 +19,6 @@ enum {
>>  /* commands supported by the thermal_genl_family */
>>  enum {
>>         THERMAL_GENL_CMD_UNSPEC,
>> -       THERMAL_GENL_CMD_EVENT,
>>         __THERMAL_GENL_CMD_MAX,
>>  };
>>  #define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
>> --
>> 2.17.1
>>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
