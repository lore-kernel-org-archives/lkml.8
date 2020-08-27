Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCF4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 125CD2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6OiJbXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgH0G3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 02:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgH0G3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 02:29:10 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ACCC061260;
        Wed, 26 Aug 2020 23:29:09 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id q4so3889845eds.3;
        Wed, 26 Aug 2020 23:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XkJzJLbaIzNQwy67FIghvuXvnhqnegZh/i4rU+IC0pQ=;
        b=H6OiJbXxg0W5opHVvSlZDR2g4gA50S9557Oyxu88dsnkxYJl74BzLeIZTiPYUy5i42
         zmJnMGd40amdXJtrBgTiX6Qou96t5T2nfL16Jz6XdTjQyeZMJyXIZ1eWfvSS9QPgCM/O
         o3Bm+zeAQ/bkBvSe6TlEm2pKhWC2s1RhhLokllf8CL4QKoEy9P0IG7S0zGbAgjD7yPPd
         Jy8hRTq+rY4KFG39eW8R4TsITUpVx/D2kZoEnR7xJsjT3Aru2Bdvm04DOHQAB/gHVmnI
         LPIkaKWqApBvOqfp1YOyEArbnxYV8/Tzr6tevssCT3HWsH2ESwOwIzqN2Y7RrchRQj0D
         DE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XkJzJLbaIzNQwy67FIghvuXvnhqnegZh/i4rU+IC0pQ=;
        b=WWXanJjWHFViMxkLfgcUxMxEx1lAQdxLkWZBK3UgHPOuGNGY4kuLwHGssF7WJXY0I2
         qPscIOLw+MrmOFlnw59PwepjxPEzXX4HoNOTJFMUK3hv/bumSv0Rhm9iHoYXE1kBr9zC
         q/C88eMYkuxprex6SdW6K5MTT8tYu9xLB61uEphoR/5Xtfb6K0Smg/L+OmtLI3vWaiA8
         kaUrntZ5yjUUr6pchSuQwOGmiJfDeFqF/3BE7bZobQV0Rw5lUnrPKP9glxToCyknaZsK
         CcA/NVH7zaA0c/rss49dzqKuD5yHq+2tC1k+Va0GtGu7HSFPu2Cr09iXsQ+8X+hgeau9
         R7Vg==
X-Gm-Message-State: AOAM533lV71XLyDWRAo0HvptErswyTLohMIh0HhoWc8HPStlgL7iachR
        Ql43czkqsDLUB21BCy59Qs2MvFxLI4I=
X-Google-Smtp-Source: ABdhPJxfqr/B3+RKGioyAgW3KV9C5amMeIOHdGeRZ1SqoeomnD0wb+6gELMai1qL4ld3zMFlAzrS4Q==
X-Received: by 2002:a05:6402:74f:: with SMTP id p15mr16409279edy.377.1598509748334;
        Wed, 26 Aug 2020 23:29:08 -0700 (PDT)
Received: from dell.be.48ers.dk (d51A5BC31.access.telenet.be. [81.165.188.49])
        by smtp.gmail.com with ESMTPSA id u24sm803971edq.23.2020.08.26.23.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 23:29:07 -0700 (PDT)
Received: from peko by dell.be.48ers.dk with local (Exim 4.92)
        (envelope-from <peter@korsgaard.com>)
        id 1kBBPG-0002D5-PQ; Thu, 27 Aug 2020 08:29:06 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] arm: dts: owl-s500: Fix incorrect PPI interrupt specifiers
References: <cover.1592123160.git.cristian.ciocaltea@gmail.com>
        <41463413d6b756e9d24f8807cf95ddd98591b990.1592123160.git.cristian.ciocaltea@gmail.com>
Date:   Thu, 27 Aug 2020 08:29:06 +0200
In-Reply-To: <41463413d6b756e9d24f8807cf95ddd98591b990.1592123160.git.cristian.ciocaltea@gmail.com>
        (Cristian Ciocaltea's message of "Mon, 15 Jun 2020 03:19:08 +0300")
Message-ID: <87zh6gy53h.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Cristian" == Cristian Ciocaltea <cristian.ciocaltea@gmail.com> writes:

 > The PPI interrupts for cortex-a9 were incorrectly specified, fix them.
 > Fixes: fdfe7f4f9d85 ("ARM: dts: Add Actions Semi S500 and LeMaker Guitar")
 > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Reviewed-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard
