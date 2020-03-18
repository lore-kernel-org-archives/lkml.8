Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F918C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736D620724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODsBolDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCRNNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 09:13:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:50748 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726759AbgCRNNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 09:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584537221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PxBoqIBbe7s8BPyTsCZ02RzESp7E1oZC6kxy/vfpBRo=;
        b=ODsBolDURrG3BqnfW4yy0khAwv1hqx65glxBLG8PfjzWpxnDOJMfs7pVJs7+odzQNsZout
        R5n1WvlUbwoJ5oQX6+dmWH8xbthAkWI8RBRINx8RIQW46zNL+GsueyeIIanTDnSqkE/4B0
        Zm8YymEbVZkIgDYg0oiMDtN4xcH9hZA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-vWrmkd0ZNlCVfEuUB02FfA-1; Wed, 18 Mar 2020 09:13:40 -0400
X-MC-Unique: vWrmkd0ZNlCVfEuUB02FfA-1
Received: by mail-wm1-f70.google.com with SMTP id s20so1076520wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 06:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PxBoqIBbe7s8BPyTsCZ02RzESp7E1oZC6kxy/vfpBRo=;
        b=gjRDxbpUymMZ3y2DDl2cUEWGo0lYyiLIWi609KjFdPYSMIloynUjHPvTvC4qT1vm0w
         IvQ/v664VM82BMRoiRAgfaSq6hHgcPjfhAQlCplqF0iawP4M0eMwylmSUfMAEXEGWVay
         h2PhbrXpgDRB+ausy1hCMJmJVBU0xxse+h+fgxN1z2DeRuN9DBIg9E69CiDSaO8mpxc6
         V1jtDeGfqiYSrQIx/87m9d7TJP0n93yygZsU+njPHGJkVGGqwVP35kmsbUIKqvLioPXP
         RwyV7VGB/P0LAcFLzXpcjW4G2PgUK2cZlPtXV+KtAtbI+fCkdPzU64aUpn1o0FsxEO2y
         e+3g==
X-Gm-Message-State: ANhLgQ1afYwlcx9myeplnWajQ4VCz3T/NMB8bbybNUoNc7tLL5OAP7O1
        FmwbTA71jiK7HGcxU2c26q6smXrq1QGM9fam6RtoTYTgzlWpLpewxIloVpLCGZIy5eusp/MWVmp
        i5qstY/h7ihn5bxfuKcS/GnAX
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr5126517wmk.131.1584537218884;
        Wed, 18 Mar 2020 06:13:38 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs+9a05PJ9MjSVvgvmjIy/7AfVl4jvUgyfkQTDqBDQ0QhqKsWXVBZhmLJxegqv36zeZ+Qbawg==
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr5126491wmk.131.1584537218610;
        Wed, 18 Mar 2020 06:13:38 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
        by smtp.gmail.com with ESMTPSA id n186sm3807573wme.25.2020.03.18.06.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 06:13:38 -0700 (PDT)
Subject: Re: [PATCH 0/2] Fix errors when try to build kvm selftests on
To:     Xiaoyao Li <xiaoyao.li@intel.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20200315093425.33600-1-xiaoyao.li@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7f7a2945-300d-d62c-e5f5-de55c2e3fd2f@redhat.com>
Date:   Wed, 18 Mar 2020 14:13:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200315093425.33600-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/20 10:34, Xiaoyao Li wrote:
> I attempted to build KVM selftests on a specified dir, unfortunately
> neither	"make O=~/mydir TARGETS=kvm" in tools/testing/selftests, nor
> "make OUTPUT=~/mydir" in tools/testing/selftests/kvm work.
> 
> This series aims to make both work.
> 
> Xiaoyao Li (2):
>   kvm: selftests: Fix no directory error when OUTPUT specified
>   selftests: export INSTALL_HDR_PATH if using "O" to specify output dir
> 
>  tools/testing/selftests/Makefile     | 6 +++++-
>  tools/testing/selftests/kvm/Makefile | 3 ++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 

Queued, thanks.

Paolo

