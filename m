Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C90DC2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6761120780
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585591657;
	bh=zb4exHoKNP9nLoK/adxpBPJohu4ng0k4iVekqgkZONU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wV1x+3pkh++EROf0mgpjfI7Kefb5UimUcL3OG6T1t2JglGdpIX5SVMrvWJ4GzEEiP
	 bggPgpqJ5Ull05VjFmlNL7jXvbzm3qBH7yiszW5e1UP0BCNqg4QgZVgDL4OhHzNCfU
	 FceyxTWzoSBqKI4D14dtQTDQn8LJsoF/aCHJEy4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgC3SHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:07:36 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:38770 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbgC3SHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:07:36 -0400
Received: by mail-il1-f196.google.com with SMTP id n13so9438479ilm.5;
        Mon, 30 Mar 2020 11:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mj9C+ldVbUlZ3vIXMBDLPPubLs9WW33ew+oonI4HdKc=;
        b=MiuBvZj5dZrhPHoQEzTH1XdPwUsV1uWSyDaIA0YTFjg2Ai/NiSkTyWqcFCQi5rIrwB
         6gErFMn8TR5RJxBcuMYf4m0Fy7I3rIw2NsIheqREKTLHZa74ETfmIu6jNtXYbcJyCx1k
         rwYhrpB00oW0y0p8PyrUEE6V38yBECkfZO9k91OfO9ko2YQkYAI5kztqO2K28s0ARqOl
         a97VmpGcIb6ol4xgBWtgHD69LG1/foj7WLWXXeMShu80hxzHz7FcKDA1rnKNNnGFK2K2
         ZdRqBGSyvGji2h/rxrZZlod4kDXIzG4L/qXy+S6BLeKChG6wUHyOK0CBlIGJXbveFiRQ
         wExg==
X-Gm-Message-State: ANhLgQ1YQ8/gm8H1I0aym/5LMCxAi9kPz19POKb1Ba/5rTLMzo+/KCQC
        /Pc35hIsqtFXUsJprxWJNg==
X-Google-Smtp-Source: ADFU+vtNqSrTRYSiHT+MOixHEmT/udRjClK4h0+HRhanDrEbRpaw67MMVUx3gP60KWbNpRPLNo+PQg==
X-Received: by 2002:a92:443:: with SMTP id 64mr12853112ile.258.1585591655065;
        Mon, 30 Mar 2020 11:07:35 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id b83sm5086913ill.7.2020.03.30.11.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 11:07:34 -0700 (PDT)
Received: (nullmailer pid 3078 invoked by uid 1000);
        Mon, 30 Mar 2020 18:07:33 -0000
Date:   Mon, 30 Mar 2020 12:07:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     robh+dt@kernel.org, agross@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org,
        rojay@codeaurora.org, skakit@codeaurora.org,
        Akash Asthana <akashast@codeaurora.org>
Subject: Re: [PATCH V2 2/2] dt-bindings: spi: Add interconnect binding for
 QSPI
Message-ID: <20200330180733.GA2966@bogus>
References: <1584098121-18075-1-git-send-email-akashast@codeaurora.org>
 <1584098121-18075-3-git-send-email-akashast@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584098121-18075-3-git-send-email-akashast@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020 16:45:21 +0530, Akash Asthana wrote:
> Add documentation for the interconnect and interconnect-names
> properties for QSPI.
> 
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---
> Changes in V2:
>  - Added minItems = 1 for interconnect property
> 
>  Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Applied, thanks.

Rob
