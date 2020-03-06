Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C61C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1EEB206E2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 22:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MZ6sQDj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCFWGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 17:06:35 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42754 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFWGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 17:06:34 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 026M3CCn179774;
        Fri, 6 Mar 2020 22:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=6LEFkemgC1LatVschRzZXAT0GyTqh7Ckc5fAeBrPSWI=;
 b=MZ6sQDj/GRe0f5Tbu7m6ZjrtzcZNxYIQdxCxOUSSRnEgK6e+jdQFK3JLw0rzC3rBlS4o
 kjYZZk2Srh7HNVoipBUMBhw5Q9idjUWh78/amQnwRiPIVGqbipcZTMYj/fWVxOG6WNHA
 EwF+W9Ed5YhmxqRLeSPBQCdYIM7Xn16tkaxrXFLiZMU6ra/T6BbhZvNTeZ68Q35yBJ70
 h4oKTggEUmKFkF0rDNW0ZmPIIj2+L/xoR3Z51dszAMff2+N9SRQbiqIN3jQ7n/Qgg3sI
 le092c4bDR3tQSTNJjEdDiX32fK68g9How/hB2iB4HDgT2r3gXJl77bP9v+29m5QhHJT mQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2yghn3sh9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Mar 2020 22:05:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 026M3Fn9023539;
        Fri, 6 Mar 2020 22:05:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2yg1h6n7uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Mar 2020 22:05:33 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 026M5W8f012825;
        Fri, 6 Mar 2020 22:05:32 GMT
Received: from localhost.localdomain (/10.159.228.115)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Mar 2020 14:05:31 -0800
Subject: Re: [PATCH v3 1/2] KVM: VMX: rename 'kvm_area' to 'vmxon_region'
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200306130215.150686-1-vkuznets@redhat.com>
 <20200306130215.150686-2-vkuznets@redhat.com>
From:   Krish Sadhukhan <krish.sadhukhan@oracle.com>
Message-ID: <ad7785c5-34e0-a4e9-689c-f4626dc37314@oracle.com>
Date:   Fri, 6 Mar 2020 14:05:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200306130215.150686-2-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9552 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=2 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003060128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9552 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003060128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/6/20 5:02 AM, Vitaly Kuznetsov wrote:
> The name 'kvm_area' is misleading (as we have way too many areas which are
> KVM related), what alloc_kvm_area()/free_kvm_area() functions really do is
> allocate/free VMXON region for all CPUs. Rename accordingly.
>
> No functional change intended.
>
> Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>   arch/x86/kvm/vmx/vmx.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 40b1e6138cd5..dab19e4e5f2b 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2635,7 +2635,7 @@ int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
>   	return -ENOMEM;
>   }
>   
> -static void free_kvm_area(void)
> +static void free_vmxon_regions(void)
>   {
>   	int cpu;
>   
> @@ -2645,7 +2645,7 @@ static void free_kvm_area(void)
>   	}
>   }
>   
> -static __init int alloc_kvm_area(void)
> +static __init int alloc_vmxon_regions(void)
>   {
>   	int cpu;
>   
> @@ -2654,7 +2654,7 @@ static __init int alloc_kvm_area(void)
>   
>   		vmcs = alloc_vmcs_cpu(false, cpu, GFP_KERNEL);
>   		if (!vmcs) {
> -			free_kvm_area();
> +			free_vmxon_regions();
>   			return -ENOMEM;
>   		}
>   
> @@ -7815,7 +7815,7 @@ static __init int hardware_setup(void)
>   			return r;
>   	}
>   
> -	r = alloc_kvm_area();
> +	r = alloc_vmxon_regions();
>   	if (r)
>   		nested_vmx_hardware_unsetup();
>   	return r;
> @@ -7826,7 +7826,7 @@ static __exit void hardware_unsetup(void)
>   	if (nested)
>   		nested_vmx_hardware_unsetup();
>   
> -	free_kvm_area();
> +	free_vmxon_regions();
>   }
>   
>   static bool vmx_check_apicv_inhibit_reasons(ulong bit)
Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
