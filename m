Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC29C43333
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D652070A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZ3Avk7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgCUAtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 20:49:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45595 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgCUAtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 20:49:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17so8385495ljk.12;
        Fri, 20 Mar 2020 17:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hfTzf6AkODc+KHzE3s2ZnR2MPNAojxSRMj8xOLinhFw=;
        b=uZ3Avk7smEVbod80RzW7uRr6ijNtsqyaJdy3tnFO6K5xUOHId0xQS/6taPTQAHYmV8
         twvZXk/+MpZrWG/SOHy7OfEJCkF3Hr+MY2NQ+tpsErU8711gBYwqjCV5GqPVsFwnFBQM
         BUkZPs46woWRQruYhlE/WJd6qzMKcJFbpVt6jvmqpGoDhNNAsvWNNhvE/qvS8KDTazVa
         zdJw9VNPr+HwEti4V6IHD7deRzwG14hwIbTFHaVJwGHhGraiNXSRDT20pNAPZU+QNBsL
         NAHyJsSvsKZkUtGl2Jg1R+InTgY7Fp2besemwjIrpTsPBQCTN2y05a5wZ8h0cVydVTS9
         wm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hfTzf6AkODc+KHzE3s2ZnR2MPNAojxSRMj8xOLinhFw=;
        b=ohosailRZV/fbk/tbgXlg5omuUgKRtgToatonduWG05M/LdXOl0U32/1u6LkLYtFW8
         C2N8a/28Y9zgnCmrktcFP4TP62AMurqz5/pK2O3aum1RK8C/Wp4mxuYmJS10EJ/XdM8G
         PVw/6YvH44UBv8G+2/Jf53y7v0khImrIae0clsgTbwYaeBMWtF7GQJUVpWUAXdmHjdqL
         DQNqUFkF1hfG0NHOXosYPYUyem0xaNjkPrqAgDBuoKIoQwMzvmeoKnvSU7VWiyiCWgkA
         SkQebZ9r0Z0wTJPwBuhXzxnlbYmq/OZ++XcXQ9lILTvTlpTJO8Ck3JOT7H1LkANyoLWS
         5jeg==
X-Gm-Message-State: ANhLgQ3CL4+6og79RnVw8q/Rrgj70u+L3VvJvSaow3BPS4fpOpqRoT64
        zV06UyThWxYYMlqG0uFuaygZYb+O
X-Google-Smtp-Source: ADFU+vtonjhhEKMbX+G14ChpIgBEzsZ10+qImyxwJ+S+brN4HJLsOs9NIn81D5tr8u0qJosVBYu/Vg==
X-Received: by 2002:a2e:964e:: with SMTP id z14mr7248148ljh.44.1584751791010;
        Fri, 20 Mar 2020 17:49:51 -0700 (PDT)
Received: from [192.168.2.145] (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.googlemail.com with ESMTPSA id q4sm4194078lfd.82.2020.03.20.17.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2020 17:49:50 -0700 (PDT)
Subject: Re: [PATCH v1 0/2] Support built-in Mic on Tegra boards that use
 WM8903
To:     Stephen Warren <swarren@wwwdotorg.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200320205504.30466-1-digetx@gmail.com>
 <c27c2087-14cf-614d-a8c0-05072a54f24b@wwwdotorg.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2f5c1082-2ce9-dff1-4f9f-3442a2ac51fd@gmail.com>
Date:   Sat, 21 Mar 2020 03:49:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <c27c2087-14cf-614d-a8c0-05072a54f24b@wwwdotorg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

21.03.2020 01:30, Stephen Warren пишет:
> On 3/20/20 2:55 PM, Dmitry Osipenko wrote:
>> Hello,
>>
>> This small series adds audio route for built-in microphone on NVIDIA Tegra
>> boards that use WM8903 CODEC. In particular this is needed in order to unmute
>> internal microphone on Acer A500 tablet device. I'm planning to send out the
>> device tree for the A500 for 5.8, so will be nice to get the microphone
>> sorted out. Please review and apply, thanks in advance.
> 
> It's been a long time since I looked at this code, but the series looks
> plausible,
> Acked-by: Stephen Warren <swarren@nvidia.com>

Thank you!

> (I wonder why machine->gpio_int_mic_en was already parse but never used!)

Perhaps there were plans to support it later on, but that never
materialized.
