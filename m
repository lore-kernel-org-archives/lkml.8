Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B622C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC7D2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yhuejy7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436981AbgDPRpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405358AbgDPRpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 13:45:38 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CD3C061A10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 10:45:36 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u15so8792534ljd.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 10:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNf+O79dxYvL9upUNIRS+k5/S1UjI4y44sK7fhayR1c=;
        b=yhuejy7C49EgHspat4U3jEapm5Mwx72TiEXWSd/E+JkFxuW54VToaZeqmpgHO9awa4
         B8KIPl/0skwI5l8MKZBwPWl2ouP9Ag8DEz0hepOepQOQQRuWZ05dtw/1PqzXx1O9iuzO
         e9pOPFmWfQogTHkA5DsEvC/7H5HoQgZov59RRldnV7rAJejBuuDUfCwOwRfqrK9aneqX
         /MdkS3FtkTaT1af0mUT3saqaE9SpuPzwd44Tu1EFw9TOQspF8GfPUjGdzH5WjcTuHzyN
         S4ZHToOtpkkDw7xauUnfBITP01N85mgxeKExbMZFwIfsCYHn0fk6s7ctr86ivxg7GGus
         XwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNf+O79dxYvL9upUNIRS+k5/S1UjI4y44sK7fhayR1c=;
        b=rgdcwElPC/DjZseBbRlH64srbQHBt/1BfeGtkbN4WCE/ZlmZKyWFSJMzENqr6gVSAI
         vxarMEoXjYtw6n/v2XaW0ePgCl/1GqG7EHIfYgXlSMag3bd37WlMKzowKAt6OW7LgPH0
         TIxxn4e0plxN95N6DkCQYHCre7qHNQAGYzraBxhkI0Dlh/ZB+n5v8xANWZjKNMsPDlnK
         o6sr7WdDQ9hiZqW/8igw2Ioi0MxZfvVLrZtD9zWfbfQrgRB5DYkpwp2mlraPcjsWg8E/
         gdzpawceFtRNi+fFywf6ZEViY+HMcwgUOUvVPCJSyMUwJYajoHdpbwZ/wTeIGPxtm6Do
         M0Wg==
X-Gm-Message-State: AGi0PuZjzCUCXCbm601SJxsCfVJiCpZCWkno4pczaChJNSnG1y6fefr/
        Czn+XOkRhFeXMH9ffV2cDUnfLvfZ1LUTanP/DTvdUw==
X-Google-Smtp-Source: APiQypJGuJOqkYj/Ehe30t1U9ZuH6dYK9mTv6Ks/1KBhVVrW2UXVfGzjV05x98HDEPK+WR5eLGwOBhDPQRAntg4Ru8g=
X-Received: by 2002:a2e:8e85:: with SMTP id z5mr6778180ljk.165.1587059134502;
 Thu, 16 Apr 2020 10:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYt7-R-_fVDeiwj=sVvBQ-456Pm1oFFtM5Hm_94nN-tA+w@mail.gmail.com>
 <CAM_iQpXQdgwFwUONX+za5vJbcXP9krwz_--pG+z_Etf_v8K2mw@mail.gmail.com>
In-Reply-To: <CAM_iQpXQdgwFwUONX+za5vJbcXP9krwz_--pG+z_Etf_v8K2mw@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 16 Apr 2020 23:15:22 +0530
Message-ID: <CA+G9fYtCV55uuArU4OLCTaaBPk7BDeZyOBUHoScN4NsbQeuPhA@mail.gmail.com>
Subject: Re: x86_64: 5.6.0: locking/lockdep.c:1155 lockdep_register_key
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Borislav Petkov <bp@suse.de>,
        Netdev <netdev@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>, lkft-triage@lists.linaro.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Apr 2020 at 02:20, Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> On Tue, Apr 7, 2020 at 2:58 AM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > On Linux mainline kernel 5.6.0 running kselftest on i386 kernel running on
> > x86_64 devices we have noticed this kernel warning.
>
> This is odd, the warning complains a lockdep key is static, but
> all of the 3 lockdep keys in netdev_register_lockdep_key() are
> dynamic. I don't see how this warning could happen.

I request to provide a debug patch which prints a detailed log.
Happy to test it again with your debug patch and will provide more information.


- Naresh
