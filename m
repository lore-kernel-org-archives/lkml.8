Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2495EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1A26208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CN7jmiIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389144AbgE0OVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:21:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34912 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389135AbgE0OVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590589310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+qKyyBRTH3XVnPxCnLL3xw/KfsJfCnDk6EWAHME3F1E=;
        b=CN7jmiIUd2q9HmDO/it777cjDn083BHbK+gtcwYo5HKoR7S2DsNIRHUVLKeXz/WFBacgPy
        EsJwRCECuhCW1aI1OXdGu4W3pfCCkql8oYNyEge/5fvwW8WJYxXIvfY7Floml3EMlc25KI
        M0im/JY9kfaT0Wr6ewgRkW4fbXRc884=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-p--wzi_mP8Odmny0Lkzj_g-1; Wed, 27 May 2020 10:21:49 -0400
X-MC-Unique: p--wzi_mP8Odmny0Lkzj_g-1
Received: by mail-qv1-f71.google.com with SMTP id da20so13086691qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 07:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+qKyyBRTH3XVnPxCnLL3xw/KfsJfCnDk6EWAHME3F1E=;
        b=BT9BwtZrif+9mSmg5cr7z0XwSqkMSifsGTTTn6LqD54WFkgbDrrLzeGbnjJNLpz/Vm
         Zkz4aDKR0suJvfpLGHAJ1FsGSSqz/rtataSrY+Mn+XQhzwnM1TNQJg0vgTp5kQK2N2Xf
         jwlGlLct8e2ZT+NVR/38zTQbqjYjmfneAEwLqJ+td3hiSJFeRqKCQI9JUsZou53haYj8
         UgkYmT5Jd1As5wKXLHM43slnAs+UQKN2N6swuaef/eqqNQJLRxdqWWrVSgWN+SBBTyx6
         oEn9hvXCRiZViuoqAx4IIVZzRL3Ly6K22D4Dyiw0W0P12YtHU7uUlFlZeuk7Oj8jpR1Y
         w04g==
X-Gm-Message-State: AOAM530DRfYPSVwhznSoVX1oGgJ/d89LZTIZ2z/btxCtzgWpDy7wsA0s
        4H/xI2Ziqp0fbBLURmLrY1ZkYVn8gtCfKr3O+53bqw+QirD+Gbry0ubOJvHl6JmogOt8s48mrX0
        fy8UmuF4u1zDptYM4w27E/DED
X-Received: by 2002:aed:3789:: with SMTP id j9mr4285362qtb.91.1590589308514;
        Wed, 27 May 2020 07:21:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwihHLn0ti/EItryQRylb806cTWUWIhBXutkjRQ5eKo3P4M2NgCdZYYiE+bYtZk1b3gfqoEHQ==
X-Received: by 2002:aed:3789:: with SMTP id j9mr4285327qtb.91.1590589308223;
        Wed, 27 May 2020 07:21:48 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id 88sm2618476qth.9.2020.05.27.07.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 07:21:45 -0700 (PDT)
Date:   Wed, 27 May 2020 10:21:43 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     aarcange@redhat.com, akpm@linux-foundation.org, cracauer@cons.org,
        dplotnikov@virtuozzo.com, gokhale2@llnl.gov, hannes@cmpxchg.org,
        hughd@google.com, jglisse@redhat.com, kirill@shutemov.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maxime.coquelin@redhat.com, mcfadden8@llnl.gov, mcgrof@kernel.org,
        mgorman@suse.de, mike.kravetz@oracle.com, pbonzini@redhat.com,
        rppt@linux.vnet.ibm.com, xemul@virtuozzo.com, keescook@chromium.org
Subject: Re: [PATCH v2 1/1] userfaultfd/sysctl: add
 vm.unprivileged_userfaultfd
Message-ID: <20200527142143.GC1194141@xz-x1>
References: <3b64de85-beb4-5a07-0093-cad6e8f2a8d8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3b64de85-beb4-5a07-0093-cad6e8f2a8d8@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 02:54:13PM +0800, Xiaoming Ni wrote:
> 
> On Tue, Mar 19, 2019 at 11:07:22AM +0800, Peter Xu wrote:
> > Add a global sysctl knob "vm.unprivileged_userfaultfd" to control
> > whether userfaultfd is allowed by unprivileged users.  When this is
> > set to zero, only privileged users (root user, or users with the
> > CAP_SYS_PTRACE capability) will be able to use the userfaultfd
> > syscalls.
> 
> Hello

Hi, Xiaoming,

> I am a bit confused about this patch, can you help to answer it.
> 
> Why the sysctl interface of fs/userfaultfd.c belongs to vm_table instead of
> fs_table ?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cefdca0a86be517bc390fc4541e3674b8e7803b0

Because I think it makes more sense to put the new key into where it suites
better, irrelevant to which directory the variable is declared.  To me,
unprivileged_userfaultfd is definitely more suitable for vm rather than fs,
because userfaultfd is really about memory management rather than file system.

Thanks,

-- 
Peter Xu

