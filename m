Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E92C54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B4C206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584997175;
	bh=+TA7KQ2sMUdn5SzkG4qlg9H4PAhYDaW1bNYEm5pMLj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZK3ZAZ9p/M4t5sitszVkio0mJ8epR+8haA4Vk19bR/l6a90VTJSkgV2924qR/fBoJ
	 D/ObJE38mrWSdAULkIRPu9hmhkMaRHTQPevI67Pwyd/1ckWkiUJclBUjceyBU3GFj8
	 ghg7IUiHKEDtwWL1gAlhYpDfYnUUf+bg01cewCPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCWU7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:59:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35254 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgCWU7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:59:34 -0400
Received: by mail-io1-f65.google.com with SMTP id h8so15911345iob.2;
        Mon, 23 Mar 2020 13:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8IyE6MoEtawQWc+ii3p8qF/jfUchyUm7Ryk1+Vf5LdA=;
        b=IP5X6FRCRGm8+9p2Iq4guk4gQvXnsANr5kg2TlVStCucFpL/qq2UHusz8YYLmS1emC
         JluzMvVh06YS+ToVcF4sREg4wwBVv/DsM2ecNx9hOpwr33dkUyH32QqeXrjN2rxKkKw0
         LDxUdnK2hI5fSPGt+kzx++/FougPZQtpIw4FhcGF6ha040uaGuukhx4tPhBxmUYr7fiS
         h2V35/alxpeHGUQxVagjOaCGA0DBc+kPpUYc+Qer0bmL6XTOSm+1mnOjU21AajObphFa
         N+eooBGiTjpSwt1wL/poduGoox1loAsRTuEN58hW7R+MC2Xy/xl2NQr5054K+vPgNkeT
         A46w==
X-Gm-Message-State: ANhLgQ2l1nsdRrsp5uEFDDR5uD5g9sadTkPTcknzSgeyr7CXV05Z+Yvv
        PA0BpD2sETt9TpnY9oV2NA==
X-Google-Smtp-Source: ADFU+vskTGdXLQiJKIPM4lcX/9O07zGAs8eCCyBftML/Gf9uUcnYeYoJjSFudfYbwa0nSAnpdxuPhw==
X-Received: by 2002:a05:6602:2439:: with SMTP id g25mr14723488iob.142.1584997173185;
        Mon, 23 Mar 2020 13:59:33 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s69sm2130679ild.70.2020.03.23.13.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 13:59:32 -0700 (PDT)
Received: (nullmailer pid 11750 invoked by uid 1000);
        Mon, 23 Mar 2020 20:59:31 -0000
Date:   Mon, 23 Mar 2020 14:59:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clk: fix example for single-output provider
Message-ID: <20200323205931.GA11658@bogus>
References: <20200309235722.26278-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309235722.26278-1-giulio.benetti@benettiengineering.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 00:57:22 +0100, Giulio Benetti wrote:
> As described above single-output clock provider should have
> 0 cells number, so let's fix it by using 0 as cells number.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
>  Documentation/devicetree/bindings/clock/clock-bindings.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
