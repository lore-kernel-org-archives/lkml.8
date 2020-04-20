Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E108BC54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB57E20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="OAEQdus/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgDTJix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 05:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725865AbgDTJiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 05:38:52 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20228C061A41
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 02:38:52 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id l11so7375001lfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 02:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fC7yVlTF2dg5BszQAz4tJyESdZOBEbxLy1Uamcwth88=;
        b=OAEQdus/uuBcOAthS3TtEvK7zG9rY3C+I5VwReBIuCwv2zXqb1cD/5zjsXepByhQ3d
         UCcSueB286izGvk8BO7rr9Ggr2ajra4ogReJw0OeO7mmEf53K6IN+l29NJctj5COEcqE
         Yo712wSYLvrq55NXzfSdoszUSYGWltWW6hWzCt7QO9VmVwiOPzXtyaALTMTax3Ux7Kof
         xsui/qk+6y3PSgsPE1KkTyT8kB24U3cIto2jpiK1aLt4hPxa4HXdf0dL80rMMYTVKesS
         biXxkI/wUmKgYpuV9t/yrDaBqiYDYnUyCFM+ehbd9gM9QIiTcspvH+6s7YrVkaGr8cTl
         CvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fC7yVlTF2dg5BszQAz4tJyESdZOBEbxLy1Uamcwth88=;
        b=ZTGSGvbxnCY7nu8/TbSjue+K37dLL2KJ2D3PUgdZXjEPdJXBJOJnKGxtdAHcP21Spm
         TGs2Gkzbh8RILVMre2Qz3KXBtkn4jat1RnLJd8PJtcgYEi1fJAfsYxPhU8eahBFKLO7E
         rh92CQaLazMjBpAc+/4cu9+yTnsrmPuK4GddJ2ccSrbXnV7adaI1/If7JhQKaAouLhe7
         ce5G5myOlf/C9KlV2GDKkXcbyS9+p9+qDGRVHxgkDKDFE2YNgu+mzbE0enolz0MAWU9j
         UAyDVLggfLkytpS6r3dxlwx6pWkfWGH/Qx4MeK+EYeobeAVjxYVQvUev2q+zpZRmQA6F
         bNmg==
X-Gm-Message-State: AGi0PuYXkVrz52kxejukXXO5JjWub4d4OX1RAnR0/EUIcS9KGuj2GAge
        6AL2cXls6XXZT//JFtTqBAuLLPSEk4P1cg==
X-Google-Smtp-Source: APiQypKznq9XrVI9hd+h/IzXvVE/uV6VvohF+/6F5gk7jvKwnPWCKyu2uLVFoOANvhPhLC1K8XldMg==
X-Received: by 2002:a19:1c3:: with SMTP id 186mr9964767lfb.191.1587375530442;
        Mon, 20 Apr 2020 02:38:50 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:25e:8f26:1014:e519:2b4e:4734? ([2a00:1fa0:25e:8f26:1014:e519:2b4e:4734])
        by smtp.gmail.com with ESMTPSA id w24sm320690lfe.58.2020.04.20.02.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 02:38:49 -0700 (PDT)
Subject: Re: [PATCH v4 1/5] PCI: OF: Don't remap iospace on unsupported
 platform
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200330114239.1112759-1-jiaxun.yang@flygoat.com>
 <20200420071220.155357-1-jiaxun.yang@flygoat.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <d8f444bf-71a5-add6-2a2c-7807a397e8b7@cogentembedded.com>
Date:   Mon, 20 Apr 2020 12:38:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420071220.155357-1-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 20.04.2020 10:12, Jiaxun Yang wrote:

> There are some platforms don't support iospace remapping
                           ^ that         ^^^^^^^ I/O space?

> like MIPS. However, our PCI code will try to remap iospace
> unconditionally and reject io resources on these platforms.
> 
> So we should remove iospace remapping check and use a range

    I/O space, maybe?

> check instead on these platforms.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> --
> v4: Fix a typo in commit message.
[...]

MBR, Sergei
