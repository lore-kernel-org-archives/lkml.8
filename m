Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBA8C54FD3
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C0F2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585152832;
	bh=z/l7SBBshWOFYbBGR0ClUkeQrd+UBb2CWsZuH43i4Vg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ReH+YhToo5yWQf/wVg/RxloufyaEHYdRT3dNvpiYaOfDp4bYcYwKDfDVtgTBKoA86
	 p1OdNI+knLhiC1h6F3Fes44frc8vxE8hGvG0NYCeOBhNBOboepHm2VsEQYzWNqopZV
	 eR3Ja+ktGNdPKVoHJ6jI/UH6bszs+QfsiVBEx+k8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgCYQNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:13:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbgCYQNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 12:13:51 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7641720409;
        Wed, 25 Mar 2020 16:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585152830;
        bh=z/l7SBBshWOFYbBGR0ClUkeQrd+UBb2CWsZuH43i4Vg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=d5srGXVBWjNKP/w4N+eoVs88y3PQJBDFqAEI8Qpi/R/mv7gG84m3wE1+TDSovJtiw
         ruLJW+9oq2T58EGMsju0piBrSirMWrctSS4dxMbZ15nrmdYnDSVUnhpvLQhV7keyQr
         8G3VNE98fkGr35AEvcwLw5c7slY680aAF+jKxojQ=
Subject: Re: [PATCH v2 0/6] Fix errors when try to build kvm selftests on
 specified output
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200325140133.103236-1-xiaoyao.li@intel.com>
From:   shuah <shuah@kernel.org>
Message-ID: <8e5a7de6-25f3-7979-c6b9-49e1ea717f8e@kernel.org>
Date:   Wed, 25 Mar 2020 10:12:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200325140133.103236-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/20 8:01 AM, Xiaoyao Li wrote:
> I attempted to build KVM selftests on a specified dir, unfortunately
> neither	"make O=/path/to/mydir TARGETS=kvm" in tools/testing/selftests, nor
> "make OUTPUT=/path/to/mydir" in tools/testing/selftests/kvm work.
> 

Please elaborate on the problems you are seeing. I would like you
to describe in detail the problems you are seeing and how you are
fixing them in this patch series.

The problem you are fixing here is subdir structure not being
supported for relocatable builds and the Makefile not being
able to locate headers files. These are issues, however, these
need to be fixed in the kvm Makefile.

Please look at arm64, android, futex tests as examples. lib.mk
and main selftests Makefile allow for overrides for make targets.
When a test has sub-dir structure and libraries, it is easier to
handle these in the individual Makefile.

Please fix the problems you are seeing in kvm Makefile.

 >I only test the sub TARGET of kvm.
 >In theory, it won't break other TARGET of selftests.

When you change lib.mk which is a common infrastructure, theory
doesn't help. Statements like this make me very reluctant to
accept patches. :)

This is one reason why I asked Paolo to drop these patches.

thanks,
-- Shuah
