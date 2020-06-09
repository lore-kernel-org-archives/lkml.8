Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B78C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A4D22078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KiW+sUf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbgFIOpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:45:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49772 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728905AbgFIOp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591713926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D0N8IG0w6TqyvrPZq3Bf6WEEBOpAcUrPcq971x3xCR0=;
        b=KiW+sUf40IGeFLP0CBk6z6ojC2g+Q6URZBahsgm6rI4TyUxGfVTFCvJsQcVIcAk92gMXA9
        rHhvp5gIWj99A3BV0bwX+m1ynD85K8jZhYKTAgTPMdeqpe63goTMqyIiPDfF5LJ7ITyldw
        7Z9a3pMiC0wSkzZlYToT/vkRtEDdAAs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-XkJ4m6_qMcC4AEXWhSQToQ-1; Tue, 09 Jun 2020 10:45:23 -0400
X-MC-Unique: XkJ4m6_qMcC4AEXWhSQToQ-1
Received: by mail-qv1-f72.google.com with SMTP id h4so16789122qvr.21
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 07:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=D0N8IG0w6TqyvrPZq3Bf6WEEBOpAcUrPcq971x3xCR0=;
        b=Qhcy5vTcVrso8npRWmeYp5NatTWqUpzQMSVvPCylfCofrX+eYCVNE398SMErzUUDdF
         pcJC0kQ7yrFweiCboPlQuQuhWNzSltXQIZbLWTIvPI91GdNZT4VvzXip0dJo5Im+euHC
         G42NapO2IkwoM0ep4kP8EOVHrhbQJo5E9A8ZiePAMRb4ywwcTJWcsXQkrulNWCyVDzdW
         PP9VzKuVM/i8NlUATYogc9iD3P3tOpwNWxYm/0vOhbi7LxTqjdcJhZdIyzg3XKzACMJs
         19eOqo5WDTZUaq+M9b18REta9o5rGm1UH52M99JRcD7f5z80wq2SQ8KV35zboNynmcJW
         rzow==
X-Gm-Message-State: AOAM533D5MI1dWbAesqLikF3O3tY9f8xoh5CeeOojzlPmGhFi5+7AVC5
        zR9ThQlVVhDrIOWLLhp7O/E3GvxXkWzobDZAatpQU1fa6i47g1wmQ5tqrdadj2BS7oG5shRhCFL
        OERM99U6M2b9C1LWNdG9xnl3R
X-Received: by 2002:a37:7645:: with SMTP id r66mr27146855qkc.397.1591713921633;
        Tue, 09 Jun 2020 07:45:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrDWGGcedgDp0WJSfkST6HxfilfGNNkZ2qb1/AuAvSqBZwRXvtCKZT5td9mD5UlkwPlyTrdg==
X-Received: by 2002:a37:7645:: with SMTP id r66mr27146798qkc.397.1591713921109;
        Tue, 09 Jun 2020 07:45:21 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f43sm11650042qte.58.2020.06.09.07.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 07:45:20 -0700 (PDT)
Subject: Re: [PATCH 1/1] selftests: fpga: dfl: A test for afu interrupt
 support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable <stable@vger.kernel.org>, linux-fpga@vger.kernel.org,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20200609130208.27390-1-trix@redhat.com>
 <20200609130208.27390-2-trix@redhat.com> <20200609142007.GA831428@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d3d8e518-0760-8cbe-cf74-191f70329a46@redhat.com>
Date:   Tue, 9 Jun 2020 07:45:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200609142007.GA831428@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Why not use the ksft_* functions and frameworks to properly print out
> the test status and results so that tools can correctly parse it?
>
> It's generally bad-form to make up your own format.

I used the the drivers/dma-buf test a basis example.  Can you point me at a better example ?

T

> thanks,
>
> gre gk-h
>

