Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C566C38BE2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D838C21556
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SSIU4cLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgBXUSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 15:18:44 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:41628 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbgBXUSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 15:18:44 -0500
Received: by mail-pl1-f182.google.com with SMTP id t14so4497891plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 12:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AsAkVqeBlUTVNMBFWbPGk3JGWoog8P01z4Gn0jtsTzU=;
        b=SSIU4cLlI2n2qbxmevdwvOEapG9ngx6Anv8KODNUhHrGmYkwT+Vofd9rZbxyHYkKrL
         OxIz6NSZEnenQmkNwJTqQ7MX59IDkoyi5+gbn6dZSi/Vmqw2XCm1CT1uozT+GL7ce+3I
         LkkDnNqFQ5GJLRTLckEy6NzC4iL9ezTOdrkohbZ8ObYNe5mKFiQ/hXG32lxMg3M7PXH6
         RwO3R25e38NobOg9yVRKix9CgSdWvD1Sk80l+Z5DSkfFYtF1zX3wjPB0Tx2vMiP8SPnd
         MiuDWaNOseXqsfnYBNDDkZWqHqMUP1nXomlnJbj5nzcgYwftoxxDbjvfAuOOH+hQ2PSr
         mD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AsAkVqeBlUTVNMBFWbPGk3JGWoog8P01z4Gn0jtsTzU=;
        b=YbmV19ACNS/UWYNoGy2OVGt+R/U+ufOJCz81sHdspeRpCcWGKQkh5QSrOfgq+fZ0gB
         FY8tE2BqerM0FwtUFS/w4pP34OezLdFrncuIIMWTZartrKJbzEkF1dbFUWMdyoJTutDc
         M97Y7XAWcFEQOnrQ8QQXFs+J0B1SN/dLqyLy5hvjdRvHWfEYjBUdPmRPirM7AI6wbI/a
         0t56ZI4e1HeTS+T8dfAEk5yDk2Z6fecqQDb4Qyq86ZzOl/gSoAD+bRF3rzQoQ1Q8FM8M
         Sus9DrkWB7s67eT+G7M/MY7I3iL7IAZBcfcvvrSSBvQtaSVjbmp0noL3eWkVnXTHRwEe
         wRwA==
X-Gm-Message-State: APjAAAWJBOtwJlHzfdBEn7bf1KuJQlzeORGg0U+Y1LGcd7aKf6DSI+9Y
        tcFYuy0E0o9QoaDHYe6AxD4s/g==
X-Google-Smtp-Source: APXvYqzMuuqbYsAPQLvRqQa13jz2PshPPsaVA7gSaadKM9nV82v1GczAEn13xMLYijD8wngok8Dx/g==
X-Received: by 2002:a17:90b:11cd:: with SMTP id gv13mr955512pjb.94.1582575521719;
        Mon, 24 Feb 2020 12:18:41 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21c8::10cd? ([2620:10d:c090:400::5:9b45])
        by smtp.gmail.com with ESMTPSA id e2sm300316pjs.25.2020.02.24.12.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 12:18:41 -0800 (PST)
Subject: Re: [PATCH] compat_ioctl, cdrom: Replace .ioctl with .compat_ioctl in
 four appropriate places
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Adam Williamson <awilliam@redhat.com>,
        Chris Murphy <bugzilla@colorremedies.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Tim Waugh <tim@cyberelk.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20200219165139.3467320-1-arnd@arndb.de>
 <yq1eeujda1d.fsf@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d9d25fda-e3c3-e6b6-0189-93fbe7c5f743@kernel.dk>
Date:   Mon, 24 Feb 2020 13:18:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <yq1eeujda1d.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/20 1:07 PM, Martin K. Petersen wrote:
> 
> Arnd,
> 
>> Arnd Bergmann inadvertently typoed these in d320a9551e394 and
>> 64cbfa96551a; they seem to be the cause of
>> https://bugzilla.redhat.com/show_bug.cgi?id=1801353 , invalid SCSI
>> commands when udev tries to query a DVD drive.
> 
> Applied to 5.6/scsi-fixes. Thanks!
> 
> Jens, I hope that's OK? I keep getting mail about this bug.

Yeah that's fine, thanks for picking this up.

-- 
Jens Axboe

