Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6921C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 06:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7A1A206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 06:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKTefwzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgGJGCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 02:02:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54329 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725943AbgGJGCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 02:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594360967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xr6sF7nLX+jiDlYkdiRpogVjgNVxfUMLwXTP3iCqcp8=;
        b=FKTefwzHf6DtnDCm0XsRvAMqSb3gTsNAMyaIoyzhZnPzDP1TXiKqPsnJXi2EHDkvdMJ/+a
        6Os1QJsvLAQH6TtEGEyuXShbw+hiC9y4pRmPmvs27Sh+lC4spprta2AI0aUJQbzHZm1jnL
        3ueooX86IfG5lYM/0gZH6LU4GpXPDas=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-vmsgvkGHMdeptKAZjhP77g-1; Fri, 10 Jul 2020 02:02:45 -0400
X-MC-Unique: vmsgvkGHMdeptKAZjhP77g-1
Received: by mail-oi1-f199.google.com with SMTP id p145so3189022oic.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 23:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xr6sF7nLX+jiDlYkdiRpogVjgNVxfUMLwXTP3iCqcp8=;
        b=N+dTC962Kv7YRFIOMV6gVOUds1/l+D21tygbi3iSI6z9cenaklhtGFbYbs8wcsS1jR
         FoQam16KLPfXd+SkJQaKU2zGKXUiFSc+FjiWwreRrHsTxLjdZh1CbeZ7jsmgSS9QCYW9
         DOL1411LYoZFf4ZdA/YiNUIZGm9YmUxJOr+Y7h+yF0zO2rj5VByPygw53jEosbh2C7Vr
         ew5y3BRVE7vaHqGxFS+cYNFzNkp/c+g2MNSOxVXYLzelAp3lc6qnNtqpUhRUigAcMPEG
         aVfuZpn/qqHpl/d8kmZv0wIVCnFndzzHUiyGwCoPtq+MX7M1cJyw5oJd1d+jbtGrZJoq
         wG0g==
X-Gm-Message-State: AOAM530olkU5p9EI2PP9ur080r4CVPyBAo3tG926zX1UsRcc4kn7vKUM
        ih/g5JN7tEzZghdL1cLEoAh1oSlx+9oGSQ7SOTSE2ExXWOQb4oNUH3hVFobri4BBd5YuyR4FTyu
        Zr7mj4qiviRUAplddgooNxegzQ71aYVQb1/eO9Mqd
X-Received: by 2002:a9d:c08:: with SMTP id 8mr55439013otr.187.1594360964653;
        Thu, 09 Jul 2020 23:02:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyWRDXQOxEoIeSRn2FeoMmze0VhGuYEL4K1E2DGwe0xC3DwjlDx8cdB5v+DCWt8qCHMZByA1rq6DeYZJ/IvE8=
X-Received: by 2002:a9d:c08:: with SMTP id 8mr55438986otr.187.1594360964387;
 Thu, 09 Jul 2020 23:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200709064946.GQ3874@shao2-debian> <9cfe8123-9cd7-a6ec-f73b-3252d695a387@linuxfoundation.org>
In-Reply-To: <9cfe8123-9cd7-a6ec-f73b-3252d695a387@linuxfoundation.org>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Fri, 10 Jul 2020 09:02:28 +0300
Message-ID: <CANoWswkjNnyBi68HL6VjX9dWt6VdjxycXV09j5L+jkCAbnrHrg@mail.gmail.com>
Subject: Re: [selftests] 7cb32086e5: kernel-selftests.x86.check_initial_reg_state_32.fail
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 6:36 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 7/9/20 12:49 AM, kernel test robot wrote:
> > Greeting,
> >
> > FYI, we noticed the following commit (built with gcc-9):
> >
> > commit: 7cb32086e59b514a832a3e11f5370d37e7cfe022 ("selftests: simplify run_tests")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >
> >
>
> Thanks for the report. I will drop this patch for now from next.
>
> Yauheni,
>
> This patch broke x86 32-bit test run
> make run_tests -C x86
>
> Please resubmit the patch with the fix.

I did not check carefully the report, but isn't it expected that some
tests are moved after the patch since they originally were placed
incorrectly?


-- 
WBR, Yauheni

