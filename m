Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B58C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC07207DE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaiKCfdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbgIHQzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:55:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23205 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731968AbgIHQsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599583682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kk/MzQpl2YW+BRjUs+jKB6CtH3juIQy3EW0uS3+0BVs=;
        b=FaiKCfdB8+U66neeWsffP/LUV0GoQtx+Cy1IXNrbabf5j2Ukf6E+ySYzCTCgbItvaCgN+7
        T8BEIHHxpjZDN/IVIejmPgJSLMH2fSCnk9XL6QqStg05DQQTcALlN0y3ipFKHy/FKYvqVo
        l8y8MA2HTwN/4Uv+VVYEh5yHNXm5VU8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-XRUQI1pMNHuYOvpsHNAFYQ-1; Tue, 08 Sep 2020 09:20:27 -0400
X-MC-Unique: XRUQI1pMNHuYOvpsHNAFYQ-1
Received: by mail-ej1-f72.google.com with SMTP id gt18so6654466ejb.16
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 06:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kk/MzQpl2YW+BRjUs+jKB6CtH3juIQy3EW0uS3+0BVs=;
        b=CFtshIBx7OlaLgWfa+KTC9t1a1xZbwIYF2VdwYt53sgBMw0+A24LRHfYODryzZdJ1J
         4JkyivphuW5tnav7Mo2/+ZQLfOfROEC71W33iysIFHTTLb95V99CmpzhnYrsjGPYnwtn
         0cQnUN5x63iDEoYhWY6pNPp4Z1mPRuTaWffeG5tM2bO+WwktqLDw7pE3SFa1ZXotDp6B
         Q8h4mejz1HwZgYFf6vfNEn8tEwwrN4LuHxrSgM2F6Zk/v1XMD70DE4qkpdbA+WIN9UWN
         Wghv3KpHaaSCO+5EG88wtYRn/tr6MGKJ0spd7bCkuF+qXoyX1jWmaYZA8oyo1mS5ckJ8
         eUTw==
X-Gm-Message-State: AOAM530a6KpPVaexSdIrWzc7di/0M/kHEA+6aKas4PDIBDGLGFjIPOwM
        OF+WywL2UEqBWluuDw2RuH8CsQ3XoPnsCJiiUKShZXa1OvpPc2QbymHg+s0c2s/uoJqdT0csQMc
        Kvd30Y9K05mN4/rl7dYaGf2p6
X-Received: by 2002:aa7:d697:: with SMTP id d23mr27729557edr.13.1599571225564;
        Tue, 08 Sep 2020 06:20:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJSCXKpUVVYMUY6y6pGIlWBQF6oylam73BShkdtH0Ngf5e1fkNihiTDrhP7Zi2Gs3qSlHKgQ==
X-Received: by 2002:aa7:d697:: with SMTP id d23mr27729530edr.13.1599571225337;
        Tue, 08 Sep 2020 06:20:25 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id n11sm14190638ejs.38.2020.09.08.06.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 06:20:24 -0700 (PDT)
Subject: Re: linux-next: manual merge of the drm-intel tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200908140022.67dd3801@canb.auug.org.au>
 <db369f50-a3a0-2504-0628-ce5e6780d31b@redhat.com>
 <20200908210449.1a4f8e52@canb.auug.org.au>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d5c2cb83-8fc0-069e-7d4b-64a8ecf9a6b4@redhat.com>
Date:   Tue, 8 Sep 2020 15:20:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908210449.1a4f8e52@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/8/20 1:04 PM, Stephen Rothwell wrote:
> Hi Hans,
> 
> On Tue, 8 Sep 2020 10:22:06 +0200 Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> On 9/8/20 6:00 AM, Stephen Rothwell wrote:
>>>
>>> Today's linux-next merge of the drm-intel tree got a conflict in:
>>>
>>>     drivers/gpu/drm/i915/display/intel_panel.c
>>>
>>> between commit:
>>>
>>>     f8bd54d21904 ("drm/i915: panel: Use atomic PWM API for devs with an external PWM controller")
> 
> This should have been
> 
>    899c537c25f9 ("drm/i915: Use 64-bit division macro")

Yes that makes more sense.

>>> from Linus' tree and commit:
>>>
>>>     6b51e7d23aa8 ("drm/i915: panel: Honor the VBT PWM frequency for devs with an external PWM controller")
>>
>> That doesn't sound correct, those are both commits from the drm-intel tree.
>>
>>> from the drm-intel tree.
>>>
>>> I fixed it up (I just used the latter)
>>
>> Just taking the drivers/gpu/drm/i915/display/intel_panel.c contents of:
>>
>> f8bd54d21904 ("drm/i915: panel: Use atomic PWM API for devs with an external PWM controller")
>>
>> Is the right thing to do, the problem is a difference in a line which gets
>> removed in that commit.
> 
> Which is what I actually did, I guess :-)

Yes, looks good.

> Sorry about that.

No problem and thank you for all the work you do on -next.

Regards,

Hans

