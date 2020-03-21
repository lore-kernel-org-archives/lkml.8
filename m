Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB7CC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B5420722
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBUbOceT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgCUPJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:09:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26491 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727033AbgCUPJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584803390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MSU1xW5N48oria5FxYWPX9oN00WI/dUeeRc525ODbVI=;
        b=dBUbOceTLngiCbgaP/LmI8ldQR5xgdlCQO0g+01GCKBo2KsCAb3V5Wg1iXwHG3VrftWsEI
        QzjEov47z9Z/WWllh4TQMa+946xyjLWjgtLkM6JK7c1Klr58ZXxkkFWH+ptYqy+mMRpsJK
        2zFTwkmP15sZDAJVIoy4ShzPoFNHL7w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-elMpNYzHOR2tniNT-ouXgA-1; Sat, 21 Mar 2020 11:09:48 -0400
X-MC-Unique: elMpNYzHOR2tniNT-ouXgA-1
Received: by mail-wr1-f70.google.com with SMTP id d17so4370091wrs.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 08:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MSU1xW5N48oria5FxYWPX9oN00WI/dUeeRc525ODbVI=;
        b=DKgc+x9U0ohGaI7LHyCvhlUU2m4JUnxp3c0UzO6iGzBfhlH+zCa8a567cMgrHgjGYH
         aNfLwYjzJ/j1weV6QTOrEfWqYoQspIIiUrUxP44CUu1wdvgUOYtF5saSCjIlQeGmRphS
         FLpBLLtMPt+g+UxisXdv5KFXBfg0o5Ct8WdS++snIhQeWZBBQrbRn4NpYFGBf+X2G9Nt
         D88+ZQrm9cp1N0aMEE6JTPuDB+416ol4vQ/aG5YcMSmTiZAsMU6ch59bAcWQ4G4gC5IV
         Yo8e9GDdL5wAmuiYwXpzmjqip4uXaZ6sixgIgaqFtg2BwdjUNybmBxcmwelrT3MIp9zn
         f8aQ==
X-Gm-Message-State: ANhLgQ1WuJtRj8fZUg0aivqnnAC6p41THQRmf1VxuUULeEjqAW9/caXp
        suXylLthPtQHilfHFDod5l+KjsapG0jmnycKcwx7mWlO1RFNQPELJmzW+cq1b+Gpras+xSWqm30
        kRbvrd+40MIkL2Eb8M8ZfXlYh
X-Received: by 2002:a1c:bb86:: with SMTP id l128mr16198897wmf.41.1584803386678;
        Sat, 21 Mar 2020 08:09:46 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuaGumNR2yz+KrzOsfQqt0aVh3JYOD0AaJd974Iziew2JHt7IGS4gIzqQDMDPYRf2VFlaHsZw==
X-Received: by 2002:a1c:bb86:: with SMTP id l128mr16198874wmf.41.1584803386328;
        Sat, 21 Mar 2020 08:09:46 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id u5sm5767186wrq.85.2020.03.21.08.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2020 08:09:45 -0700 (PDT)
Subject: Re: linux-next: Fixes tag needs some work in the gpio tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200321162707.5f4b1951@canb.auug.org.au>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2195891d-4f41-a4e9-c067-2f2b556a1517@redhat.com>
Date:   Sat, 21 Mar 2020 16:09:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200321162707.5f4b1951@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/21/20 6:27 AM, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>    1b26f3ba6117 ("gpiolib: acpi: Add quirk to ignore EC wakeups on HP x2 10 CHT + AXP288 model")
> 
> Fixes tag
> 
>    Fixes: aa23ca3d98f7 ("gpiolib: acpi: Add honor_wakeup module-option + quirk mech

I see in my personal tree that I introduced this broken tag, sorry about
that. Linus, if you are ok with doing a forced push to fix it up then
the correct tag should be:

Fixes: aa23ca3d98f7 ("gpiolib: acpi: Add honor_wakeup module-option + quirk mechanism")

OTOH if you dislike forced pushes (which I completely understand)
then we will just have to live with the broken tag.

Regards,

Hans

