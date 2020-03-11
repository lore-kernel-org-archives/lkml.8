Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B95EC18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6026321655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYu1tv+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgCKLtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:49:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47348 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729016AbgCKLtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 07:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583927359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F5OgNaYAikVgpZYOSNk5y2jqMOtP53edDDqZVD/pDRE=;
        b=RYu1tv+QbJaZlAuU5XuoKwZiYxM/hJbhRqklnpmWshRELnoL5dHaF041C+xE7mXqqrx+Lc
        8wnWdA/54zISNbi+yfl6huFpSwX9wPJ19K9ACS66VWr0yxcmGkKAJq4125SeAYNDnJpQQK
        85qAMaV7QvGRvjzvCyZBT6C15ApwCBY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-ttlULYhYOi2cB9E766cMrg-1; Wed, 11 Mar 2020 07:49:18 -0400
X-MC-Unique: ttlULYhYOi2cB9E766cMrg-1
Received: by mail-wr1-f69.google.com with SMTP id n11so341790wrs.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 04:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=F5OgNaYAikVgpZYOSNk5y2jqMOtP53edDDqZVD/pDRE=;
        b=OQ4pk3eiOLFB2SYl/XiNcxNiJMY9ucfP7jZjCf2lD1z0TaE9Gfxs/Y/qUjD9cpjVFw
         c9mLWEzUApB0f91xB45dg12DQSb/dT6ynyWYKPegGbvYJw1HQtbRS+ARuPtodc70ry2/
         5yzoE9KNin5YKRy1+NqRfhp85+UnXXsqaDG5MU1jHVoliuRTHYJd7R8ZIm2kP/o5Bxzu
         yW1HdAjwgqqbgl3XwChf/wfW9bajTCMZ8MbQENSvFFiFWVYo+LvY5o/CtHxzJ8C/+qhh
         GyxRN2JoyfzEdocT5Uu5aZwTcpSrMdr7h64dbiYnWvNna8XDlHD8LEgz3pr5T1C1D5ok
         wqmA==
X-Gm-Message-State: ANhLgQ2fh2c9guyUaHoH/nYOa0IWJMl04PaRcgDWR8EFGW30Yj2TCTak
        EqrAUP+s5xtshEBTPWwM5pyqEs37OfMAU5XOWYkS47jfk2sQ7dQv0/3xUo029VTx7SuLI7iabVw
        wm2k3lu7Zpln3PWrDR/bQGi/m
X-Received: by 2002:a5d:6a4d:: with SMTP id t13mr4127278wrw.344.1583927356339;
        Wed, 11 Mar 2020 04:49:16 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsLTPh5QjDF4BVIWhl7Hz6t3aq6gMtSaIcj8l84Z5nkZqsVtENlcA0VXwUD8mRF8pmkrPvYTA==
X-Received: by 2002:a5d:6a4d:: with SMTP id t13mr4127247wrw.344.1583927356118;
        Wed, 11 Mar 2020 04:49:16 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c4sm8261810wml.7.2020.03.11.04.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 04:49:14 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liran Alon <liran.alon@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [RFC PATCH] KVM: nVMX: nested_vmx_handle_enlightened_vmptrld() can be static
In-Reply-To: <20200310200830.GA84412@69fab159caf3>
References: <20200309155216.204752-4-vkuznets@redhat.com> <20200310200830.GA84412@69fab159caf3>
Date:   Wed, 11 Mar 2020 12:49:13 +0100
Message-ID: <87d09jaz7q.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild test robot <lkp@intel.com> writes:

> Fixes: e3fd8bda412e ("KVM: nVMX: properly handle errors in nested_vmx_handle_enlightened_vmptrld()")
> Signed-off-by: kbuild test robot <lkp@intel.com>
> ---
>  nested.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 65df8bcbb9c86..1d9ab1e9933fb 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -1910,7 +1910,7 @@ static int copy_vmcs12_to_enlightened(struct vcpu_vmx *vmx)
>   * This is an equivalent of the nested hypervisor executing the vmptrld
>   * instruction.
>   */
> -enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
> +static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
>  	struct kvm_vcpu *vcpu, bool from_launch)
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>

Yea,

I accidentially dropped 'static' in PATCH3, will restore it in v2.

Thanks!

-- 
Vitaly

