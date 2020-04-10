Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50867C2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDA420769
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4H65oV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgDJT1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:27:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53060 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726177AbgDJT1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586546822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ddNmEkCT3NuYAPr19Gh+8RyFM7t2I+OUmUTTKHVjsXQ=;
        b=R4H65oV/piiaFxCONv2hcd8uancE7pSECUD7QWxBzAOxcWBeqN9pEqRellE6VOpm+CkyqF
        nD605fpUH+9FLepEoOx6LXHdwhoL1sOwGQyNtgV1ki1Hg5DDi+ayeIhvzsJI8044A3/WvE
        tNOvb2uCzedeyxcKHAsyfjilBGTzgYY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-p-VmyNlAOqy0ssIhC77wnw-1; Fri, 10 Apr 2020 15:27:00 -0400
X-MC-Unique: p-VmyNlAOqy0ssIhC77wnw-1
Received: by mail-qt1-f200.google.com with SMTP id x7so2649435qtv.23
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 12:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ddNmEkCT3NuYAPr19Gh+8RyFM7t2I+OUmUTTKHVjsXQ=;
        b=akLbXiNq0RTdFWCvwOeliSaklruO+i1+g3TDjdG0YJ7MaMHFYj+gpMgs/B48ruS9HO
         TLdGJ3dUXaocAWHwZ/figofxhdVJyFOixdodsR0aqXUvmSa8BehqOe2JLi7gWrsjarj5
         dwS/xg5eJdVrcU962aQ9HhW/hqjunPVgNNPNv/3zApDXlcRFIfutNCJEvcs2tCyFARNn
         TFAiVwj0OaulN1KbBN8yYOFHC/I2BzDmYt5HFbryPOxMq3d4yhL18E5ierqMjtf63BUc
         xkdzzICbgiCEZQwgbsko3oZ9fcDdbyRThCrOYcVt1wuHyLD2OyJl/qmlSewXbL0shkFU
         4Vjw==
X-Gm-Message-State: AGi0PubU1oAbexoaCeThauGS1aBZWFQH5BrvZDSi3F8K2VtxG8S6BRvO
        pkSHABubpbQL3VCSaVYf87EvXQ3f8WEqVddvhhEgr+Bd2Fuy1oUNMa+4FAE+B6UAn2ocRQU92qc
        xeJKQsTNb0G/qp8AFpgb1WMfZ
X-Received: by 2002:ac8:2c66:: with SMTP id e35mr769586qta.188.1586546820314;
        Fri, 10 Apr 2020 12:27:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypJUBND9mw4a79BsRjlZQBzcyo9K+K4n4uLp4F1mRayVM5WnYx0Zu2cY7436wozu46yjuIupKQ==
X-Received: by 2002:ac8:2c66:: with SMTP id e35mr769568qta.188.1586546820098;
        Fri, 10 Apr 2020 12:27:00 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id o33sm2321940qtj.62.2020.04.10.12.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 12:26:59 -0700 (PDT)
Date:   Fri, 10 Apr 2020 15:26:56 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Longpeng <longpeng2@huawei.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/4] hugetlbfs: move hugepagesz= parsing to arch
 independent code
Message-ID: <20200410192656.GE3172@xz-x1>
References: <20200401183819.20647-1-mike.kravetz@oracle.com>
 <20200401183819.20647-3-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200401183819.20647-3-mike.kravetz@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 11:38:17AM -0700, Mike Kravetz wrote:
> Now that architectures provide arch_hugetlb_valid_size(), parsing
> of "hugepagesz=" can be done in architecture independent code.
> Create a single routine to handle hugepagesz= parsing and remove
> all arch specific routines.  We can also remove the interface
> hugetlb_bad_size() as this is no longer used outside arch independent
> code.
> 
> This also provides consistent behavior of hugetlbfs command line
> options.  The hugepagesz= option should only be specified once for
> a specific size, but some architectures allow multiple instances.
> This appears to be more of an oversight when code was added by some
> architectures to set up ALL huge pages sizes.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

This could change the error messages for a wrong setup on archs, but I
guess it's not a big deal, assuming even to capture error people will
majorly still look for error lines in general..

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

