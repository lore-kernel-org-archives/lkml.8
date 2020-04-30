Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C232C8300C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D7121974
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kpnp/1yH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgD3KeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 06:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725280AbgD3KeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 06:34:07 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F1CC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 03:34:06 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r26so1306142wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 03:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=iKvyQs3hqK0Cahom1nAntcSOXnDcOmXkOeQhD6hPnVs=;
        b=Kpnp/1yHy15dfbxKwTaVJgmapZynLaz8RCBCyrMnnFutFCQRtgUNqskx4jFHPHRvHm
         dGpzg3VR+wMNhqkAQDXb+aT4QYFmvDQhYITXn7Wu3dfAwUoYjYN3YRnS/tVNRylo4wek
         svFJl86VA+EVzElhfZK5IJKidQcnkDo3yBHhEFf+vCtvM90CwEN1k6pb/pTK5R3Yc7NN
         z4uAcWS1gmVPgCeJehBfIBnMgZL/jHMFIVuypGJnTW+AJ5assTLDDeFjCs1/jAvS6ATP
         YZUl915tMKglrZXlWWEuq6ersDF5c2+wm/gx11+lxoTcNl3jxFDtTuuGbx+3gerTLOYU
         JBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=iKvyQs3hqK0Cahom1nAntcSOXnDcOmXkOeQhD6hPnVs=;
        b=ResOSXLReq3xGSeBci3ACMIY78KZ/vyfr/J+MjV7K5TZ3fW6J997FVwCgK0LF+mQNJ
         PX7xA5+7B89wdN8S2fIEzJDuz26oF6fsWHaOzrT/1d3loznjgtS0YW7DKqiHN6SxZ6Fr
         +FsdDn/6kuJizNVY5P4wt5bAhwJ/UJzSCk5DLtQQHG0f1TcwmlcQdU4QpJJ3+1fYB3Dc
         UYwa0Qo34NvxuKFox+x/reULD4tmIQyJlBn8or6X2l6mEsf0ostRXLZvV9lT7xvpxW2n
         3Fetr3HFxlsdalkQGmTtcXlySVLbkFFTETY0MBvRmFXB9EuRVa5fu53ruiOrUa5/WVni
         p+sQ==
X-Gm-Message-State: AGi0PuaO3/wHLZau7pvz67QNnMlCCPBnB5rqr+FyZXzPQURUxkjG/J1W
        0J1l4pJU3IxovFqJpv2rzfN0POGp
X-Google-Smtp-Source: APiQypLRo9BOzn4MqWto4kHSYcRYAxuUSxbia8X+XluJmYRYJICoxCn7H0cWHUumwiTcKesjpX0E5g==
X-Received: by 2002:a7b:c38b:: with SMTP id s11mr2244959wmj.55.1588242845429;
        Thu, 30 Apr 2020 03:34:05 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.gmail.com with ESMTPSA id n25sm11672204wmk.9.2020.04.30.03.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 03:34:04 -0700 (PDT)
Message-ID: <2602d65b534fc0e9d6738d3c670bdb07fd287e5b.camel@gmail.com>
Subject: Re: [PATCH v3 2/5] w1_therm: adding sysfs entry to check device
 power
From:   Akira shimahara <akira215corp@gmail.com>
To:     Evgeniy Polyakov <zbr@ioremap.net>, Greg KH <greg@kroah.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 30 Apr 2020 12:34:03 +0200
In-Reply-To: <330221588173223@mail.yandex.ru>
References: <20200429133204.140081-1-akira215corp@gmail.com>
         <20200429134655.GB2132814@kroah.com> <330221588173223@mail.yandex.ru>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 (3.36.1-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Le mercredi 29 avril 2020 à 18:18 +0300, Evgeniy Polyakov a écrit :
> Hi
> 
> 
> 
> 29.04.2020, 16:47, "Greg KH" <greg@kroah.com>:
> 
> 
> 
> > >  +What: /sys/bus/w1/devices/.../w1_slave
> > >  +Date: Apr 2020
> > >  +Contact: Akira Shimahara <akira215corp@gmail.com>
> > >  +Description:
> > >  + (RW) return the temperature in 1/1000 degC.
> > >  + *read*: return 2 lines with the hexa output data sent on the
> > >  + bus, return the CRC check and temperature in 1/1000 degC
> > the w1_slave file returns a temperature???
> > And sysfs is 1 value-per-file, not multiple lines.
> 
> 
> It was 'content crc' previously, and probably a good idea would be to
> add just one file with 'content'
 
That's the purpose of the new sysfs entry 'temperature'. It only
content temperature. As already mentionned we have to keep the w1_slave
entry for compatibility purpose, all existing user application parse
this file.

I submitted the patch series yesterday night, splitting it in 9
patches.

Regards,

Akira Shimahara

