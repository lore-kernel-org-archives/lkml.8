Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF28C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C9120870
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PrhC/74b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbgCCQvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:51:08 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33418 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730216AbgCCQvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:51:07 -0500
Received: by mail-ot1-f65.google.com with SMTP id a20so3708897otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 08:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qHOn5vqQErDHAkJzL6biRHoTSOSlgdzSHmMDR1rwOSw=;
        b=PrhC/74bze2iem1KsYtIHMvUu/v2Av2MYk8EydsyRsT6ErJ1YQjmNh0R/wDKNLwWyQ
         giq1Pswj3xm3xsbBxVlb00LD6jgh8VspNAcUdojVVHgzs6YNMORKfgfiLcxXKihiD2U4
         VPumlwmRJK94sUJBBlqZZYGZUQDwIbA2T5iHVgWPvH96kjWeV0LugsEESIk6ALCIRDQm
         RBXbpHeIFbrG+TdqIZuAbNbugBhyCIMZGQaFYAf3mlAz6FH7d7jAZcPCS1yweB7G38bo
         a3New9pxIAHaKb1Yr5Al4Jz6nhSG737F7DafcGI95pWkYx4GRRGQsLd7Cs4k3E6agMnj
         8xSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHOn5vqQErDHAkJzL6biRHoTSOSlgdzSHmMDR1rwOSw=;
        b=cLSZD0VxFIWYo543C6ebYzAr5HIPJAJGacgecQMaGOtPQB67NW8mC42ZMpfb8OdnTG
         6s72u4l9z4671PjwBU78bYABOtp0oMDZv9k6mJZsUjPDAcbYnQfL2Xzngg4N9XSmqTlv
         XSxiUd7JqQzSAehIgbCC0cDxkT3kLXgXeiIAcfUWZvjmW+/1C8SGixF5A/TSQO61WtDC
         scFESQ5oFCvlANt/hKCG6PWUAXKkSUM5mQHFWE+4KJg2//4Z7xoGMDK9ASp+U/gwFAgY
         KAoXSzx41eolp4KVge4NIIhm6AbrffAHLsUGCAwESfTccIiMnjAICUeF45wpaGk8/yd5
         xgRg==
X-Gm-Message-State: ANhLgQ2oCLKUW3jVWXjAdjcdl5W9Xrs074QHCmmktlohwlaiHy5A+O7J
        QXNilQFDXolb6pg/7zIrJYLGVnDY5k0kSXzzn8G0RQ==
X-Google-Smtp-Source: ADFU+vs5bHTlzYDWcHBa7hol10zll+6LrbecnEkuqNf6A/g6QQbYC6octS5rirZT91tqzWiEaJRDmLwA3XoTOV7oDBs=
X-Received: by 2002:a05:6830:118c:: with SMTP id u12mr3866768otq.124.1583254265433;
 Tue, 03 Mar 2020 08:51:05 -0800 (PST)
MIME-Version: 1.0
References: <20200303013901.32150-1-dxu@dxuuu.xyz>
In-Reply-To: <20200303013901.32150-1-dxu@dxuuu.xyz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 3 Mar 2020 08:50:54 -0800
Message-ID: <CALvZod5m3otRRqcLBebbgiZbhoYWAMbMg+ESkacJuj64OP=H4Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Support user xattrs in cgroupfs
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Cgroups <cgroups@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Mon, Mar 2, 2020 at 5:42 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> User extended attributes are useful as metadata storage for kernfs
> consumers like cgroups. Especially in the case of cgroups, it is useful
> to have a central metadata store that multiple processes/services can
> use to coordinate actions.
>
> A concrete example is for userspace out of memory killers. We want to
> let delegated cgroup subtree owners (running as non-root) to be able to
> say "please avoid killing this cgroup". In server environments this is
> less important as everyone is running as root.

I would recommend removing the "everyone is running as root" statement
as it is not generally true.

Shakeel
