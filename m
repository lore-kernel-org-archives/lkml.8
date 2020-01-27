Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A17C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 21:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AF324679
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 21:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580159237;
	bh=tAX6yDr0IhujvnZ6kLXHg9mvJe9D611oaH/B6mkzBbU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=F7CJVsy6UeQFuDx8/IumsMjGOVB6+2GojcWhSU4BC79MdgMYa1UqbfHUSfrEIwCxY
	 CxL/y6xmLdMM/BBDNgsbw242ZixICDogZ4EmbufZqfVz8ydR9x9wCJ/58l0HmpEa5c
	 6vFpcjAqgyllddSdiXs6jdcKvls1CjfC0Vxmuzk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgA0VHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 16:07:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:47726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgA0VHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 16:07:16 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E7DA24685;
        Mon, 27 Jan 2020 21:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580159235;
        bh=tAX6yDr0IhujvnZ6kLXHg9mvJe9D611oaH/B6mkzBbU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Dayd5ALxnRvjcmd6CdVdAnAeHlsKPu8amrIZXBRoRG/qDNJYwb+aGAXwJUE87oJnZ
         zexYy+8zr3ZQZpF6JREvfjVWNvAez7vq/2a/faB3lWJXSqKkBhqfGK4BfJWTE6nJgp
         5PlPwz4EVva39REDLIN3r45rr6Z7CxVxpm4LTEYA=
Received: by mail-qt1-f182.google.com with SMTP id d5so8593500qto.0;
        Mon, 27 Jan 2020 13:07:15 -0800 (PST)
X-Gm-Message-State: APjAAAXKfuWOmwF6QnqvTSY7DCgvpQvqzE6RcsNe7ZLhO3MoMMM5ZMep
        DmtMCi/fnLLK3N8WymguEMoMlJwOkwKw4Mh+oA==
X-Google-Smtp-Source: APXvYqz6TcnGjayCnrZyiOhSkagdqkmRPHWtYG3imaw/anjUcBcBkDZwHIlxd5O98Ut5vvyzcURPSnzpyZ2XVj/mInc=
X-Received: by 2002:ac8:1415:: with SMTP id k21mr17990875qtj.300.1580159234323;
 Mon, 27 Jan 2020 13:07:14 -0800 (PST)
MIME-Version: 1.0
References: <20200127145223.8283-1-benjamin.gaignard@st.com>
In-Reply-To: <20200127145223.8283-1-benjamin.gaignard@st.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 27 Jan 2020 15:07:02 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+702FHQtgSu-c7M8j-4G578Ce1x3WhhQY2OCpq8APi5A@mail.gmail.com>
Message-ID: <CAL_Jsq+702FHQtgSu-c7M8j-4G578Ce1x3WhhQY2OCpq8APi5A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: Convert etnaviv to json-schema
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        etnaviv@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philippe Cornu <philippe.cornu@st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 8:52 AM Benjamin Gaignard
<benjamin.gaignard@st.com> wrote:
>
> Convert etnaviv bindings to yaml format.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../bindings/display/etnaviv/etnaviv-drm.txt       | 36 -----------
>  .../bindings/display/etnaviv/etnaviv-drm.yaml      | 72 ++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 36 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
>  create mode 100644 Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.yaml

Looks good, but can you move this to bindings/gpu/vivante,gc.yaml.

Rob
