Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A655AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A9122074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wi9oG8lz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgE2HqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 03:46:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27384 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726845AbgE2HqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590738380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7bp9K1xQDo+AhoH9e/7SQpViLsmuixXQeTMU/HkuiBc=;
        b=Wi9oG8lzq3pmDOxcCtwtUrBnmhoKCjsE1GZOL+CeJzrcCFSx+irwGICIwwVIF0z5XbFCj8
        MmOWY91c4yDJofSoClsOhsRQNVRhCPtpi1LYYboWTWS9ZE4TZBtQe8M1G3XzjgXW+CBnES
        3Jj8lcpHMCwmiLMwukq/MNxRFksAAqQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-McPVyvfdOVuH6nHXtBlM6w-1; Fri, 29 May 2020 03:46:17 -0400
X-MC-Unique: McPVyvfdOVuH6nHXtBlM6w-1
Received: by mail-wm1-f72.google.com with SMTP id p24so367475wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 00:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=7bp9K1xQDo+AhoH9e/7SQpViLsmuixXQeTMU/HkuiBc=;
        b=fBCjpx+V7nhXx0ZmyToqbay5ORvKGWZGINSZ75qoCnrgl92emqsQWRX8MJcCw9aE7R
         cGiTisjdMrtuhraWXy7M4ncSeGzSuwR2kP4Y6LWRe8SqJ4OU39lRKmFCZNA6VI4gI9Ga
         Sm5VWinALVhIxKrSQSBRGz4ZFkx3ygIGqtfBvdmnlO6rNdtcw5t+pesPFjvJTTBqT1MT
         xIdviSqOwurDY5Cvsn3Ce71TcU5BN/wB4Svcda4LW4eE7Vxu+I+BgHDIj6Nwe5RT+cWy
         9spLA7DgoHPZ90DGvtj+yCFNuyvJZHhmG0t5spJB1fEvDEW3xYZ57bJFyssMnxD/agIE
         r3jw==
X-Gm-Message-State: AOAM531G9e+jfPMTrCnFo8Pegsgu0DXm/R+cunuwoE+KTrW8ysFxGOMD
        aPKq0XC9sHMkg+5wR1M9nrOFsO4HlyKNdE7ZfNaDmVrdJ1O9n0vNrKwPllNiiipKS9Jdi6IPgRP
        03Cjb5MOsZp3ikCGZ4git9C/J
X-Received: by 2002:adf:e44c:: with SMTP id t12mr7073399wrm.181.1590738375682;
        Fri, 29 May 2020 00:46:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhI05ctvDPHmK0GSn7jXPozth0v0wonOshy3raxVwfo1HlERJb1RrSppYq/7L2egaQSMLAgw==
X-Received: by 2002:adf:e44c:: with SMTP id t12mr7073381wrm.181.1590738375477;
        Fri, 29 May 2020 00:46:15 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u13sm8796062wrp.53.2020.05.29.00.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:46:14 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+904752567107eefb728c@syzkaller.appspotmail.com,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: x86: Initialize tdp_level during vCPU creation
In-Reply-To: <20200528194604.GE30353@linux.intel.com>
References: <20200527085400.23759-1-sean.j.christopherson@intel.com> <40800163-2b28-9879-f21b-687f89070c91@redhat.com> <20200527162933.GE24461@linux.intel.com> <20200528194604.GE30353@linux.intel.com>
Date:   Fri, 29 May 2020 09:46:13 +0200
Message-ID: <871rn3ji9m.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> I'll looking into writing a script to run all selftests with a single
> command, unless someone already has one laying around? 

Is 'make run_tests' in tools/testing/selftests/kvm/ what you're looking
for?

-- 
Vitaly

