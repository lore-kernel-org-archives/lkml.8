Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CABC2BA1B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 01:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA8A206F5
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 01:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586051189;
	bh=uKjXwD5ZwsQ0Z/FVdTozwyITLw6P7S5XNWkOJXHbQPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RTHLFRaYHzwBFkTIyIgCvLSegBNCXhm7ADDG2waBhbBNO5lqaMPU8XsAzWEDSwaaT
	 br/4J9aLA409EaQgWMhrZEExuvvkw+o7FOs2bc7qrsJvK5U15qSEW89PjQytFoH5Wq
	 21KeK996wyYxz3/+oWf7F756PKoLHxN82suIo5tA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgDEBq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 21:46:27 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:35589 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgDEBq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 21:46:27 -0400
Received: by mail-il1-f196.google.com with SMTP id 7so11361235ill.2;
        Sat, 04 Apr 2020 18:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RFHxoEL6ykrdk4JOC9Jspkh7XU+mBTUm4l93qZh6WEY=;
        b=WKxF6SkLb7zSHtHkiPrrtvcgoF4arMse0EuqeVL90auc0XUmvwzFHZ65ttKE35ERrL
         ZJ82nCr6pn9qENcmCi8t3yjVA5SElsu0N9hyzHVaKASjb+GY51VVj1GnvMHPcEHS4ZCN
         z1YkDsA8DHliXgfJp76yO6MCgKyWg0T4WcBFeIjGYsjpFGEPnTCA6C4mNVgLjH7ojgsb
         V1sFh0TkOSD7+A7Gx5/up6txXG13S2oJSY4kQxgzWntIEwHFq1QCa5OsoYiS2sVQ/tdW
         ZMhFoMW4I1qHK8gYH9qMcqq0NcS+NmUaiL1ewShQgEZ8//VsbebceGnllCJlzvbIbovK
         0RKQ==
X-Gm-Message-State: AGi0PubOBNoFX+P1AtbLlGGKr9xFo8/1iIutUTuG058OhfQCTc8Rz1Zj
        kN8R7Y2ZVj2HgY5/lg0d7Q==
X-Google-Smtp-Source: APiQypImhG5w60K3Rvo0QaDgLWP4ljC++jaNo/Znd4dwaJBJQu/fOwzyGRIICZLuSPq5dJRxkxKIeQ==
X-Received: by 2002:a92:9e99:: with SMTP id s25mr15058198ilk.306.1586051184908;
        Sat, 04 Apr 2020 18:46:24 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t5sm3799836ilp.6.2020.04.04.18.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 18:46:24 -0700 (PDT)
Received: (nullmailer pid 10915 invoked by uid 1000);
        Sun, 05 Apr 2020 01:46:23 -0000
Date:   Sat, 4 Apr 2020 19:46:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: phy: renesas: usb2-phy: add r8a77961
 support
Message-ID: <20200405014623.GA10862@bogus>
References: <1585301636-24399-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1585301636-24399-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585301636-24399-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020 18:33:54 +0900, Yoshihiro Shimoda wrote:
> This patch adds support for r8a77961 (R-Car M3-W+).
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
