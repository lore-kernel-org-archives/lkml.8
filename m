Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4ED2C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFE66206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcM2L5DB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbgEKQPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:15:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59686 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730561AbgEKQPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589213710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hMmg8VXRFHP3NtN5OvlSRCC/9CYursiCkwl7Hbg93g0=;
        b=UcM2L5DBBTShsOTMIDTriHKkzKFhg7Zkbn6FgbSVseu2LVGP6GIcLK2CnjKodb4qjEaE78
        r+gRISeeAT8/p/noO4IGBqZ4pCz9mJuQ3xNor4kcRwz2LQogWmRi2eVoefS1pwA1tcCJhd
        9C1BKRURx3eMR/xozqE4iN0Zx3O3rmI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-naT-iPugP1yz7U8BFmQypw-1; Mon, 11 May 2020 12:15:08 -0400
X-MC-Unique: naT-iPugP1yz7U8BFmQypw-1
Received: by mail-qk1-f198.google.com with SMTP id a18so10607010qkl.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hMmg8VXRFHP3NtN5OvlSRCC/9CYursiCkwl7Hbg93g0=;
        b=gyP1DCsPjX6jYSAc7PaiQLhwH7B29OrgVQgNUcJ1akwX2MpB9+9APzR1NJgaoU9nA3
         ekD/AF/Y1SP57LDBou9u1j4nh8IGHlVgJ5a2SrRP9ZVhk/6/3nwCl+M0TG+YzFsLqdZ7
         L45sjzNvYOu4RSeGqbcHXmu4VQXazfYORcT3YXMrLCJaGRKcD1zUAGMBQ3Io8AjyO9EK
         6WI+Js3bmEOlrQwx68y7VxyWKfiYTc9u7nP+J/+h9RzQdXPibUWl3/6zZQuJCkQnMylY
         5HSyk6jntLoruH/76+wHk+V84LoLyR08FvPk9Zh/z6jlb94NTdFR7sjvyi7ZC0ofhkfd
         QekA==
X-Gm-Message-State: AGi0PuYbsX7wPakJIFYoOSdQk5nKuZZ2tzqZdXKcfsSewFtKrt4dzzLY
        SjBJezH53tQn/uNmbs5+9k1JSy1eZG5G2Grrs5aQXbLHSE5BYo0DXrHI6jP9k8/Ol/PxbvrAbWz
        O1bOBVkthHlJoWt9RDARCOKmz
X-Received: by 2002:a05:620a:13a7:: with SMTP id m7mr14264304qki.498.1589213708408;
        Mon, 11 May 2020 09:15:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypLFlqG5vF/e7y0pD5EcKe9ThQIhRa2tEFR+EpAWfKOuQOPTdjVG8EmWZz7lFamA9ZguN16SpQ==
X-Received: by 2002:a05:620a:13a7:: with SMTP id m7mr14264282qki.498.1589213708136;
        Mon, 11 May 2020 09:15:08 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id c24sm6645942qtd.26.2020.05.11.09.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 09:15:06 -0700 (PDT)
Date:   Mon, 11 May 2020 12:15:05 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 8/9] KVM: x86, SVM: isolate vcpu->arch.dr6 from
 vmcb->save.dr6
Message-ID: <20200511161505.GI228260@xz-x1>
References: <20200507115011.494562-1-pbonzini@redhat.com>
 <20200507115011.494562-9-pbonzini@redhat.com>
 <20200507192808.GK228260@xz-x1>
 <dd8eb45b-4556-6aaa-0061-11b9124020b1@redhat.com>
 <20200508153210.GZ228260@xz-x1>
 <a0dd65bc-bfea-75b8-60d7-5060b9ee6c51@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a0dd65bc-bfea-75b8-60d7-5060b9ee6c51@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 03:28:44PM +0200, Paolo Bonzini wrote:
> On 08/05/20 17:32, Peter Xu wrote:
> > On Fri, May 08, 2020 at 12:33:57AM +0200, Paolo Bonzini wrote:
> >> On 07/05/20 21:28, Peter Xu wrote:
> >>>> -	svm->vcpu.arch.dr6 = dr6;
> >>>> +	WARN_ON(svm->vcpu.arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT);
> >>>> +	svm->vcpu.arch.dr6 &= ~(DR_TRAP_BITS | DR6_RTM);
> >>>> +	svm->vcpu.arch.dr6 |= dr6 & ~DR6_FIXED_1;
> >>> I failed to figure out what the above calculation is going to do... 
> >>
> >> The calculation is merging the cause of the #DB with the guest DR6.
> >> It's basically the same effect as kvm_deliver_exception_payload.
> > 
> > Shall we introduce a helper for both kvm_deliver_exception_payload and here
> > (e.g. kvm_merge_dr6)?  Also, wondering whether this could be a bit easier to
> > follow by defining:
> 
> It would make sense indeed but I plan to get rid of this in 5.9 (so in
> about a month), as explained in the comment.

OK. I thought it would be easy to change and verify when with the selftests,
however it's definitely ok to work upon it too.  Thanks,

-- 
Peter Xu

