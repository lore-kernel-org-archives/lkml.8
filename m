Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B430C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC662465E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583192476;
	bh=L80nZ7i1LC244PxEUQB2golwW3/H7GMiinNmtYYtAuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z5TrONlbnOeLy11ym2wzmLXYxLM0J4NuTTwdW4sT1BcxXDmfzQ7wt7/qa0FoL12XM
	 GSSEkEgjEutx133E1KRtJ6bC36tZhDFy6o3lSF3h7A6T5bNXEhSRWKTDGgSJcCtn34
	 Z5DW1DSasL58/FUkHojmiq4bayoBz9mzie75NS+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCBXlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 18:41:15 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40586 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgCBXlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 18:41:14 -0500
Received: by mail-ot1-f66.google.com with SMTP id x19so1169158otp.7;
        Mon, 02 Mar 2020 15:41:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0C7KbIrNsdK55X+XBECBVpZklmhln+kZr6VyUlPfaOg=;
        b=FZHPe3gMase4bYHT2m/r3pwCkj0Th0tOzSosyqtgh9jDZouJNUxDXKVIJa9ChzHg01
         J+Hf3pR3TlYcxJrtdVoLnipjDzC44ZACUPJLcEhQXScSXz8X5LGbRzMaBwbQ7y09Fdn3
         RHj6CR8nD6wj+lot9a2q0frJvYhcTAMqOcv9t7855rhg5BgcZwz3cVElnom3jX7EmK/b
         RlxZF88VvB9P9oQg3869F+71VSxZ9f/h7HB9pQwFjdf5C80rPWchd/NcXH2ZWKD2RrIe
         rXq7exNJHAolNtGZf1ILltIc6VqZ3YDYCX9hfukgRdm/nDF5Q0wvOTanUT1+j05sTrzB
         3Vtg==
X-Gm-Message-State: ANhLgQ25Wl1ypVbHPyCiFCNCUD6MAmfq4ZwCqWLmuTNpYJ4Nkf1q7tUc
        eAkbFejK20xqyKxrYUVMGw==
X-Google-Smtp-Source: ADFU+vvRNTwOIvYWej38IX/q9s2fFMVV+Tr53mzpWuzaWObBRVFixrBQrnrBtVRBMjR5Mq1mWiO3hA==
X-Received: by 2002:a9d:6a4f:: with SMTP id h15mr1326265otn.86.1583192473868;
        Mon, 02 Mar 2020 15:41:13 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 67sm6924948oid.30.2020.03.02.15.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 15:41:13 -0800 (PST)
Received: (nullmailer pid 21716 invoked by uid 1000);
        Mon, 02 Mar 2020 23:41:12 -0000
Date:   Mon, 2 Mar 2020 17:41:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Andi Kleen <ak@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Subject: Re: [PATCH v8 3/7] Bindings: nvmem: add bindings for JZ4780 efuse
Message-ID: <20200302234112.GA21654@bogus>
References: <cover.1582905653.git.hns@goldelico.com>
 <37d3b9e4c60692215fff0e75a78ac1e7792aaf75.1582905653.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37d3b9e4c60692215fff0e75a78ac1e7792aaf75.1582905653.git.hns@goldelico.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2020 17:00:49 +0100, "H. Nikolaus Schaller" wrote:
> From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> 
> This patch brings support for the JZ4780 efuse. Currently it only exposes
> a read only access to the entire 8K bits efuse memory.
> 
> Tested-by: Mathieu Malaterre <malat@debian.org>
> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> [converted to yaml]
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../bindings/nvmem/ingenic,jz4780-efuse.yaml  | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
