Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B0EC3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D0A2467B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOFBJ3e2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgB1Hvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 02:51:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39958 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726188AbgB1Hvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 02:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582876303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eTT8FXeQMHv7s+EBx66XZVwoA8dR5HvOkfpI/qKvIkU=;
        b=BOFBJ3e2ocCL9B9IuCHThIcKlIuyvLwjlypG5EY2fFyKlJnb12XV72wO8eV59EjZNVtG0m
        KAbNQzFLLdpLFo35A4gjpoTkVkqzT6Ws43lfms5JS6qth122Lf2mYLDBxjNIyMSSNUF2D1
        GIgsNbj7AjG2oBq9JQxm61rGbj/BRnU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-Zsoi-6p4MFWy-Dx0mvBSDA-1; Fri, 28 Feb 2020 02:51:38 -0500
X-MC-Unique: Zsoi-6p4MFWy-Dx0mvBSDA-1
Received: by mail-wm1-f69.google.com with SMTP id f9so369974wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 23:51:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eTT8FXeQMHv7s+EBx66XZVwoA8dR5HvOkfpI/qKvIkU=;
        b=dFDlWuCjfxrqE2r7L5RUUPQO4BgWNPVxZEkDFqPrgNhQpLypwWbyzDO80dHjCXDn2R
         E2GQE9tG5YaPEMgyr1hEH5lOJ9lUa0iMw44QyR9yQFyDJe5H4WlugpFDZ3u+ep+NIqFg
         HP5yC1WPpGxCtPF2CUEZoIxTZ1Pfc+qO7senk8fe4BNOpWMoIUWCs/JGGLbF7aUBii98
         U7nGIGsHqfsB2DKF00CUQSKMLbtdWtgmCgU1Y2n2MFWIpSXezL3OU/0zdzX7hgrX+BOU
         AD3GCrfKGMvReFM9EAjie/AHM8dfEe8jyqTrNxMwKazCubiW3+G3GqR/uU9Xcw+ObSgF
         y0tw==
X-Gm-Message-State: APjAAAUaITfTyMvIhPeE8Lo4uysVcVLWQEo25GCukRdO3SatVQvBkoIJ
        jhc1OSv1eCjUXdxaVPfSWSccBilcwcSBIiuFVgfAgyHK9DbFXx6RQLIQI33zlgi8U7WL9kLVXjD
        tD6gRV3rLikkNMf+G6AsFK4Pq
X-Received: by 2002:a1c:7317:: with SMTP id d23mr3534890wmb.165.1582876297311;
        Thu, 27 Feb 2020 23:51:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqyEgITJkgzzi/X/0qQ4zxyjKAd+q5iaFUHfUC0A5D7/mXEzirfehxJYaerZloHy8sLfxR76Jw==
X-Received: by 2002:a1c:7317:: with SMTP id d23mr3534871wmb.165.1582876297061;
        Thu, 27 Feb 2020 23:51:37 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id o9sm11950607wrw.20.2020.02.27.23.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 23:51:36 -0800 (PST)
Subject: Re: [KVM] a06230b62b: kvm-unit-tests.vmx.fail
To:     kernel test robot <rong.a.chen@intel.com>,
        Oliver Upton <oupton@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
References: <20200228074408.GM6548@shao2-debian>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <96533a86-feca-ace8-952b-7e5c88732ee5@redhat.com>
Date:   Fri, 28 Feb 2020 08:51:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200228074408.GM6548@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/20 08:44, kernel test robot wrote:
> [31mFAIL[0m vmx (408415 tests, 3 unexpected failures, 2 expected failures, 5 skipped)

Please include the commit of kvm-unit-tests that you are using. You are
likely missing "vmx: tweak XFAILS for #DB test".

Paolo

