Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643B2C4724C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CDCD206B9
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EvyLgigN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgEGVOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 17:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgEGVOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 17:14:41 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB987C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 14:14:39 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k19so2577399pll.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 14:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=ioAtKKBLetMrNC3UOrZBDpCms01n9tKhgmw2P4KuQ10=;
        b=EvyLgigNsQCXtN+ZrgfW3obNeN7n95kvB+iKsA3+ZKnx6Pg5GXwuwrpAimKciweQLh
         A5IVBx9MVFabDi+Q4FiPn1IL+Ut97gCeTeb7mX2JJGN/XYRuTQAwLpP2rSFctxdoyafo
         dTtwQ79hSAA/WHsbFnshcKXq7Ma1fctt8eopE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=ioAtKKBLetMrNC3UOrZBDpCms01n9tKhgmw2P4KuQ10=;
        b=c2dHXHXiY7DbMfGpi7ETR2/Z/fzy/vcalkfArje9swEwZWl2MY3mcavqWKs4o+bLnV
         RTdrDsMcXkLTJcdYzdho7SSbzS27d6t/FmJVBEzhjkcovWt9bKwqhgxErwBdWo159fP4
         3f4jr1BQTnDZzmBsntbKKVakM4pSTOS0v74mLie7xhvMFMsh8Nwqq2wTTZBPHFwVU8bs
         MMKfs7uVLkKipUih8qdVsABZfYAGWDN+8RFadwfaQsSeGPl0MSUhavMwJmodlViic5xS
         iDmnvgQYcjJxbvCZGwnkR+l+q9c7ZDMK9p07m8J15IRpRN7NuEPDcl2hR8fPSe4WjUxe
         ZEmg==
X-Gm-Message-State: AGi0PuYYZpFVWB8mc3VftyT5xR/lEWPKWdA7paFJVZAF8HHoM0Vb7HEG
        MJPBpHiM1VMdcNLwtzsCxpX5Rg==
X-Google-Smtp-Source: APiQypJ3ry9ekB/Mu6A+agxgYdfo7bbCE87C+rrfPRAkcpuV1AuLxv17o9r4CKcuSidKzhyfOYnUbA==
X-Received: by 2002:a17:90a:fd94:: with SMTP id cx20mr2284622pjb.157.1588886079220;
        Thu, 07 May 2020 14:14:39 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x63sm5873453pfc.56.2020.05.07.14.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:14:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200507192157.6831-1-sibis@codeaurora.org>
References: <20200507192157.6831-1-sibis@codeaurora.org>
Subject: Re: [PATCH v5] iommu/arm-smmu-qcom: Request direct mapping for modem device
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, dianders@chromium.org,
        evgreen@chromium.org, mka@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Sibi Sankar <sibis@codeaurora.org>, joro@8bytes.org,
        robin.murphy@arm.com, will@kernel.org
Date:   Thu, 07 May 2020 14:14:37 -0700
Message-ID: <158888607765.26370.18078298627976225073@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2020-05-07 12:21:57)
> The modem remote processor has two modes of access to the DDR, a direct
> mode and through a SMMU which requires direct mapping. The configuration
> of the modem SIDs is handled in TrustZone.

Is it "The configuration of the modem SIDs is typically handled by
code running in the ARM CPU's secure mode, i.e. secure EL1"? And is that
even true? I though it was programmed by EL2.

> On platforms where TrustZone

TrustZone is always there.

> is absent this needs to be explicitly done from kernel. Add compatibles
> for modem to opt in for direct mapping on such platforms.
>=20
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Is Sai the author? Or does this need a co-developed-by tag?

> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>=20
> V5
>  * Reword commit message and drop unnecessary details

I don't see any improvement! Probably because I don't understand _why_
the modem needs a direct mapping. The commit text basically says "we
need to do it because it isn't done in secure world sometimes". This is
probably wrong what I wrote below, but I'd like to clarify to confirm my
understanding. Maybe the commit text should say:

The modem remote processor has two access paths to DDR. One path is
directly connected to DDR and another path goes through an SMMU. The
SMMU path is configured to be a direct mapping because it's used by
various peripherals in the modem subsystem. Typically this direct
mapping is configured by programming modem SIDs into the SMMU when EL2
responds to a hyp call from the code that loads the modem binary in the
secure world.

In certain firmware configurations, especially when the kernel is
entered at EL2, we don't want secure mode to make hyp calls to program
the SMMU because the kernel is in full control of the SMMU. Let's add
compatibles here so that we can have the kernel program the SIDs for the
modem in these cases.
