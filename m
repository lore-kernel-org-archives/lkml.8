Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DA7C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFC520753
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584977627;
	bh=jyFWBRIRYk0JA7U0dN/9XleYTgS2UFd/FcsRq3elXVQ=;
	h=Subject:To:References:From:Date:In-Reply-To:List-ID:From;
	b=VLiIIp9HO0WdkObWOJY7uSDKCbthIMUB7AieqdthfrVFv9Hb9ev+DQEwwk4D6O/9o
	 b69OUPFMjjizNZhEaI/2tT3pWMxrVyMO6TSic5VyvKguN2bEfNYfhaQBNKPIfWaSYK
	 iDpnYiUn4Qt9HizeTMnmOPwpvk28bHY3ZXsWNUac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgCWPdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:33:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbgCWPdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:33:46 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C711C20409;
        Mon, 23 Mar 2020 15:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584977626;
        bh=jyFWBRIRYk0JA7U0dN/9XleYTgS2UFd/FcsRq3elXVQ=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=OBOGUwc6BKO42ghUi9CibvkvoSUkPxkD81dK5aV3EKgfqVh4QR9JBNrcRliYV0eNM
         ORNu+CJ4g6zQOXS5dXh4WHKx69zD5gyoHMB682zrngRVzUO918V+dfHAqD3jy1a71+
         AFsrAg+13kB30qLqlIyw45luTG/fuZ/lfXbrZ1Sk=
Subject: Re: [PATCH 0/2] Fix errors when try to build kvm selftests on
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, shuah <shuah@kernel.org>
References: <20200315093425.33600-1-xiaoyao.li@intel.com>
 <7f7a2945-300d-d62c-e5f5-de55c2e3fd2f@redhat.com>
From:   shuah <shuah@kernel.org>
Message-ID: <b472a6aa-dba1-1e50-c660-7bbecf2d0eff@kernel.org>
Date:   Mon, 23 Mar 2020 09:33:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7f7a2945-300d-d62c-e5f5-de55c2e3fd2f@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/20 7:13 AM, Paolo Bonzini wrote:
> On 15/03/20 10:34, Xiaoyao Li wrote:
>> I attempted to build KVM selftests on a specified dir, unfortunately
>> neither	"make O=~/mydir TARGETS=kvm" in tools/testing/selftests, nor
>> "make OUTPUT=~/mydir" in tools/testing/selftests/kvm work.
>>
>> This series aims to make both work.
>>
>> Xiaoyao Li (2):
>>    kvm: selftests: Fix no directory error when OUTPUT specified
>>    selftests: export INSTALL_HDR_PATH if using "O" to specify output dir
>>
>>   tools/testing/selftests/Makefile     | 6 +++++-
>>   tools/testing/selftests/kvm/Makefile | 3 ++-
>>   2 files changed, 7 insertions(+), 2 deletions(-)
>>
> 
> Queued, thanks.
> 
> Paolo
> 
> 

Sorry for the delay. I would like to see these two to go through
kselftest tree. These involve frame work changes and will cause
problems if they aren't integrated in kselftest next branch.

thanks,
-- Shuah
