Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC566C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 21:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF80820661
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 21:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qg4TL8Iy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgDXVCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 17:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgDXVCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 17:02:50 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAECC09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 14:02:48 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id f7so3143238vkl.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 14:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N+lekRCvAeIq1HnnVu1dMr0TEj8QJMC4PyRn69xzXA8=;
        b=Qg4TL8IyERbxZ4ldVherT7+8Xp22wDPat2HaRwguiuYRWkHmJToETRessf3QYBm1Ft
         wY1Jb6qdGOziULEpvY3RofC6ZToMQ7N8Nv5/ovg+dXabXbVgwsl690rEWl8vrgseQB8r
         o8iYO6aXpywZAV6M1ErBHT81hacRpcIkf6vBVbc1Bk/bslDfeJIYkrAcuhawRhxgy6sn
         dgNBoYanlSF7pjWMgIscOqeTapc0cBHQqrZ8yty7T2W0a+o4Zzps6JNC20hoV7RvFfE+
         yPYke/KYEbnIXqd0/8HhSZ+QW0e5GgLSl4rcyKyhyk21cEL531r5ANHAGM8yOCIIraGz
         FX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N+lekRCvAeIq1HnnVu1dMr0TEj8QJMC4PyRn69xzXA8=;
        b=HuLiBLxaLPpQPVqnx6cxuMabbpxOyjqZiaBUgzGlH1ke6iOKQ+tUYTT2iwqnwxvbTd
         Nd+gRzaDGGeZOCgOOrTRLyo9//At5x5wjQAB2G+9EW1rSKLDrQ9X+LG9L2IkjiK7mdOb
         PoL5+xsjnbXNNThDtFTWXVTtI2kxF6phLOuOPnfojydO6CPYGZ5dzvVc6TuTpqwTa53H
         N1qJ/vlkQrOSBxQ0g9/dUX2aPUnrdYiQjFW2lIRnLQder+vN3zhUpTkIjH2weItgefIr
         ST+8rft37vmhAQJqdf+H1oxlamSXRFwmEyriy78Wy69rpzycRMwwIolYiR1DB/cAzSUv
         lGUA==
X-Gm-Message-State: AGi0PuYcdiOh1oKgAtPOAManCnP9puKFLddAYqdHjc7MqXLPmBH2+MTt
        ycBfB/I9/G1zsjP+8nwXXcocPA==
X-Google-Smtp-Source: APiQypLW193+p+mWHTSAc87JCKYuoXneFfjRmShR5mwMzAfKp2W4ARyBRe8ZbJtLj/vq9CxiP/q1Zw==
X-Received: by 2002:a1f:1f52:: with SMTP id f79mr9655456vkf.19.1587762167144;
        Fri, 24 Apr 2020 14:02:47 -0700 (PDT)
Received: from google.com (25.173.196.35.bc.googleusercontent.com. [35.196.173.25])
        by smtp.gmail.com with ESMTPSA id t194sm1887798vkt.56.2020.04.24.14.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 14:02:46 -0700 (PDT)
Date:   Fri, 24 Apr 2020 21:02:42 +0000
From:   Oliver Upton <oupton@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        wei.huang2@amd.com, cavery@redhat.com, vkuznets@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH v2 00/22] KVM: Event fixes and cleanup
Message-ID: <20200424210242.GA80882@google.com>
References: <20200424172416.243870-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424172416.243870-1-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo,

I've only received patches 1-9 for this series, could you resend? :)

--
Thanks,
Oliver
