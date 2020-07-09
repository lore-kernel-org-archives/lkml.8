Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935ADC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C24D2076A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594328300;
	bh=Xkf48gTToGHllmUfrT0K4xurBoHvQ3uI/4oa3YEsiwc=;
	h=To:Cc:From:Subject:Date:List-ID:From;
	b=TOkjrMLnCb3GbdFxzPqe1xRrPts7WRMu6OajQ/tBTWgE3ntlUpLTKdvHrOI3JHWk8
	 XuzTkPFg9zFocACrPOMrM4JVRdsmxC9xl2vcuB3LrBTmzDkU98OK0w2EDnQLXGF50z
	 hghYuY8g+RDj5rQmvdrO3w2pfCJ06wNHSbiONxyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgGIU6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgGIU6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 16:58:18 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425E3C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 13:58:18 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id t198so3013177oie.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 13:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=EDWW8ZPjyoebchhz2GeXwkSC4GQIj8hrZuuqox3N7vI=;
        b=bBHUN6OrbVFW8ceOMeAHbEHtBJUcTipUpBqltr2dVz+TlhHHs5pB+MtFBe4Gpm2SMH
         np9N0u/xz0XqMfDOwx4i4gYWv4ZXNlnsLKLZknNaLuxns3QKjEo4D9Px25Ev1HTSyNJv
         1w6uG33jIB2kPxfk+Zu16fXFpvxJkTXJz8euA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=EDWW8ZPjyoebchhz2GeXwkSC4GQIj8hrZuuqox3N7vI=;
        b=TTyIeP13KSOTI00wymm1nns0LBManL0Fy+Uer5XevlNLDXiT6teUTVnC82E/7dGcF3
         PasuNLGH62bxjkhSAW/RU/1UtIH2y7v+qty8QaVbWzoeTrF4AgVRLFXzqaTmyeLB1jZI
         4vRek7Gnl9Y6J6sMkEUhYGG21yt8fcLSFZSCD3zHWhWKHWzIkw3Qs4r+pLgQS7mFR4Y3
         Qn6aiFpbWYYMP0ZKnZeyf790cAQ5Cxh+e2+Hvd6A+dJ6MhI2DllgB7Y3EyZqz6BGoNh8
         BrCzZ5AjMmh8HICw3ggv4jLSzAhfxrdA3fUAMEMpBXiX/eKRw/y9GNNMO/TuFi/wRGWQ
         4Uyw==
X-Gm-Message-State: AOAM533gbvkbFj8fqxGtsF3iXaB0HwxFaFSe0vEhPLJPl/6xA7Qjao7s
        7cAr9JlPKiuZtZ2CpaqMntxiTQ==
X-Google-Smtp-Source: ABdhPJytgSEh45RvMZKy1z5ZYTrYSnGPT/HMB+mqjdUMUGmtsq60LuL3wXhvh7+HhOi76fn4nN2I0g==
X-Received: by 2002:aca:5c03:: with SMTP id q3mr1769738oib.132.1594328296417;
        Thu, 09 Jul 2020 13:58:16 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d193sm704681oib.53.2020.07.09.13.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 13:58:15 -0700 (PDT)
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-safety@lists.elisa.tech
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
        "lukas.bulwahn@bmw.de" <lukas.bulwahn@bmw.de>,
        skhan@linuxfoundation.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [ANNOUNCE][CFP] Kernel Dependability & Assurance Micro Conference -
 LPC 2020
Message-ID: <675ed25a-3fa8-e288-1be4-41710a807d1f@linuxfoundation.org>
Date:   Thu, 9 Jul 2020 14:58:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the call for proposals for the Kernel Dependability & Assurance
Micro Conference at the Linux Plumbers Conference 2020. It will take
place online during the Linux Plumbers Conference on August 24th-28th,
2020.

The Kernel Dependability & Assurance Micro Conference is intended to
bring the safety-critical systems community and the kernel community
together to start a dialogue and collaboration on making sure that the
kernel is fit to be used in safety-critical systems and that questions
from the safety community and other wrt. software quality can be
answered adequately.

The goal for this conference is to explore kernel dependability as it
relates to safety-critical applications in the areas of uptime, tooling,
and processes. The focus is going to be on the following topics.

- Kernel Quality Assurance beyond Testing and CI?

- Understanding the User's Expectations on Software Quality for
   business-critical systems

- Define safety requirements for overall kernel: features, tests etc.

- Define run-time characteristics and requirements

- Identify missing features necessary to operate in safety critical
   environments.

- Discuss safety features

- Regression Testing for safety: Identify configurations and tests
   critical and important for safety quality and dependability

- Discuss and identify gaps in tests.

- Add tests and add configurations to existing test rings.

- Understanding the Kernel Development Organization and Management

- Assessing, Measuring and Evaluating the Development Process

We encourage submissions that do not present a final solution. Instead,
that serves to get feedback from the community, to point to action items
for future development, and that can result in patches for the Linux
Kernel and Linux ecosystem in the future.

Please submit your proposals on the LPC website at:

https://www.linuxplumbersconf.org/event/7/abstracts/#submit-abstract

And be sure to select "Kernel Dependability & Assurance MC" in the Track
pulldown menu.

Proposals must be submitted by August 2nd, and submitters will be
notified of acceptance by August 9th.

thanks,
-- Shuah
