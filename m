Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B777C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A4AF20738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIO4SkjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgGGPhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:37:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27060 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727079AbgGGPhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594136241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8SdgB4saJnCjRdo/oh+TvX5LAU++LqcRafgEBY2mxVo=;
        b=jIO4SkjIV/xPCakutcWYTGumaFN5TV9ba7iUChHQQKgHgWXGUChAUXBsjVtsG6i+aiZf4V
        dYP8zrdxAEcZjkGviBaI+sIH+IC85CcfnC9VKXUwHELaYKB1O0/jX6a329hNy17S1AFrC4
        GL8x+aOrvlu4LgzeXtCsdvmp2RLbZdU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-0q6c-uy_P9Ois5YIwXilvw-1; Tue, 07 Jul 2020 11:37:20 -0400
X-MC-Unique: 0q6c-uy_P9Ois5YIwXilvw-1
Received: by mail-ej1-f72.google.com with SMTP id c16so39798753ejb.22
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 08:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8SdgB4saJnCjRdo/oh+TvX5LAU++LqcRafgEBY2mxVo=;
        b=VMvvDuXgEMQbBzihrY7oFcUxaWkBfQLzO7iu3YIjxcZ78Wt1MMq1g3nTutLwkFH5BU
         Qv9sfrVpOWJ7T9Gtb3QfRutjH47nCdoBSG3u2BbFQqvpQdsnWFLt74oSCkZRKFGUWpcy
         qriQH04QC3NzWhOqEL+B3R6KC9jWOzgdXXAoxSlIxvWpNFG7wj4CNY9bXPGYtxp7vMvT
         eyOHyYvHqNwO5rA20TvOiuG7JxdpALdJRIwtWLdrHatjLPE4iK0owWyDNMTFHlH5TWki
         ixyIQeaBSAthTAjQu2VJLftOMo9kGZVfBwA5DwVkqIZBtZEqnsyhMDjwoU7zNjp0u7S0
         JFCw==
X-Gm-Message-State: AOAM532Jx7lL/FakZVoYGLZAGcNAOF9lkprafOx0cGE4rK31RTXLmZkd
        hMOWeGbabJm646KiZH8iMjpYhCLQ1J8WzUKZNlGoU9SBUcgJ7c9UYiC020juN2U5lVZ69dl/vy2
        UTt4HXwnZIAZ6RONQE+9SMuV/
X-Received: by 2002:a17:906:3787:: with SMTP id n7mr46219503ejc.551.1594136238593;
        Tue, 07 Jul 2020 08:37:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+9cgMMpParXneUmMGaXdYI1xVfHrHMt12BKnlWwkFoZypUOBN6lHuVORzlZx4jItMWSKaUA==
X-Received: by 2002:a17:906:3787:: with SMTP id n7mr46219487ejc.551.1594136238383;
        Tue, 07 Jul 2020 08:37:18 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id u18sm25891090edx.34.2020.07.07.08.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 08:37:17 -0700 (PDT)
Subject: Re: [PATCH v2 0/8] virt: vbox: Add support for the new
 VBG_IOCTL_ACQUIRE_GUEST_CAPABILITIES ioctl
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20200623142401.3742-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1cbeeac9-650b-fc6a-9d2d-a5dc26ce1a45@redhat.com>
Date:   Tue, 7 Jul 2020 17:37:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623142401.3742-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 6/23/20 4:23 PM, Hans de Goede wrote:
> Hi All,
> 
> Here is v2 of my vboxguest driver patch-set adding support for the
> new VBG_IOCTL_ACQUIRE_GUEST_CAPABILITIES ioctl which is necessary to
> make guest resizing work with the new(ish) VMSVGA emulation in vbox +
> some other small fixes.
> 
> The only change since v2 is rate-limiting the error-logging in:
> [PATCH v2 7/8] virt: vbox: Log unknown ioctl requests as error

What is the status of this series?   I've addressed the one review
remark you had on v1 of this series and it would be nice to
get it upstream for the next cycle.

Regards,

Hans

