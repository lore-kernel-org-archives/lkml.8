Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C26BC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BC02146E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQCbEyej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgCCIxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:53:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58160 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727412AbgCCIxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:53:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583225632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uA9jSqeJ7YM+hlM0Q0AtYm6l/6Ib8O+uDltLoDfxB+M=;
        b=FQCbEyejigaDVf/O9fb3la57nVFhVeY8fBjzISJ/mLf6JtW3F+/DHdK6kgAqoU+dUVSI21
        P9P+baqjSjx43bIP/7wd2MeeYQTroBmbRugtJYAqKnm0wwoqLJfDXQx3PAjMero0EVugGe
        P9FMz1Xr+csgTU5pE/1Nw/SNqo1o/cs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-X6gEeQ9-PAeRj66Tc1fWPw-1; Tue, 03 Mar 2020 03:53:50 -0500
X-MC-Unique: X6gEeQ9-PAeRj66Tc1fWPw-1
Received: by mail-wm1-f71.google.com with SMTP id g26so373455wmk.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 00:53:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uA9jSqeJ7YM+hlM0Q0AtYm6l/6Ib8O+uDltLoDfxB+M=;
        b=thjYRXMzOMEDH9N5eRYOfQYwHRDStjiQAM0TfkE+IFs9V6piCi4xuyfuK7/PN1pNos
         KqMHo0Bibv2njsmCI1u0oX0wbSMWtnyrKF/HXyzdtqwCLR/HD+f/psFjowN5mXRQSRR1
         5RsH6Wr8ER08nKfHDxdotpVGi4qeMxKh42rEj/kVn1u04RYwiNQUSnagcw4OLnRB/eha
         S73bfs9TsC+sR9FZcDnzepwwfl67G7Cub+AhDzDCSfitL4f3JkEgJ12fd7OXfLj4vcab
         gECx0Z4WFQRxY6xdlFZS5rEkrZ3nGn47UOn+Q7vgzxCFOcjYNnhgNAD88be2ZFHSkDij
         rJsw==
X-Gm-Message-State: ANhLgQ172OnJU1mirnNSj2F8RCmEpOR6lxIgpSmSGsXvxLqOkD6rYBG9
        5bNGW903ivKga/jth1/wdVb0Oayo7jeACMkqwuUE8kilqtCMbraEgRsr/Y9+AHysotuYDdYDIDO
        kYmhJ4gJObF/SgN8lvqM8UKH3
X-Received: by 2002:a05:600c:20c7:: with SMTP id y7mr1606815wmm.77.1583225629641;
        Tue, 03 Mar 2020 00:53:49 -0800 (PST)
X-Google-Smtp-Source: ADFU+vu19cWQ55lE5QJmKdvRAzYW7XwuOB682RJTOOcVGWM8jkkZxs+1Z+TsKH/j2igC9PJlcNhr6g==
X-Received: by 2002:a05:600c:20c7:: with SMTP id y7mr1606787wmm.77.1583225629387;
        Tue, 03 Mar 2020 00:53:49 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:4c52:2f3b:d346:82de? ([2001:b07:6468:f312:4c52:2f3b:d346:82de])
        by smtp.gmail.com with ESMTPSA id b10sm2788680wmh.48.2020.03.03.00.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 00:53:48 -0800 (PST)
Subject: Re: [PATCH] kvm: selftests: Support dirty log initial-all-set test
To:     Jay Zhou <jianjay.zhou@huawei.com>, kvm@vger.kernel.org
Cc:     peterx@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangxinxin.wang@huawei.com, weidong.huang@huawei.com,
        liu.jinsong@huawei.com
References: <20200303080710.1672-1-jianjay.zhou@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0ec6b946-fa0e-6a18-0a49-f0b509cf2ced@redhat.com>
Date:   Tue, 3 Mar 2020 09:53:49 +0100
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

	dirty_log_manual_caps &= (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE |
				  KVM_DIRTY_LOG_INITIALLY_SET);


Paolo

