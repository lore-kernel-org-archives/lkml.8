Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F3EC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 19:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D962C20786
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 19:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QybfgRe8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgGKToK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 15:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgGKToJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 15:44:09 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AC6C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 12:44:09 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id 72so3635238ple.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 12:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FFScSyqhtEjbSNl30tNfDPx/n2WK+xzVbxi3r8v/eGw=;
        b=QybfgRe8wNY8XCA8SxET6OXJ2wTy8BFJuOLwWBvbZHdqFw0MyEu987sTMat2tqIB9j
         xVgBhHRFIV3VJrXnsW+Z/VcE4iZu8NS+HnU8m5PejlWaXOBtfJmySpKrwf8gkxhfVm+z
         hgnX1q1xAt4ahpr6IiSXPWx2Dho5U9d2H9o5oz/13bq4urIztuU2MvXmwO17381XFQ8T
         D+iojhaC5CVi/EVvse5mHkac8QhOMknI1UqzBTRCR7GdasWqLoW1c8C3B5lhTaymhZWS
         EivGqW0bisT1Uq9/TOSZAgqCWbbbfDs+FQoYNFiRnoNOpJFI7OW4SWB9GdAe6kaKGERN
         3mxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FFScSyqhtEjbSNl30tNfDPx/n2WK+xzVbxi3r8v/eGw=;
        b=kpj8QmFeVYD4M5st7UX7mjjPznu+crGNUvnrbcYKKigN3D8Fgvu5BM0e3odClXMkt+
         vaLZdH+IJtvsHOaCXAJAcJGBalnoaArJ2t8PpijYZAYxablTZsZuR76PE+vKUi2+ZQ0l
         t7JH89Qc4Ooih725Fr/xQSBikOBWVhTnPG3i72Cvzmey7yIrpL7gGmORAKAn3FeqOE9D
         3Ed0ocqGCEePLAhyxM0x2flx9AeM0ZmJ3D6uj9YULKkvkqow7s0t1VkXpbHbUvtiP8F8
         UB1G+Ptff+pkqp3fg7zTRAsZjaOjqdQf64vNt8YsavXpyPloteLDXF3xj87R+r3iT4eh
         Y6hQ==
X-Gm-Message-State: AOAM533n9C6U3iNfUqjdi54PlOhlNdxHwa/7NQvb8bQb1ndc8w4zmmvK
        SXVPZKr/6sgpfVNBK7TtMlWfSQ==
X-Google-Smtp-Source: ABdhPJx8dvnRbV1dcsvA18UTcbWnEGPbhHvvqkWGlc2JVYQ1ljT023zBQkpIiknuci/9St141NzM+g==
X-Received: by 2002:a17:902:9b83:: with SMTP id y3mr12860099plp.271.1594496648688;
        Sat, 11 Jul 2020 12:44:08 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 129sm10008580pfv.161.2020.07.11.12.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 12:44:07 -0700 (PDT)
Date:   Sat, 11 Jul 2020 12:41:56 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Akash Asthana <akashast@codeaurora.org>
Subject: Re: [PATCH -next] <linux/of.h>: add stub for of_get_next_parent() to
 fix qcom build error
Message-ID: <20200711194156.GA1218486@builder.lan>
References: <ce0d7561-ff93-d267-b57a-6505014c728c@infradead.org>
 <CAL_Jsq+AWo6xP1vC1NubFcdWzoX4hVvSW4KGry1NhOXUieDrSA@mail.gmail.com>
 <215c3c59-e6f7-1721-76ca-993bbaf91356@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <215c3c59-e6f7-1721-76ca-993bbaf91356@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 10 Jul 16:40 PDT 2020, Randy Dunlap wrote:

> On 7/10/20 8:28 AM, Rob Herring wrote:
> > On Mon, Jun 29, 2020 at 10:43 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> From: Randy Dunlap <rdunlap@infradead.org>
> >>
> >> Fix a (COMPILE_TEST) build error when CONFIG_OF is not set/enabled
> >> by adding a stub for of_get_next_parent().
> >>
> >> ../drivers/soc/qcom/qcom-geni-se.c:819:11: error: implicit declaration of function 'of_get_next_parent'; did you mean 'of_get_parent'? [-Werror=implicit-function-declaration]
> >> ../drivers/soc/qcom/qcom-geni-se.c:819:9: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
> >>
> > 
> > Fixes tag?
> 
> Are linux-next hashes/tags stable?
> 

Yes, the hashes of the Qualcomm tree are stable.

> Fixes: 048eb908a1f2 ("soc: qcom-geni-se: Add interconnect support to fix earlycon crash")
> 

Thank you, added this to the commit and...

> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Rob Herring <robh+dt@kernel.org>
> >> Cc: Frank Rowand <frowand.list@gmail.com>
> >> Cc: devicetree@vger.kernel.org
> >> Cc: Andy Gross <agross@kernel.org>
> >> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> >> Cc: linux-arm-msm@vger.kernel.org
> >> ---
> >>  include/linux/of.h |    5 +++++
> >>  1 file changed, 5 insertions(+)
> > 
> > I'm assuming this will be applied to the tree that introduced the problem.
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> > 
> 
> Hi Akash,
> Can you add this patch to your tree, as Rob indicated above?
> 

...applied it to the Qualcomm "drivers" tree for 5.9.

Thanks for the patch Randy and thanks for the Ack, Rob.

Regards,
Bjorn

> thanks.
> -- 
> ~Randy
> 
