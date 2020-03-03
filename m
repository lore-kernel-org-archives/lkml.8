Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BDFC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 22:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2412072A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 22:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583275101;
	bh=i+FJPpnpUyQ07Wv4G7WRCDmh82JZ3q2tQCrFPGAxDCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rCRpZWZL20R5OxPhQ/JD9j18nzCV8fXClhB1waW3wb5e2qAPH+6WD8rbijA6JIhWp
	 DggCjj6y1F15yhCYu+ENMhZf7F4ufeA0IPn9OQfrR/ZJoSFhiYo5mYixeany6FtlRP
	 CwWeVa8lt8OBaC6SVYSYoSyeO9jlwkTivHzHJkcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgCCWiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:38:20 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40572 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbgCCWiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 17:38:20 -0500
Received: by mail-ot1-f66.google.com with SMTP id x19so64274otp.7;
        Tue, 03 Mar 2020 14:38:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0FIpv/OUvR76v9iwOAqhXw3ngtUGboEQ7jvFqcQcaq8=;
        b=VprBxdrt/eP80Gq4qIfkcuQSbtaZPqtMHrNbgf3/EBmaHk9hlDk+FiovQ87CTYraBI
         cmvkvbaBcx5ShMOHMmmNRW1cMwO3uxbpM4fGzdQ43ZavDns1PdL5+OgfSdCxMW2lwPTc
         R1CoZqA4Vair4bTtb7uQUHbx/rw+ldgz8UI1X3nS/quf/WwibSB/2LBVN73VicUcgMWr
         uv7n7EwOgQaleqX4keFhQ0gm8SEqHJ0zr+h9V8xejwoxAz2SGnAgB/HCEGf8M6v7NMOU
         +GImJzGmtmrN3UFz9HnVFhqm5rIerzFFC1g1fhNFPCbEFyUlmUbsR2RmzF2KPyqf0Cmz
         HKFQ==
X-Gm-Message-State: ANhLgQ3mEPBUn53pTUGh6jv/6K77XuIV/BWe9PhoB1Chy3k0V/qamwl4
        ab3s2CTCAXgmeUO/gogCZQ==
X-Google-Smtp-Source: ADFU+vtGIq1fDTWdDHUduPlKc10mCXIOM6omTTG7lUpIbghFUq+2FcoNa8d5APUpEdUIRJhGDkQFSg==
X-Received: by 2002:a05:6830:10da:: with SMTP id z26mr95262oto.27.1583275098314;
        Tue, 03 Mar 2020 14:38:18 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t203sm8212900oig.39.2020.03.03.14.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 14:38:17 -0800 (PST)
Received: (nullmailer pid 19747 invoked by uid 1000);
        Tue, 03 Mar 2020 22:38:17 -0000
Date:   Tue, 3 Mar 2020 16:38:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     devicetree@vger.kernel.org,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: tps65910: Improve grammar
Message-ID: <20200303223816.GA19633@bogus>
References: <20200227160522.17582-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200227160522.17582-1-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020 17:05:21 +0100, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= wrote:
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/devicetree/bindings/mfd/tps65910.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Rob
