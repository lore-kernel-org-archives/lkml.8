Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC238C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A99320848
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bskPpamX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgCINwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:52:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45644 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgCINwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:52:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id m9so2253702wro.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 06:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PfZu5RD0EkiRIzyfyoJo3cq7qDSD4XfrrbjoyTCBf4U=;
        b=bskPpamXDjt6HermMBgC7riSz1e6tedwQyK04CGOiWZ9CavV1oDf8Yvo+ixJagBjsO
         vbGjtJ33rJ2PpBPjMruYDD6MM6t/ph3vYbww5KZDzbsz2FiOdskBi1ESKuCr/XKw5chi
         ewp5cPwop40x0qJ4s4ojUyX8g0dPFta/q6ZFFEfHIny41ZIHe9up72XbU4RGhM7KNv5p
         OKHoAlhSAf4oMcbACZh4gEExYMey+nqEhBTNum+A2UghGiFIhkuO/WSW3ZgReXYjFuWC
         crWSNFaqh/Oz8ZvCo2QMhgQeJfJdHl4Qj+pL7CSL9dXcY8t88julw7HokOACfWIocxM8
         fyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PfZu5RD0EkiRIzyfyoJo3cq7qDSD4XfrrbjoyTCBf4U=;
        b=JYQPws2+c+1u0PnPOD4VNCYG74tB2VmMwyn2yE/LbAKF6u1N8WFNI2WMLpJiE5Rrz0
         FkTBzOPxzra6thaftb3QtWflzCwe8BxW27EJCX6r5l6qIePZEF5QZNqSFhDDbeZ97Y6V
         QKgFCUEvKMJoIaST4TcmcwGRH/cS1x4zes4PSg5nBWakOO9qPZdch6NTZFSIwo3At7tK
         FBorgiXJgRoQhuGqVhxvpioTOr+KiJ+nqh+SpEkaT9lBF6sM6IFk2FSarpvC3MJ789yJ
         MIp2XsrkgscFGbJl2MywvvipopVVPEyUunB4NnU6aRneEr7guwNBWIOX1GJKn4TC8CNw
         pgVg==
X-Gm-Message-State: ANhLgQ240/LgRiHFs/S8EWET6yq+jMRSbI8BsVKCnaDUWAhkhD5h8MFr
        mC0E24s43i3Kf7E3vRtGcJD/hA==
X-Google-Smtp-Source: ADFU+vsAKabuIQXOSE7o3xg7D222ujCIl4Yh+N8hP4yA3DJUzAA3XMts4YjRQ/egv8e3+zEZfzmuxg==
X-Received: by 2002:a5d:4b82:: with SMTP id b2mr21302349wrt.102.1583761971175;
        Mon, 09 Mar 2020 06:52:51 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id v20sm9940563wrv.17.2020.03.09.06.52.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2020 06:52:50 -0700 (PDT)
Subject: Re: [PATCH] nvmem: jz4780-efuse: fix build warnings on ARCH=x86_64 or
 riscv
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        letux-kernel@openphoenux.org, kbuild test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, malat@debian.org,
        paul@crapouillou.net
References: <79e1dec195d287001515600b1dae0bcaa33fbf65.1583522277.git.hns@goldelico.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e444754a-3bd3-d46f-d2f9-188fb2cc6f0e@linaro.org>
Date:   Mon, 9 Mar 2020 13:52:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <79e1dec195d287001515600b1dae0bcaa33fbf65.1583522277.git.hns@goldelico.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/03/2020 19:17, H. Nikolaus Schaller wrote:
> kbuild-robot did find a type error in the min(a, b)
> function used by this driver if built for x86_64 or riscv.
> 
> Althought it is very unlikely that this driver is built
> for those platforms it could be used as a template
> for something else and therefore should be correct.
> 
> The problem is that we implicitly cast a size_t to
> unsigned int inside the implementation of the min() function.
> 
> Since size_t may differ on different compilers and
> plaforms there may be warnings or not.
> 
> So let's use only size_t variables on all platforms.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: srinivas.kandagatla@linaro.org
> Cc: prasannatsmkumar@gmail.com
> Cc: malat@debian.org
> Cc: paul@crapouillou.net
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>   drivers/nvmem/jz4780-efuse.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Applied thanks,
srini
