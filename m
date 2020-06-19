Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65480C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 00:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34290207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 00:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lfo+hRz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgFSAMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 20:12:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45857 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726478AbgFSAMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 20:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592525528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4IvmOEXU995/nnkIHpkUNgSHVYZli54q5t/36kQjlWA=;
        b=Lfo+hRz8/YccCFrWEmw79/zFStvb5R7ACfUUpSk1QHwA54rlD1bI/XHzjkd6rs+Y6CIHil
        IzoMvb6IRNyfbumN63of9Q7FaL//CePbCvTt4YlPK3R2HLzPlAvaTj7sSQ2fDQ2utQGQkL
        Pb4FdkXSlsNVBgkxINTjBttRQ0AEMec=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-S4XqYz-sNRC1UOpFdYNmUQ-1; Thu, 18 Jun 2020 20:12:07 -0400
X-MC-Unique: S4XqYz-sNRC1UOpFdYNmUQ-1
Received: by mail-qt1-f197.google.com with SMTP id u26so5739958qtj.21
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 17:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4IvmOEXU995/nnkIHpkUNgSHVYZli54q5t/36kQjlWA=;
        b=aRrReSnh3Drim4yTDt+tDqJFk6qBbpk9+1c8YvvcBWKYDAbvinqtfm1vlu6t1JhYdK
         gx6uSNBOREoZjr9pgXJ0mPOvs7Z0S//cmORMtz4l9FiQVNxeBMfq8OciwQr51Sm5zUe8
         BvDpn69THnT3l2rj8f+g/iBfbyj4yKFauJRdw76zIEleClCoPgbpRuO/+Xnm3iZoPdft
         l+hyrKbt1Vx3apWNNUDDzBQxQtFSO8MtCtLOvp2KWMP49wSjaBCte5e1X51+NeHy/s/g
         oT+kuHQwA3ThXm1+az6tQY8ASkToOnyJT29B0irBZvL9xjf6UXct0l0BfJP8DutWN1mS
         kQtg==
X-Gm-Message-State: AOAM5328H0ilzeIXQHkZLxdG/gk5FHwMItpzQS5Og8BzxIztdRNZXAnN
        A7QXxUsFgU4AvhlRX4bh50LUk4o5SShsxXxRh2RsDuB/IaXYZa/WQxNpltlcZLSFkT9iH7fzdPO
        l5kMEnfJHtUreEBfkp3oQRZWc
X-Received: by 2002:ac8:4d0f:: with SMTP id w15mr958024qtv.120.1592525526276;
        Thu, 18 Jun 2020 17:12:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsaEDMK957KqZXyUDwEjV/HolMB1Vybv4Ttl9SBvvS0zGdpaROCsM+8lk2j72BNvujeZyNRA==
X-Received: by 2002:ac8:4d0f:: with SMTP id w15mr958004qtv.120.1592525526038;
        Thu, 18 Jun 2020 17:12:06 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id 59sm3278161qtf.41.2020.06.18.17.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 17:12:05 -0700 (PDT)
Date:   Thu, 18 Jun 2020 20:12:03 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-kernel@vger.kernel.org, gerald.schaefer@de.ibm.com,
        akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        aarcange@redhat.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 18/25] mm/riscv: Use mm_fault_accounting()
Message-ID: <20200619001203.GA172559@xz-x1>
References: <20200615221607.7764-19-peterx@redhat.com>
 <mhng-261b69ba-d08f-4560-9c69-f4ece64a7729@palmerdabbelt-glaptop1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mhng-261b69ba-d08f-4560-9c69-f4ece64a7729@palmerdabbelt-glaptop1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 04:49:23PM -0700, Palmer Dabbelt wrote:
> AFAICT this changes the behavior of the perf event: it used to count any fault,
> whereas now it only counts those that succeed successfully.  If everyone else
> is doing it that way then I'm happy to change us over, but this definately
> isn't just avoiding retries.

Right, I'm preparing v2 to keep the old behavior of PERF_COUNT_SW_PAGE_FAULTS,
while with a nicer approach.

Thanks for looking!

-- 
Peter Xu

