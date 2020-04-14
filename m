Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304D3C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B2C52064A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1bVuonv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbgDNN0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:26:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38584 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2502881AbgDNNQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586870160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fkgBK9xnpU8Tu3dZHUSNLZnfPluOMQrIKm9bQ1t2jqg=;
        b=b1bVuonvr/JIGfQWurak0N3bHyZbH0acpd9wXv+CNFWCJZJPKg/hlXurOlwv3zCUx67pit
        acvjmOhpVraFX8qwFvcms2vy0VaNrdazzWYMrZapfUnE4JD3/j+9p6N2l5EYypsm6cLQlp
        YJYLAWsl37vVxpyJOCpybFr6SWse2PA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-YWaPvv61PlOyaXj1ZubTnQ-1; Tue, 14 Apr 2020 09:15:57 -0400
X-MC-Unique: YWaPvv61PlOyaXj1ZubTnQ-1
Received: by mail-wr1-f69.google.com with SMTP id 11so2339384wrc.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 06:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fkgBK9xnpU8Tu3dZHUSNLZnfPluOMQrIKm9bQ1t2jqg=;
        b=W7SOP7wnsaEblldROoIKHtf6JnOkEWJPLI2tuS4VbtJHV4RwzKM5h84hbRbUIBQahH
         nZgqmbKFx29yI7LrunFmeElFJQms/W6HQVItPNbgVIfqKdfeDmJXetDq0Dy2hPKWGkJH
         Sb2LpZy8OugqQ1s4zhhWKUzxiQF8fE/vwhSLMBqvt7uEcNcMT02poZfxsJ+WqwyFviaX
         43IlEXeUJnRKBxEPWirhPvHHUctI/a5Ty3M+xSEDJmzG3DUgAkVpvmO2TBLm0YYsdK9/
         nRUrM9mHu79/RYDv6dXdf1d610jkb8VHmsq82kbGQpBdn+XYiMvX8MLACB5qp2ljqZDg
         5g7g==
X-Gm-Message-State: AGi0PubZTJE2xvJNJwagDx7oU3OLaJ356/UGw5o2vui51Ok3tAzYIaZ+
        9lhR7aNT9JlSgLzVfC2zpU4WiwOrEdoIRhJwIwSnXlpmsMy1grDhPTekK3V0Z9EB5oOq7VaOGWh
        8nmP2i7OfE1Li9DwOkmQFMj+Q
X-Received: by 2002:a5d:6145:: with SMTP id y5mr3671372wrt.126.1586870155645;
        Tue, 14 Apr 2020 06:15:55 -0700 (PDT)
X-Google-Smtp-Source: APiQypIYnGXCmimjktgJ31Rsn05nuM82C4sRRSEJSiXVM+BE/3APQErQB0fwpedAZZG7kleviTPIyA==
X-Received: by 2002:a5d:6145:: with SMTP id y5mr3671335wrt.126.1586870155233;
        Tue, 14 Apr 2020 06:15:55 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id y15sm19420635wro.68.2020.04.14.06.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 06:15:54 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: intel_int0002_vgpio: Only bind to the
 INT0002 dev when using s2idle
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxim Mikityanskiy <maxtram95@gmail.com>,
        "5 . 3+" <stable@vger.kernel.org>
References: <20200407213058.62870-1-hdegoede@redhat.com>
 <cfd3171a-94fb-7382-28e1-a236cb6759cc@redhat.com>
 <CAHp75VdqQnHbMSSeoDESMgywH-1VxBTT=Uo_GLV1aycmg=MXtA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <32d57d33-5278-aead-1545-fac1ab936fbd@redhat.com>
Date:   Tue, 14 Apr 2020 15:15:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdqQnHbMSSeoDESMgywH-1VxBTT=Uo_GLV1aycmg=MXtA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/8/20 12:26 AM, Andy Shevchenko wrote:
> On Wed, Apr 8, 2020 at 1:24 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi all,
>>
>> I just realized that I should have added a cover letter to this
>> patch to discuss how to merge it.
>>
>> Rafael has already queued up the
>> "[PATCH v3 2/2] platform/x86: intel_int0002_vgpio: Use acpi_register_wakeup_handler()"
>> in his tree. Looking at both patches the parts of the file the
>> touch are different enough that that should not be a problem though.
>>
>> So I guess this can go through platform/x86 as usual, or
>> (assuming everyone is ok with the change itself) alternatively
>> Rafael can take it to make sure there will be no conflicts?
> 
> You will need different patches for v5.7 and the rest.
> In v5.7 new CPU macros are in use.

I see, I will send out a v2 rebased on top of 5.7-rc1.

Regards,

Hans

