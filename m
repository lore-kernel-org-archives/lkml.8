Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76B2C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5276208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Gt/cWQhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgCEM4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:56:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40698 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgCEM4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 07:56:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id e26so5619361wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 04:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=HjCIB0cRkswxBHicvx3GUv0HnHsmCo8E8PgbIAIILt8=;
        b=Gt/cWQhhASP5bBzj8TNSd2HNFVxn+yN97a2l6r9ou6WkoZ9ke+th42t11blcXXVp0B
         ghq7GvlWbyevzK+R8YSdaHLsREQV69CgCzV5gnte0XYqag7edAbdx3NksGubzTbhrC6C
         L7WDW2T91Hh7BuiXiHZj3m41Zjzb2ehCS0iFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=HjCIB0cRkswxBHicvx3GUv0HnHsmCo8E8PgbIAIILt8=;
        b=PMNXnUnJNDkwlPI3PdHqhfmQqaaR3eu6tB4RlomRlGCCwAzZzKp3DJvpkf/DY/4pi8
         MbaztepE/dVMlKckqd31gpCgRFErEVUoo+Brv/aA6kzOd3O30XEThqiSMVBckPYYjKuN
         aq/Lbfi+uuQ0caIK/YXRd/xv6Rf4zROal/27BR8KnoFfYCi8y7LC81W3+CVyZRhQErP0
         wWi0TxuDKVHwscikCwiEMPqNY54rhJ7MImJFSJobxmh7j0c8THKkAe6rf7eOvaWlifTe
         piPKLZ+qx6HsNxguh9Q8kP8FcWz/A3D0bfQwsdMJp2Li5RyYhko5Ozq+NJphJ+wxtVUq
         fMWg==
X-Gm-Message-State: ANhLgQ2ZjaMNSA749o0JPltT3zH8BZ03X/iAK0QCgFEm7KmwI2xmhue8
        r07T3Bd8N3Kvzc5OpKJWJHX7+g==
X-Google-Smtp-Source: ADFU+vtTdXrgymK5ixyZsrcFBHG6FINonOFExU1Faxcsm81kgoO3Fs/OiO+Ghm8rTSqRlerFLgFhTg==
X-Received: by 2002:a1c:7f87:: with SMTP id a129mr9810661wmd.160.1583413003982;
        Thu, 05 Mar 2020 04:56:43 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id s5sm42900540wru.39.2020.03.05.04.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 04:56:43 -0800 (PST)
References: <20200304101318.5225-1-lmb@cloudflare.com> <20200304101318.5225-12-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     john.fastabend@gmail.com, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team@cloudflare.com, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 11/12] selftests: bpf: enable UDP sockmap reuseport tests
In-reply-to: <20200304101318.5225-12-lmb@cloudflare.com>
Date:   Thu, 05 Mar 2020 13:56:42 +0100
Message-ID: <877dzzyn79.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 11:13 AM CET, Lorenz Bauer wrote:
> Remove the guard that disables UDP tests now that sockmap
> has support for them.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

[...]
