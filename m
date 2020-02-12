Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F81CC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59BE2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="GQn85WKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgBLH1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 02:27:37 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36583 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgBLH1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:27:37 -0500
Received: by mail-pg1-f195.google.com with SMTP id d9so748252pgu.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 23:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8ibAYzH7JwVChn/H9xG7OZ9qhyi4dW0rrjKwNb5KAWM=;
        b=GQn85WKXRnkAY5iH0k9SE+x/iSThmMmKghqDjUFg2sHbDyFtvdqI7TM4RiX0EEwmLe
         h8u2IonB0PxHjglmyiEljJSChjO3yQaFpkKcnxPszQPElPJPu22iukCoWSV8Wj3L65uc
         ZnWtY4izdXQj881iVbMNCkRu4Q3dWL52WAgDjIB6lbE6qGQAV95RmpfY6giTClUumhz7
         jK8UkZ6Q3m5gpzW1JYBVxBGJilyHnqkPfasDpSU62lG7p9WFXOY+zHrhsPnDunSFwIQF
         hXy7J/9QM2WJdw4A4s86oS5VqVeqp8MML4qvl7tZ9T23zzImJ/1tjdELNWk8/AcReZ3n
         D1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ibAYzH7JwVChn/H9xG7OZ9qhyi4dW0rrjKwNb5KAWM=;
        b=dzdJuQKM7wQTCtR6OwbH9kGUsf6ahjaeqjgf/quh43hp5u2ycCw7+RXzyhb47Jks63
         HHGi2+ACBwKuNjRXE2c9nH21jhAXL5o47kA3hoOs2KPn2e/8aA3T7834AVD7KfpvutEC
         WhoP4QtSI6juriBhNDSWRQxMAUkD7u9cHuGSlERvQ82fAoWNpYJhhZtm419Aq0FOdh9d
         Dkya9nPmlMYVVm9zaceu8aW+D49zUNzx+S/He9CEYptLyheVZQn0HRRTwVY5QQQE8TDi
         8Or9LvgQ+CRuT55uiLXp0TbpZrA9l4JiiQu7bVSc2E+6wHYOayo3N2QsCYaguwAIe7tE
         dDPA==
X-Gm-Message-State: APjAAAUp6EV1K0tPS+HBMvc4w/quuwWu4shlxyKp7lB7s5xITFRMnvBN
        zWvQCnu31GcVoaGXW4rUWUkA5Q==
X-Google-Smtp-Source: APXvYqzb1q6Be3UwEdG2DOk2jCioBvFQ1A3EV8QQ+Cxg85nPVGVMz8mF0U3jqDZ6cDb4AbclPMYhCA==
X-Received: by 2002:a63:9dcd:: with SMTP id i196mr10811370pgd.93.1581492456207;
        Tue, 11 Feb 2020 23:27:36 -0800 (PST)
Received: from debian ([122.183.169.124])
        by smtp.gmail.com with ESMTPSA id 23sm6843069pfh.28.2020.02.11.23.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 23:27:35 -0800 (PST)
Date:   Wed, 12 Feb 2020 12:57:28 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        jeffrin@rajagiritech.edu.in
Subject: Re: [PATCH 5.5 000/367] 5.5.3-stable review
Message-ID: <20200212072728.GA4944@debian>
References: <20200210122423.695146547@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 04:28:33AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.5.3 release.
> There are 367 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Feb 2020 12:18:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.5.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.5.y
> and the diffstat can be found below.

hello,

compiled and booted 5.5.3-rc2+ . No new error according to "sudo dmesg -l err"
