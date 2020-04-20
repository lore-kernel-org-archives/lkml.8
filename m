Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA42EC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE2F20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d49h6XH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgDTIvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725896AbgDTIvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:51:02 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9D2C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:51:02 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x25so10056996wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/86wH7JWOB+EnbCrmjcNAfMepyHUh6K1vg0KqRTo2pQ=;
        b=d49h6XH0HHef07FJWwhy4NfpH2mlHTezHIUUaU/Bcd/h11fjOs+P5L4/1kYgKaDgRW
         wNPaBZJSN19VivHhR7S1/tc2jELyculFYhlLt8bHexuTkCfFKIR68hRl1GezsJFR7ir/
         fBky+koEGhAmGTRaunAKWxej99iPb6868mMWiTsD3DNZZcUVQI1dK2Zygnf35W6xpG8T
         H9HCIV7Bu5e89pkUQTc2CIiTB05rlF1g4auOUfdYlQH+E8ud3zE/1JcWTud4WAJjdcaJ
         G0nBtr7DvUyzzfL+HZ80jLy8U2WwS/Wd/HGv+lHy2zPa74LucMKohfEKpECRI0+rtmld
         P6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/86wH7JWOB+EnbCrmjcNAfMepyHUh6K1vg0KqRTo2pQ=;
        b=BTc6K8z6sSbjrtihpypYWuslccn6VQXUiAgowmkd2yiDHhn/F0uFRNv2O+eCxupJoT
         QdVzySexZWIBDbc0chkdNV/VtcKJ708KzLDWpABKG1ToCfIkstgfcGlE1o4teGYBaCwT
         +ce7kHTwXLVhlMe9HG84YD+L89o4mWSDUZ25JxS+148LYDn/SMiu+P8tx62zQqCQdJ5v
         6IrtlBM/Tz1XkPcgnnYTpLr2W9o1sqTO5O43tgjzlQJmwA3StswfRhbaANyDnBD2+1LJ
         pHP+rxKc2HIV1XfBe3tsvohKGFYp9YulOCdr8Xl4KLdD/JiH7cgQO4HxMdkY8hbPQxL9
         CDKA==
X-Gm-Message-State: AGi0PuakgdSoWC1dPQTitE5zGkf86ESDi9qS/ySjfpww0tk9CZl7xmm+
        Pap2p2Mf8D0yF0XoTnpQSsZXFBK59wo=
X-Google-Smtp-Source: APiQypJ8VJYfizc8LA+akvZJBSmsOILGofN3kS3G9v+tLbbiNZEfsoUT2A7Owm9J4aJlYKDHo+C9vg==
X-Received: by 2002:a1c:7415:: with SMTP id p21mr16220999wmc.93.1587372660943;
        Mon, 20 Apr 2020 01:51:00 -0700 (PDT)
Received: from dell ([95.149.164.107])
        by smtp.gmail.com with ESMTPSA id s6sm442863wmh.17.2020.04.20.01.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:51:00 -0700 (PDT)
Date:   Mon, 20 Apr 2020 09:50:58 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Tang Bin <tangbin@cmss.chinamobile.com>,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>,
        linux-kernel@vger.kernel.org
Subject: Re: mfd: asic3: Add error checking return in asic3_mfd_probe()
Message-ID: <20200420085058.GA3612@dell>
References: <b9626e96-4bdb-e7e1-51e7-a99210de4c32@web.de>
 <20200420071339.GG3737@dell>
 <aa5f9e64-042e-21a1-d252-9856207c7511@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa5f9e64-042e-21a1-d252-9856207c7511@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020, Markus Elfring wrote:

> >>> And remove the redundant 'ret = 0'.
> >>
> >> I propose to reconsider this interpretation of the source code here.
> >> How do you think about to move the mentioned statement into an else branch
> >> at the end?
> >
> > Could you please fix your mailer.
> 
> Would you like to help with increasing software development resources
> according to corresponding open issues?

You mean, do I want to contribute to fixing your mailer?

No, not really. :)

>mailto:tangbin%40cmss.chinamobile.com?In-Reply-To=%3C20200419091923.5728-1-tangbin@cmss.chinamobile.com%3E&Cc=lee.jones%40linaro.org%2Clinux-kernel%40vger.kernel.org%2Czhangshengju%40cmss.chinamobile.com&Subject=Re%3A%20%5BPATCH%5D%20mfd%3A%20asic3%3A%20Add%20error%20checking%20return%20in%20asic3_mfd_probe%28%29

?

> Can any more clarification help also around the previous update suggestion
> “mfd: asic3: Delete redundant variable definition”?
> https://lore.kernel.org/lkml/20200403042020.17452-1-tangbin@cmss.chinamobile.com/
> https://lore.kernel.org/patchwork/patch/1219914/
> https://lkml.org/lkml/2020/4/3/4

Reviews for these patches are on my TODO.

So, it seems this mail did the right thing.  Did you use a different
mailer, or fix/configure your previous one?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
