Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62942C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 03:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C8CA2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 03:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDuwCt8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbgFVDzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 23:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgFVDzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 23:55:50 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90EAC061794;
        Sun, 21 Jun 2020 20:55:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 64so7804905pfv.11;
        Sun, 21 Jun 2020 20:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WezStc/D1EkmnZa5KTdzKFk1A1s8o2Eo2djnKEDQ8c0=;
        b=DDuwCt8NaRU8AEME2lf6Xc/MxvCRFUlvC7hL5pw/OXnA9wDQyF8UUwvnU9fpkxofAG
         dEwBh8VoveUofsI2MpvknhfML6tLZiIW0Ah290WlGaSSheaS66PbO/aD6qkz1SkbnYzD
         1rAzWX9OaZGXEvlHdistSoUR3uZM5J8y2fqynD5SIJG4qCnme/bVRjVxs/IBX4qc5OyY
         KkqwFVtMpqM/PRZx0qR+WaNgWZrqJiuFRyQpEN+UsGQt/Aelyqqi1VnX7cuGOZ56EYKW
         snF2HbGDOGxqYtPaF49qt0qfXTP6Y0ImyZ0VhngeeZQqQj4cPV3WIMitA4u/QON3K/Tc
         xtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WezStc/D1EkmnZa5KTdzKFk1A1s8o2Eo2djnKEDQ8c0=;
        b=a0wiZMzrUQsp1+Pt7yAA40KLGBnYaSeVQVT8NL2m3wwz7kWtKBHaHzB66ceC732rRm
         UUDZ3G+JS2zuy6K+UjdN3wx7TcIik5wu30CfsIVmlhWYF7SbLUVzgY8I5fqZ2jgD4Rj9
         cPmLtqc/K/qSjlYOKKO4Y/PcMd4Ujyhcn4em68FmAQa3OH6SXXjs6Q2R9i3oCYmF779H
         5+0JPZ/HvQeoNRMH6ib/x9jmC1mkGLPa5VOwflPWyg0EZZtMg5Tugm7r4Guw6lHymo4N
         a/2zbf8+ZZnzCDqFSBWughUKDlVM1ZMrVawHnvmW5q1V21n+B/nSoRIabLsVmgFptYiV
         PKdw==
X-Gm-Message-State: AOAM532/9TN/p/FDhfOh8SNU45vNrClpOfycOhEMJAVMW532C/xWd6fE
        5OBWlJjpCTj2m5GnOp8+lHxqJ0Eo
X-Google-Smtp-Source: ABdhPJyPV7626Cj2vZU/cpWBhGomZEB5wxpncS/E2vsopQ7iNkcMfS6SY127a30X2xcNxNiviMMbrA==
X-Received: by 2002:a63:6643:: with SMTP id a64mr8466553pgc.246.1592798149925;
        Sun, 21 Jun 2020 20:55:49 -0700 (PDT)
Received: from ?IPv6:2601:1c0:6280:3f0::19c2? ([2601:1c0:6280:3f0::19c2])
        by smtp.gmail.com with ESMTPSA id d25sm9519660pgn.2.2020.06.21.20.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2020 20:55:49 -0700 (PDT)
From:   Randy Dunlap <rd.dunlab@gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Add naming guidelines
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200620054944.167330-1-davidgow@google.com>
Organization: nil
Message-ID: <067f9f56-8990-0d60-815f-10d6c296dbef@gmail.com>
Date:   Sun, 21 Jun 2020 20:55:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200620054944.167330-1-davidgow@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/19/20 10:49 PM, David Gow wrote:
>  Documentation/dev-tools/kunit/index.rst |   1 +
>  Documentation/dev-tools/kunit/style.rst | 139 ++++++++++++++++++++++++
>  2 files changed, 140 insertions(+)
>  create mode 100644 Documentation/dev-tools/kunit/style.rst
> 
> diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
> index e93606ecfb01..117c88856fb3 100644
> --- a/Documentation/dev-tools/kunit/index.rst
> +++ b/Documentation/dev-tools/kunit/index.rst
> @@ -11,6 +11,7 @@ KUnit - Unit Testing for the Linux Kernel
>  	usage
>  	kunit-tool
>  	api/index
> +        style

Use tab for indentation, not spaces.

>  	faq


thanks.
-- 
~Randy
