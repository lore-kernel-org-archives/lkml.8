Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D36DC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 23:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1290020866
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 23:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583363373;
	bh=lzYSK+MEuk72nMhzqBd5bNzw6N8PHF0L/J1HXFibw0Q=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=SJCpAeoifsRFgYUsbLRVQHOC0WSDfW5RvqcLrVIN6CLmCn9sByGsNC+73w+hL2Dxe
	 vyjnjOxFHr6alJbz3GA7oA4jfw46DXDXZKNBOHvOj+kpnl09xO4q8JhQcGUQruq9W8
	 1W/aqsPxqvhqe93QiI1r9wX5PJ8iIDrsl2yy2y7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbgCDXJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 18:09:31 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38783 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388407AbgCDXJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 18:09:31 -0500
Received: by mail-io1-f67.google.com with SMTP id s24so4352090iog.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 15:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LO4sFnLO2wiKWhH2CPGBBj7RnEjSWuWu+5bPaWGne3A=;
        b=GRUxsx43gpC2xVKP9oFcjdHOtdsoBEiZVqdYpYccGdnPmwDJ5vaIAUlkJkYEwM2cn9
         4iBt9rhv3B5SnI7cZpBxkf8bnsueotIEG7J6JKz6nkQSN7xuo7MqW2KmYc47CwuDZdqq
         UTfnBjMjiUEv9mQcXNkWTEDhbTK9axnU9qTYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LO4sFnLO2wiKWhH2CPGBBj7RnEjSWuWu+5bPaWGne3A=;
        b=PFbKYyO9Q66bpFh2p++RyI4GK/qRUxyGi4gDLjBfrQE3LsGZtn+5F4dYbNz8maOz8s
         MOdNEh3ubkJV/JibWwKayH35D7RrIxvd9BNuQ/DvY49oYqwC5LpzHhxuPLvLBHsNFYgu
         6dQQtci08EzQyU8wuvnlYqMvazOq4Sfd+2NGi65Z+zaI33ixj8l5I3qH+4YcC03d4k+i
         PztwQBXrNHwHnlYv+IFeMiwShqjRVXeOp7PrAWVD+eG+s8Wnkz0mpQAAoIkRyLe3/P3S
         9edX2xUQg8QkKR0dGiMPpXN7xdr8EwpTcXceJTVdW0ehW2ln1TY5F7Dk+WhaWyXe6oAl
         g7TA==
X-Gm-Message-State: ANhLgQ1OYTeBGAaQeHvn4Gdr6Vqj9eiUB6AqYmt+smh29REwOlCcTBXW
        FN8Kxg60bt1bMWw8iTRgPKa8aQ==
X-Google-Smtp-Source: ADFU+vtyCpv8ORr2dtmq5bQJdqqW/cgZJGtUiAs4EcPOweiSbguRMZiA3Ga6HVFtBYEgjjU6+sp9Vg==
X-Received: by 2002:a5d:814a:: with SMTP id f10mr3969167ioo.7.1583363370669;
        Wed, 04 Mar 2020 15:09:30 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s3sm8163040ild.7.2020.03.04.15.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 15:09:30 -0800 (PST)
Subject: Re: [PATCH 0/4] Kselftest integration into Kernel CI - Part 1
To:     shuah@kernel.org, keescook@chromium.org, luto@amacapital.net,
        wad@chromium.org, daniel@iogearbox.net, kafai@fb.com, yhs@fb.com,
        andriin@fb.com, gregkh@linuxfoundation.org, tglx@linutronix.de
Cc:     khilman@baylibre.com, mpe@ellerman.id.au,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
References: <cover.1583358715.git.skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <408294cd-5c54-d8c2-1dce-7224699670fe@linuxfoundation.org>
Date:   Wed, 4 Mar 2020 16:09:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cover.1583358715.git.skhan@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/20 3:13 PM, Shuah Khan wrote:
> This patch series consists of first round of fixes to integrate
> Kselftest into Kernel CI.
> 
> You can find full list of problems in my announcement I sent out
> last week:
> 
> https://lkml.org/lkml/2020/2/27/2221

Here is the lore link:

https://lore.kernel.org/lkml/3b3dc707-7ae7-955b-69fe-b9abe9ae26c5@linuxfoundation.org/

thanks,
-- Shuah
