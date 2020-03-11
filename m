Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F24EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25C520734
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4nYMCIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbgCKRpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:45:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22938 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730626AbgCKRpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583948705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rW7pu79lKkKAPsdVQOo/aJ4urBOrtpq5oK5W7qCpQMY=;
        b=E4nYMCIrGWKW+1xY69Ew/e8DzYWPVuIWgdFcuGBUGoNJUQh29C6XydCIHbk0QdBaCtLFM7
        zvAStnMXBC3LyamxuZr5oJNO+2yb9Nd538P3Gs7c2IQk/c0D0TIFMcToNtlzsIXhM1O2VX
        HYaIcrtPEIw5NwF6SJ/nyp06bbaiI4M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-qcIU6n-uMxObtRdyLhYiSA-1; Wed, 11 Mar 2020 13:45:03 -0400
X-MC-Unique: qcIU6n-uMxObtRdyLhYiSA-1
Received: by mail-wm1-f70.google.com with SMTP id r19so1174458wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rW7pu79lKkKAPsdVQOo/aJ4urBOrtpq5oK5W7qCpQMY=;
        b=g3CWQiibwhvT6SHcVUv8SJ2EoDCaVnGeb4SIS2IU2tI59y3DbUx3D//65TfF0YkaHw
         p48gNxRA+KCp9LMBb9Fpe/Aji5SDyfTVe4n1+0ae2Lk6uwR1uudUtg9j41XUYrnuLDqg
         v3CzgyGF+cNZuS8alQJHh5a4hNMc1zRvMpg4BF8Fx7i4+QLrthqTymovTsPwHT8U9oRL
         x+gobeXa9ZHvSXIy6jfZB8iF7AOpJaLBQ9SQGEUqC8PFX8WJazG3begL1WZXNFp36A9A
         e/Dsfsc6RJg45rKk4y2zYyHkdIcP60RRq5pfaGrq7YKUMBPZDpnyer/Cdas064p8/FsI
         MdHw==
X-Gm-Message-State: ANhLgQ3fw+cMdM6jo333xWrdB2ftCt6Q9pks4cqpsgrvnDiuuUeODJMe
        q4PlEonn/rTR/uE5zb2IOFqmCezs1Rkx5scaOsY7wBCsHgLRVmrmUehY5l8An8w8gp1VvzKYa+K
        jZhNduVtJruWkYAOx4VokMmAY
X-Received: by 2002:a1c:4805:: with SMTP id v5mr770345wma.98.1583948702488;
        Wed, 11 Mar 2020 10:45:02 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvb2cSXhwPBa8avHtfP3up4fDySjC14dqD45ZcSdTFyPdocWJAOkwI8QHYiJr+lnsYF+iTknA==
X-Received: by 2002:a1c:4805:: with SMTP id v5mr770331wma.98.1583948702237;
        Wed, 11 Mar 2020 10:45:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4887:2313:c0bc:e3a8? ([2001:b07:6468:f312:4887:2313:c0bc:e3a8])
        by smtp.gmail.com with ESMTPSA id a13sm340949wrh.80.2020.03.11.10.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 10:45:01 -0700 (PDT)
Subject: Re: [RFC PATCH] KVM: nVMX: nested_vmx_handle_enlightened_vmptrld()
 can be static
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liran Alon <liran.alon@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>
References: <20200309155216.204752-4-vkuznets@redhat.com>
 <20200310200830.GA84412@69fab159caf3> <87d09jaz7q.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6fbd3df7-2fb6-337c-a9ce-e663f3742009@redhat.com>
Date:   Wed, 11 Mar 2020 18:45:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87d09jaz7q.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/20 12:49, Vitaly Kuznetsov wrote:
> kbuild test robot <lkp@intel.com> writes:
> 
>> Fixes: e3fd8bda412e ("KVM: nVMX: properly handle errors in nested_vmx_handle_enlightened_vmptrld()")
>> Signed-off-by: kbuild test robot <lkp@intel.com>
>> ---
>>  nested.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
>> index 65df8bcbb9c86..1d9ab1e9933fb 100644
>> --- a/arch/x86/kvm/vmx/nested.c
>> +++ b/arch/x86/kvm/vmx/nested.c
>> @@ -1910,7 +1910,7 @@ static int copy_vmcs12_to_enlightened(struct vcpu_vmx *vmx)
>>   * This is an equivalent of the nested hypervisor executing the vmptrld
>>   * instruction.
>>   */
>> -enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
>> +static enum nested_evmptrld_status nested_vmx_handle_enlightened_vmptrld(
>>  	struct kvm_vcpu *vcpu, bool from_launch)
>>  {
>>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>>
> 
> Yea,
> 
> I accidentially dropped 'static' in PATCH3, will restore it in v2.

No problem, I will squash.

Paolo

