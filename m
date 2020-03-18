Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA03C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23B520768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b="SymM6JX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgCRJ3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 05:29:01 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44438 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbgCRJ3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 05:29:01 -0400
Received: by mail-lf1-f68.google.com with SMTP id y2so4939417lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 02:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xI+nNVteVjSy3ZGdtWuI/tAMjznZhMdLDuHpaHBTc6A=;
        b=SymM6JX3M8rY9bbhScbNhia4a5WFTNME1ETRVETTwmfizUPUHXvQdjS2BcdWjuLHiT
         et0mvFjOuJhBpDEIPymT1vewmNvt8yMS8OkejsRxMFN7Ngi4YwcIcITomJouE1LaT085
         JeGSwQw3C25xiy8b4RgOLL3udu8m7VSExEtP0WysVtH4XNbf+9K0LOnVAmlvJ+G574ss
         qmnYOuGlGJGHPH96D8xznl1/WCAdlXhIYvXf9ig5LWXD/pctUaWlDIJv9cMKCwFbECTY
         JtEfwH7/fjpBTjxhkg/mKd3kfqLivbtIaZRW8PF58oTveVdb9I2WNL0KcTVdxHkTJJrM
         +sSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xI+nNVteVjSy3ZGdtWuI/tAMjznZhMdLDuHpaHBTc6A=;
        b=ggKpOnNbVGznGkCxUHt3vSKCjWhaLp0CBDMYrunlM0DwO92ELFl5vaLeqEN9NfupxG
         Sbv/6zj1JNCOp02lBpFX5vuOF/xW5Q5eFPG+TpxOOZb2BMHawhjqE2x1SUxkKhQ8eUKd
         sdnHwi46pKMI+0IB4HO/tQ8n/eK2iqHdzjlzx0SF7Cw6nP7G+g/qVI7fjWr/zHPF9ZvE
         BLiSbDXZh1AHebxDqN49wXvOZ9f/r6zSTbWBmlI59ToQ74sYAZgOPXzzK5/+JFIUz8o/
         2UhaYS2lNXfS5bJ388pH6JC4tT5snWgrcPSLQAXRECpCWxT/lLfHTuf+POm1wlpnAoDF
         6WqQ==
X-Gm-Message-State: ANhLgQ1NiZKhfd5EKpXuPOZGdfxoE5x026EqoCNvWIOpsyN2KlfC3JLf
        3i9dNIcND0qcug8qc9r+jo4iq/BGXL8sC/6uSpbAVQ==
X-Google-Smtp-Source: ADFU+vt9RaqPeaQFcnibcOYchRkGU43JPFZ+ootd7u1qqbA7zone9+6G7f6jOLdG+HJihZ1J+PXHqkiyj/xrGoYNbZU=
X-Received: by 2002:a05:6512:1054:: with SMTP id c20mr2294611lfb.69.1584523739621;
 Wed, 18 Mar 2020 02:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <1584463806-15788-1-git-send-email-martin.fuzzey@flowbird.group>
 <1584463806-15788-4-git-send-email-martin.fuzzey@flowbird.group> <20200318091734.GA23244@lunn.ch>
In-Reply-To: <20200318091734.GA23244@lunn.ch>
From:   "Fuzzey, Martin" <martin.fuzzey@flowbird.group>
Date:   Wed, 18 Mar 2020 10:28:48 +0100
Message-ID: <CANh8QzzA34th-h8ULM=LNvOvRw9P9=vekOBGvdYjv6TEBNDMig@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: fec: document the new fsl,stop-mode property
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Fugang Duan <fugang.duan@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, 18 Mar 2020 at 10:17, Andrew Lunn <andrew@lunn.ch> wrote:
>
> You should not be putting registers and values into device tree.
>
> The regmap is fine. But could you add the register and the bit to
> fec_devtype[IMX6SX_FEC], fec_devtype[IMX6UL_FEC], etc.
>

If that's the consensus I can do it that way.

But I should point out that there is already a precedent in mainline for this:

Documentation/devicetree/bindings/net/can/fsl-flexcan.txt

Regards,

Martin
