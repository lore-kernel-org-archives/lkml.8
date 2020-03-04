Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A585AC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8B52146E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKOJXMWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbgCDLqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:46:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45104 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729389AbgCDLqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583322361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cCc7BElPshbmHtWbpagJwHxtkWCPSA1SVypRulNi+oI=;
        b=FKOJXMWujAvERLLKRrmsTbWT56z/bgErDTEtVycy+R+jo9KQnnHoIu9CWqJDJlZ6JlYLAU
        d0fyM091ECUrBTfORSLtdU5qmAG/xsp1f1+QYFzv18G7T1VgmpN6CaY4FUVa0l/e9uJ2vZ
        zpx+D5+vhMbdr3u3avQMEWh7v0DiCfg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-5xgQfrUINiy2i2oqR1RjMQ-1; Wed, 04 Mar 2020 06:45:57 -0500
X-MC-Unique: 5xgQfrUINiy2i2oqR1RjMQ-1
Received: by mail-wr1-f70.google.com with SMTP id n7so738150wro.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 03:45:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cCc7BElPshbmHtWbpagJwHxtkWCPSA1SVypRulNi+oI=;
        b=uPI75ZP5CcDfavZcjVjmRvTlXvX1J6vrAp/S6uKCokAC8lQaiyJ0ASe18x1SyHilIq
         dE4a1i8BjOip57c+TXFKl9rEoUKQtJL/XxTEp+FmnJB0Qd9+ZzJZnSM+r91cxNoCuAF8
         qgg3qNCdm/D7IKaBcwgs3fAGPuW+2RpPCrLqKtHDZ2Ac58IUy3F+NEz3KbJhK6rTBNvI
         QZEi811t5F0IWTGyKOIw2DfcSFy7ygi5xoBNqa3VNuHx+tipiX7RRDSCpbVXnlLmjhMq
         q6e3W2y6S8Ewy5mk9JGRQwfKpTi2LKBUhbVFlnR6BGfYmhUN7VKitcd3gYidYsOvz6/y
         YN+w==
X-Gm-Message-State: ANhLgQ3LtOcSyHFYxoFpjoJ/nvVJ1ZrTre6DRrl8luarlglHzXFCsngC
        YqNwa+IoTBmU+x+j8aQLivtlTh/FXtzYNtsHgbiK4o3Zhcu+zZYlh8kXid8WNR0oZaMdaKu+n3y
        dDeWUyu1F6AyvwpQWdKL9Jp5/
X-Received: by 2002:a05:600c:34b:: with SMTP id u11mr3265900wmd.69.1583322356248;
        Wed, 04 Mar 2020 03:45:56 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtDCFoIzfRfvbrwlxy97mJ/vLfuAr+c71xd1ne4wJN7KG9hlnGajvZ1LeDt6NFSBwXSN8nQog==
X-Received: by 2002:a05:600c:34b:: with SMTP id u11mr3265875wmd.69.1583322355946;
        Wed, 04 Mar 2020 03:45:55 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id z12sm11885882wrs.43.2020.03.04.03.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 03:45:55 -0800 (PST)
Subject: Re: Updating cypress/brcm firmware in linux-firmware for
 CVE-2019-15126
From:   Hans de Goede <hdegoede@redhat.com>
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Chirjeev Singh <Chirjeev.Singh@cypress.com>,
        Chung-Hsien Hsu <cnhu@cypress.com>
List-Id: <linux-firmware.lore.kernel.org>
Cc:     linux-firmware@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <93dba8d2-6e46-9157-d292-4d93feb8ec1a@redhat.com>
Message-ID: <c2f75e84-6c8d-f4f0-bcc6-5fb2b662de33@redhat.com>
Date:   Wed, 4 Mar 2020 12:45:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <93dba8d2-6e46-9157-d292-4d93feb8ec1a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/26/20 11:16 PM, Hans de Goede wrote:
> Hello Cypress people,
> 
> Can we please get updated firmware for
> brcm/brcmfmac4356-pcie.bin and brcm/brcmfmac4356-sdio.bin
> fixing CVE-2019-15126 as well as for any other affected
> models (the 4356 is explicitly named in the CVE description) ?
> 
> The current Cypress firmware files in linux-firmware are
> quite old, e.g. for brcm/brcmfmac4356-pcie.bin linux-firmware has:
> version 7.35.180.176 dated 2017-10-23, way before the CVE
> 
> Where as https://community.cypress.com/docs/DOC-19000 /
> cypress-fmac-v4.14.77-2020_0115.zip has:
> version 7.35.180.197 which presumably contains a fix (no changelog)

Ping?

The very old age of the firmware files in linux-firmware is really
UNACCEPTABLE and very irresponsible from a security POV. Please
fix this very soon.

If you do not reply to this email I see no choice but to switch
the firmwares in linux-firmware over to the ones from the SDK which
you do regularly update, e.g. those from:
https://community.cypress.com/docs/DOC-19000

Yes those are under an older, slightly different version of the Cypress
license, which is less then ideal, but that license is still acceptable
for linux-firmware (*) and since you are not providing any updates to
the special builds you have been doing for linux-firmware you are
really leaving us no option other then switching to the SDK version
of the firmwares.

Regards,

Hans

*) We have distributed files under the old version of the license before

