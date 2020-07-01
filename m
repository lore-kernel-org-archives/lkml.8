Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E23C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A8A120722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esb0EVjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgGAJQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbgGAJQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:16:04 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B168C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 02:16:03 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id i3so17829116qtq.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 02:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=AVkuAQt3zmUSd/hP5pmgdSg0Mi9G3q8Aq3nV0Xeims8=;
        b=esb0EVjJA5DlIn02z1t5pQxqr8kr0wcygddY6z9Yry2z56FJRpTPHE0otRarZXkB5+
         6BH5sAAuLGjjjVcze3A6ciJI2mxsOdNSEX4ZU9rdNQCTX2UTA5gUqNfOwOvgu+Y4jzUQ
         EqdDNEmno7UnEd9S5pNL6FmxCU6x5Conxn12BWj5O+PS4ufjL0KiK/tobWeqqnlV3SZZ
         nIAVpJbourfONSOXP71pCS0kJ1sM+nccJyhPb4xfot+jTgdbBoyKTm6v27kY6KokbYk1
         zO+Gpn87l3RnbwHOTMOFoEbm8Nn4V44SnEJWftesNB84ksj+r/S7XkK9LenJk2q3uAU3
         ffPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AVkuAQt3zmUSd/hP5pmgdSg0Mi9G3q8Aq3nV0Xeims8=;
        b=gkST+K0ueKwco/YYNYPGLwCsmZiIXw6QYfx9Fqo8sMy5ooeeOjjsWls2pem9jpA+kH
         sNaETTF8koXFA3SIcFKFlT/ympQ+4qZc38MN/VClWLp2bN5egfoWjPcM6KVaA/dNJ3Zg
         CIYdaGoUSyjvvJ92u6rIPo9O+EI/1XyFWV3GK3VTvX0FHwsTUFKQ1y55iju3WoB6KapZ
         z4iEpa3JXTlaLlmHs2iZyhjdjkLniAtuDiI7C0tdvH+CKWEm0c8KulCu8RRR3/9csqO/
         oWfOihwBt6eH/WNhqC2ENVQ7M8X8PAX6DSaPYw5IXFWtXmzT8Yh3oKE98hXjqeCqy0qN
         pjcQ==
X-Gm-Message-State: AOAM530eFOSEyScuVGQjiIhBUj9qgDWk6aSrzNBODOl2j3sIdV2qtrhl
        0DT7cnmZK0/P6nuBeezTsCoS5BV+jaC4YI2t/3IaQMmsAVk=
X-Google-Smtp-Source: ABdhPJx/u4yjQKbhh5anvd68Pt5r4U8q1ZuOQm5YgQmmB6YCa8gVmo2aAmLB+bHD7SOSyRoLfHsnOcK2CgYUlJ2QLfQ=
X-Received: by 2002:ac8:172e:: with SMTP id w43mr14000587qtj.8.1593594963166;
 Wed, 01 Jul 2020 02:16:03 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date:   Wed, 1 Jul 2020 17:15:52 +0800
Message-ID: <CAAvDm6bGBbN=EiJxO9Fq9HqLz6F=hSQqjKms_G6qPHzbZ6G3zg@mail.gmail.com>
Subject: Are there some potentially serious problems that I should be aware of
 if I totally disable the CONFIG_ACPI option on the X86_64 platform?
To:     Kernelnewbies@kernelnewbies.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, list

Are there some potentially serious problems that I should be aware of
if I totally disable the CONFIG_ACPI option on the X86_64 platform?

Would it do harm to the hardware?

Thank you for your attention to this matter.
