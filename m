Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DD4C11D0E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A66F24670
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582213766;
	bh=tPJqy7I17iS8Faldi9qkAdsBtRE06zoPwfwV6E+SLT4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=qDXkQVtfj9MaTSgl3HmShrlVzktktyWhj2pGGhA90bs5LftlGk4c6TrDMtL4LrRiQ
	 6BKW8o4WrW41MZ6l1F+xdv0BDy9/PJLabweoiAH+bxUyp+S2lfN0QYJedltBdMii6J
	 m/vfE6Hltck2CRFCY8sWv8W4FSFPtmChz0cr6WIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgBTPtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:49:24 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45526 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbgBTPtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:49:24 -0500
Received: by mail-io1-f67.google.com with SMTP id i11so5138591ioi.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 07:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TNlV6j5dy2YpzNbMudPK2N6M4tmat+Q7yeBq9QSr2Cc=;
        b=DAkOWfFvuULYeW4zlDdUrSsxfOp2+6i3eNbNfme23q36UoDRNBkz3lGrwWsQARSF/b
         Bhcp7v4C73l4K6NITvym0C/OScIwDVQouN0vfj9CVVGbIxiQwUwfFxyjlbjrB23zO+ye
         ChHirGZ2CzowM+kOAz1UKlh2JTJKtBhGXeduU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TNlV6j5dy2YpzNbMudPK2N6M4tmat+Q7yeBq9QSr2Cc=;
        b=reHzgG51DJGaunE8mM66FqhqdbSP4sf5ycO//BmDVKBEB4G/W0NsuaLJ7IjszFBiYE
         nrn0VgfohPt80uRWefzw4NhR+awDNKgyJ5rw0Cosm0t46dmV0IgBSQbkeVdgpMFierY+
         Igw+AH2GSNiWyyTr55EyeTD6TUfJoEFkhFKEZRajxEF04rVMxMUIAqLFqNz9GIlQPO1q
         91Bhx1rRG4FvL7Rmld/T1Evp/GcN73O/zWp4Y9t4U5D2o88L7eGTs0va3fpCzSanzHEn
         80vfRc1NVenZGLBBHecXN3j5luvVdoGY00/jwfMLOM3GHwVVAP70FUswk42CEr2G/P13
         Fkig==
X-Gm-Message-State: APjAAAUr7QkotWr16P8d/sXg88qcHgAX6Beoj/rHVFFWzxJBjOJrku/Y
        EbZYpjZmbeS53mo79w/GRiQKdyDUT7k=
X-Google-Smtp-Source: APXvYqwo5E+136MY2CwhDaw8W8F8otbFcd8wGERgcY8BOLwyf/TxO32uWLk0lDAiASLqVmzlDZeraA==
X-Received: by 2002:a05:6602:2113:: with SMTP id x19mr26054792iox.227.1582213763404;
        Thu, 20 Feb 2020 07:49:23 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r18sm1216159ilo.3.2020.02.20.07.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 07:49:22 -0800 (PST)
Subject: Re: [PATCH] selftest/lkdtm: Don't pollute 'git status'
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <668b6ff463849ceee01f726fbf3e7110687575ec.1580976576.git.christophe.leroy@c-s.fr>
 <ca71e490-b4fa-bf53-7a60-b6954b9dd33e@c-s.fr>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <17ea7ab6-d5c4-cf38-3c3b-9da70b2c35b5@linuxfoundation.org>
Date:   Thu, 20 Feb 2020 08:49:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ca71e490-b4fa-bf53-7a60-b6954b9dd33e@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/20 7:58 AM, Christophe Leroy wrote:
> ping
> 
> On 02/06/2020 08:11 AM, Christophe Leroy wrote:
>> Commit 46d1a0f03d66 ("selftests/lkdtm: Add tests for LKDTM targets")
>> added generation of lkdtm test scripts.
>>
>> Ignore those generated scripts when performing 'git status'
>>
>> Fixes: 46d1a0f03d66 ("selftests/lkdtm: Add tests for LKDTM targets")
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> Without this, 'git status' now reports the following crap and real 
> problems are drowned in the middle, that's annoying.
> 

I will pull this in. Please cc linux-kselftest mailing list in the
future.

thanks,
-- Shuah

