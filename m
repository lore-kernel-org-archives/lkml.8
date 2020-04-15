Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0072BC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF6F620857
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLXAHyto"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414583AbgDOPLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:11:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58289 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2393131AbgDOPL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586963488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C0vYOJO4v4REcjYahYU+BEluO/YhMr3LnC3HEtpWFrM=;
        b=bLXAHytosK8av7sofohPvmQMYcFny/v1XNc+m7Sql2y76wVO9OwPP6SgmX7uGD/rcFwh+y
        w4uUKQjOi2BRTJ+Tcr6cF0LERHszx3aeYnahPbwzAnoK7JH/FgOFUfkIh9/kILjJystrZ9
        39Tm5tASOsEX+RLf4tcvlCZlpame7+g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-BEMnQwfqOpKJ2JOPmfkwIw-1; Wed, 15 Apr 2020 11:11:24 -0400
X-MC-Unique: BEMnQwfqOpKJ2JOPmfkwIw-1
Received: by mail-wm1-f69.google.com with SMTP id q5so4043845wmc.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 08:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C0vYOJO4v4REcjYahYU+BEluO/YhMr3LnC3HEtpWFrM=;
        b=ZKCNJ2h9Z+VMv+nk17d7XteLlcd1Or4BjCK+LUA5z2vQdNXy4YWB9qGHzH5Mca+RJ8
         tPi4S/UYYmipjLrjM1USo+ND4Nh14Zris8oKI6p+u7pZkdFAY3DgfJyA8V6FMBCLUQZJ
         OtzId6AT8Zj9cZ8LocWzB3D037pS4FM7dww0RQKHOQDhiwym/dup1qKuM0jt4nqqa1xk
         g9GSdKcSETeqwjaYlnW2NuwOLburrnIxS6d76MwTV01twxynRQ/jZ90+FQEC1fN2vOiY
         de7Cbg6nhTNLdcWjXSPtFTkuqvjru+1za+NRWS7W2WQSHiE8cOYvZPlVmXzlzEFDRmp+
         704w==
X-Gm-Message-State: AGi0PuZTySMr49r6BLsR6CuG5T8Vchcl9k9xnbZyYTq0CO/9oD9UMqkW
        69TZbHgkRVnD4fx6rX0OsNzyAnprSobj2rWonh85v8mveDdYNuj1qRA6XLaKNAi3uJt+/U4HwLa
        3cNrZpVI2BBVfdbWHs+Ht1Fl/
X-Received: by 2002:a1c:7301:: with SMTP id d1mr6033192wmb.26.1586963483567;
        Wed, 15 Apr 2020 08:11:23 -0700 (PDT)
X-Google-Smtp-Source: APiQypKABLDLSsReEBMN+X/RLahvOhdo6qaiJnvnlmfjlbWNKdq2bnrmCnT0QXYbj9B/mxQdNLqTZw==
X-Received: by 2002:a1c:7301:: with SMTP id d1mr6033166wmb.26.1586963483345;
        Wed, 15 Apr 2020 08:11:23 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9066:4f2:9fbd:f90e? ([2001:b07:6468:f312:9066:4f2:9fbd:f90e])
        by smtp.gmail.com with ESMTPSA id h2sm23766953wmf.34.2020.04.15.08.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2020 08:11:22 -0700 (PDT)
Subject: Re: [PATCH 01/10] KVM: selftests: Take vcpu pointer instead of id in
 vm_vcpu_rm()
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>
References: <20200410231707.7128-1-sean.j.christopherson@intel.com>
 <20200410231707.7128-2-sean.j.christopherson@intel.com>
 <b696c5b9-2507-8849-e196-37c83806cfdf@redhat.com>
 <20200413212659.GB21204@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d2def9fa-375e-d677-32a2-b1bb0e8d3fb6@redhat.com>
Date:   Wed, 15 Apr 2020 17:11:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200413212659.GB21204@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/20 23:26, Sean Christopherson wrote:
> FWIW, I think the whole vcpuid thing is a bad interface, almost all the
> tests end up defining an arbitrary number for the sole VCPU_ID, i.e. the
> vcpuid interface just adds a pointless layer of obfuscation.  I haven't
> looked through all the tests, but returning the vcpu and making the struct
> opaque, same as kvm_vm, seems like it would yield more readable code with
> less overhead.

Yes, I agree.  This was in the original Google submission, I didn't like
it either but I didn't feel like changing it and I wouldn't mind if
someone does the work...

Paolo

