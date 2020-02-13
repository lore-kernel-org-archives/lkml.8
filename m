Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54225C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200302465D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 20:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="TcHXD8FE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgBMUZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 15:25:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42849 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbgBMUZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:25:40 -0500
Received: by mail-wr1-f67.google.com with SMTP id k11so8291228wrd.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 12:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mYU7K19Hqtiw3fxG+0bFd1qNUKm263pOaYfaAxc6hpM=;
        b=TcHXD8FErmY0j5Ks1AE2DladhbHuIzSy82IrQnKtihLC+RFDXWVeIC7yCY48m9vT89
         0w5NHKyQ3vOyCdZ+e04HADXfO/xGAKkY4W9Gp22TBZGmL4HaUXSJQ29CGs4PXcmBADg2
         4aUdbYcGnrXz1IOX7pcAHfa8dI1+S15BOFQiXjNJvLZOeX4ThH+TnZv+xVxxBuEOLnLT
         RamqLQwmnemtplsqA1ee0ptpBgUNPavqEDXBbt7fSy/JbwYRf9mgW7mNNaUGLpA6Qo58
         jHmUn2tEtN4EaBfweFtRtn6A3hBsHnwjUwD+tHgfKl6XZ3VB4p8qrX2NAAtbN/JLCSwj
         rerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mYU7K19Hqtiw3fxG+0bFd1qNUKm263pOaYfaAxc6hpM=;
        b=axAERgLK5KpI1RKxUXetCT0COa6L8j2P6blyVCk/2EoWwI5iCkkWXdWGLGj3w34lHQ
         IoH0pTKKAPFzBBvwcTTBzp5SWg3LBRULS9l0X99vY6wq6ulXG+UPiAcuoUqmTWCVIKgv
         iZs0UpYyy4/pukmTIn8xza0pfFZ8YR9ZDhtkvYQWjnjZjSTES47oJHWM6qfCDTfxtLpM
         fGGfg0rGCkQGcWiQAKNo5rtwOp72qBNKDdiJg388sxpJQ5Sv5DRQh8meruJNfqW4g53X
         2LCxKKevaRQVA+frPhIFPFPr/pTKNPOB40UR6Du1FttN7DhKm9P7g7o3LVveQoYdtqAr
         3hYA==
X-Gm-Message-State: APjAAAX9l5uG0x+QzD7800rbKNv/iF5u+fFiXNG9F5KH4gL5t6o6rMna
        MaoSZYadWjWgGc3sblr3BUVWF8Ahepc=
X-Google-Smtp-Source: APXvYqyIcrjHC0V1ObVSzKK1O+oFquBykb9wkqmiTtpRb49YjwQlFdnjV3D9CdqM+jtvVeLpIVz5bg==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr24701152wrr.226.1581625536927;
        Thu, 13 Feb 2020 12:25:36 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f11sm4210674wml.3.2020.02.13.12.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 12:25:36 -0800 (PST)
Subject: Re: [PATCH] selftests: use LDLIBS for libraries instead of LDFLAGS
To:     shuah <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, avagin@gmail.com,
        linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
References: <20200212140040.126747-1-dima@arista.com>
 <db01c4e9-c236-3847-f812-943e4442f048@kernel.org>
 <c9b248a3-8df5-a76d-b472-9e65d837cf5c@kernel.org>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <074f7494-e01f-1654-c771-27e2b6d3cddf@arista.com>
Date:   Thu, 13 Feb 2020 20:25:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <c9b248a3-8df5-a76d-b472-9e65d837cf5c@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/20 8:24 PM, shuah wrote:
> In the interest of getting this fix in, I applied it to
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
> fixes branch.
> 
> No need to do anything.

Ah, thank you!
I was on other issues - sorry for the delay.

Thanks,
          Dmitry
