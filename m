Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133D8C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB702068E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IpI+kuHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbgEFQBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:01:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38515 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729059AbgEFQBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588780903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z393CfivApjsVrwKlNbhxhzx0gces5Zy/3TksIJjQj8=;
        b=IpI+kuHLwrhp1gWUHmIy87w204vQLfEkh+3lGnM67XM3AQMKNxyGIXAloEU9iiWZX03p3I
        e3Jb+lcnRO3UR8w1MDIygCnS5jYv0ucXjdNnbJnhlPNK3WTvVmM7FeMfiq4OgrXS+7MciE
        JzHvkbzI2MI7QszQ0WA6QeFmPLdgZHM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-SHNPKDtCOZehhGYybqySeg-1; Wed, 06 May 2020 12:01:41 -0400
X-MC-Unique: SHNPKDtCOZehhGYybqySeg-1
Received: by mail-qk1-f200.google.com with SMTP id j12so2249164qkl.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 09:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z393CfivApjsVrwKlNbhxhzx0gces5Zy/3TksIJjQj8=;
        b=oZeQ9TvHaxH+wiK8dt0a1nIxgjgv16qRhYVyGIQRystTXx3nVO659xS7oCd1/+tXZp
         rwASNCxddcqUuI5wM+6KpO4IYumZdtT+Y8OkgxA97LvgJcJ1viYNSdL1zFnOzC8FGRdm
         OppGuG4v6qfg4X3uEukkDVDhXWAryhXK78IByfas8Fkd20CiUOMxquirSq7dLzFnDM+d
         nS3778TrrfoW9xBI9yraYJ8v8/1wsyfidzdWItQVU7E6JVvJ4elyS2aYCTsgcmrTVkFp
         Map5G2IIHzjlmnuJMBK8fynekTvrVMYcsT431s225G97swluCS0svQENEz4F05ePCnQb
         DK2Q==
X-Gm-Message-State: AGi0PuZSxWtgTDpjhmtPpZyKNm18l/PvPyI22fEKTcKOXa1UNNMjYPCi
        NlqNuyCdEzPXkzWG5qxhLGGo5avltMYVINmLM6uc5iCST2znSkZhYM/xSBw2NB35RM4OKCk8YyH
        or2lYf9IACFTYJyeZ2K9zQq5c
X-Received: by 2002:a05:620a:12f6:: with SMTP id f22mr6809549qkl.76.1588780901360;
        Wed, 06 May 2020 09:01:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypLK+qF0S7SG5s1Ltj20QoKwPVXuJJsa1ak/ZLSXYyMz12MWdAozCj8NqzeHu9g3Ndi1bm7ALw==
X-Received: by 2002:a05:620a:12f6:: with SMTP id f22mr6809516qkl.76.1588780900994;
        Wed, 06 May 2020 09:01:40 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id g14sm1859729qtb.24.2020.05.06.09.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 09:01:39 -0700 (PDT)
Date:   Wed, 6 May 2020 12:01:38 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH 2/9] KVM: x86: fix DR6 delivery for various cases of #DB
 injection
Message-ID: <20200506160138.GM6299@xz-x1>
References: <20200506111034.11756-1-pbonzini@redhat.com>
 <20200506111034.11756-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200506111034.11756-3-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 07:10:27AM -0400, Paolo Bonzini wrote:
> Go through kvm_queue_exception_p so that the payload is correctly delivered
> through the exit qualification, and add a kvm_update_dr6 call to
> kvm_deliver_exception_payload that is needed on AMD.
> 
> Reported-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

