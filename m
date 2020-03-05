Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE23EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9658E20732
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYR9WFqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCEOvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:51:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32598 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725963AbgCEOvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583419890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q2h6nPEsw2WQpXjdndQPq3IqLV2vLVlw94U+XC3vi3k=;
        b=eYR9WFqjHc2tluXiDlAyhnk2Hdri1jZblg02na6nkysoAFSysjuLLr3sZr5+QJXZc4eC8+
        RuCG8iFd2ROJNeEqxV3kt2pD6JNvXefPDsMzETe9veSIqzJ/rRkB4FLcsHix0HfhUYLTSM
        N03LEQa5f79YzbtIm3Kn+Kw+fddxotw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-jJzC4JpDNW-yrc6nSNDSUg-1; Thu, 05 Mar 2020 09:51:26 -0500
X-MC-Unique: jJzC4JpDNW-yrc6nSNDSUg-1
Received: by mail-wm1-f72.google.com with SMTP id e26so664120wmk.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 06:51:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q2h6nPEsw2WQpXjdndQPq3IqLV2vLVlw94U+XC3vi3k=;
        b=kC2Ac0U/zno0byWxGOXfsa7wOVbrUL37EHP9liwJUiXvnfirAbAc5APfzOBVWwcjRP
         qbSkbDwcpewwKtCvYpoVtowN+R7X4dsgjLCIUcUSNdjitNYC0xbFdQ6gFV4pBLWhtd+D
         1VScJpUAv8GN6nzc5a2jia1VFR7ce/i4xo1yp+cnyPavw/7LIW24zqp6SY1JuoTI9AcQ
         GpG3+kJS8Uc3XJQAAiYci27eWpJmVIfN3XJkHfFurOpOp5qtLlx6JRADXDRvmwWgIAeu
         PsiJgspT9uIr6nMiJ1H0+Yyj0VIGhe/RN5qK3Xrm3+pC+oQvwFevAT6tqDzIBleh6OyN
         IH0Q==
X-Gm-Message-State: ANhLgQ0mm5E4mRxz84W4UJ/mHJ4evN/ic80unxoceizTvezJ6N67qqpu
        Lx2RBAYAqOlsJtuKb0Qp1Id3cTk8Q+j8Zhnxa0I3tRgkQVce2iobzr+hVmD5IeJ34FBGGXj5iIZ
        hIIKLbEl3rDfaZY9onVjnRcGZ
X-Received: by 2002:adf:db84:: with SMTP id u4mr10772012wri.317.1583419884800;
        Thu, 05 Mar 2020 06:51:24 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtTRxo3t5rJ55MDnIHanJNHGJWt5oHjPPR6NBeyxl0zG2Vh2C3V07dfWyE02Tr41RF7mTuCEA==
X-Received: by 2002:adf:db84:: with SMTP id u4mr10771941wri.317.1583419883699;
        Thu, 05 Mar 2020 06:51:23 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id 12sm9559704wmo.30.2020.03.05.06.51.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 06:51:23 -0800 (PST)
Subject: Re: [PATCH v9 1/7] KVM: CPUID: Fix IA32_XSS support in CPUID(0xd,i)
 enumeration
To:     Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmattson@google.com,
        sean.j.christopherson@intel.com
Cc:     yu.c.zhang@linux.intel.com
References: <20191227021133.11993-1-weijiang.yang@intel.com>
 <20191227021133.11993-2-weijiang.yang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bd75450f-a929-f60b-e973-205e4f5a9743@redhat.com>
Date:   Thu, 5 Mar 2020 15:51:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20191227021133.11993-2-weijiang.yang@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/12/19 03:11, Yang Weijiang wrote:
> +	u64 (*supported_xss)(void);

I don't think the new callback is needed.  Anyway I'm rewriting this
patch on top of the new CPUID feature and will post it shortly.

Paolo

