Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0F6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4C8722403
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPKE3WWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbgFSW6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:58:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55747 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730201AbgFSW6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 18:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592607530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E2BNk2Ub7uBT0HBt8BMR2hg/5o8g14jlSam4dCx84bQ=;
        b=cPKE3WWVwDbAMxYSBshkPK1kjbrkYoyf6FT0wbGYl7mmRFb5l9QOAkIukDSUGcy35rpPTw
        nxHsrzqLRJ0a6DgWGj6VQy+ts4yreyQV70UF4fcXoZofoz723pfKUxEwKWTa+KaqZcASN5
        2CGcLSmfb+NtCPYMQmgYfyIdqAKnXAw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-3F4YsLcRO0KdIJkYrjFrFg-1; Fri, 19 Jun 2020 18:58:48 -0400
X-MC-Unique: 3F4YsLcRO0KdIJkYrjFrFg-1
Received: by mail-wm1-f69.google.com with SMTP id p24so4891983wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 15:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E2BNk2Ub7uBT0HBt8BMR2hg/5o8g14jlSam4dCx84bQ=;
        b=qQGoPrproIGc4d33dxfnaGKTGyKOu4V9yZeqyYxF3vgfOcSw3RVz1wrOV9+2Ie01z1
         5+CubXXxN01Oj2KyiH4f0ytk9DdlZYDhPMjglv6Eu9bKXzJiVHVZ9l1IymALEpA1vRCh
         HQkghparLoiy1DvPdivuY53KAWE1IMc4w91tmWSYAVheqHRACXR+oOH34k5aVt5gK1mt
         6J6DbOHcsNjE36pgVBXKe1nRVDTiGuDQEExGtgbbrxRXYJkjTYljoh/mP63iESgEz84c
         1miUbYYO3ThL9mo2j9C7imdl8cWxlbByfRYe1XhzZTGOwjvbed3zBAsKCM7JnvKiTgjB
         Wh8g==
X-Gm-Message-State: AOAM5324e85tEFbN5Ufz7ZHDtTjw3qFHkXzsUmaSXsMFQhHAeP/AHbWo
        PVOIpuqNJNEXBnLlxpco87Da1IGRg8JBQ87GAgNmlEOQOGCpmn+ngCaJMKSMuKm0lK2nVKbL0b8
        jCAJOLsxoQrdj+6PXeFlxVo0A
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr5779789wma.148.1592607527323;
        Fri, 19 Jun 2020 15:58:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMKhY/RzPovyTwhCbOPKYFuzo5dk0SjaJP0wmIxsSDDxtGzS04gtLD/QEWjSSWySAcyxN+DQ==
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr5779776wma.148.1592607527023;
        Fri, 19 Jun 2020 15:58:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e1d2:138e:4eff:42cb? ([2001:b07:6468:f312:e1d2:138e:4eff:42cb])
        by smtp.gmail.com with ESMTPSA id r12sm8693338wrc.22.2020.06.19.15.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 15:58:46 -0700 (PDT)
Subject: Re: RFC - kernel selftest result documentation (KTAP)
To:     Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     "Bird, Tim" <Tim.Bird@sony.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006141120.96FF8C5@keescook>
 <CY4PR13MB11757D57CD441C5CAEC3F257FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <7161fadb-45ba-c4c0-8bbb-cb47d2dd0265@redhat.com>
 <CY4PR13MB11755F5A6879CA3FFD005426FD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <CAFd5g454n4ZPgCdWaAxezFueG47TztqBx4L7x4oYwgPAR3BZNA@mail.gmail.com>
 <202006161653.15C278A5@keescook>
 <398200b2-f8bc-894d-6d6f-366ff98a490e@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c60c25ab-6737-1cc9-4370-dae4ebb4b823@redhat.com>
Date:   Sat, 20 Jun 2020 00:58:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <398200b2-f8bc-894d-6d6f-366ff98a490e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/20 20:47, Frank Rowand wrote:
> Or if the entire test depends on the missing config then Bail out might
> be appropriate.

No, in that case you want

	1..0 # SKIP: unsupported configuration

The spec is not clear if "Bail out!" is an error condition or just a
warning that only part of the test was run, but prove(1) and Automake
both treat it as the former, for example.

For example, an ENOSPC error creating a temporary file could be turned
into a bail-out, while an ENOSYS would be a skip.

Paolo

