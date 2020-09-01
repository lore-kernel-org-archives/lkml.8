Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29A4C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD34820719
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 04:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M1WvaDgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgIAEEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 00:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgIAEEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 00:04:48 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6E7C061290
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 21:04:48 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id e23so7278otk.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 21:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7tF5yri2JrvbpuG08PkKfHvaUZh8WWw0hbP0EluJihY=;
        b=M1WvaDgYP5swmd9Trqsx8z670mDBsLaKq+qcBaK8y2jBn33lZ2hEfjX+tQ+0a4BJwi
         wsXsfhClQG0zZeP+DwK5HhxO4pz9BJFCVypqoT+H1oYoH7FxHMYIbQiDJ71MqDdJXo+a
         24VCN3nmoP531xyuidmBEtfBsqq7AEgXQhrTYOQ6dkkjMe+8abBzlrsDVF2BR9a1Yjp+
         Kn1BA4zk/jS/wqFYTQBvFFeF0Kaaa9E66+oiZ+qSGD6242mh1yt9beKM6hE/r9ClFelO
         XEw+b+rAb8UU0SBQw56hfj+v10dou7juYR8rLQRYGF94Bzk8LEanBjhpSViLpoIJlPeS
         7yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7tF5yri2JrvbpuG08PkKfHvaUZh8WWw0hbP0EluJihY=;
        b=rgo0f+PQV20S9DDqJBSGoQi1KTStYZqE+AbZVS05ataf+VgJoPkgONrulClbrBWgw4
         13g8OCBjoeNZAbB1CHoD0ktiWFsSKjgInxHTFS9KSpXNVqDzjbOGDpyVw3fL459782Ck
         HHRtuCOJLrEcgu36skeFnYzqjde7M6oJEHNmsRPo6027lDFAjN6gSxGVwlTqO0fBVdHZ
         tabUrf4Y0sWOWy0Nl/ZJBJhopDia5WoNnQedvYH6o/EnXNIpguWj7g7kD4zBEOyu7Z96
         wCiBWUFg7b+JowITKKvPeNg+wf1iHyNN0zVtW4ztqjiupxcscDHauqMx7hhP0hg3aeds
         CQyw==
X-Gm-Message-State: AOAM530HOGD9CIGrCCy4pkMTvcMF9OSi1peFr3pxFOetO1WX0/Aqz/wM
        TapJDMW2l3Pi5ADueM5Vxg6gbRfKNzqRKRpR2kmAkDMzsak=
X-Google-Smtp-Source: ABdhPJw58JZ5LU2bTsgeGqMMWY9gbABpuH1aV0WA7Wgxvfh8rLe/Y37yR+nWxMGI9FEU3rLnm6Z5elAOeiqV3NLqrPg=
X-Received: by 2002:a9d:6004:: with SMTP id h4mr51911otj.102.1598933087465;
 Mon, 31 Aug 2020 21:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <1597227730-16477-1-git-send-email-rnayak@codeaurora.org>
In-Reply-To: <1597227730-16477-1-git-send-email-rnayak@codeaurora.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 31 Aug 2020 21:04:36 -0700
Message-ID: <CALAqxLVQ1uB5Zy1DrFP6K4FgZ0U9rwGterhvzcTws_9O9wWE2g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sdm845: Fixup OPP table for all qup devices
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>, tdas@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 3:23 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> This OPP table was based on the clock VDD-FMAX tables seen in
> downstream code, however it turns out the downstream clock
> driver does update these tables based on later/production
> rev of the chip and whats seen in the tables belongs to an
> early engineering rev of the SoC.
> Fix up the OPP tables such that it now matches with the
> production rev of sdm845 SoC.
>
> Fixes: 13cadb34e593 ("arm64: dts: sdm845: Add OPP table for all qup
> devices")
> Reported-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Just wanted to follow up on this, as it's still missing from 5.9-rc3
and is needed to fix a bluetooth regression on db845c from 5.9-rc1.

Amit has already validated it (on PocoF1 as well), but just in case its useful:
Tested-by: John Stultz <john.stultz@linaro.org>

thanks
-john
