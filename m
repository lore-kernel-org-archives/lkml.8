Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E34C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE2C20637
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGya3HUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgCEQvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:51:39 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26311 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725944AbgCEQvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 11:51:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583427098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SqVNCIytxdHmAm4l+2tk3rB1xbxHOZa0mRnp6D7J+Ck=;
        b=PGya3HUyi6by75HhAwHHTB0Im8tUjP+Tus1w9Y2BhvpIAIDun4TXkTUSrSgzjuGkICr8ID
        IHBQhxXkCL8AXvqvElUDjdo4lKp5/MlCWvtOPhh0D0u4M/IUrGr5+jzypLTN5NedbWSlW9
        tShl7YUFbbMM8RWlpUD8FIALb635Tv0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-Q1DKsTS0NXS6r6ALR0li_Q-1; Thu, 05 Mar 2020 11:51:34 -0500
X-MC-Unique: Q1DKsTS0NXS6r6ALR0li_Q-1
Received: by mail-wm1-f71.google.com with SMTP id g26so1799286wmk.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 08:51:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SqVNCIytxdHmAm4l+2tk3rB1xbxHOZa0mRnp6D7J+Ck=;
        b=Lfl6qEuwPGaT4yZj+xzUF86CAwb3rMyDpGH/TAk4u9kTr7jnA4MXOhjpMtH6B0GTYg
         uN+zTmT72CYiiDDFz+UQCPpGGnpYMnERvpIBS4HpJSYjUeqVnCBkP6Pi9prWAqnA7duM
         5n36MdRcgx94Hiy9v3NnGl3ZbKjfD79a0AsKCK5f4seX03tRFXVXj/EI2v3G6UO2Qk9u
         zNwgPyLSudxmo2LTzasjDiZic6dkKSjsaqD/vCviv2GBEVTLjNtq9mwnYlXLpL/hPt4f
         Im+zmqta3ope3iGr66w83aHG6q0qBpO1XKXvKwrovoxCZKzz662y9OODRCuXVM27fivp
         LiiQ==
X-Gm-Message-State: ANhLgQ1IzAk0LGQYqlRa6vBRrDYSyO8dxpnCEGr/nj7hTt+5aOKw23Ju
        UB4CThMPNH2k6JhAgr1Jeft7rpmH3fKx/CASpNpGEbmv8B0dpp439mdle5lGU8wJX4oeiwUJZbl
        xBcxyJmCK9DVevb4HLBPN5f/f
X-Received: by 2002:a7b:c446:: with SMTP id l6mr10060480wmi.3.1583427091591;
        Thu, 05 Mar 2020 08:51:31 -0800 (PST)
X-Google-Smtp-Source: ADFU+vty5v9FoOa0gGl9gu7HAojv2CNgZGjeX+xuelU6nsEMG9+BrIhKp6yHt4D+lPtraLEsiIFV/w==
X-Received: by 2002:a7b:c446:: with SMTP id l6mr10060406wmi.3.1583427090476;
        Thu, 05 Mar 2020 08:51:30 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id e1sm32448187wrx.90.2020.03.05.08.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 08:51:29 -0800 (PST)
Subject: Re: [PATCH v1 00/11] PEBS virtualization enabling via DS
To:     Luwei Kang <luwei.kang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, hpa@zytor.com, sean.j.christopherson@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, pawan.kumar.gupta@linux.intel.com,
        ak@linux.intel.com, thomas.lendacky@amd.com, fenghua.yu@intel.com,
        kan.liang@linux.intel.com, like.xu@linux.intel.com
References: <1583431025-19802-1-git-send-email-luwei.kang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <da7e4734-a184-7f4f-6456-e57ac6d8063d@redhat.com>
Date:   Thu, 5 Mar 2020 17:51:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1583431025-19802-1-git-send-email-luwei.kang@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/20 18:56, Luwei Kang wrote:
> BTW:
> The PEBS virtualization via Intel PT patchset V1 has been posted out and the
> later version will base on this patchset.
> https://lkml.kernel.org/r/1572217877-26484-1-git-send-email-luwei.kang@intel.com/

Thanks, I'll review both.

Paolo

