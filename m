Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AE1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 22:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 849182086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 22:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596666249;
	bh=s6WJZYX+rw7JseXqsa5Ed8HNbPKm4WjdarWjPDxi0rM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Ow7cPdcVYAfw5fsgBbdcRSVyCuNb+vCD++JYyer/Nq1jff/++SNVJHuQD48eVVguP
	 fvWSs4wk/ggMlMUo/SCg6M3HTOv3558TE6PWC+gXIfO6yjkP9vppaSmvngF6HsPQu2
	 8FbFmEuf0fjr+3nnaggkQcsCi8+pefShsrzS2H4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgHEWYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 18:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgHEWYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 18:24:07 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14E1C061756
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 15:24:06 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id z22so10494482oid.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 15:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c/0XN0nQd2KpNchDFp8LW2+LpOtHnOT2i875v2wDjPM=;
        b=iRcPk7qbcM0wWiGxJX5MZMWN1las2jGCKplJY2ksTyzDvuMaZI1SfqUfqYkcIlbNtH
         wnVGFVLYVx7YEMuzBhHAMew7QDyi/tEJi+cQtH0UJyjDCrTX6TW59U2FhN9VRwaM4roy
         iAckGC9CysC28qoBqVLqQh79B/iqILwhmcOlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c/0XN0nQd2KpNchDFp8LW2+LpOtHnOT2i875v2wDjPM=;
        b=Pxe1iQsI4EeVQo6vAVx1vXoDhu8kIZy8q/7Mk3eK0dHcLbezFGtbMc2HU/xI0KPmUD
         Nlrs+evzRAefyaYoQUqRxtd8d+ETnn0/9Hj/5Swd2U1w7tleMck18aGAvBUM7+FUWBQS
         AgoqTZZnm6Askszg/PYs8JpiQ1E3esMAOakIMbJZsyiyvkeRxnYytwc1zVnr5+mD/qH6
         WjJI969siDMrcLASEExAMFVk5fQAa5e3QXY2PijJwB2dObA1ZBEZyAFEDs/S6XOgHX2x
         DT+JwcEVbk5KUOSM158SzbvolC2e2q3DBN9jM8GsuKuhVZRvXjHRw5pIhxAb3Y3t7Nie
         rzSg==
X-Gm-Message-State: AOAM530ClWhEaUfUAiXZA4dw0M6A5oqjP+5SlKLvBwwz1vjg7zCpiEcG
        d07EfCEzwF/DsifLCECm8zr1yA==
X-Google-Smtp-Source: ABdhPJxIVH2oNQNMTpgmLOqjlAJh/fTHFh4bcvVe80BUYWbOiGCnmwuTEEJGzLIQH5gFrH6v9MbQlg==
X-Received: by 2002:a05:6808:610:: with SMTP id y16mr4467410oih.0.1596666246158;
        Wed, 05 Aug 2020 15:24:06 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a187sm738568ooc.19.2020.08.05.15.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 15:24:05 -0700 (PDT)
Subject: Re: linux-next: manual merge of the seccomp tree with the kselftest
 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200720155917.607fff9b@canb.auug.org.au>
 <20200805154511.698d76d0@canb.auug.org.au>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0300764c-a9cf-bdef-57aa-afc0e59d8c17@linuxfoundation.org>
Date:   Wed, 5 Aug 2020 16:24:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805154511.698d76d0@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/20 11:45 PM, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 20 Jul 2020 15:59:17 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi all,
>>
>> Today's linux-next merge of the seccomp tree got a conflict in:
>>
>>    tools/testing/selftests/seccomp/seccomp_bpf.c
>>
>> between commit:
>>
>>    4c6614dc86ad ("selftests/seccomp: Check ENOSYS under tracing")
>>
>> from the kselftest tree and commit:
>>
>>    11eb004ef7ea ("selftests/seccomp: Check ENOSYS under tracing")
>>
>> from the seccomp tree.
>>
>> I fixed it up (I just used the latter version) and can carry the fix as
>> necessary. This is now fixed as far as linux-next is concerned, but any
>> non trivial conflicts should be mentioned to your upstream maintainer
>> when your tree is submitted for merging.  You may also want to consider
>> cooperating with the maintainer of the conflicting tree to minimise any
>> particularly complex conflicts.
> 
> This is now a conflict between the kselftest tree and Linus' tree.
> 

This is sorted out. I added a note to my pull request.

thanks,
-- Shuah
