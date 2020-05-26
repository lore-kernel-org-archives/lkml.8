Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF44C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C626208C9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590532182;
	bh=ekKNeNee1MhvK9tq5BOS9AGTldx3+yaX5CwkXqG7/TA=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=gb28/Soe/DQTbx7ZXMcAxhqhesNIQ2Tbp2OR2G3gfEGsQuqzSWcfKYCnubM56q1gI
	 QThnBcIkeuq2cdSNUj3RVt2LbHsTcXCTItJGWvhSneOYp7rv5CXUOBR4Mx+cKbdVqp
	 gBO1tPNi8ur7w37tiOAUwS3ZcAeZuhRQgiZRLHHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392000AbgEZW3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 18:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389482AbgEZW3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:29:41 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB14C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 15:29:40 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id b18so17723116oti.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5wqB25Ndtf7G896Xqr2DU1ONCjpaiNIvRfUkDhIp+o4=;
        b=ajCuuPdVNqJkiWUnn8o03t9TsMo7OEm3Qkfy9klzyZhl3i1I3ekfHr0s9Zn3xB8saQ
         KsS8XImoIfanBQsGd/FJI/5xiiDtBWFT7WfsF7PAbZAWWtlc37D0g9zX0Irm3bp5N0By
         533c/c/rF8H6sPab+sGruZq3Kx8M7fEalWda8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5wqB25Ndtf7G896Xqr2DU1ONCjpaiNIvRfUkDhIp+o4=;
        b=bvcGI2VZ0VT286b0uqVUW2rRaRlMUWeVzsJOciRHtTTIMUDVqL1Frd7XdBJ1nI1zdU
         hhBX2Gkj8fcxJBcUKQTuDI02HKyNFVHDl+FY+QdP4t6/LQ6iuDCYpiFH3vE1TmVXIGhv
         NwVGwTThKlupaA/J0vmpCklwhUdhEmnhMLm6TaTgqLntTQaAAEFyAbzPPCVUoV7bfP8W
         OKFIX4PONgewkJsOJSg6HlxZgj4mKf5of9l6I+2kE0CFiVUU3fsT8FyE+TwgzZtqCrhj
         D5s9E3WV45e3uxRpgo4Xd2Mhz9JufA4Cno+WPi9MAyZL7vsNVNKFqGFNMwCA33YN8gmU
         ZKyw==
X-Gm-Message-State: AOAM530VMMh9F/CxsUusXugY3jdj92NcT/g3RnwhJKwrWocwDm/PIhts
        PMME+8ZlKHwOH96x0+n3YnG9nQ==
X-Google-Smtp-Source: ABdhPJw2UJGheVoQlPvhb7lYFGjKDjL07dSv/0TUE+bFEqIDtMMdHttQ9hsCTHmFNvxtgVQFW6OFrQ==
X-Received: by 2002:a9d:6092:: with SMTP id m18mr2402145otj.117.1590532179333;
        Tue, 26 May 2020 15:29:39 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d21sm282371otp.46.2020.05.26.15.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 15:29:38 -0700 (PDT)
Subject: Re: [fixup] kunit: use --build_dir=.kunit as default
To:     Vitor Massaru Iha <vitor@massaru.org>, kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
References: <20200526183436.47026-1-vitor@massaru.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ace26347-a78e-1bd1-86f5-f8e644aa93ec@linuxfoundation.org>
Date:   Tue, 26 May 2020 16:29:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200526183436.47026-1-vitor@massaru.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/20 12:34 PM, Vitor Massaru Iha wrote:
> To make KUnit easier to use, and to avoid overwriting object and
> .config files, the default KUnit build directory is set to .kunit
> 
>   * Related bug: https://bugzilla.kernel.org/show_bug.cgi?id=205221
> 
> Fixed up minor merge conflicts - Shuah Khan <skhan@linuxfoundation.org>
> 
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> version after merge on kunit brach:
>   * fix identation (tabs instead of spaces)

You mentioned spaces breaking python. Please include the python
errors and make it clear in the change log what is fixes.

thanks,
-- Shuah

