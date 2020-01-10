Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBBCC33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DF42072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578692354;
	bh=7Gltkh8C8vj0lWm0fqbx6Gr/WMmvGqGiXB3jFfKe47c=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=2F5eLT9AEPnub4kcGBlT09b0ybzv+yc2TZXrBBLSJgenwH0wNFIG5j52aDcAuORGg
	 E+R3cXAOcKrmWbioNUGivkGXuFOUquGIzSWw4aubsXz7dPU96qeTwVspnTyXaQNTgR
	 bYel6G4bwmlLXAHkO9WYOmUmvBa3Y7zAqJS/3OKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgAJVjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:39:13 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41953 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgAJVjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:39:12 -0500
Received: by mail-io1-f67.google.com with SMTP id c16so3637718ioo.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 13:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r4PmeZ/898aGumdPWOcSK9D1hCv5M+BfhsqeoQLug0k=;
        b=ML7g1aGMVB7Qp8hywr4osLv4e9aIFPmirYd1vE8lV2zZG0jw6MHA7xk2G5/1QBpB9A
         lsFCYoibZbW4Yg+U+lVU8nWRGcQlf5nbru+soLWJxXYIFsF/Qg+8PBBOXz4j+XtgtDS/
         zIeEaBxxVesBv1PbkWOCVFJp5lJnAbmVRRK1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r4PmeZ/898aGumdPWOcSK9D1hCv5M+BfhsqeoQLug0k=;
        b=FzC7fLb69TRwoPd8tPxJH0gKmWJ9GEL0Wv5NM75fHwiycWpUK3NwGy3S1bgbNx8b7U
         JTfKwgFDkIkmkW6BlAON+KlXZR/9VEMb5iOccAy6jATvseMRKBjhx5mTGFMcuuvP77L/
         i0PaiuztyXh47+rOhGDL5mjeAu62s4gkkysi6RbU/TlRS7kxDTfq/U+/xLUHMd1hDj3N
         ibopiJEX772wAdOs/jyWLKKwcvfK69JabY3oNPv8mEwtWpBtcXckETmYQtDyw+CuiQNJ
         FHNVHb0uLocRN4m4FXzs75ZJwyEnBRdfFzS4DbKurGrAsb60hgNxB3+Cfx/RGGSq0fbl
         tTvw==
X-Gm-Message-State: APjAAAW1+ubMuaXNQL5TQOFm7uMaZBVilUMXaK8s2Ub5TB8FRj896Xdy
        H4Oxc9QSLczf6IKFcikZjbH77A==
X-Google-Smtp-Source: APXvYqzSdoMLMiGIeDogdzlJjB5mKTqBKEmCoffAq0etf1KN36GTMK3ghL0iHprY4NA340RAOTssng==
X-Received: by 2002:a5e:9907:: with SMTP id t7mr4335773ioj.72.1578692352205;
        Fri, 10 Jan 2020 13:39:12 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v10sm825497iot.12.2020.01.10.13.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 13:39:11 -0800 (PST)
Subject: Re: [PATCH kunit] kunit: building kunit as a module breaks
 allmodconfig
To:     Alan Maguire <alan.maguire@oracle.com>, brendanhiggins@google.com,
        gregkh@linuxfoundation.org
Cc:     rafael@kernel.org, jmorris@namei.org, serge@hallyn.com,
        knut.omang@oracle.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, sfr@canb.auug.org.au,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1578656965-2993-1-git-send-email-alan.maguire@oracle.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <bb27a03b-1c3d-567b-caf3-7b0e4a039f6d@linuxfoundation.org>
Date:   Fri, 10 Jan 2020 14:39:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1578656965-2993-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On 1/10/20 4:49 AM, Alan Maguire wrote:
> kunit tests that do not support module build should depend
> on KUNIT=y rather than just KUNIT in Kconfig, otherwise
> they will trigger compilation errors for "make allmodconfig"
> builds.
> 
> Fixes: 9fe124bf1b77 ("kunit: allow kunit to be loaded as a module")
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

Thanks for fixing this quickly. For future reference, Signed-off-by
should be last. I fixed it and applied the patch.

thanks,
-- Shuah
