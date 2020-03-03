Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65B0C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AEF2146E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADh48kCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgCCIyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:54:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37918 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727820AbgCCIyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583225656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OjsWUXqjUWqBSkSGCD4PbdKz2btlJQttY4xDooxfz/U=;
        b=ADh48kCNYCMHEDMMIE7F2ggKcYH6TV9UqPz9VPM/pbLe1ikNBRhKVVhqlyIo/sOTGKBbev
        hyS2IAI8pmIpKd/UxqCuA4Tb5YfM2us/WDmgaoL0MP37oYLCBeto878fzxXyY7voYv7A9p
        ohgTOT7Ojf8DsE9yD+uLsgay3dMYFtg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-bEohyM4jN2WWgXZN-cfm9w-1; Tue, 03 Mar 2020 03:54:15 -0500
X-MC-Unique: bEohyM4jN2WWgXZN-cfm9w-1
Received: by mail-wr1-f70.google.com with SMTP id p5so906622wrj.17
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 00:54:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OjsWUXqjUWqBSkSGCD4PbdKz2btlJQttY4xDooxfz/U=;
        b=CKrep2Y/cdbh2xukmj/Q0/mEjw67hUO4IjJgi7Sa2qPV4MUkDxYGmLLW01pzayNw0Z
         0Gpv34PQio7fHRxvyvoD/OBQ6+xQDRa9vGtZtsD3bwUv+jkhl4j4kYkrqv5WEEEPHNZG
         Umcvf5AtQHCR6zRtsNHF0IVWbY8xbzCcMhJD2aWzz+7ecdhteqi1REnhtpgVhZCmdXSR
         1AwBsNnBMvlCvro8bPsaH3p+rYZkdsTpC5VAW0ZL86Zi21CMd50yQK5rAU2JL1i3VPa+
         VAJzrnbwSQz3J9y23/BcIj6Y+T+Ad2JDl849rs2TLInAOr6MfzU7aLeWNNjVXNwO3knn
         /Q9w==
X-Gm-Message-State: ANhLgQ0Z8jXujgExkgUuGbnWjOtJLWsfhXOV90XmCQQP8cKQw4kse2oW
        bM5M9OcVtBTLfigjV+ybiOuTRGFyo3VsW3YM2tM7GV7dH0uq8IqrpPQPVejkL7VmkWkCY9PPZYx
        UpD/1ktLW1/iEAaBWksZSIjH+
X-Received: by 2002:adf:ce12:: with SMTP id p18mr4208152wrn.88.1583225653992;
        Tue, 03 Mar 2020 00:54:13 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtxioLATY0Il+f/lYtoQmrW/DITC8fuFwFe+1VWyWHfMfdr9VUldKUP1b6K08oPMsyN/DiChQ==
X-Received: by 2002:adf:ce12:: with SMTP id p18mr4208133wrn.88.1583225653782;
        Tue, 03 Mar 2020 00:54:13 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:4c52:2f3b:d346:82de? ([2001:b07:6468:f312:4c52:2f3b:d346:82de])
        by smtp.gmail.com with ESMTPSA id t124sm3204441wmg.13.2020.03.03.00.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 00:54:13 -0800 (PST)
Subject: Re: [PATCH] kvm: selftests: Support dirty log initial-all-set test
To:     Jay Zhou <jianjay.zhou@huawei.com>, kvm@vger.kernel.org
Cc:     peterx@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangxinxin.wang@huawei.com, weidong.huang@huawei.com,
        liu.jinsong@huawei.com
References: <20200303080710.1672-1-jianjay.zhou@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f0c2dcb8-4415-eec9-d181-fb29d206c55c@redhat.com>
Date:   Tue, 3 Mar 2020 09:54:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303080710.1672-1-jianjay.zhou@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/20 09:07, Jay Zhou wrote:
>  #ifdef USE_CLEAR_DIRTY_LOG
> -	if (!kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2)) {
> -		fprintf(stderr, "KVM_CLEAR_DIRTY_LOG not available, skipping tests\n");
> +	dirty_log_manual_caps =
> +		kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
> +	if (!dirty_log_manual_caps) {
> +		fprintf(stderr, "KVM_CLEAR_DIRTY_LOG not available, "
> +				"skipping tests\n");
> +		exit(KSFT_SKIP);
> +	}
> +	if (dirty_log_manual_caps != KVM_DIRTY_LOG_MANUAL_CAPS &&
> +		dirty_log_manual_caps != KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE) {
> +		fprintf(stderr, "KVM_CLEAR_DIRTY_LOG not valid caps "
> +				"%"PRIu64", skipping tests\n",
> +				dirty_log_manual_caps);
>  		exit(KSFT_SKIP);
>  	}
>  #endif
> 

Thanks, instead of this final "if" it should be enough to do

	dirty_log_manual_caps &= (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE |
				  KVM_DIRTY_LOG_INITIALLY_SET);


Otherwise looks good, I'll test it and eventually apply both patches.

Paolo

