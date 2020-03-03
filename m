Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C70C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6734220CC7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1vqhX6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbgCCRdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:33:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58653 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730398AbgCCRdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583256821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gxnMDm1mj8e+e8hgSCFPYUZNViu0FuRVXA/Vwdb0hRY=;
        b=C1vqhX6ZF6U3ZhsZ47D8T5MULJt182tv4t1n8sKtEi395RL6cmSJgFXARcjnLIri+EPhUs
        aLVTPgAP15gjSdvx5Vc7Ri/XwH+bsxGIWbOrbncp+e3jgkfa2NEA99nsDSq7Goa6wi81wX
        bZ23ag5oFqH4DdHVZUYrA4PmfALfFFA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-jluh5TemNgqKHEsgSbgZEA-1; Tue, 03 Mar 2020 12:33:40 -0500
X-MC-Unique: jluh5TemNgqKHEsgSbgZEA-1
Received: by mail-qk1-f198.google.com with SMTP id v189so2630375qkb.16
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 09:33:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gxnMDm1mj8e+e8hgSCFPYUZNViu0FuRVXA/Vwdb0hRY=;
        b=pcFiWo12lvaggNxSq/ai5d/K/UKvSwHCDULEUc/Cu2bST/a01LbjoIIHFwfQq2xO2C
         HkV98tznD0z9gCUqLAOwHfijU1BnQd5JgFpKRtbKFBA6/iA55rwYSs1894mVPyYrxguF
         hKoJ0Gi+uKP+cT+VhL/lRGqR5Rw86HiuJ/pbh2VzLiYywoFagyBPP2f3OLdFoaZaBPGk
         mEEVoWBRksNf2rZrfl6T+EvuaYD+4GRtzakirh437na8asm4A1u/vEMJQGyy6Xq+wywk
         asBrj0VoVEqkbAla0h5w6MEwdvmt7YTkq42Y/w6E745W0TEu8T/01Rjh3BCbu5Ta2MeN
         o+XA==
X-Gm-Message-State: ANhLgQ359mHgtM2Vf32Eg9fLK0e8clqQOUDGQRHBPk9I4grNE0ifKDEi
        zshJQROqsjKhwbNULlHCT0/B8GbXDUuucMDpsj7/D5ViSmb+G92B9XyIy0Qv6WjMt/6kGFcZDWX
        rmbIEJVwChkdnozEHaX29z5cb
X-Received: by 2002:a0c:f707:: with SMTP id w7mr5015548qvn.46.1583256819814;
        Tue, 03 Mar 2020 09:33:39 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuHtSJyfYDqXoUN1urEzaepBYjtUM0hwlk7Vp2mQmweuGkMQhYrGhiK0np00+bkmmUz680EJw==
X-Received: by 2002:a0c:f707:: with SMTP id w7mr5015528qvn.46.1583256819589;
        Tue, 03 Mar 2020 09:33:39 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id m1sm4095574qkk.103.2020.03.03.09.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 09:33:38 -0800 (PST)
Date:   Tue, 3 Mar 2020 12:33:34 -0500
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v4 00/14] KVM: Dirty ring interface
Message-ID: <20200303173334.GE464129@xz-x1>
References: <20200205025105.367213-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200205025105.367213-1-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 09:50:51PM -0500, Peter Xu wrote:
> KVM branch:
>   https://github.com/xzpeter/linux/tree/kvm-dirty-ring
> 
> QEMU branch for testing:
>   https://github.com/xzpeter/qemu/tree/kvm-dirty-ring
> 
> v4 changelog:
> 
> - refactor ring layout: remove indices, use bit 0/1 in the gfn.flags
>   field to encode GFN status (invalid, dirtied, collected) [Michael,
>   Paolo]
> - patch memslot_valid_for_gpte() too to check against memslot flags
>   rather than dirty_bitmap pointer
> - fix build on non-x86 arch [syzbot]
> - fix comment for kvm_dirty_gfn [Michael]
> - check against VM_EXEC, VM_SHARED for mmaps [Michael]
> - fix "KVM: X86: Don't track dirty for
>   KVM_SET_[TSS_ADDR|IDENTITY_MAP_ADDR]" to unbreak
>   unrestricted_guest=N [Sean]
> - some rework in the test code, e.g., more comments

Any comments before I repost another version?  Thanks,

-- 
Peter Xu

