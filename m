Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A8AC352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F7D217BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581026558;
	bh=3BJiOfiUA7V9MKtVnYPxCmXpQ9JY+qQviE6h0RLL86I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a4cJewWsgEJBSpTTJo7sSE0eVrXIVws8O+0RuzlfQ2lBqwmy0SpkOCZmWg0QVE7tD
	 ACOECsCayARLgieXruAkn5sZ6djw0RKhTDhgKtksrpReZOXZ1bt90iav7bSyQ1s24s
	 DkAyAQyPjF/uU523BehaFdM5kDQi+oKUXs7VGvBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgBFWCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 17:02:38 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42239 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbgBFWCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 17:02:38 -0500
Received: by mail-pg1-f194.google.com with SMTP id w21so11221pgl.9;
        Thu, 06 Feb 2020 14:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QZbN+Rw9Wauw1FSQRjx1EufFnK6c8lNge5XZrv7SCxo=;
        b=WLxAuLsrk0BLIIjCIj1hd09ok9/djewmgjNAB3QIEEYMX1KmaGd1JhkvgslSsToKD0
         qz9vYV1Ir36QmADuueWSYWw4r5uipWsoLfnG+rCN6nQinAfIqDWE0MtbChestRzVdIU2
         675vbOaWw2n2ogV1s9iDwoGfG9MqrnMynmj7183lutXYVZ9Ne6BH0unxPh65sCj1ETs/
         UDo9vpTpWfJqFAaMQ4B1eLAa+iMgO80X7CzW+iEa/hcsy5aug1XHIaYklmj1vn1n8DZ+
         wgRfQgNL4TPvDjlNPAXU65zadFBtPDOVLGK4lGMh+ZnhejgGCoAb3VeOaYpk/U4ShqKl
         USJg==
X-Gm-Message-State: APjAAAUQ7MCCxXhxnmzXdn8lNSGx+hvFwm8gZk5s4XtgPeAnjS61z5H6
        Y4eyr1Nl4jsZOOjCnWvrxA==
X-Google-Smtp-Source: APXvYqzgCtK5jer0WP+jTalui8imMwVqNKHQY63IVhlORAQ77cic7EYV5b0qZ4PiE7a9I22N4V4rIA==
X-Received: by 2002:aa7:87c5:: with SMTP id i5mr6347609pfo.114.1581026557162;
        Thu, 06 Feb 2020 14:02:37 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id e1sm348605pff.188.2020.02.06.14.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 14:02:36 -0800 (PST)
Received: (nullmailer pid 28125 invoked by uid 1000);
        Thu, 06 Feb 2020 22:02:34 -0000
Date:   Thu, 6 Feb 2020 15:02:34 -0700
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org, mark.rutland@arm.com,
        philippe.cornu@st.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v4 3/3] dt-bindings: panel: Convert orisetech,otm8009a to
 json-schema
Message-ID: <20200206220234.GA28073@bogus>
References: <20200206133344.724-1-benjamin.gaignard@st.com>
 <20200206133344.724-4-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206133344.724-4-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Feb 2020 14:33:44 +0100, Benjamin Gaignard wrote:
> Convert orisetech,otm8009a to json-schema.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../bindings/display/panel/orisetech,otm8009a.txt  | 23 ----------
>  .../bindings/display/panel/orisetech,otm8009a.yaml | 53 ++++++++++++++++++++++
>  2 files changed, 53 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
>  create mode 100644 Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
