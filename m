Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CACC2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C85206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZoXf2i3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgDHVZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:25:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41795 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728187AbgDHVZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 17:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586381151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UJBpmrLVUaj5bFLbNbY74eKb6lWRZxALhzam3N9grC8=;
        b=ZoXf2i3fP1ci9z4jzb2lv1oi33tvwPOImsAWKFa+622VF2T/VlywwTsHIxB+EmMaVDSFMI
        gCrf9r4qDK5xWoPVPEYED3mH4yI8dHVGag3fA1io2P0szhabBACPkkMVxXH4fm9jPs7lgD
        1IZXJHn4muj+aXtinRdyYGrKA4Rjocw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-Gk-jcBdRPgebs1cFiDOgZA-1; Wed, 08 Apr 2020 17:25:49 -0400
X-MC-Unique: Gk-jcBdRPgebs1cFiDOgZA-1
Received: by mail-wm1-f72.google.com with SMTP id s9so1104730wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 14:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UJBpmrLVUaj5bFLbNbY74eKb6lWRZxALhzam3N9grC8=;
        b=MGCFt8o4BkvEpCrGnJE8xGii7x4vtvgAgJ/8zguX73oC6lAc17KqWNay0tclI6n8C/
         EOiZ0z9wniRBRjHCmuPvWhRKJ5t/PmoF4QswUJs8Pus9Is2vXJGNMSwG3mrcZ3mC/Nch
         t+SPQMoNrAFFsoSff6ALDUvI4fousnzaKX1ZCynbnTOx9N8uR+YHrQBCHGkzRUNQlkes
         6YklaZV6/9xIWAmlSXB38dsmrWjzcQ4JaBgtfZWe7266XGzwWlIU2Sqv0o2v92MSecyb
         j1OUldTAVHjthxZte8RyDYpFATSDAWScwf3uud6+Dapg8Qf1vBPIdPiO/iY3hpgQvRi6
         IjYA==
X-Gm-Message-State: AGi0PuY65tNYEE6P4iaKrAVCBxZtYiXZnGSBi8c6ZOgRwFvnRgqlMV44
        N+IB+2IFsRkan1A+LnajjVHVe2Ani4OwJaWf+/Y4xToWss2HV0eaxncoGQ1heJia1xs70WPMUhp
        UV2JqDLfelBWpInyvq8nroba7
X-Received: by 2002:a1c:2705:: with SMTP id n5mr6375968wmn.94.1586381148142;
        Wed, 08 Apr 2020 14:25:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypIEypWtp8IszcU/gyunBrcO7Rg/owcCayhmUqap5hxAkVPpXeNBGcvzCuxiSUBSePrEqghURw==
X-Received: by 2002:a1c:2705:: with SMTP id n5mr6375955wmn.94.1586381147897;
        Wed, 08 Apr 2020 14:25:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9c71:ae6b:ee1c:2d9e? ([2001:b07:6468:f312:9c71:ae6b:ee1c:2d9e])
        by smtp.gmail.com with ESMTPSA id t17sm32671085wrv.53.2020.04.08.14.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 14:25:47 -0700 (PDT)
Subject: Re: KCSAN + KVM = host reset
To:     Qian Cai <cai@lca.pw>, Elver Marco <elver@google.com>
Cc:     "paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org
References: <E180B225-BF1E-4153-B399-1DBF8C577A82@lca.pw>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fb39d3d2-063e-b828-af1c-01f91d9be31c@redhat.com>
Date:   Wed, 8 Apr 2020 23:25:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <E180B225-BF1E-4153-B399-1DBF8C577A82@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/20 22:59, Qian Cai wrote:
> Running a simple thing on this AMD host would trigger a reset right away.
> Unselect KCSAN kconfig makes everything work fine (the host would also
> reset If only "echo off > /sys/kernel/debug/kcsan” before running qemu-kvm).

Is this a regression or something you've just started to play with?  (If
anything, the assembly language conversion of the AMD world switch that
is in linux-next could have reduced the likelihood of such a failure,
not increased it).

Paolo

