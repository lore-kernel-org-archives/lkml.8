Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A0CC3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8A52468A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gL0eJDOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgB1GNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:13:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36619 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725805AbgB1GNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582870422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bQZy9BsnvGs4DJv5PXGxTDbanrd6o8j4AgcuAD33/N0=;
        b=gL0eJDOl7vlHydvzS5K977amjwoLSuIk8HVsK7iIh9eIQQJtlBPIdLnursLB05zRYZTCKT
        5uqK/hWKwEey9p4RXXxI6PGLVHpgdTzPXJzNHtC1wWvI+/2Pe/m7RnHDSa3waRHYaqGh40
        JcvXxyzInXwS1ECKfz8p+XGcPsJ7fAE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-_OK5fbG8OAS5AcWh7nKAPg-1; Fri, 28 Feb 2020 01:13:41 -0500
X-MC-Unique: _OK5fbG8OAS5AcWh7nKAPg-1
Received: by mail-wr1-f70.google.com with SMTP id w18so901958wro.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 22:13:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=bQZy9BsnvGs4DJv5PXGxTDbanrd6o8j4AgcuAD33/N0=;
        b=BXTswqCSAX8UEIgC3eZ96qj5IpvBJWzywRlYJ/yn+SS6zbPWwnqv6qQGInza4waj2q
         sOtf7JsE4rpqHNIkaqdAxhbtlgZlhikU49Pjj4iGrM2dF8WVMU2s8qTKhIo1/S2ZdVex
         mxq/FxwW3a9gB5XJYqVrzezUFhZnKnVLCyKD3vAvUm0rYe+llhWxCgdK56QvQnYV2eGa
         DeWU4k6tlcbdDntq5TVCWS6rajsXdQKZPzAKfrgpYf9TnkYhYdxwkJYrGkwkR5FFaOxc
         0swxWdniyledfxJKhanqNQMuRbAcQcj1jI6F0MANsE71eXHseADMbF2zuQg1+naploIW
         Kwjw==
X-Gm-Message-State: APjAAAXs11ptvbcnWwqIZ0iQItyTclfqyGvjw3ODE2xqq3p0gFZbjVyY
        Z1sqxq9Q1dN2iakvAJLSHVt9UyxjO07ppGOcXdxK23gQJVdOIIibQWv2sp36apoC7RqDrWQ40f9
        q0iZKn2pawVxYpmwSCe9649EV
X-Received: by 2002:adf:cd11:: with SMTP id w17mr3255777wrm.66.1582870419889;
        Thu, 27 Feb 2020 22:13:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqytLtf3bqBmoH4VSVokPNlQ4OLwr+04hPKM7EP6nAym2oOemd792mZP0+koSwsZr1UOB4jSLg==
X-Received: by 2002:adf:cd11:: with SMTP id w17mr3255756wrm.66.1582870419682;
        Thu, 27 Feb 2020 22:13:39 -0800 (PST)
Received: from [192.168.3.122] ([91.12.99.244])
        by smtp.gmail.com with ESMTPSA id 25sm682892wmi.32.2020.02.27.22.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 22:13:39 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC 2/3] mm: Add a new page flag PageLayzyFree() for MADV_FREE
Date:   Fri, 28 Feb 2020 07:13:33 +0100
Message-Id: <0C8CC772-5840-4F0C-9859-C1D7B8BF6025@redhat.com>
References: <20200228033819.3857058-3-ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
In-Reply-To: <20200228033819.3857058-3-ying.huang@intel.com>
To:     "Huang, Ying" <ying.huang@intel.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 28.02.2020 um 04:38 schrieb Huang, Ying <ying.huang@intel.com>:
>=20
> =EF=BB=BFFrom: Huang Ying <ying.huang@intel.com>
>=20
> Now !PageSwapBacked() is used as the flag for the pages freed lazily
> via MADV_FREE.  This isn't obvious enough.  So Dave suggested to add a
> new page flag for that to improve the code readability.

This patch subject and description is *really* confusing. You=E2=80=98re add=
ing a helper function, not a page flag. It=E2=80=98s a fairly easy refactori=
ng.

(Adding new page flags is close to impossible).

Cheers!=

