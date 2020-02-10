Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAE5C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50AA20733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NiQWcvLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgBJVPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 16:15:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44350 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJVPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 16:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=bsxuISQKXc1QVXfhX/xu9UmxvHFsqYl3xryeCuozyaI=; b=NiQWcvLzrYNrDYRy71Dxh5Y2/q
        TrFw4y/GXXWToBCQG70ylBysvQw2XIylVfTGj3napUhrN8yFe2GE8igpsb5KKkI2q7+EIY78qcNGl
        JOFU/7o7xL52L97MB5yPTgJ/1E6X4xri3GS0QQpJD9AOtuk5KYhRouccpkfGTvHfmIY9PZs6IHJiZ
        l1UzZEZieE7YQrAItSj47KGJU3KtHP0sPi4Ve/vjDZrhslLiqIzBXuVSWCxGI17CPxMquu99IN9rM
        MMLs/H99XBZIM0y5M5lb1gV7JaufImKjwP7PR0eeeh1Zl0bdwccDJzdk4Q7PYyX6dXJ0zHpo2V8oQ
        QElsnSbw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1GPH-00014A-Ej; Mon, 10 Feb 2020 21:15:51 +0000
Subject: Re: [PATCH v6] dynamic_debug: allow to work if debugfs is disabled
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Saravana Kannan <saravanak@google.com>,
        Jason Baron <jbaron@akamai.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20200123093628.GA18991@willie-the-truck>
 <20200123085015.GA436361@kroah.com>
 <CAGETcx86rQpS4qodSiv_v+E_8P3DUQDY9jiN_Yq07Jwh9tHQcQ@mail.gmail.com>
 <20200125101130.449a8e4d@lwn.net> <20200125014231.GI147870@mit.edu>
 <20200123155340.GD147870@mit.edu> <20200209110549.GA1621867@kroah.com>
 <20200210211142.GB1373304@kroah.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <827b4265-918e-99a7-544a-668edad5b2b9@infradead.org>
Date:   Mon, 10 Feb 2020 13:15:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200210211142.GB1373304@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/20 1:11 PM, Greg Kroah-Hartman wrote:
> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
> index 252e5ef324e5..585451d12608 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> @@ -54,6 +54,9 @@ If you make a mistake with the syntax, the write will fail thus::
>  				<debugfs>/dynamic_debug/control
>    -bash: echo: write error: Invalid argument
>  
> +Note, for systems without 'debugfs' enabled, the control file can also

Hi Greg,
If you make any more changes, please drop the word "also" here       ^^^^

> +be found in ``/proc/dynamic_debug/control``.
> +
>  Viewing Dynamic Debug Behaviour
>  ===============================
>  


-- 
~Randy

