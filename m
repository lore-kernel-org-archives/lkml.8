Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE33C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D9A2192A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581021981;
	bh=wJGGvyC/2zFwga7d5RzXye80kSwmtv+erjyW5SewCeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v/PJPg44u0a/u3B5NmY2r8a+DHTDXbda3u9v57+uVpPnn069P7DkOMfob0Z3u5ikZ
	 Lr3WyjurSIe3VKY8SgHjPKXvXJhXFuEkDH+J91V/kBH0P1fwdRmTm7uvOTZgm5I3kM
	 mCpNw/wmQ3/7F9bCQF3FhVKoAN1Chmvczcydc3yQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgBFUqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:46:20 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45183 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbgBFUqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:46:15 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22so24455pls.12;
        Thu, 06 Feb 2020 12:46:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l5FvaNiAtzMYswvlFr6v0YaM1iOHco5V/a0AR5TCzVA=;
        b=MBoLmzT3ZZzQt+/uPW8SzAM3Q59ulAD7xZSAaN2ynAgX18hbbzn7hiwp1Sd/Pko9je
         2WyNbPKxWlw+4aiMnDRqCkxFueVvgEjF+S/BfJsDOSDG0CmhIUsEZjH8U7p4iIcQPWQ2
         Qkmb9hUQIRBW7nhGtRgCJ1QVoVS4QfyEqIpnWZ0q44TLq4UW2sTzF8C4Xls4He66UbBv
         kdzUwM82PglsKIvSEdCOXEe+ObDJ0kzRO0n2rQ8cnkgIdkpiBW7I9VAAconAhlQTMies
         YxkS0f/fBhm1u6r/3ukPoeGgttOYgqM0NpOD5GB1K7A+Mx8f/vHnSBc1vWd4ORLv38qw
         M7Kw==
X-Gm-Message-State: APjAAAUwDPmf7fkXpgWjgdadkbZ53m7zJmoul2jGa4WdTatLXWR3K2UT
        zIDDSequ6RgqjcIyfBOKfg==
X-Google-Smtp-Source: APXvYqwvDRaorolz00MleJCnJNgdTgpyUgIq0k/Rh07UG3JXyWjdd+l7GKasnxQgNLs9FQRIpoGJVQ==
X-Received: by 2002:a17:902:8d91:: with SMTP id v17mr5698026plo.53.1581021974341;
        Thu, 06 Feb 2020 12:46:14 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id u7sm265881pfh.128.2020.02.06.12.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:46:13 -0800 (PST)
Received: (nullmailer pid 32672 invoked by uid 1000);
        Thu, 06 Feb 2020 17:24:52 -0000
Date:   Thu, 6 Feb 2020 17:24:52 +0000
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     l.stach@pengutronix.de, linux+etnaviv@armlinux.org.uk,
        christian.gmeiner@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, maxime@cerno.tech,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        philippe.cornu@st.com, pierre-yves.mordret@st.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v3] dt-bindings: display: Convert etnaviv to json-schema
Message-ID: <20200206172452.GA32579@bogus>
References: <20200129085613.3036-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129085613.3036-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2020 09:56:13 +0100, Benjamin Gaignard wrote:
> Convert etnaviv bindings to yaml format.
> Move bindings file from display to gpu folder.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> version 3:
> - describe clock-names as enum to allow all possible mix
> 
> version 2:
> - move bindings file from display to gpu folder
>  .../bindings/display/etnaviv/etnaviv-drm.txt       | 36 -----------
>  .../devicetree/bindings/gpu/vivante,gc.yaml        | 69 ++++++++++++++++++++++
>  2 files changed, 69 insertions(+), 36 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
>  create mode 100644 Documentation/devicetree/bindings/gpu/vivante,gc.yaml
> 

Applied, thanks.

Rob
