Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAD4C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFCE120719
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNQ6YQYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgIJFei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 01:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgIJFeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 01:34:05 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3759CC061573;
        Wed,  9 Sep 2020 22:34:01 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o16so2464769pjr.2;
        Wed, 09 Sep 2020 22:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uGUkLkekDDrHHyjl9V1yaazxeNg3zJrmb/AGpekFVEU=;
        b=LNQ6YQYlGzUoEEn59bhxCAzN0bbl0RH3ljxUlRnh8MvIkfpOCRQN5XEMH/xRYA+JQI
         MbwO0s/RiAvGlJAmzsU1/Gjve4jRbyiPhjQAWj9i4i/+Tvvx5X/w8AlSz7PInXV10Tp6
         RIBT1pgKtAf+7vUT/N9a5+AEeTfUQA4RlqbAwwPX3tTWSDo7nEsF3KpKEhrY/zd7QXmm
         uvFkOh3Ej6tRjlIsLSbuGw+chSIIhXReaHOszaTXvv2CoRZZR/Tjn5oK4qThg9++DAeG
         0ahQ5J9HSH/14/4AARusqV25omLbV4GjHBlX7ZAPXnquQn3XpSSmRF/xrx7O1YvKiJyA
         VLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uGUkLkekDDrHHyjl9V1yaazxeNg3zJrmb/AGpekFVEU=;
        b=Zba0qlF5d6EEdeMb9e0Mo5fU1uxCzyfDPWbQ+o9kszE7+y1AKyoldQmj6rDSVoAAcs
         eYyGHP2tFuog/lmhCKE9e++NXtD1ZwWSYGeDXRkEjXQyL1dBKSblmXgPxwpo6e3yRPcE
         C/zp4Uq/KV0lHkehyvKlw3kOiBW3ywQtJZIrePi/zWn5Qv0O253c8VUtq8JfFTSeDcV9
         ivEjjjcL7dzLH6xYXY/SaBkVS9ZH432S2Z9qALhlhZN9qLFj6gHLoOZCnQcn7teaZRJL
         huPy5k11qM6ys0K9D7k+EuY2dXNGWdHfNkLVdTe7rQZXsqdR8Ylc77QHuKAHZYaE1jqo
         azBQ==
X-Gm-Message-State: AOAM532nyBz+iuBYR7rduvB2ipnNkmf8N5zSmXYJHJbCgpV90NOUzyFZ
        4qDah40n2LZRORpcF1VIM3Q=
X-Google-Smtp-Source: ABdhPJyA4kPg48qb2udCMYHl4sXWhpEBoJK9wBIXp40zG7zp6AGgM9d0QvaM0WisgbU+c02gkQNkMg==
X-Received: by 2002:a17:902:bc81:: with SMTP id bb1mr4107803plb.105.1599716040593;
        Wed, 09 Sep 2020 22:34:00 -0700 (PDT)
Received: from [192.168.1.5] ([61.7.133.45])
        by smtp.googlemail.com with ESMTPSA id j26sm4453002pfa.160.2020.09.09.22.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 22:34:00 -0700 (PDT)
Subject: Re: [PATCH v2] usb: serial: Repair FTDI FT232R bricked eeprom
To:     Oliver Neukum <oneukum@suse.de>,
        James Hilliard <james.hilliard1@gmail.com>,
        linux-usb@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Russ Dill <Russ.Dill@gmail.com>,
        Hector Martin <hector@marcansoft.com>
References: <20200909193419.2006744-1-james.hilliard1@gmail.com>
 <1599706954.10822.3.camel@suse.de>
From:   Lars Melin <larsm17@gmail.com>
Message-ID: <a1161f77-5b37-39ea-eb91-7b0b59278960@gmail.com>
Date:   Thu, 10 Sep 2020 12:33:55 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1599706954.10822.3.camel@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/2020 10:02, Oliver Neukum wrote:
> Am Mittwoch, den 09.09.2020, 13:34 -0600 schrieb James Hilliard:
>> This patch detects and reverses the effects of the malicious FTDI
>> Windows driver version 2.12.00(FTDIgate).
> 
> Hi,
> 
> this raises questions.
> Should we do this unconditionally without asking?
> Does this belong into kernel space?
> 

My answer to both of those question is a strong NO.

The patch author tries to justify the patch with egoistical arguments 
(easier for him and his customers) without thinking of all other users 
of memory constrained embedded hardware that doesn't need the patch code 
but have to carry it.

The bricked PID is btw already supported by the linux ftdi driver so 
there is no functionality gain in the patch.

br
Lars



