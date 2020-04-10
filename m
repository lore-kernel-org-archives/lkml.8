Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194E1C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE992078E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586540349;
	bh=7FJ9FSfgdGgjoPWBLLac7ubL4MOAkDYmaZcfd/eqKa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oCj34jtLUbIV8PHCDs9iuz3IdgibSSMuSwEA1tgAMyLj/u+VVX/MGQEOuR9sjze1Y
	 C3MOB/7/Dj5nuJbfQUdDdgpj949BJ4uPBwxVyawrBT8UwbTJWJ6xGvJs90BVFCvLgL
	 mwEOswkIUuxU/zhhm3KzubXRE0wT7GSM/mAZC+a0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgDJRjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:39:07 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46506 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgDJRjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 13:39:07 -0400
Received: by mail-ot1-f68.google.com with SMTP id w12so1609870otm.13;
        Fri, 10 Apr 2020 10:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sMpQBRP8FS5/1RZ8Jd5Q+SlXPKexMnkYQKuvOFERAmM=;
        b=aQJ26UrHV6SolvPod/srOeI3JJGxPcx8oCaqXy2L4OqZ/FMYHF39Wa+J2LMe3xt20k
         lvSN8GFoUIUHO1FFCsdTggrFIzdlH5Ajz/UpJ4gj0V0qxcp7J7QQdtlO3JLBwMCNEv4V
         w09GOu8lhg36V0EzySw3lEQZxb3TQKairBGj4TxkBoC6TmiDrwF5yIYYb2I+PbFvls1N
         0vK2rJi4milwgisuapHXrsbkxHk4x1pQZWwdVB6c/VAS0ubz3W6ZOLB7ASoGxZWVY803
         XBKsMWrJvwlAwpo87oHwf84XVE4+oqKts+2mrERMw1Cg4M6Q2zAgPVh0SjBN3egCcqex
         T5FQ==
X-Gm-Message-State: AGi0PuateItOKQG0Rs1NPnxJYrYu6tTtx6nAWdhETXcpLZrJoQnM0MdU
        4SJ783QWb7+OD5KeX8q+lBGqqM8=
X-Google-Smtp-Source: APiQypLOpDs/VWOK6XL5g7aYp34maDUCWLeFvZay6f1FWhW6f3+p9gzEOnFLor7ULmSrlOR2HJ54hg==
X-Received: by 2002:a05:6830:1e79:: with SMTP id m25mr4962035otr.36.1586540345966;
        Fri, 10 Apr 2020 10:39:05 -0700 (PDT)
Received: from rob-hp-laptop (ip-99-203-29-27.pools.cgn.spcsdns.net. [99.203.29.27])
        by smtp.gmail.com with ESMTPSA id r24sm1518599otq.9.2020.04.10.10.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:39:05 -0700 (PDT)
Received: (nullmailer pid 11877 invoked by uid 1000);
        Fri, 10 Apr 2020 17:14:05 -0000
Date:   Fri, 10 Apr 2020 12:14:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v4 1/5] dt-bindings: vendor-prefixes: Add an entry for
 Protonic Holland
Message-ID: <20200410171405.GA11823@bogus>
References: <20200330120640.9810-1-o.rempel@pengutronix.de>
 <20200330120640.9810-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330120640.9810-2-o.rempel@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020 14:06:36 +0200, Oleksij Rempel wrote:
> Add "prt" entry for Protonic Holland: https://www.protonic.nl/en/
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks.

Rob
